@compute(CompileFor.deviceOnly) module dcompute.std.atomic;

import ldc.dcompute;

import cuda = dcompute.std.cuda.atomic;
public import dcompute.std.atomic_common : MemoryOrder;

int atomicAddShared(MemoryOrder mo = MemoryOrder.seq_cst)(SharedPointer!int dst, int val)
{
	if(__dcompute_reflect(ReflectTarget.CUDA))
		return cuda.atomicAddShared!mo(dst, val);
	assert(0);
}

int atomicAdd(MemoryOrder mo = MemoryOrder.seq_cst)(GlobalPointer!int dst, int val)
{
	if(__dcompute_reflect(ReflectTarget.CUDA))
		return cuda.atomicAdd!mo(dst, val);
	assert(0);
}
/*
 * @brief Atomically exchanges the value at the address with a new value.
 * @param dst The shared memory address (passed as i64).
 * @param newVal The integer value to store (i32).
 * @return The old value that was stored at the address (i32).
 */
int atomicExchange(MemoryOrder mo = MemoryOrder.seq_cst)
                  (GlobalPointer!int dst, int newVal)
{
    if (__dcompute_reflect(ReflectTarget.CUDA))
		return cuda.atomicExchange!mo(dst, newVal);
	assert(0);
}

int atomicExchangeShared(MemoryOrder mo = MemoryOrder.seq_cst)(SharedPointer!int dst, int newVal)
{
	if(__dcompute_reflect(ReflectTarget.CUDA))
		return cuda.atomicExchangeShared!mo(dst, newVal);
	assert(0);
}

/*
 *Atomic:
 * T add (GenericPointer!T addr,T val)
 * T sub (GenericPointer!T addr,T val)
 * T xchg(GenericPointer!T addr,T val)
 * T min (GenericPointer!T addr,T val)
 * T max (GenericPointer!T addr,T val)
 * T cas (GenericPointer!T addr,T val)
 * I and (GenericPointer!I addr,I val)
 * I or  (GenericPointer!I addr,I val)
 * I xor (GenericPointer!I addr,I val)
 * I inc (GenericPointer!I addr,I val)
 * I dec (GenericPointer!I addr,I val)

 */
