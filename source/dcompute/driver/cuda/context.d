module dcompute.driver.cuda.context;

import dcompute.driver.cuda;

struct Context
{
    CUcontext raw;

    // Shared atomic refcount for an OWNED CUcontext (one created via
    // cuCtxCreate); see rcCreate/rcRetain/rcRelease in dcompute.driver.cuda.
    // null = non-owning view. The static factory paths pop() and current()
    // intentionally leave _rc null: they reference an existing context owned
    // elsewhere (e.g. the runtime's _defaultContext), so a transient copy
    // must NOT destroy it.
    private shared(int)* _rc;

    this(Device dev, uint flags = 0)
    {
        status = cast(Status)cuCtxCreate(&raw, flags,dev.raw);
        checkErrors();
        if (raw !is null)
            _rc = rcCreate();
    }

    this(this)
    {
        rcRetain(_rc);
    }

    // Last owner destroys the context. The CUresult is deliberately ignored:
    // a destructor must not throw (it may run as a GC finalizer or during
    // shutdown after the driver is already torn down).
    ~this()
    {
        if (rcRelease(_rc) && raw !is null)
            cuCtxDestroy(raw);
        raw = null;
    }

    static void push(Context ctx)
    {
        status = cast(Status)cuCtxPushCurrent(ctx.raw);
        checkErrors();
    }
    
    static Context pop()
    {
        // ret._rc stays null: this references an EXISTING context being popped
        // off the stack, owned elsewhere. A non-owning view must not destroy it.
        Context ret;
        status = cast(Status)cuCtxPopCurrent(&ret.raw);
        checkErrors();
        return ret;
    }
    static @property Context current()
    {
        // ret._rc stays null: non-owning view of the current context (owned by
        // whoever created it, e.g. the runtime). Its destructor is a no-op.
        Context ret;
        status = cast(Status)cuCtxGetCurrent(&ret.raw);
        checkErrors();
        return ret;
    }
    
    static @property void current(Context ctx)
    {
        status = cast(Status)cuCtxSetCurrent(ctx.raw);
        checkErrors();
    }
    
    static void sync()
    {
        status = cast(Status)cuCtxSynchronize();
        checkErrors();
    }
    //CUlimit
    enum Limit
    {
        stackSize,
        printfFifoSize,
        mallocHeapSize,
        deviceRuntimeSyncDepth,
        deviceRuntimePendingLaunchCount
    }
    
    static @property void limit(Limit what)(size_t lim)
    {
        status = cast(Status)cuCtxSetLimit(what,lim);
        checkErrors();
    }
    
    static @property size_t limit(Limit what)()
    {
        size_t ret;
        status = cast(Status)cuCtxGetLimit(&ret,what);
        checkErrors();
        return ret;
    }
    //CUfunc_cache
    enum CacheConfig
    {
        preferNone,
        preferShared,
        preferL1,
        preferEqual,
    }
    
    static @property void cacheConfig(CacheConfig cc)
    {
        status = cast(Status)cuCtxSetSharedMemConfig(cc);
        checkErrors();
    }
    
    
    static @property CacheConfig cacheConfig()
    {
        CacheConfig ret;
        status = cast(Status)cuCtxGetSharedMemConfig(cast(int*)&ret);
        checkErrors();
        return ret;
    }
    
    @property uint apiVersion()
    {
        uint ret;
        status = cast(Status)cuCtxGetApiVersion(raw,&ret);
        checkErrors();
        return ret;
    }
    
    static void getQueuePriorityRange(out int lo, out int hi)
    {
        status = cast(Status)cuCtxGetStreamPriorityRange(&lo,&hi);
        checkErrors();
    }
    
    // Deprecated: cuCtxDetach is a legacy refcount-decrement API. The RAII
    // destructor (~this) uses cuCtxDestroy for owned contexts. For an OWNED
    // context this drops one owner and only the last owner actually detaches
    // (so surviving copies never see a destroyed handle); the handle and
    // ownership are always cleared here, making a later ~this a no-op.
    void detach()
    {
        if (_rc !is null)
        {
            if (rcRelease(_rc) && raw !is null)
            {
                status = cast(Status)cuCtxDetach(raw);
                checkErrors();
            }
        }
        else if (raw !is null)
        {
            // Non-owning view: legacy behaviour, detach immediately.
            status = cast(Status)cuCtxDetach(raw);
            checkErrors();
        }
        raw = null;
    }
}
