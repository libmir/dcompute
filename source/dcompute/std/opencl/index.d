@compute module dcompute.std.opencl.index;

import dcompute.attributes;
extern(C++):
size_t get_work_dim(uint);
size_t get_global_size(uint);
size_t get_global_id(uint);
size_t get_global_offset(uint);
size_t get_local_size(uint);
size_t get_enqueued_local_size(uint);
size_t get_local_id(uint);
size_t get_num_groups(uint);
size_t get_group_id(uint);
size_t get_global_linear_id();
size_t get_local_linear_id();
size_t get_sub_group_size(uint);
size_t get_max_sub_group_size(uint);
size_t get_num_sub_groups();
size_t get_enqueued_num_sub_groups();
size_t get_sub_group_id(uint);
size_t get_sub_group_local_id(uint);



