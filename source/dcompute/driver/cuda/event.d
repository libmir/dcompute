module dcompute.driver.cuda.event;

import dcompute.driver.cuda;

struct Event
{
    CUevent raw;

    // Shared atomic refcount for an OWNED CUevent (see rcCreate/rcRetain/
    // rcRelease in dcompute.driver.cuda). null = non-owning view.
    // Default-constructed Events keep _rc null, so ~this is a no-op for them.
    private shared(int)* _rc;

    /**
     * Create an event.
     *
     * Params:
     *   flags = CU_EVENT_* creation flags (pass 0 / CU_EVENT_DEFAULT for the
     *           default behaviour; CU_EVENT_BLOCKING_SYNC,
     *           CU_EVENT_DISABLE_TIMING, ... to opt in to other modes).
     */
    this(uint flags)
    {
        status = cast(Status)cuEventCreate(&raw, flags);
        checkErrors();
        if (raw !is null)
            _rc = rcCreate();
    }

    this(this)
    {
        rcRetain(_rc);
    }

    // Last owner destroys the event. The CUresult is deliberately ignored:
    // a destructor must not throw (it may run as a GC finalizer or during
    // shutdown after the driver is already torn down).
    ~this()
    {
        if (rcRelease(_rc) && raw !is null)
            cuEventDestroy(raw);
        raw = null;
    }
}
