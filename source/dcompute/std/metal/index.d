@compute(CompileFor.deviceOnly) module dcompute.std.metal.index;

import ldc.dcompute;
pure: nothrow: @nogc:

pragma(LDC_intrinsic, "air.get_global_id.i32") uint get_global_id(uint dim);
pragma(LDC_intrinsic, "air.get_local_id.i32") uint get_local_id(uint dim);
pragma(LDC_intrinsic, "air.get_group_id.i32") uint get_group_id(uint dim);
pragma(LDC_intrinsic, "air.get_global_size.i32") uint get_global_size(uint dim);
pragma(LDC_intrinsic, "air.get_local_size.i32") uint get_local_size(uint dim);
pragma(LDC_intrinsic, "air.get_num_groups.i32") uint get_num_groups(uint dim);

// thread_position_in_grid → GlobalIndex
uint get_global_id_x()() { return get_global_id(0); }
uint get_global_id_y()() { return get_global_id(1); }
uint get_global_id_z()() { return get_global_id(2); }

// thread_position_in_threadgroup → SharedIndex
uint get_local_id_x()() { return get_local_id(0); }
uint get_local_id_y()() { return get_local_id(1); }
uint get_local_id_z()() { return get_local_id(2); }

// threadgroup_position_in_grid → GroupIndex
uint get_group_id_x()() { return get_group_id(0); }
uint get_group_id_y()() { return get_group_id(1); }
uint get_group_id_z()() { return get_group_id(2); }

// threads_per_grid → GlobalDimension
uint get_global_size_x()() { return get_global_size(0); }
uint get_global_size_y()() { return get_global_size(1); }
uint get_global_size_z()() { return get_global_size(2); }

// threads_per_threadgroup → SharedDimension
uint get_local_size_x()() { return get_local_size(0); }
uint get_local_size_y()() { return get_local_size(1); }
uint get_local_size_z()() { return get_local_size(2); }

// threadgroups_per_grid → GroupDimension
uint get_num_groups_x()() { return get_num_groups(0); }
uint get_num_groups_y()() { return get_num_groups(1); }
uint get_num_groups_z()() { return get_num_groups(2); }
