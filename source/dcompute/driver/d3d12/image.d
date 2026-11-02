module dcompute.driver.d3d12.image;

import dcompute.driver.d3d12.bindings;
import dcompute.driver.d3d12.device;
import dcompute.driver.d3d12.error;
import dcompute.driver.d3d12.buffer : Copy;

/// D3D12 Image (Texture): wraps a committed GPU texture resource with host memory shadow.
///
/// Unlike Buffer, Image uses a swizzled GPU memory layout (D3D12_TEXTURE_LAYOUT.UNKNOWN).
/// Copying requires mapping host memory into a staging footprint buffer,
/// and executing a CopyTextureRegion command to swizzle/unswizzle.
struct Image(uint Dim, T)
{
    static assert(Dim >= 1 && Dim <= 3, "Image dimension must be 1, 2, or 3");

    ID3D12Resource  gpuResource;
    ID3D12Resource  uploadResource;
    ID3D12Resource  readbackResource;
    T[]             hostMemory;
    uint            width, height, depth;
    ID3D12Device    device;

    this(uint w, uint h = 1, uint d = 1)
    {
        import dcompute.driver.d3d12.runtime : Runtime;
        device = Runtime.defaultDevice.raw;
        width = w;
        height = h;
        depth = d;

        if (device is null) return;

        D3D12_HEAP_PROPERTIES hp;
        hp.Type = D3D12_HEAP_TYPE.DEFAULT;

        D3D12_RESOURCE_DESC rd;
        if (Dim == 1) rd.Dimension = D3D12_RESOURCE_DIMENSION.TEXTURE1D;
        else if (Dim == 2) rd.Dimension = D3D12_RESOURCE_DIMENSION.TEXTURE2D;
        else rd.Dimension = D3D12_RESOURCE_DIMENSION.TEXTURE3D;

        rd.Width            = w;
        rd.Height           = h;
        rd.DepthOrArraySize = cast(ushort)d;
        rd.MipLevels        = 1;
        rd.SampleDesc.Count = 1;
        
        // Let driver choose the best swizzled layout
        rd.Layout = D3D12_TEXTURE_LAYOUT.UNKNOWN;
        
        // Use R32_FLOAT if T is float, R32_UINT if T is uint. 
        // A full implementation would use a type traits map.
        static if (is(T == float))
            rd.Format = DXGI_FORMAT.R32_FLOAT;
        else static if (is(T == uint))
            rd.Format = DXGI_FORMAT.R32_UINT;
        else
            static assert(0, "Unsupported Image format");

        rd.Flags = D3D12_RESOURCE_FLAGS.ALLOW_UNORDERED_ACCESS;

        auto hr = device.CreateCommittedResource(
            &hp,
            D3D12_HEAP_FLAGS.NONE,
            &rd,
            D3D12_RESOURCE_STATES.UNORDERED_ACCESS, // Ready for compute UAV
            null,
            &IID_ID3D12Resource,
            cast(void**)&gpuResource
        );
        checkErrors(hr);
    }

    this(T[] arr, uint w, uint h = 1, uint d = 1)
    {
        this(w, h, d);
        hostMemory = arr;
    }

    void copy(Copy c)()
    {
        if (device is null || gpuResource is null) return;

        // Get the required footprint size and row pitch
        D3D12_RESOURCE_DESC rd;
        if (Dim == 1) rd.Dimension = D3D12_RESOURCE_DIMENSION.TEXTURE1D;
        else if (Dim == 2) rd.Dimension = D3D12_RESOURCE_DIMENSION.TEXTURE2D;
        else rd.Dimension = D3D12_RESOURCE_DIMENSION.TEXTURE3D;
        
        rd.Width            = width;
        rd.Height           = height;
        rd.DepthOrArraySize = cast(ushort)depth;
        rd.MipLevels        = 1;
        rd.SampleDesc.Count = 1;
        rd.Layout = D3D12_TEXTURE_LAYOUT.UNKNOWN;
        static if (is(T == float)) rd.Format = DXGI_FORMAT.R32_FLOAT;
        else static if (is(T == uint)) rd.Format = DXGI_FORMAT.R32_UINT;
        
        ulong totalBytes;
        D3D12_PLACED_SUBRESOURCE_FOOTPRINT footprint;
        uint numRows;
        ulong rowSizeInBytes;
        device.GetCopyableFootprints(&rd, 0, 1, 0, &footprint, &numRows, &rowSizeInBytes, &totalBytes);

        static if (c == Copy.hostToDevice)
        {
            if (uploadResource is null)
                uploadResource = createStagingBuffer(D3D12_HEAP_TYPE.UPLOAD, D3D12_RESOURCE_STATES.GENERIC_READ, totalBytes);
            if (uploadResource is null) return;

            // Map and write respecting RowPitch alignment
            void* mapped;
            D3D12_RANGE readRange = D3D12_RANGE(0, 0);
            auto hr = uploadResource.Map(0, &readRange, &mapped);
            checkErrors(hr);
            if (mapped !is null)
            {
                import core.stdc.string : memcpy;
                ubyte* pDest = cast(ubyte*)mapped;
                const(ubyte)* pSrc = cast(const(ubyte)*)hostMemory.ptr;
                
                uint srcRowPitch = width * T.sizeof;
                for (uint z = 0; z < depth; ++z)
                {
                    for (uint y = 0; y < height; ++y)
                    {
                        memcpy(pDest + footprint.Offset + z * footprint.Footprint.Height * footprint.Footprint.RowPitch + y * footprint.Footprint.RowPitch,
                               pSrc + z * height * srcRowPitch + y * srcRowPitch,
                               srcRowPitch);
                    }
                }
                
                D3D12_RANGE writeRange = D3D12_RANGE(0, totalBytes);
                uploadResource.Unmap(0, &writeRange);
            }

            D3D12_TEXTURE_COPY_LOCATION dstLoc;
            dstLoc.pResource = gpuResource;
            dstLoc.Type = D3D12_TEXTURE_COPY_TYPE.SUBRESOURCE_INDEX;
            dstLoc.u.SubresourceIndex = 0;

            D3D12_TEXTURE_COPY_LOCATION srcLoc;
            srcLoc.pResource = uploadResource;
            srcLoc.Type = D3D12_TEXTURE_COPY_TYPE.PLACED_FOOTPRINT;
            srcLoc.u.PlacedFootprint = footprint;

            import dcompute.driver.d3d12.event : Event;
            
            auto copyQ = Runtime.defaultCopyQueue();
            auto compQ = Runtime.defaultQueue();
            
            Event preCopyEvent = compQ.transitionResource(
                gpuResource,
                D3D12_RESOURCE_STATES.UNORDERED_ACCESS,
                D3D12_RESOURCE_STATES.COMMON
            );
            
            copyQ.wait(preCopyEvent);
            Event copyEvent = copyQ.executeTextureCopy(&dstLoc, &srcLoc);
            
            compQ.wait(copyEvent);
            Event postCopyEvent = compQ.transitionResource(
                gpuResource,
                D3D12_RESOURCE_STATES.COMMON,
                D3D12_RESOURCE_STATES.UNORDERED_ACCESS
            );
        }
        else static if (c == Copy.deviceToHost)
        {
            if (readbackResource is null)
                readbackResource = createStagingBuffer(D3D12_HEAP_TYPE.READBACK, D3D12_RESOURCE_STATES.COPY_DEST, totalBytes);
            if (readbackResource is null) return;

            D3D12_TEXTURE_COPY_LOCATION dstLoc;
            dstLoc.pResource = readbackResource;
            dstLoc.Type = D3D12_TEXTURE_COPY_TYPE.PLACED_FOOTPRINT;
            dstLoc.u.PlacedFootprint = footprint;

            D3D12_TEXTURE_COPY_LOCATION srcLoc;
            srcLoc.pResource = gpuResource;
            srcLoc.Type = D3D12_TEXTURE_COPY_TYPE.SUBRESOURCE_INDEX;
            srcLoc.u.SubresourceIndex = 0;

            import dcompute.driver.d3d12.event : Event;
            
            auto copyQ = Runtime.defaultCopyQueue();
            auto compQ = Runtime.defaultQueue();
            
            Event preCopyEvent = compQ.transitionResource(
                gpuResource,
                D3D12_RESOURCE_STATES.UNORDERED_ACCESS,
                D3D12_RESOURCE_STATES.COMMON
            );
            
            copyQ.wait(preCopyEvent);
            Event copyEvent = copyQ.executeTextureCopy(&dstLoc, &srcLoc);
            
            compQ.wait(copyEvent);
            Event postCopyEvent = compQ.transitionResource(
                gpuResource,
                D3D12_RESOURCE_STATES.COMMON,
                D3D12_RESOURCE_STATES.UNORDERED_ACCESS
            );
            
            copyEvent.wait();
        }
    }

    void readBack()
    {
        if (readbackResource is null || hostMemory is null) return;

        D3D12_RESOURCE_DESC rd;
        rd.Width = width;
        rd.Height = height;
        rd.DepthOrArraySize = cast(ushort)depth;
        static if (is(T == float)) rd.Format = DXGI_FORMAT.R32_FLOAT;
        else static if (is(T == uint)) rd.Format = DXGI_FORMAT.R32_UINT;
        
        ulong totalBytes;
        D3D12_PLACED_SUBRESOURCE_FOOTPRINT footprint;
        uint numRows;
        ulong rowSizeInBytes;
        device.GetCopyableFootprints(&rd, 0, 1, 0, &footprint, &numRows, &rowSizeInBytes, &totalBytes);

        void* mapped;
        D3D12_RANGE readRange = D3D12_RANGE(0, totalBytes);
        auto hr = readbackResource.Map(0, &readRange, &mapped);
        checkErrors(hr);
        if (SUCCEEDED(hr) && mapped !is null)
        {
            import core.stdc.string : memcpy;
            ubyte* pSrc = cast(ubyte*)mapped;
            ubyte* pDest = cast(ubyte*)hostMemory.ptr;
            
            uint dstRowPitch = width * T.sizeof;
            for (uint z = 0; z < depth; ++z)
            {
                for (uint y = 0; y < height; ++y)
                {
                    memcpy(pDest + z * height * dstRowPitch + y * dstRowPitch,
                           pSrc + footprint.Offset + z * footprint.Footprint.Height * footprint.Footprint.RowPitch + y * footprint.Footprint.RowPitch,
                           dstRowPitch);
                }
            }
            readbackResource.Unmap(0, null);
        }
    }

    private ID3D12Resource createStagingBuffer(D3D12_HEAP_TYPE heapType, D3D12_RESOURCE_STATES initialState, ulong sizeBytes)
    {
        D3D12_HEAP_PROPERTIES hp;
        hp.Type = heapType;

        D3D12_RESOURCE_DESC rd;
        rd.Dimension        = D3D12_RESOURCE_DIMENSION.BUFFER;
        rd.Width            = sizeBytes;
        rd.Height           = 1;
        rd.DepthOrArraySize = 1;
        rd.MipLevels        = 1;
        rd.SampleDesc.Count = 1;
        rd.Layout           = D3D12_TEXTURE_LAYOUT.ROW_MAJOR;
        rd.Flags            = D3D12_RESOURCE_FLAGS.NONE;
        rd.Format           = DXGI_FORMAT.UNKNOWN;

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

    void release()
    {
        if (gpuResource !is null) { gpuResource.Release(); gpuResource = null; }
        if (uploadResource !is null) { uploadResource.Release(); uploadResource = null; }
        if (readbackResource !is null) { readbackResource.Release(); readbackResource = null; }
        hostMemory = null;
    }
}
