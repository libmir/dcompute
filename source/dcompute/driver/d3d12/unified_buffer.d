/**
 * Unified Memory (Managed Memory) buffer for D3D12.
 *
 * A UnifiedBuffer!T allocates memory that is accessible from both the host
 * (CPU) and the device (GPU) through a single pointer. In D3D12, this is
 * achieved by creating a CUSTOM heap in system memory (L0) with WRITE_BACK
 * CPU page properties, allowing both `Map()` for the CPU and Unordered Access
 * Views (UAVs) for the GPU.
 */
module dcompute.driver.d3d12.unified_buffer;

import dcompute.driver.d3d12.bindings;
import dcompute.driver.d3d12.device;
import dcompute.driver.d3d12.error;
import dcompute.driver.d3d12.buffer;

struct UnifiedBuffer(T)
{
    ID3D12Resource  gpuResource;
    size_t          numElements;
    ID3D12Device    device;

    private T[]     _hostSlice;

    // ------------------------------------------------------------------
    // Construction
    // ------------------------------------------------------------------

    @trusted this(size_t elems)
    {
        import dcompute.driver.d3d12.runtime : Runtime;
        device = Runtime.defaultDevice.raw;
        numElements = elems;

        if (device is null) return;

        // Custom heap to allow both CPU access and GPU UAVs
        D3D12_HEAP_PROPERTIES hp;
        hp.Type = D3D12_HEAP_TYPE_CUSTOM;
        hp.CPUPageProperty = D3D12_CPU_PAGE_PROPERTY_WRITE_BACK;
        hp.MemoryPoolPreference = D3D12_MEMORY_POOL_L0; // System memory
        hp.CreationNodeMask = 0;
        hp.VisibleNodeMask = 0;

        D3D12_RESOURCE_DESC rd;
        rd.Dimension        = D3D12_RESOURCE_DIMENSION_BUFFER;
        rd.Alignment        = 0;
        rd.Width            = elems * T.sizeof;
        rd.Height           = 1;
        rd.DepthOrArraySize = 1;
        rd.MipLevels        = 1;
        rd.Format           = DXGI_FORMAT_UNKNOWN;
        rd.SampleDesc.Count = 1;
        rd.SampleDesc.Quality = 0;
        rd.Layout           = D3D12_TEXTURE_LAYOUT_ROW_MAJOR;
        rd.Flags            = D3D12_RESOURCE_FLAG_ALLOW_UNORDERED_ACCESS; // Required for compute kernels

        auto hr = device.CreateCommittedResource(
            &hp,
            D3D12_HEAP_FLAG_NONE,
            &rd,
            D3D12_RESOURCE_STATE_UNORDERED_ACCESS, // GPU ready
            null,
            &IID_ID3D12Resource,
            cast(void**)&gpuResource
        );
        checkErrors(hr);

        if (gpuResource !is null)
        {
            // Permanently map the buffer for the CPU
            void* mapped;
            D3D12_RANGE readRange = D3D12_RANGE(0, 0); // No immediate read
            hr = gpuResource.Map(0, &readRange, &mapped);
            checkErrors(hr);
            
            if (SUCCEEDED(hr) && mapped !is null)
            {
                _hostSlice = (cast(T*)mapped)[0 .. elems];
            }
        }
    }

    this(T[] arr)
    {
        this(arr.length);
        _hostSlice[] = arr[];
    }

    // ------------------------------------------------------------------
    // Host-side access
    // ------------------------------------------------------------------

    @property @trusted T[] hostSlice()
    {
        return _hostSlice;
    }

    @property size_t length() const { return numElements; }

    @trusted void release()
    {
        if (gpuResource !is null)
        {
            gpuResource.Unmap(0, null);
            gpuResource.Release();
            gpuResource = null;
        }
        _hostSlice = null;
        numElements = 0;
    }

    // ------------------------------------------------------------------
    // DCompute Interop
    // ------------------------------------------------------------------

    alias hostArgOf(U : GlobalPointer!T) = gpuResource;

    @property Buffer!T asBuffer()
    {
        Buffer!T b;
        b.gpuResource = gpuResource;
        b.hostMemory  = _hostSlice;
        b.numElements = numElements;
        b.device      = device;
        return b;
    }

    alias this = asBuffer;
}

import ldc.dcompute : GlobalPointer;
