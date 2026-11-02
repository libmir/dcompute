module dcompute.driver.cuda.platform;

import dcompute.driver.error;
import dcompute.driver.cuda;
import std.experimental.allocator.typed;

struct Platform
{
    static void initialise(uint flags =0)
    {
        auto support = loadCUDA();
        if (support == CUDASupport.noLibrary || support == CUDASupport.badLibrary)
        {
            status = Status.sharedObjectInitFailed;
            checkErrors();
        }
        status = cast(Status)cuInit(flags);
        checkErrors();
    }

    /**
     * Soft-failing variant of initialise() for use from module constructors,
     * where an uncaught exception aborts the program before main() starts.
     *
     * Probes the CUDA driver without throwing and without touching the
     * thread-local `status`: loads the shared library, calls cuInit and
     * checks that at least one device is present.
     *
     * Returns: true if CUDA is fully usable on this machine.
     */
    static bool tryInitialise(uint flags = 0)
    {
        auto support = loadCUDA();
        if (support == CUDASupport.noLibrary || support == CUDASupport.badLibrary)
            return false;
        if (cast(Status)cuInit(flags) != Status.Success)
            return false;
        int deviceCount;
        if (cast(Status)cuDeviceGetCount(&deviceCount) != Status.Success)
            return false;
        return deviceCount > 0;
    }
    
    static Device[] getDevices(A)(A a)
    {
        int len;
        TypedAllocator!(A) allocator;
        status = cast(Status)cuDeviceGetCount(&len);
        checkErrors();

        //TODO:
        //Device[] ret = allocator.makeArray!(Device)(len);
            Device[] ret = new Device[len];
        foreach(int i; 0 .. len)
        {
            status = cast(Status)cuDeviceGet(&ret[i].raw,i);
            checkErrors();
        }
        return ret;
    }
    
}
