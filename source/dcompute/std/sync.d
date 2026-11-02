@compute(CompileFor.deviceOnly) module dcompute.std.sync;

import ldc.dcompute;
import ldc.intrinsics;

import ocl  = dcompute.std.opencl.sync;
import cuda = dcompute.std.cuda.sync;
import dx   = dcompute.std.directx.sync;

//suspends work-item execution until all work-items in the work-group have called the barrier
void barrier()()
{
    if(__dcompute_reflect(ReflectTarget.OpenCL))
        ocl.barrier(0);
    if(__dcompute_reflect(ReflectTarget.CUDA)) {
        static if (LLVM_atleast!21) { // >= LDC 1.42.0(LLVM 21)
            cuda.barrier_n(0);
        } else {
            cuda.barrier0();
        }
    }
    if(__dcompute_reflect(ReflectTarget.DirectX))
        dx.barrier();
}

void local_fence()
{
    if(__dcompute_reflect(ReflectTarget.OpenCL))
        ocl.mem_fence(ocl.CLK_LOCAL_MEM_FENCE);
    if(__dcompute_reflect(ReflectTarget.CUDA))
        cuda.membar_cta();
    if(__dcompute_reflect(ReflectTarget.DirectX))
        dx.local_fence();
}
// A global fence implies a local fence
void global_fence()
{
    if(__dcompute_reflect(ReflectTarget.OpenCL))
        ocl.mem_fence(ocl.CLK_GLOBAL_MEM_FENCE);
    if(__dcompute_reflect(ReflectTarget.CUDA))
        cuda.membar_gl();
    if(__dcompute_reflect(ReflectTarget.DirectX))
        dx.global_fence();
}

//TODO: image fence?


