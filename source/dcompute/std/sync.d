@compute module dcompute.std.sync;

import dcompute.attributes;
import dcompute.reflect;

import ocl  = dcompute.std.opencl.sync;
import cuda = dcompute.std.cuda.sync;

//suspends work-item execution until all work-items in the work-group have called the barrier
void barrier()
{
    if(__dcompute_reflect(target.OpenCL))
        ocl.barrier();
    if(__dcompute_reflect(target.CUDA))
        cuda.barrier0();
}

void local_fence()
{
    if(__dcompute_reflect(target.OpenCL))
        ocl.mem_fence(0);
    if(__dcompute_reflect(target.CUDA))
        cuda.membar_cta();
}
// A global fence implies a local fence
void global_fence()
{
    if(__dcompute_reflect(target.OpenCL))
        ocl.mem_fence(1);
    if(__dcompute_reflect(target.CUDA))
        cuda.membar_gl();
}

//TODO: image fence?


