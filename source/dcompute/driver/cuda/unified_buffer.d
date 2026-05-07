/**
 * Unified Memory (Managed Memory) buffer for CUDA.
 *
 * A UnifiedBuffer!T allocates memory that is accessible from both the host
 * (CPU) and the device (GPU) through a single pointer. The CUDA runtime
 * migrates data automatically, so explicit copy!(Copy.hostToDevice) /
 * copy!(Copy.deviceToHost) calls are not needed.
 *
 * Requirements:
 *   - CUDA Compute Capability >= 3.0
 *   - Device.supportsUnifiedMemory == true
 *
 * Limitations (current):
 *   - prefetch() is a documented no-op stub because cuMemPrefetchAsync is not
 *     present in the derelict-cuda 3.1.1 binding (API version 6.5). If you
 *     need deterministic placement before a kernel launch, call
 *     Context.sync() after writing from the host and before the kernel; the
 *     driver will migrate pages on first access otherwise.
 *     (Tracked for discussion with mentors)
 */
module dcompute.driver.cuda.unified_buffer;

import dcompute.driver.cuda;

// Attach mode — controls which streams can access the managed allocation
// initially. CU_MEM_ATTACH_GLOBAL makes the buffer immediately visible to
// all streams (the most common choice). CU_MEM_ATTACH_HOST restricts it to
// the host until a stream explicitly attaches to it.

enum AttachMode : uint
{
    /// Accessible from any CUDA stream (default). Equivalent to
    /// CU_MEM_ATTACH_GLOBAL.
    global_ = CU_MEM_ATTACH_GLOBAL,

    /// Initially host-only. Use cuStreamAttachMemAsync (not yet wrapped) or
    /// switch to global_ to make the buffer available on the device.
    /// Equivalent to CU_MEM_ATTACH_HOST.
    host = CU_MEM_ATTACH_HOST,
}

struct UnifiedBuffer(T)
{
    /// Raw CUdeviceptr — also a valid host-side pointer on unified-memory
    /// capable systems (UVA must be enabled, which is true on all 64-bit CUDA
    /// systems with CC >= 2.0).
    size_t raw;

    private size_t _length; // number of T elements

    // ------------------------------------------------------------------
    // Construction
    // ------------------------------------------------------------------

    /**
     * Allocate `elems` uninitialised elements of T in managed memory.
     *
     * Params:
     *   elems = number of elements to allocate
     *   mode  = attachment scope (default: global_)
     */
    this(size_t elems, AttachMode mode = AttachMode.global_)
    {
        status = cast(Status)cuMemAllocManaged(&raw, elems * T.sizeof,
                                              cast(uint)mode);
        checkErrors();
        _length = elems;
    }

    /**
     * Allocate and initialise from a host slice.
     * The contents of `arr` are copied into the managed allocation before
     * returning, so the caller's original array is no longer needed.
     *
     * Params:
     *   arr  = source host data
     *   mode = attachment scope (default: global_)
     */
    this(T[] arr, AttachMode mode = AttachMode.global_)
    {
        this(arr.length, mode);
        hostSlice[] = arr[];
    }

    // ------------------------------------------------------------------
    // Host-side access
    // ------------------------------------------------------------------

    /**
     * Returns a D slice backed by the managed allocation.
     * Valid to read/write on the host at any time when no kernel is
     * concurrently accessing the same memory.
     */
    @property T[] hostSlice()
    {
        return (cast(T*)raw)[0 .. _length];
    }

    /// Number of elements.
    @property size_t length() const { return _length; }

 
    // Device-side hints (stubs pending driver-version upgrade)

    /**
     * Prefetch this buffer's data to a device asynchronously.
     *
     * NOTE: This is currently a **no-op stub**. cuMemPrefetchAsync is not
     * present in the derelict-cuda 3.1.1 binding (CUDA API 6.5). Without an
     * explicit prefetch the CUDA runtime will migrate pages on first access,
     * which is correct but may cause latency on the first kernel invocation.
     *
     * As a workaround, call Context.sync() on the host before launching the
     * kernel to ensure all host writes have completed; the driver will then
     * migrate on first GPU access.
     */
    void prefetch(Device dev, Queue q = Queue.init)
    {
        // Stub — intentionally left empty.
        // See module documentation for rationale.
    }


    /// Free the managed allocation.  After this call `raw` and `length`
    /// are zeroed; accessing `hostSlice` is undefined behaviour.
    void release()
    {
        status = cast(Status)cuMemFree(raw);
        checkErrors();
        raw = 0;
        _length = 0;
    }

    /// Satisfies the same hostArgOf alias contract as Buffer!T so that
    /// HostArgsOf!kernelFn replaces GlobalPointer!T with UnifiedBuffer!T
    /// transparently.
    alias hostArgOf(U : GlobalPointer!T) = raw;

    // Implicit conversion to Buffer!T

    /**
     * Returns a Buffer!T view of this managed allocation.
     *
     * This conversion exists so that UnifiedBuffer!T can be passed directly
     * to Queue.enqueue!() whose opCall signature is fixed at compile-time
     * to (Buffer!float, ...) via HostArgsOf.  Because both structs store
     * `raw` as their first field, CUDA receives the correct CUdeviceptr.
     *
     * The Buffer's hostMemory slice is set to hostSlice so that if anyone
     * accidentally calls copy!() on the returned Buffer, it still touches
     * the right memory region.
     */
    @property Buffer!T asBuffer()
    {
        Buffer!T b;
        b.raw        = raw;
        b.hostMemory = hostSlice;
        return b;
    }

    /// Implicit subtype: UnifiedBuffer!T is accepted wherever Buffer!T is
    /// expected (e.g. Queue.enqueue!() opCall arguments).
    alias this = asBuffer;
}
