//contains the pseudo conditional compilation function

module dcompute.reflect;

enum target : uint
{
    Host = 0,
    OpenCL = 1,
    CUDA = 2,
}
// returns true if the given target == t
// think __ctfe but target as oppsed to compiletime/runtime
// arguments MUST be compiletime constants
// valid values of _version are for OpenCL 100 110 120 200 210
// and for CUDA are 
extern(C) bool __dcompute_reflect(uint t, uint _version = 0);

