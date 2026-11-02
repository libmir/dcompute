module dcompute.driver.d3d12.memory;

import dcompute.driver.d3d12.bindings;
import dcompute.driver.d3d12.device;
import dcompute.driver.d3d12.error;
import dcompute.driver.d3d12.runtime;
import dcompute.driver.d3d12.context;

/// Void pointer equivalent for D3D12 GPU memory.
/// Mirrors dcompute.driver.cuda.memory.MemoryPointer
struct MemoryPointer
{
    ID3D12Resource raw;
    
    /// Allocates an untyped block of GPU-only memory (DEFAULT heap).
    static MemoryPointer allocate(size_t nbytes)
    {
        MemoryPointer ret;
        auto device = Context.current.device.raw;
        if (device is null) return ret;

        D3D12_HEAP_PROPERTIES hp;
        hp.Type = D3D12_HEAP_TYPE.DEFAULT;
        hp.CPUPageProperty = D3D12_CPU_PAGE_PROPERTY.UNKNOWN;
        hp.MemoryPoolPreference = D3D12_MEMORY_POOL.UNKNOWN;
        hp.CreationNodeMask = 0;
        hp.VisibleNodeMask = 0;

        D3D12_RESOURCE_DESC rd;
        rd.Dimension        = D3D12_RESOURCE_DIMENSION.BUFFER;
        rd.Alignment        = 0;
        rd.Width            = nbytes;
        rd.Height           = 1;
        rd.DepthOrArraySize = 1;
        rd.MipLevels        = 1;
        rd.SampleDesc.Count = 1;
        rd.SampleDesc.Quality = 0;
        rd.Layout           = D3D12_TEXTURE_LAYOUT.ROW_MAJOR;
        rd.Flags            = D3D12_RESOURCE_FLAGS.ALLOW_UNORDERED_ACCESS;
        rd.Format           = DXGI_FORMAT.UNKNOWN;

        auto hr = device.CreateCommittedResource(
            &hp,
            D3D12_HEAP_FLAGS.NONE,
            &rd,
            D3D12_RESOURCE_STATES.COMMON,
            null,
            &IID_ID3D12Resource,
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
    }
}

/// Void[] equivalent for D3D12 GPU memory.
/// Mirrors dcompute.driver.cuda.memory.Memory
struct Memory
{
    MemoryPointer ptr;
    size_t length;

    enum CopySource
    {
        Host,
        Device,
        Array
    }
    
    // Note: In D3D12, copies must be executed via CommandLists.
    // Untyped raw copying is supported by Buffer!T.copy for structured execution.
    // This wrapper is provided for parity with the CUDA backend's raw memory management.
    
    void release()
    {
        ptr.release();
        length = 0;
    }
}
