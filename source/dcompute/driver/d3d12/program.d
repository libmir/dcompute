module dcompute.driver.d3d12.program;

import dcompute.driver.d3d12.bindings;
import dcompute.driver.d3d12.kernel;
import dcompute.driver.d3d12.device;
import dcompute.driver.d3d12.error;

/// D3D12 program: loads DXIL byte code and creates Pipeline State Objects.
/// Mirrors dcompute.driver.cuda.program.
///
/// In CUDA, a "module" is a .ptx/.cubin blob that contains multiple kernels.
/// In D3D12, the equivalent is a signed DXIL container (.dxil) that we load
/// and use to create compute PSOs.
struct Program
{
    const(ubyte)[] dxilBlob;   // raw DXIL container bytes (DXBC header)
    private Kernel!void[string] _kernelCache; // cache compiled PSOs to prevent massive leaks and CPU stalls

    /// DCompute Formal ABI Mapping:
    /// Constructs a Root Signature mapping D host arguments to DXIL/SPIR-V expected registers.
    /// - Rule 1 (Global Memory): N UAV buffers map sequentially to u0..u(N-1), space0.
    /// - Rule 2 (Scalars): All scalar arguments are packed into a single CBV at c0, space0.
    private ID3D12RootSignature buildRootSignature(Device device, uint numUAVs, bool hasCBV)
    {
        D3D12_DESCRIPTOR_RANGE1[2] ranges;
        uint numRanges = 0;
        
        bool isBindless = device.supportsBindless && Runtime.Config.enableBindlessABI;

        D3D12_ROOT_PARAMETER1 param;
        param.ShaderVisibility = D3D12_SHADER_VISIBILITY.ALL;

        D3D12_ROOT_SIGNATURE_FLAGS flags = D3D12_ROOT_SIGNATURE_FLAGS.NONE;

        if (isBindless)
        {
            // Bindless ABI (SM 6.6):
            // We pass ALL arguments (scalars + buffer indices) inside a single CBV.
            // Shaders will index ResourceDescriptorHeap directly.
            param.ParameterType = D3D12_ROOT_PARAMETER_TYPE.CBV;
            param.DescriptorTable.NumDescriptorRanges = 0; // Not used for CBV, but maps to Descriptor in union
            // Note: C++ union means DescriptorTable overlaps with Descriptor.
            // For CBV, we need to set ShaderRegister=0, RegisterSpace=0.
            // In D3D12_ROOT_PARAMETER1, the struct layout for CBV/SRV/UAV is:
            // struct { ShaderRegister, RegisterSpace, Flags } Descriptor;
            // D's bindings in bindings.d map DescriptorTable over this. We must be careful!
            // Wait, in bindings.d, D3D12_ROOT_PARAMETER1 has ONLY DescriptorTable! 
            // We need to fix the bindings union or use DESCRIPTOR_TABLE for the CBV.
            // Let's just use a DESCRIPTOR_TABLE containing 1 CBV (c0) for Bindless,
            // which simplifies the driver code and achieves the same result (a single constant buffer).
            
            ranges[0].RangeType          = D3D12_DESCRIPTOR_RANGE_TYPE.CBV;
            ranges[0].NumDescriptors     = 1;
            ranges[0].BaseShaderRegister = 0; // Starts at c0
            ranges[0].RegisterSpace      = 0; // Space 0
            ranges[0].Flags              = D3D12_DESCRIPTOR_RANGE_FLAGS.DESCRIPTORS_VOLATILE;
            
            param.ParameterType = D3D12_ROOT_PARAMETER_TYPE.DESCRIPTOR_TABLE;
            param.DescriptorTable.NumDescriptorRanges = 1;
            param.DescriptorTable.pDescriptorRanges   = ranges.ptr;

            flags |= D3D12_ROOT_SIGNATURE_FLAGS.CBV_SRV_UAV_HEAP_DIRECTLY_INDEXED;
        }
        else
        {
            // Legacy ABI (SM 5.1/6.0): 
            // - Buffer arguments -> UAV Descriptor Table (u0..uN)
            // - Scalar arguments -> CBV Descriptor Table (c0)
            if (numUAVs > 0)
            {
                ranges[numRanges].RangeType          = D3D12_DESCRIPTOR_RANGE_TYPE.UAV;
                ranges[numRanges].NumDescriptors     = numUAVs;
                ranges[numRanges].BaseShaderRegister = 0; // Starts at u0
                ranges[numRanges].RegisterSpace      = 0; // Space 0
                ranges[numRanges].Flags              = D3D12_DESCRIPTOR_RANGE_FLAGS.DESCRIPTORS_VOLATILE;
                numRanges++;
            }

            if (hasCBV)
            {
                ranges[numRanges].RangeType          = D3D12_DESCRIPTOR_RANGE_TYPE.CBV;
                ranges[numRanges].NumDescriptors     = 1;
                ranges[numRanges].BaseShaderRegister = 0; // Starts at c0
                ranges[numRanges].RegisterSpace      = 0; // Space 0
                ranges[numRanges].Flags              = D3D12_DESCRIPTOR_RANGE_FLAGS.DESCRIPTORS_VOLATILE;
                numRanges++;
            }

            param.ParameterType              = D3D12_ROOT_PARAMETER_TYPE.DESCRIPTOR_TABLE;
            param.DescriptorTable.NumDescriptorRanges = numRanges;
            param.DescriptorTable.pDescriptorRanges   = ranges.ptr;
        }

        D3D12_VERSIONED_ROOT_SIGNATURE_DESC rsDesc;
        rsDesc.Version                    = D3D_ROOT_SIGNATURE_VERSION._1_1;
        rsDesc.Desc_1_1.NumParameters     = 1;
        rsDesc.Desc_1_1.pParameters       = &param;
        rsDesc.Desc_1_1.NumStaticSamplers = 0;
        rsDesc.Desc_1_1.pStaticSamplers   = null;
        rsDesc.Desc_1_1.Flags             = flags;

        ID3DBlob rsBlob, rsErr;
        auto hr = D3D12SerializeVersionedRootSignature(&rsDesc, &rsBlob, &rsErr);
        if (FAILED(hr))
        {
            checkErrors(hr); // Will throw
        }

        ID3D12RootSignature rootSig;
        hr = device.raw.CreateRootSignature(
            0, // node mask
            rsBlob.GetBufferPointer(),
            rsBlob.GetBufferSize(),
            &IID_ID3D12RootSignature,
            cast(void**)&rootSig
        );

        rsBlob.Release();
        if (rsErr !is null)
            rsErr.Release();

        checkErrors(hr);

        return rootSig;
    }

    /// Create a kernel (PSO) by name, with N UAV bindings and optional CBV.
    /// Results are heavily cached because CreateComputePipelineState is incredibly expensive.
    Kernel!void getKernelByName(string name, uint numUAVs = 1, bool hasCBV = false)
    {
        import dcompute.driver.d3d12.context : Context;
        
        // 1. Check the cache (O(1) fast path)
        if (auto cached = name in _kernelCache)
        {
            return *cached;
        }

        Kernel!void ret;

        auto device = Context.current.device;
        if (device.raw is null)
            return ret;

        // Build the root signature dynamically based on argument count
        ret.rootSignature = buildRootSignature(device, numUAVs, hasCBV);
        if (ret.rootSignature is null)
            return ret;

        // Build the compute PSO
        D3D12_COMPUTE_PIPELINE_STATE_DESC psoDesc;
        psoDesc.pRootSignature      = cast(void*)ret.rootSignature;
        psoDesc.CS.pShaderBytecode  = dxilBlob.ptr;
        psoDesc.CS.BytecodeLength   = dxilBlob.length;
        psoDesc.NodeMask            = 0;

        auto hr = device.raw.CreateComputePipelineState(
            &psoDesc,
            &IID_ID3D12PipelineState,
            cast(void**)&ret.pipelineState
        );

        if (FAILED(hr))
        {
            ret.rootSignature.Release();
            checkErrors(hr); // Will throw
        }

        // 2. Cache it for all future dispatches!
        _kernelCache[name] = ret;

        return ret;
    }

    /// Compile-time kernel lookup (mirrors CUDA Program.getKernel).
    Kernel!(typeof(k)) getKernel(alias k)()
    {
        import dcompute.driver.d3d12.traits : countUAVs, countScalars;
        enum numUAVs = countUAVs!k;
        enum hasCBV  = countScalars!k > 0;

        // Note: k.mangleof is a string at compile time
        return cast(typeof(return)) getKernelByName(k.mangleof, numUAVs > 0 ? numUAVs : 1, hasCBV);
    }

    /// Load a DXIL blob from a file path.
    static Program fromFile(string path)
    {
        Program ret;
        import std.file : read;
        auto data = cast(const(ubyte)[]) read(path);
        ret.dxilBlob = data;
        return ret;
    }

    /// Load a DXIL blob from a byte array (for embedded blobs).
    static Program fromBytes(const(ubyte)[] blob)
    {
        Program ret;
        ret.dxilBlob = blob;
        return ret;
    }

    /// LDC embeds DXIL blobs as __dcompute_dxil_* globals.
    /// Similar to CUDA's __dcompute_ptx_* mechanism.
    static if (__VERSION__ >= 2113)
    static Program fromModule(string moduleName)()
    {
        version      (DComputeDirectX_660) enum _arch = "directx660";
        else version (DComputeDirectX_680) enum _arch = "directx680";
        else static assert(false,
            "Add a DComputeDirectX_XXX version to your dub config " ~
            "matching your --mdcompute-targets=directx-XXX dflag. " ~
            "Example: \"versions\": [\"DComputeDirectX_660\"]");

        import std.array : replace;
        enum mangledName = moduleName.replace(".", "_");
        enum symbolName  = "__dcompute_dxil_" ~ _arch ~ "_" ~ mangledName;

        mixin("pragma(mangle, \"" ~ symbolName ~ "\") extern(C) extern __gshared const ubyte " ~ symbolName ~ ";");

        Program ret;
        // The embedded blob starts at the symbol address; length is baked
        // into the DXBC container header (bytes 24-27, little-endian).
        mixin("const(ubyte)* base = &" ~ symbolName ~ ";");
        // Read DXBC container size from header
        uint containerSize = *cast(const(uint)*)(base + 24);
        ret.dxilBlob = base[0 .. containerSize];
        return ret;
    }

    __gshared static Program globalProgram;

    void unload()
    {
        foreach (k, kernel; _kernelCache)
        {
            if (kernel.pipelineState !is null) kernel.pipelineState.Release();
            if (kernel.rootSignature !is null) kernel.rootSignature.Release();
        }
        _kernelCache.clear();
        dxilBlob = null;
    }
}

// Forward-declare Runtime so program.d can reference it
import dcompute.driver.d3d12.runtime;
alias Runtime = dcompute.driver.d3d12.runtime.Runtime;
