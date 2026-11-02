module dcompute.driver.d3d12.buffer;

import dcompute.driver.d3d12.bindings;
import dcompute.driver.d3d12.device;
import dcompute.driver.d3d12.error;

/// Copy direction for host ↔ device transfers.
enum Copy {
    hostToDevice,
    deviceToHost,
}

/// D3D12 buffer: wraps a committed GPU resource with host memory shadow.
/// Mirrors dcompute.driver.cuda.buffer.
///
/// D3D12 memory model:
///   - DEFAULT heap  = GPU-local VRAM (fast compute access, no CPU mapping)
///   - UPLOAD heap   = CPU-writable, GPU-readable (for hostToDevice)
///   - READBACK heap = GPU-writable, CPU-readable (for deviceToHost)
///
/// This struct manages all three heaps transparently.
struct Buffer(T)
{
    ID3D12Resource  gpuResource;      // DEFAULT heap — UAV target
    ID3D12Resource  uploadResource;   // UPLOAD heap for hostToDevice
    ID3D12Resource  readbackResource; // READBACK heap for deviceToHost
    T[]             hostMemory;       // Host-side shadow
    size_t          numElements;
    ID3D12Device    device;           // cached reference

    this(size_t elems)
    {
        import dcompute.driver.d3d12.runtime : Runtime;
        device = Runtime.defaultDevice.raw;
        numElements = elems;

        if (device is null) return;

        // Create DEFAULT heap resource (GPU-local, UAV-capable)
        D3D12_HEAP_PROPERTIES hp;
        hp.Type = D3D12_HEAP_TYPE.DEFAULT;

        D3D12_RESOURCE_DESC rd;
        rd.Dimension        = D3D12_RESOURCE_DIMENSION.BUFFER;
        rd.Width            = elems * T.sizeof;
        rd.Height           = 1;
        rd.DepthOrArraySize = 1;
        rd.MipLevels        = 1;
        rd.SampleDesc.Count = 1;
        rd.Layout           = D3D12_TEXTURE_LAYOUT.ROW_MAJOR;
        rd.Flags            = D3D12_RESOURCE_FLAGS.ALLOW_UNORDERED_ACCESS;

        auto hr = device.CreateCommittedResource(
            &hp,
            D3D12_HEAP_FLAGS.NONE,
            &rd,
            D3D12_RESOURCE_STATES.UNORDERED_ACCESS,
            null, // no clear value for buffers
            &IID_ID3D12Resource,
            cast(void**)&gpuResource
        );
        checkErrors(hr);
    }

    this(T[] arr)
    {
        this(arr.length);
        hostMemory = arr;
    }

    /// Transfer data between host and device.
    /// In a full implementation this requires a command list to execute
    /// CopyResource between the staging and GPU resources.
    void copy(Copy c)()
    {
        if (device is null || gpuResource is null) return;

        static if (c == Copy.hostToDevice)
        {
            // 1. Lazy allocation of upload heap staging buffer
            if (uploadResource is null)
            {
                uploadResource = createStagingBuffer(D3D12_HEAP_TYPE.UPLOAD, D3D12_RESOURCE_STATES.GENERIC_READ);
            }
            if (uploadResource is null) return;

            // 2. Map upload buffer, copy host data in
            void* mapped;
            D3D12_RANGE readRange = D3D12_RANGE(0, 0); // we won't read
            auto hr = uploadResource.Map(0, &readRange, &mapped);
            checkErrors(hr);
            if (mapped !is null)
            {
                import core.stdc.string : memcpy;
                memcpy(mapped, hostMemory.ptr, hostMemory.length * T.sizeof);
                D3D12_RANGE writeRange = D3D12_RANGE(0, hostMemory.length * T.sizeof);
                uploadResource.Unmap(0, &writeRange);
            }

            // 3. Execute GPU copy
            import dcompute.driver.d3d12.runtime : Runtime;
            import dcompute.driver.d3d12.bindings : D3D12_RESOURCE_STATES;
            import dcompute.driver.d3d12.event : Event;
            
            auto copyQ = Runtime.defaultCopyQueue();
            auto compQ = Runtime.defaultQueue();
            
            // a) Compute queue: Transition GPU buffer from UAV to COMMON
            Event preCopyEvent = compQ.transitionResource(
                gpuResource, 
                D3D12_RESOURCE_STATES.UNORDERED_ACCESS, 
                D3D12_RESOURCE_STATES.COMMON
            );
            
            // b) Copy queue: Wait for Compute queue to finish transition, then copy
            copyQ.wait(preCopyEvent);
            Event copyEvent = copyQ.executeCopy(gpuResource, uploadResource);
            
            // c) Compute queue: Wait for Copy queue to finish, then transition back to UAV
            compQ.wait(copyEvent);
            Event postCopyEvent = compQ.transitionResource(
                gpuResource,
                D3D12_RESOURCE_STATES.COMMON,
                D3D12_RESOURCE_STATES.UNORDERED_ACCESS
            );
        }
        else static if (c == Copy.deviceToHost)
        {
            // 1. Lazy allocation of readback heap staging buffer
            if (readbackResource is null)
            {
                readbackResource = createStagingBuffer(D3D12_HEAP_TYPE.READBACK, D3D12_RESOURCE_STATES.COPY_DEST);
            }
            if (readbackResource is null) return;

            // 2. Execute GPU copy
            import dcompute.driver.d3d12.runtime : Runtime;
            import dcompute.driver.d3d12.bindings : D3D12_RESOURCE_STATES;
            import dcompute.driver.d3d12.event : Event;
            
            auto copyQ = Runtime.defaultCopyQueue();
            auto compQ = Runtime.defaultQueue();
            
            // a) Compute queue: Transition GPU buffer from UAV to COMMON
            Event preCopyEvent = compQ.transitionResource(
                gpuResource, 
                D3D12_RESOURCE_STATES.UNORDERED_ACCESS, 
                D3D12_RESOURCE_STATES.COMMON
            );
            
            // b) Copy queue: Wait for Compute queue to finish transition, then copy
            copyQ.wait(preCopyEvent);
            Event copyEvent = copyQ.executeCopy(readbackResource, gpuResource);
            
            // c) Compute queue: Wait for Copy queue to finish, then transition back to UAV
            compQ.wait(copyEvent);
            Event postCopyEvent = compQ.transitionResource(
                gpuResource,
                D3D12_RESOURCE_STATES.COMMON,
                D3D12_RESOURCE_STATES.UNORDERED_ACCESS
            );
            
            // Sync host (this blocks the CPU until the copy is done so we can safely read)
            copyEvent.wait();
            
            // Note: readBack() should be called after this completes to map memory
        }
    }

    /// After a deviceToHost copy + queue wait, map the readback buffer
    /// and copy data into hostMemory.
    void readBack()
    {
        if (readbackResource is null || hostMemory is null) return;

        void* mapped;
        D3D12_RANGE readRange = D3D12_RANGE(0, numElements * T.sizeof);
        auto hr = readbackResource.Map(0, &readRange, &mapped);
        checkErrors(hr);
        if (SUCCEEDED(hr) && mapped !is null)
        {
            import core.stdc.string : memcpy;
            memcpy(hostMemory.ptr, mapped, numElements * T.sizeof);
            readbackResource.Unmap(0, null);
        }
    }

    /// Create a staging buffer (upload or readback).
    private ID3D12Resource createStagingBuffer(D3D12_HEAP_TYPE heapType, D3D12_RESOURCE_STATES initialState)
    {
        D3D12_HEAP_PROPERTIES hp;
        hp.Type = heapType;

        D3D12_RESOURCE_DESC rd;
        rd.Dimension        = D3D12_RESOURCE_DIMENSION.BUFFER;
        rd.Width            = numElements * T.sizeof;
        rd.Height           = 1;
        rd.DepthOrArraySize = 1;
        rd.MipLevels        = 1;
        rd.SampleDesc.Count = 1;
        rd.Layout           = D3D12_TEXTURE_LAYOUT.ROW_MAJOR;
        rd.Flags            = D3D12_RESOURCE_FLAGS.NONE;

        ID3D12Resource res;
        auto hr = device.CreateCommittedResource(
            &hp,
            D3D12_HEAP_FLAGS.NONE,
            &rd,
            initialState,
            null,
            &IID_ID3D12Resource,
            cast(void**)&res
        );
        checkErrors(hr);
        return res;
    }

    /// Map kernel GlobalPointer argument to the underlying GPU resource.
    /// This is the bridge between dcompute's type system and D3D12.
    alias hostArgOf(U : GlobalPointer!T) = gpuResource;

    void release()
    {
        if (gpuResource !is null)
        {
            gpuResource.Release();
            gpuResource = null;
        }
        if (uploadResource !is null)
        {
            uploadResource.Release();
            uploadResource = null;
        }
        if (readbackResource !is null)
        {
            readbackResource.Release();
            readbackResource = null;
        }
        hostMemory = null;
    }
}

// Forward import for GlobalPointer
import ldc.dcompute : GlobalPointer;

alias bf = Buffer!float;
