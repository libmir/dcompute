@compute(deviceOnly) module dcompute.std.memory;

import ldc.attributes;

/*
 *Pointer conversions:
 * *Pointer!T GenericPtrTo*(GenericPointer!T ptr)
 * GenericPointer!T *toGenericPtr(*Pointer!T ptr)
 *
 *Shared memory:
 * SharedPointer!T sharedStaticReserve!(T[N])
 * SharedPointer!void sharedDynamicBase();
 * auto sharedIndices!(Ts...) if(isSharedIndex!(Ts...) // (T, alias length) pairs
       see http://stackoverflow.com/questions/15435559/use-dynamic-shared-memory-allocation-for-two-different-vectors
       for what this emulates. Memory aligned to A =reduce!max(T.alignof)
       Returns a tuple of {SharedPointer!(align(A) T), length} 
 */