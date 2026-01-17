@compute(CompileFor.deviceOnly) module dcompute.std.atomic_common;

import ldc.dcompute;

enum MemoryOrder {
	relaxed, 
	acquire, 
	release, 
	acq_rel, 
	seq_cst
}
