@compute(CompileFor.deviceOnly) module dcompute.std.metal.index;

import ldc.dcompute;
pure: nothrow: @nogc:

// thread_position_in_grid → GlobalIndex
pragma(mangle, "air.thread_position_in_grid.x") uint get_global_id_x();
pragma(mangle, "air.thread_position_in_grid.y") uint get_global_id_y();
pragma(mangle, "air.thread_position_in_grid.z") uint get_global_id_z();

// thread_position_in_threadgroup → SharedIndex
pragma(mangle, "air.thread_position_in_threadgroup.x") uint get_local_id_x();
pragma(mangle, "air.thread_position_in_threadgroup.y") uint get_local_id_y();
pragma(mangle, "air.thread_position_in_threadgroup.z") uint get_local_id_z();

// threadgroup_position_in_grid → GroupIndex
pragma(mangle, "air.threadgroup_position_in_grid.x") uint get_group_id_x();
pragma(mangle, "air.threadgroup_position_in_grid.y") uint get_group_id_y();
pragma(mangle, "air.threadgroup_position_in_grid.z") uint get_group_id_z();

// threads_per_grid → GlobalDimension
pragma(mangle, "air.threads_per_grid.x") uint get_global_size_x();
pragma(mangle, "air.threads_per_grid.y") uint get_global_size_y();
pragma(mangle, "air.threads_per_grid.z") uint get_global_size_z();

// threads_per_threadgroup → SharedDimension
pragma(mangle, "air.threads_per_threadgroup.x") uint get_local_size_x();
pragma(mangle, "air.threads_per_threadgroup.y") uint get_local_size_y();
pragma(mangle, "air.threads_per_threadgroup.z") uint get_local_size_z();

// threadgroups_per_grid → GroupDimension
pragma(mangle, "air.threadgroups_per_grid.x") uint get_num_groups_x();
pragma(mangle, "air.threadgroups_per_grid.y") uint get_num_groups_y();
pragma(mangle, "air.threadgroups_per_grid.z") uint get_num_groups_z();
