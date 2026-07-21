module dcompute.driver.cuda.buffer;

import dcompute.driver.cuda;

struct Buffer(T)
{
    size_t raw;

	// Host memory associated with this buffer
    T[] hostMemory;

    // Shared atomic reference count for the owned CUdeviceptr (see rcCreate/
    // rcRetain/rcRelease in dcompute.driver.cuda). null when this Buffer does
    // not own a handle (e.g. a non-owning view created via
    // UnifiedBuffer.asBuffer). Copies share the same counter so the underlying
    // device allocation is freed exactly once, when the last owner dies.
    private shared(int)* _rc;

    this(size_t elems)
    {
        status = cast(Status)cuMemAlloc(&raw,elems * T.sizeof);
        checkErrors();
        hostMemory = null;
        if (raw != 0)
            _rc = rcCreate();
    }

    this(T[] arr)
    {
        status = cast(Status)cuMemAlloc(&raw,arr.length * T.sizeof);
        checkErrors();
        hostMemory = arr;
        if (raw != 0)
            _rc = rcCreate();
    }

    // Copies bump the shared refcount so the handle survives until the last
    // copy is destroyed.
    this(this)
    {
        rcRetain(_rc);
    }

    // Last owner frees the device allocation. The CUresult is deliberately
    // ignored: throwing from a destructor (which may run as a GC finalizer, on
    // a thread without a current CUDA context, or after driver teardown at
    // program exit) is unsafe — in those cases cuMemFree simply reports an
    // error we cannot act on anyway.
    ~this()
    {
        if (rcRelease(_rc) && raw != 0)
            cuMemFree(raw);
        raw = 0;
        // hostMemory is a GC-owned slice: never free it, just drop the reference.
        hostMemory = null;
    }
    void copy(Copy c)()
    {
        static if (c == Copy.hostToDevice)
        {
            status = cast(Status)cuMemcpyHtoD(raw, hostMemory.ptr,hostMemory.length * T.sizeof);
        }
        else static if  (c == Copy.deviceToHost)
        {
            status = cast(Status)cuMemcpyDtoH(hostMemory.ptr,raw,hostMemory.length * T.sizeof);
        }
        checkErrors();
    }
    alias hostArgOf(U : GlobalPointer!T) = raw;
    void release()
    {
        if (_rc !is null)
        {
            // Owning buffer: drop this copy's ownership. Only the LAST owner
            // actually frees — with other copies still alive the free is
            // deferred to the last copy's release()/~this(), so the surviving
            // copies keep a valid handle and nothing is freed twice.
            if (rcRelease(_rc) && raw != 0)
            {
                status = cast(Status)cuMemFree(raw);
                checkErrors();
            }
        }
        else if (raw != 0)
        {
            // Non-owning / manually assembled buffer: legacy behaviour, free
            // immediately (the caller manages the lifetime by hand).
            status = cast(Status)cuMemFree(raw);
            checkErrors();
        }
        raw = 0;
        hostMemory = null;
        // Handle and ownership are both gone; ~this is now a guaranteed no-op.
    }
}

alias bf = Buffer!float;
