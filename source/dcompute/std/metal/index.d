@compute(CompileFor.deviceOnly) module dcompute.std.metal.index;

import ldc.dcompute;
pure: nothrow: @nogc:
//tid = threadId
pragma(LDC_intrinsic, "air.get_global_id.i32")
uint thread_position_in_grid_x(uint dim);

pragma(LDC_intrinsic, "air.get_global_id.i32")
uint thread_position_in_grid_y(uint dim);

pragma(LDC_intrinsic, "air.get_global_id.i32")
uint thread_position_in_grid_z(uint dim);
