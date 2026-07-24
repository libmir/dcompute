@compute(CompileFor.deviceOnly) module dcompute.std.metal.index;

import ldc.dcompute;
pure: nothrow: @nogc:

pragma(LDC_intrinsic, "air.get_global_id.i32")
uint thread_position_in_grid(uint dim);

pragma(LDC_intrinsic, "air.get_local_id.i32")
uint thread_position_in_threadgroup(uint dim);

pragma(LDC_intrinsic, "air.get_local_size.i32")
uint threads_per_threadgroup(uint dim);

pragma(LDC_intrinsic, "air.get_group_id.i32")
uint threadgroup_position_in_grid(uint dim);

pragma(LDC_intrinsic, "air.get_global_size.i32")
uint threads_per_grid(uint dim);

pragma(LDC_intrinsic, "air.get_num_groups.i32")
uint threadgroups_per_grid(uint dim);
