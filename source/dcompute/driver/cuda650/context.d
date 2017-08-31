module dcompute.driver.cuda650.context;

import dcompute.driver.cuda650;

struct Context
{
    void* raw;
    this(Device dev, uint flags)
    {
        status = cast(Status)cuCtxCreate(&raw, flags,dev);
        checkErrors();
    }
    
    static void push(Context ctx)
    {
        status = cast(Status)cuCtxPushCurrent(ctx.raw);
        checkErrors();
    }
    
    static Context pop()
    {
        Context ret;
        status = cast(Status)cuCtxPopCurrent(&ret.raw);
        checkErrors();
    }
    static @property Context current()
    {
        Context ret;
        status = cast(Status)cuCtxGetCurrent(&ret.raw);
        checkErrors();
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
        status = cast(Status)cuCtxSetLimit(&ret,what);
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
        status = cast(Status)cuCtxSetSharedMemConfig(&ret);
        checkErrors();
        return ret;
    }
    
    @property uint apiVersion()
    {
        uint ret;
        status = cast(Status)cuCtxGetApiVersion(&ret);
        checkErrors();
        return ret;
    }
    
    static void getQueuePriorityRange(out int lo, out int hi)
    {
        status = cast(Status)cuCtxGetStreamPriorityRange(&lo,&hi);
        checkErrors();
    }
    
    void detach()
    {
        status = cast(Status)cuCtxDetach(raw);
        checkErrors();
    }
}
