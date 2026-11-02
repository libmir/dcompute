module dcompute.driver.d3d12.device;

import dcompute.driver.d3d12.bindings;
import dcompute.driver.d3d12.error;

/// D3D12 device: wraps adapter enumeration and ID3D12Device creation.
/// Mirrors dcompute.driver.cuda.device — one Device per physical adapter.
struct Device
{
    ID3D12Device    raw;
    IDXGIAdapter1   adapter;

    /// Device capability information (D3D12 equivalent of CUDA Device.Info).
    static struct Info
    {
        wchar[128] description;
        uint vendorId;
        uint deviceId;
        size_t dedicatedVideoMemory;
        size_t dedicatedSystemMemory;
        size_t sharedSystemMemory;
        bool isSoftware;
    }

    /// Retrieve adapter metadata.
    @property Info info()
    {
        Info ret;
        if (adapter is null) return ret;

        DXGI_ADAPTER_DESC1 desc;
        adapter.GetDesc1(&desc);

        ret.description           = desc.Description;
        ret.vendorId              = desc.VendorId;
        ret.deviceId              = desc.DeviceId;
        ret.dedicatedVideoMemory  = desc.DedicatedVideoMemory;
        ret.dedicatedSystemMemory = desc.DedicatedSystemMemory;
        ret.sharedSystemMemory    = desc.SharedSystemMemory;
        ret.isSoftware            = (desc.Flags & DXGI_ADAPTER_FLAG_SOFTWARE) != 0;
        return ret;
    }

    @property size_t totalMemory()
    {
        auto i = info;
        return i.dedicatedVideoMemory;
    }

    /// True if the device supports Unified Shared Memory (USM).
    /// In D3D12, this is true if the architecture is Cache Coherent UMA,
    /// allowing CPU to map memory with WRITE_BACK properties (Custom Heaps).
    @property bool supportsUnifiedMemory()
    {
        if (raw is null) return false;
        
        D3D12_FEATURE_DATA_ARCHITECTURE1 arch = {0};
        // D3D12_FEATURE_ARCHITECTURE1 requires NodeIndex to be set
        arch.NodeIndex = 0;
        
        auto hr = raw.CheckFeatureSupport(D3D12_FEATURE.ARCHITECTURE1, &arch, arch.sizeof);
        if (SUCCEEDED(hr))
        {
            return arch.CacheCoherentUMA != 0;
        }
        
        // Fallback to older D3D12_FEATURE_ARCHITECTURE if 1 is not supported
        D3D12_FEATURE_DATA_ARCHITECTURE arch0 = {0};
        arch0.NodeIndex = 0;
        hr = raw.CheckFeatureSupport(D3D12_FEATURE.ARCHITECTURE, &arch0, arch0.sizeof);
        if (SUCCEEDED(hr))
        {
            return arch0.CacheCoherentUMA != 0;
        }
        
        return false;
    }

    // ── Advanced Capability Queries ──────────────────────────────────────

    /// Queries the highest Shader Model the hardware supports.
    /// The API works by "clamping": you set the max you want, and the
    /// driver writes back the actual max it supports (never higher).
    /// We probe from SM 6.8 downward.
    @property D3D_SHADER_MODEL highestShaderModel()
    {
        if (raw is null) return D3D_SHADER_MODEL._5_1;

        D3D12_FEATURE_DATA_SHADER_MODEL sm;
        sm.HighestShaderModel = D3D_SHADER_MODEL._6_8; // probe for the highest

        auto hr = raw.CheckFeatureSupport(
            D3D12_FEATURE.SHADER_MODEL,
            &sm,
            sm.sizeof
        );

        if (SUCCEEDED(hr))
            return sm.HighestShaderModel;

        // Fallback: if the runtime doesn't even know about SM 6.8,
        // try SM 6.6 (the bindless minimum).
        sm.HighestShaderModel = D3D_SHADER_MODEL._6_6;
        hr = raw.CheckFeatureSupport(
            D3D12_FEATURE.SHADER_MODEL,
            &sm,
            sm.sizeof
        );

        if (SUCCEEDED(hr))
            return sm.HighestShaderModel;

        return D3D_SHADER_MODEL._5_1;
    }

    /// Queries the Resource Binding Tier.
    /// Tier 3 = full bindless heap access (all descriptors accessible
    /// from any shader stage without root signature limits).
    @property D3D12_RESOURCE_BINDING_TIER resourceBindingTier()
    {
        if (raw is null) return D3D12_RESOURCE_BINDING_TIER.TIER_1;

        D3D12_FEATURE_DATA_D3D12_OPTIONS opts;
        auto hr = raw.CheckFeatureSupport(
            D3D12_FEATURE.OPTIONS,
            &opts,
            opts.sizeof
        );

        if (SUCCEEDED(hr))
            return opts.ResourceBindingTier;

        return D3D12_RESOURCE_BINDING_TIER.TIER_1;
    }

    /// True if the hardware supports SM 6.6 Dynamic Resources (Bindless).
    /// Requirements: Shader Model >= 6.6 AND Resource Binding Tier 3.
    /// When true, LDC can lower GlobalPointer!T to a 32-bit descriptor
    /// heap index instead of requiring explicit Root Signature UAV slots.
    @property bool supportsBindless()
    {
        return highestShaderModel >= D3D_SHADER_MODEL._6_6
            && resourceBindingTier >= D3D12_RESOURCE_BINDING_TIER.TIER_3;
    }

    /// True if the hardware supports Wave Intrinsics (SM 6.0+).
    /// Wave ops (WaveGetLaneIndex, WaveActiveSum, etc.) are the D3D12
    /// equivalent of CUDA warp-level primitives.
    @property bool supportsWaveIntrinsics()
    {
        return highestShaderModel >= D3D_SHADER_MODEL._6_0;
    }

    /// Create a D3D12 device on a specific adapter.
    static Device create(IDXGIAdapter1 adap, D3D_FEATURE_LEVEL level = D3D_FEATURE_LEVEL._11_0)
    {
        Device ret;
        ret.adapter = adap;
        auto hr = D3D12CreateDevice(
            cast(void*)adap,
            level,
            &IID_ID3D12Device,
            cast(void**)&ret.raw
        );
        checkErrors(hr);
        return ret;
    }

    void release()
    {
        if (raw !is null)
        {
            raw.Release();
            raw = null;
        }
        if (adapter !is null)
        {
            adapter.Release();
            adapter = null;
        }
    }
}
