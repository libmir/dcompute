@compute(CompileFor.deviceOnly) module dcompute.std.metal.sync;

import ldc.dcompute;

pure: nothrow: @nogc:

alias mem_flags = uint;

enum : mem_flags
{
    mem_none = 0,
    mem_device = 1,
    mem_threadgroup = 2,
    mem_texture = 4,
}

enum uint threadgroup_scope = 1;

/// Threadgroup-wide execution barrier with optional memory fence flags.
/// Matches Julia Metal.jl `threadgroup_barrier(flag)` → `air.wg.barrier(flag, 1)`.
/// See Apple’s `MemoryFlags` / MSL `threadgroup_barrier`.
pragma(LDC_intrinsic, "air.wg.barrier")
void wg_barrier(uint mem_flags, uint execution_scope);

void threadgroup_barrier()(mem_flags flags = mem_none)
{
    wg_barrier(flags, threadgroup_scope);
}
