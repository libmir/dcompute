//contains the pseudo conditional compilation function

module dcompute.reflect;

// These numbers MUST match DcomputeTarget::target in LDC. 
enum target : uint
{
    Host = 0,
    OpenCL = 1,
    CUDA = 2,
}
// returns true if t and _version match the target and it's version.
// think __ctfe but per target, codegen time conditional compilation.
// as oppsed to compiletime/runtime.
// arguments MUST be compiletime constants
// valid values of _version are for OpenCL 100 110 120 200 210
// and for CUDA are x*100 + y*10 for x any valid values of sm x.y
// use 0 as a wildcard to match any version.

// This is mostly used for selecting the correct intrinsic for the
// given target and version, but could also be used to tailor for
// performance characteristics. See dcompute.std.index for an example
// of how to select intrinsics.

pure nothrow @nogc
extern(C) bool __dcompute_reflect(uint t, uint _version = 0);

