module dcompute.driver.cuda650.platform;

import dcompute.driver.error;
import std.allocator.typed;

struct Platform
{
    static void initialise(uint flags =0)
    {
        status = cast(Status)cuInit(flags);
        checkErrors();
    }
    
    Device[] devices(A)(A a)
    {
        int len;
        TypedAllocator!(A) allocator;
        status = cast(Status)cuDeviceGetCount(&len);
        checkErrors();
        
        Device[] ret = allocator.makeArray!(Device)(len);
        foreach(int i; 0 .. len)
        {
            status = cast(Status)cuDeviceGet(&ret[i].raw,i);
            checkErrors();
        }
        return ret;
    }
    
}
