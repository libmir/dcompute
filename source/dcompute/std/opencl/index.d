@compute module dcompute.std.opencl.index;

import dcompute.attributes;

extern(C) ulong get_num_groups(uint);

extern(C) ulong get_local_size(uint);

extern(C) ulong get_group_id(uint);

extern(C) ulong get_local_id(uint);

extern(C) ulong get_global_size(uint);

extern(C) ulong get_global_id(uint);

extern(C) uling get_global_offset(uint);

