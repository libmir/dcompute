module dcompute.driver.d3d12.queue;

import dcompute.driver.d3d12.bindings;
import dcompute.driver.d3d12.device;
import dcompute.driver.d3d12.program;
import dcompute.driver.d3d12.runtime;
import dcompute.driver.d3d12.buffer;
import dcompute.driver.d3d12.event;
import dcompute.driver.d3d12.error;
import dcompute.driver.d3d12.context;

/// Structure to hold resources that are currently executing on the GPU.
/// D3D12 forbids resetting an allocator that is still in-flight.
struct InFlightResource {
    ID3D12CommandAllocator    allocator;
    ID3D12GraphicsCommandList commandList;
    ulong                     targetFence; // The fence value when this will be free
    ID3D12Resource[]          pendingReleases; // Resources to release when this fence passes
}

/// A command queue in D3D12. Mirrors dcompute.driver.cuda.queue.
///
/// Handles command list recording, descriptor heap allocation for kernel arguments,
/// and dispatching compute workloads asynchronously.
struct Queue
{
    ID3D12CommandQueue        raw;
    ID3D12Fence               fence;
    ulong                     fenceValue;
    HANDLE                    fenceEvent;
    ID3D12Device              device; // cached

    // Ring-buffer for true async execution
    InFlightResource[]        inFlightPool;
    
    // Bump-allocator Descriptor Heap (Shader Visible)
    ID3D12DescriptorHeap      globalDescriptorHeap;
    uint                      descriptorIncrementSize;
    uint                      currentDescriptorOffset;
    enum                      MAX_DESCRIPTORS = 65536;
    D3D12_COMMAND_LIST_TYPE   qType;

    this(D3D12_COMMAND_LIST_TYPE type)
    {
        device = Context.current.device.raw;
        if (device is null) return;
        
        qType = type;

        // 1. Create Command Queue
        D3D12_COMMAND_QUEUE_DESC qDesc;
        qDesc.Type = type;
        qDesc.Flags = 0;
        
        auto hr = device.CreateCommandQueue(
            &qDesc, &IID_ID3D12CommandQueue, cast(void**)&raw
        );
        checkErrors(hr);

        // 2. Create Sync Fence
        hr = device.CreateFence(
            0, D3D12_FENCE_FLAGS.NONE, &IID_ID3D12Fence, cast(void**)&fence
        );
        checkErrors(hr);
        
        fenceValue = 1;
        fenceEvent = CreateEventW(null, 0 /*FALSE*/, 0 /*FALSE*/, null);

        // 3. Create a single large Shader Visible Descriptor Heap (COMPUTE/DIRECT only)
        if (type != D3D12_COMMAND_LIST_TYPE.COPY)
        {
            D3D12_DESCRIPTOR_HEAP_DESC heapDesc;
            heapDesc.NumDescriptors = MAX_DESCRIPTORS;
            heapDesc.Type = D3D12_DESCRIPTOR_HEAP_TYPE.CBV_SRV_UAV;
            heapDesc.Flags = D3D12_DESCRIPTOR_HEAP_FLAGS.SHADER_VISIBLE;
            heapDesc.NodeMask = 0;

            hr = device.CreateDescriptorHeap(
                &heapDesc, &IID_ID3D12DescriptorHeap, cast(void**)&globalDescriptorHeap
            );
            checkErrors(hr);

            descriptorIncrementSize = device.GetDescriptorHandleIncrementSize(
                D3D12_DESCRIPTOR_HEAP_TYPE.CBV_SRV_UAV
            );
            currentDescriptorOffset = 0;
        }
    }
    
    // For backwards compatibility with old tests
    this(bool async) {
        this(D3D12_COMMAND_LIST_TYPE.DIRECT);
    }

    @property bool async()
    {
        return true; // We are now truly async!
    }

    /// Instructs the GPU command queue to wait for the given event (fence)
    /// to reach its target value, without blocking the CPU.
    /// Mirrors dcompute.driver.cuda.queue.wait(Event)
    void wait(Event e)
    {
        if (raw is null || e.q is null || e.q.fence is null) return;
        
        auto hr = raw.Wait(e.q.fence, e.targetValue);
        checkErrors(hr);
    }

    /// Retrieve an available command allocator/list from the pool,
    /// or create a new one if all are currently executing.
    private InFlightResource getAvailableResource()
    {
        ulong completed = fence.GetCompletedValue();

        // Search for an allocator the GPU has finished using
        foreach (ref res; inFlightPool)
        {
            if (res.targetFence <= completed)
            {
                // GPU is done with this! We can safely reset it.
                res.allocator.Reset();
                res.commandList.Reset(res.allocator, null);
                
                foreach (r; res.pendingReleases)
                {
                    if (r !is null) r.Release();
                }
                res.pendingReleases.length = 0;
                
                return res;
            }
        }

        // None available, create a new one (expands the pool)
        InFlightResource newRes;
        auto hr = device.CreateCommandAllocator(
            qType, &IID_ID3D12CommandAllocator, cast(void**)&newRes.allocator
        );
        checkErrors(hr);
        hr = device.CreateCommandList(
            0, qType, newRes.allocator, null, &IID_ID3D12GraphicsCommandList, cast(void**)&newRes.commandList
        );
        checkErrors(hr);

        // Store in pool
        newRes.targetFence = 0; // Available immediately
        inFlightPool ~= newRes;
        return newRes;
    }

    /// Internal helper: Execute a copy between resources.
    /// CRITICAL: D3D12 requires explicit resource state transitions (barriers)
    /// before and after CopyResource. Without them, GPU caches are incoherent
    /// and the copy produces undefined results or validation layer crashes.
    import dcompute.driver.d3d12.event : Event;
    
    Event executeCopy(ID3D12Resource dst, ID3D12Resource src)
    {
        if (raw is null) return Event(null, 0);
        
        auto res = getAvailableResource();

        // 2. Execute the copy
        // Copy queues rely on implicit state promotion (from COMMON to COPY_SOURCE/COPY_DEST)
        res.commandList.CopyResource(dst, src);

        res.commandList.Close();

        auto ppCommandLists = cast(ID3D12CommandList)res.commandList;
        raw.ExecuteCommandLists(1, &ppCommandLists);
        
        // Signal fence
        ulong fenceToWaitFor = fenceValue;
        raw.Signal(fence, fenceToWaitFor);
        fenceValue++;
        
        // Update the resource in the pool so it knows when it's free
        res.targetFence = fenceToWaitFor;

        return Event(&this, fenceToWaitFor);
    }

    /// Internal helper: Execute a texture copy between resources.
    Event executeTextureCopy(const(D3D12_TEXTURE_COPY_LOCATION)* dst, const(D3D12_TEXTURE_COPY_LOCATION)* src)
    {
        if (raw is null) return Event(null, 0);
        
        auto res = getAvailableResource();

        // 2. Execute the copy
        res.commandList.CopyTextureRegion(dst, 0, 0, 0, src, null);

        res.commandList.Close();

        auto ppCommandLists = cast(ID3D12CommandList)res.commandList;
        raw.ExecuteCommandLists(1, &ppCommandLists);
        
        ulong fenceToWaitFor = fenceValue;
        raw.Signal(fence, fenceToWaitFor);
        fenceValue++;
        
        res.targetFence = fenceToWaitFor;

        return Event(&this, fenceToWaitFor);
    }

    /// Internal helper: Issue explicit resource barriers on this queue.
    /// Used by Compute queues to transition resources to COMMON before handing them off
    /// to Copy queues, and back to UNORDERED_ACCESS when receiving them.
    Event transitionResource(ID3D12Resource resource, D3D12_RESOURCE_STATES stateBefore, D3D12_RESOURCE_STATES stateAfter)
    {
        if (raw is null || resource is null || stateBefore == stateAfter) return Event(null, 0);

        auto res = getAvailableResource();

        D3D12_RESOURCE_BARRIER barrier;
        barrier.Type = D3D12_RESOURCE_BARRIER_TYPE.TRANSITION;
        barrier.Flags = D3D12_RESOURCE_BARRIER_FLAGS.NONE;
        barrier.Transition.pResource = cast(void*)resource;
        barrier.Transition.Subresource = D3D12_RESOURCE_BARRIER_ALL_SUBRESOURCES;
        barrier.Transition.StateBefore = stateBefore;
        barrier.Transition.StateAfter = stateAfter;

        res.commandList.ResourceBarrier(1, &barrier);
        res.commandList.Close();

        auto ppCommandLists = cast(ID3D12CommandList)res.commandList;
        raw.ExecuteCommandLists(1, &ppCommandLists);

        ulong fenceToWaitFor = fenceValue;
        raw.Signal(fence, fenceToWaitFor);
        fenceValue++;
        
        res.targetFence = fenceToWaitFor;

        return Event(&this, fenceToWaitFor);
    }

    /// Drain all pending GPU work on this queue.
    /// Mirrors OpenCL's clFinish() — blocks the CPU until every
    /// command list submitted to this queue has completed execution.
    void finish()
    {
        if (raw is null || fence is null) return;

        ulong waitVal = fenceValue;
        raw.Signal(fence, waitVal);
        fenceValue++;

        if (fence.GetCompletedValue() < waitVal)
        {
            fence.SetEventOnCompletion(waitVal, fenceEvent);
            WaitForSingleObject(fenceEvent, INFINITE);
        }
    }

    /// The core dispatch function. Returns an Event for async synchronization!
    auto enqueue(alias k)(uint[3] _grid, uint[3] _block, uint _sharedMem = 0)
    {
        static struct Call
        {
            Queue* q;
            uint[3] grid, block;
            uint sharedMem;
            
            this(Queue* _q, uint[3] _grid, uint[3] _block, uint _sharedMem)
            {
                q = _q;
                grid = _grid;
                block = _block;
                sharedMem = _sharedMem;
            }

            // Returns an Event instead of blocking!
            Event opCall(HostArgsOf!(typeof(k)) args)
            {
                if (q.raw is null) return Event(q, 0);

                auto kernel = Program.globalProgram.getKernel!k();
                if (!kernel.isValid()) return Event(q, 0);

                import dcompute.driver.d3d12.traits : isBufferArg, countUAVs, countScalars, scalarSize, checkKernelABI;

                // 0. Enforce DCompute Driver ABI at compile-time
                checkKernelABI!k;

                enum numUAVs   = countUAVs!k;
                enum numScalars= countScalars!k;
                
                bool isBindless = q.device.supportsBindless && Runtime.Config.enableBindlessABI;

                // In Bindless, we need descriptors for each UAV + 1 for the CBV.
                // In Legacy, we need descriptors for each UAV + 1 for the CBV (if any scalars exist).
                // It ends up being the same number of descriptors allocated from the heap.
                enum totalDescriptors = (numUAVs > 0 ? numUAVs : 1) + 1;

                // 1. Grab sub-allocation from global descriptor heap
                if (q.currentDescriptorOffset + totalDescriptors >= q.MAX_DESCRIPTORS)
                {
                    // Ring buffer wrap-around: wait for everything to finish, then reset offset
                    ulong waitVal = q.fenceValue - 1;
                    if (q.fence.GetCompletedValue() < waitVal)
                    {
                        q.fence.SetEventOnCompletion(waitVal, q.fenceEvent);
                        WaitForSingleObject(q.fenceEvent, INFINITE);
                    }
                    q.currentDescriptorOffset = 0;
                }

                uint offset = q.currentDescriptorOffset;
                q.currentDescriptorOffset += totalDescriptors;

                D3D12_CPU_DESCRIPTOR_HANDLE cpuHandle = q.globalDescriptorHeap.GetCPUDescriptorHandleForHeapStart();
                D3D12_GPU_DESCRIPTOR_HANDLE gpuHandle = q.globalDescriptorHeap.GetGPUDescriptorHandleForHeapStart();
                
                cpuHandle.ptr += offset * q.descriptorIncrementSize;
                gpuHandle.ptr += offset * q.descriptorIncrementSize;

                // We track the index of each UAV relative to the start of the entire heap (for Bindless)
                // The absolute index is what the shader uses: ResourceDescriptorHeap[index]
                uint baseHeapIndex = offset;
                
                size_t uavSlot = 0;
                static foreach (i, arg; args)
                {
                    static if (isBufferArg!(typeof(arg)))
                    {
                        D3D12_UNORDERED_ACCESS_VIEW_DESC uavDesc;
                        uavDesc.Format = DXGI_FORMAT.UNKNOWN;
                        uavDesc.ViewDimension = D3D12_UAV_DIMENSION.BUFFER;
                        uavDesc.Buffer.FirstElement = 0;
                        uavDesc.Buffer.NumElements = cast(uint)arg.numElements;
                        uavDesc.Buffer.StructureByteStride = typeof(arg.hostMemory[0]).sizeof;
                        uavDesc.Buffer.CounterOffsetInBytes = 0;
                        uavDesc.Buffer.Flags = D3D12_BUFFER_UAV_FLAGS.NONE;

                        D3D12_CPU_DESCRIPTOR_HANDLE currentHandle = cpuHandle;
                        currentHandle.ptr += uavSlot * q.descriptorIncrementSize;

                        q.device.CreateUnorderedAccessView(
                            arg.gpuResource, null, &uavDesc, currentHandle
                        );
                        uavSlot++;
                    }
                    else static if (isImageArg!(typeof(arg)))
                    {
                        import dcompute.driver.d3d12.image : Image;
                        D3D12_UNORDERED_ACCESS_VIEW_DESC uavDesc;
                        
                        static if (is(typeof(arg) : Image!(1, U), U)) {
                            uavDesc.ViewDimension = D3D12_UAV_DIMENSION.TEXTURE1D;
                            uavDesc.Texture1D.MipSlice = 0;
                        } else static if (is(typeof(arg) : Image!(2, U), U)) {
                            uavDesc.ViewDimension = D3D12_UAV_DIMENSION.TEXTURE2D;
                            uavDesc.Texture2D.MipSlice = 0;
                            uavDesc.Texture2D.PlaneSlice = 0;
                        } else {
                            uavDesc.ViewDimension = D3D12_UAV_DIMENSION.TEXTURE3D;
                            uavDesc.Texture3D.MipSlice = 0;
                            uavDesc.Texture3D.FirstWSlice = 0;
                            uavDesc.Texture3D.WSize = cast(uint)-1;
                        }
                        
                        static if (is(typeof(arg.hostMemory[0]) == float))
                            uavDesc.Format = DXGI_FORMAT.R32_FLOAT;
                        else static if (is(typeof(arg.hostMemory[0]) == uint))
                            uavDesc.Format = DXGI_FORMAT.R32_UINT;
                        
                        D3D12_CPU_DESCRIPTOR_HANDLE currentHandle = cpuHandle;
                        currentHandle.ptr += uavSlot * q.descriptorIncrementSize;

                        q.device.CreateUnorderedAccessView(
                            arg.gpuResource, null, &uavDesc, currentHandle
                        );
                        uavSlot++;
                    }
                }

                // 3. Acquire command allocator BEFORE building CBV, so we can schedule
                //    the CB resource for deferred release on this allocator's fence.
                auto res = q.getAvailableResource();
                
                // In Bindless, the CBV must be large enough to hold all scalars AND 32-bit indices for buffers.
                // In Legacy, the CBV only holds scalars.
                size_t payloadSize = 0;
                static foreach (i, arg; args)
                {
                    if (isBindless)
                    {
                        static if (isBufferArg!(typeof(arg)) || isImageArg!(typeof(arg)))
                            payloadSize += 4; // 32-bit integer index
                        else
                            payloadSize += arg.sizeof; // scalar
                    }
                    else
                    {
                        static if (!isBufferArg!(typeof(arg)) && !isImageArg!(typeof(arg)))
                            payloadSize += arg.sizeof; // scalar
                    }
                }

                ID3D12Resource cbResource;
                
                // If there's a payload to pack (either scalars exist, or we are in Bindless and have buffers)
                if (payloadSize > 0)
                {
                    enum alignedCBSize = 256; // Minimum CBV alignment is 256 bytes

                    D3D12_HEAP_PROPERTIES hp;
                    hp.Type = D3D12_HEAP_TYPE.UPLOAD;

                    D3D12_RESOURCE_DESC rd;
                    rd.Dimension        = D3D12_RESOURCE_DIMENSION.BUFFER;
                    rd.Width            = ((payloadSize + 255) & ~255);
                    rd.Height           = 1;
                    rd.DepthOrArraySize = 1;
                    rd.MipLevels        = 1;
                    rd.SampleDesc.Count = 1;
                    rd.Layout           = D3D12_TEXTURE_LAYOUT.ROW_MAJOR;
                    rd.Flags            = D3D12_RESOURCE_FLAGS.NONE;

                    auto hr = q.device.CreateCommittedResource(
                        &hp,
                        D3D12_HEAP_FLAGS.NONE,
                        &rd,
                        D3D12_RESOURCE_STATES.GENERIC_READ,
                        null,
                        &IID_ID3D12Resource,
                        cast(void**)&cbResource
                    );
                    checkErrors(hr);

                    if (cbResource !is null)
                    {
                        void* mapped;
                        D3D12_RANGE readRange = D3D12_RANGE(0, 0);
                        cbResource.Map(0, &readRange, &mapped);
                        if (mapped !is null)
                        {
                            size_t byteOffset = 0;
                            uint currentUavIndex = 0;
                            
                            static foreach (i, arg; args)
                            {
                                if (isBindless)
                                {
                                    static if (isBufferArg!(typeof(arg)) || isImageArg!(typeof(arg)))
                                    {
                                        import core.stdc.string : memcpy;
                                        // Pack the absolute 32-bit index into the heap
                                        uint heapIndex = baseHeapIndex + currentUavIndex;
                                        memcpy(mapped + byteOffset, &heapIndex, 4);
                                        byteOffset += 4;
                                        currentUavIndex++;
                                    }
                                    else
                                    {
                                        import core.stdc.string : memcpy;
                                        memcpy(mapped + byteOffset, &arg, arg.sizeof);
                                        byteOffset += arg.sizeof;
                                    }
                                }
                                else
                                {
                                    static if (!isBufferArg!(typeof(arg)) && !isImageArg!(typeof(arg)))
                                    {
                                        import core.stdc.string : memcpy;
                                        memcpy(mapped + byteOffset, &arg, arg.sizeof);
                                        byteOffset += arg.sizeof;
                                    }
                                }
                            }
                            D3D12_RANGE writeRange = D3D12_RANGE(0, rd.Width);
                            cbResource.Unmap(0, &writeRange);
                        }

                        D3D12_CONSTANT_BUFFER_VIEW_DESC cbvDesc;
                        cbvDesc.BufferLocation = cbResource.GetGPUVirtualAddress();
                        cbvDesc.SizeInBytes    = cast(uint)rd.Width;

                        // Place the CBV at the very end of our sub-allocation
                        D3D12_CPU_DESCRIPTOR_HANDLE cbvHandle = cpuHandle;
                        cbvHandle.ptr += uavSlot * q.descriptorIncrementSize;

                        q.device.CreateConstantBufferView(
                            &cbvDesc, cbvHandle
                        );
                        
                        // Schedule CB resource for release once this dispatch's fence passes.
                        foreach(ref poolRes; q.inFlightPool) {
                            if (poolRes.allocator == res.allocator) {
                                poolRes.pendingReleases ~= cbResource;
                                break;
                            }
                        }
                    }
                }

                // 4. Record command list
                res.commandList.SetPipelineState(kernel.pipelineState);
                res.commandList.SetComputeRootSignature(kernel.rootSignature);
                
                auto ppHeaps = cast(ID3D12DescriptorHeap)q.globalDescriptorHeap;
                res.commandList.SetDescriptorHeaps(1, &ppHeaps);

                if (isBindless)
                {
                    // Bindless ABI: Only pass the CBV. The CBV contains the indices to the UAVs.
                    // The CBV was placed at `uavSlot` in our sub-allocation.
                    D3D12_GPU_DESCRIPTOR_HANDLE bindlessCbvHandle = gpuHandle;
                    bindlessCbvHandle.ptr += uavSlot * q.descriptorIncrementSize;
                    res.commandList.SetComputeRootDescriptorTable(0, bindlessCbvHandle);
                }
                else
                {
                    // Legacy ABI: Pass the entire sub-allocation starting at u0 (UAVs first, then CBV).
                    res.commandList.SetComputeRootDescriptorTable(0, gpuHandle);
                }

                // 5. Dispatch
                res.commandList.Dispatch(grid[0], grid[1], grid[2]);
                res.commandList.Close();

                // 6. Execute Async!
                auto ppCommandLists = cast(ID3D12CommandList)res.commandList;
                q.raw.ExecuteCommandLists(1, &ppCommandLists);

                // Signal fence
                ulong targetFence = q.fenceValue;
                q.raw.Signal(q.fence, targetFence);
                q.fenceValue++;

                // Update the resource pool with the fence value so we know when it's free
                foreach (ref poolRes; q.inFlightPool)
                {
                    if (poolRes.allocator == res.allocator)
                    {
                        poolRes.targetFence = targetFence;
                        break;
                    }
                }

                // Return the event immediately instead of blocking!
                return Event(q, targetFence);
            }
        }
        
        return Call(&this, _grid, _block, _sharedMem);
    }
}

// Forward import for HostArgsOf
import dcompute.driver.d3d12.traits : HostArgsOf;
