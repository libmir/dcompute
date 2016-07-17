@compute module dcompute.std.opencl.sync;

import dcompute.attributes;

extern(C) void barrier();

extern(C) void mem_fence(ulong);

extern(C) void read_mem_fence();

extern(C) void write_mem_fence();