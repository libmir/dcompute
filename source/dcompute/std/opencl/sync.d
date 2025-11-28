/++
Provides access to the OpenCL C sync functions.
See_Also: [6.15.8. Synchronization Functions](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#synchronization-functions)$(BR)
          [6.15.12.5. Fences](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#fences)$(BR)
          [6.15.9. Legacy Explicit Memory Fence Functions](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#legacy-mem-fence-functions)
Standards: [The OpenCL™ C Specification](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html)
License:  [Boost License 1.0](https://boost.org/LICENSE_1_0.txt).
+/
@compute(CompileFor.deviceOnly) module dcompute.std.opencl.sync;

import ldc.dcompute;
import ldc.attributes;

pure:
nothrow:
@nogc:

/// Standards: [6.3.3. Other Built-in Data Types](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#other-built-in-data-types)
alias cl_mem_fence_flags = uint;
enum : uint
{
    CLK_LOCAL_MEM_FENCE  = 1,
    CLK_GLOBAL_MEM_FENCE = 2,
    CLK_IMAGE_MEM_FENCE  = 4,
}

/// Standards: [6.15.12.4. Memory Scope](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#memory-scope)
enum memory_scope : uint
{
    work_item       = 0,
    sub_group       = 4,
    work_group      = 1,
    scope_device    = 2,
    all_svm_devices = 3,
    all_devices     = 3,
}

/// Standards: [6.15.12.3. Order and Consistency](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#order-and-consistency)
enum memory_order : uint
{
    relaxed = 0,
    acquire = 2,
    release = 3,
    acq_rel = 4,
    seq_cst = 5,
}

/// Standards: [6.15.8. Synchronization Functions](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#synchronization-functions)
pragma(mangle, "_Z7barrierj")
void barrier(cl_mem_fence_flags);

/// Standards: [6.15.8. Synchronization Functions](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#synchronization-functions)
pragma(mangle, "_Z18work_group_barrierj")
void work_group_barrier(cl_mem_fence_flags);

/// Standards: [6.15.8. Synchronization Functions](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#synchronization-functions)
pragma(mangle, "_Z18work_group_barrierj12memory_scope")
void work_group_barrier(cl_mem_fence_flags, memory_scope);

/// Standards: [6.15.12.5. Fences](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#fences)
pragma(mangle, "_Z22atomic_work_item_fencej12memory_order12memory_scope")
void atomic_work_item_fence(cl_mem_fence_flags, memory_order, memory_scope);

/*
LDC's backend, LLVM, does not support lowering the builtin memory fence functions.
These calls to atomic_work_item_fence generate the same OpMemoryBarrier instructions as a native mem_fence call.
I've tried pragma(inline, true) but it leaves a OpStore before the OpMemoryBarrier at -O0,
and something about it crashes llvm-spirv (i take this as a bad sign) so i didn't use it.
Using inlinehint doesn't inline at -O0 and inlines at -O1 and up. Perfect!
*/
/// Contrary to the OpenCL C spec this implementation of `mem_fence` is not deprecated by OpenCL C 2.0.
/// Standards: [6.15.9. Legacy Explicit Memory Fence Functions](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#legacy-mem-fence-functions)
@llvmAttr("inlinehint")
void mem_fence(cl_mem_fence_flags flags)
{
    atomic_work_item_fence(flags, memory_order.acq_rel, memory_scope.work_group);
}

/// Contrary to the OpenCL C spec this implementation of `read_mem_fence` is not deprecated by OpenCL C 2.0.
/// Standards: [6.15.9. Legacy Explicit Memory Fence Functions](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#legacy-mem-fence-functions)
@llvmAttr("inlinehint")
void read_mem_fence(cl_mem_fence_flags flags)
{
    atomic_work_item_fence(flags, memory_order.acquire, memory_scope.work_group);
}

/// Contrary to the OpenCL C spec this implementation of `write_mem_fence` is not deprecated by OpenCL C 2.0.
/// Standards: [6.15.9. Legacy Explicit Memory Fence Functions](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#legacy-mem-fence-functions)
@llvmAttr("inlinehint")
void write_mem_fence(cl_mem_fence_flags flags)
{
    atomic_work_item_fence(flags, memory_order.release, memory_scope.work_group);
}
