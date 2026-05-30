@compute(CompileFor.deviceOnly) module dcompute.std.metal.atomic;

import ldc.dcompute;
import dcompute.std.atomic_common : MemoryOrder;

pragma(LDC_inline_ir)
    R inlineIR(string s, R, P...)(P);

int atomicAddShared(MemoryOrder mo = MemoryOrder.seq_cst)(SharedPointer!int dst, int val)
{
    static if (mo == MemoryOrder.relaxed) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(3)
            %old = atomicrmw add ptr addrspace(3) %ptr, i32 %1 monotonic
            ret i32 %old`, int)(cast(long)dst, cast(int)val);
    } else static if (mo == MemoryOrder.acquire) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(3)
            %old = atomicrmw add ptr addrspace(3) %ptr, i32 %1 acquire
            ret i32 %old`, int)(cast(long)dst, cast(int)val);
    } else static if (mo == MemoryOrder.release) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(3)
            %old = atomicrmw add ptr addrspace(3) %ptr, i32 %1 release
            ret i32 %old`, int)(cast(long)dst, cast(int)val);
    } else static if (mo == MemoryOrder.acq_rel) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(3)
            %old = atomicrmw add ptr addrspace(3) %ptr, i32 %1 acq_rel
            ret i32 %old`, int)(cast(long)dst, cast(int)val);
    } else static if (mo == MemoryOrder.seq_cst) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(3)
            %old = atomicrmw add ptr addrspace(3) %ptr, i32 %1 seq_cst
            ret i32 %old`, int)(cast(long)dst, cast(int)val);
    }
    else
        static assert(0, "atomicAddShared doesn't support memoryOrder " ~mo.stringof);
}

int atomicAdd(MemoryOrder mo = MemoryOrder.seq_cst)(GlobalPointer!int dst, int val)
{
    static if (mo == MemoryOrder.relaxed) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(1)
            %old = atomicrmw add ptr addrspace(1) %ptr, i32 %1 monotonic
            ret i32 %old`, int)(cast(long)dst, cast(int)val);
    } else static if (mo == MemoryOrder.acquire) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(1)
            %old = atomicrmw add ptr addrspace(1) %ptr, i32 %1 acquire
            ret i32 %old`, int)(cast(long)dst, cast(int)val);
    } else static if (mo == MemoryOrder.release) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(1)
            %old = atomicrmw add ptr addrspace(1) %ptr, i32 %1 release
            ret i32 %old`, int)(cast(long)dst, cast(int)val);
    } else static if (mo == MemoryOrder.acq_rel) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(1)
            %old = atomicrmw add ptr addrspace(1) %ptr, i32 %1 acq_rel
            ret i32 %old`, int)(cast(long)dst, cast(int)val);
    } else static if (mo == MemoryOrder.seq_cst) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(1)
            %old = atomicrmw add ptr addrspace(1) %ptr, i32 %1 seq_cst
            ret i32 %old`, int)(cast(long)dst, cast(int)val);
    }
    else
        static assert(0, "atomicAdd doesn't support memoryOrder " ~mo.stringof);
}

int atomicExchangeShared(MemoryOrder mo = MemoryOrder.seq_cst)(SharedPointer!int dst, int newVal)
{
    static if (mo == MemoryOrder.relaxed) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(3)
            %old = atomicrmw xchg ptr addrspace(3) %ptr, i32 %1 monotonic
            ret i32 %old`, int)(cast(long)dst, newVal);
    } else static if (mo == MemoryOrder.acquire) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(3)
            %old = atomicrmw xchg ptr addrspace(3) %ptr, i32 %1 acquire
            ret i32 %old`, int)(cast(long)dst, newVal);
    } else static if (mo == MemoryOrder.release) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(3)
            %old = atomicrmw xchg ptr addrspace(3) %ptr, i32 %1 release
            ret i32 %old`, int)(cast(long)dst, newVal);
    } else static if (mo == MemoryOrder.acq_rel) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(3)
            %old = atomicrmw xchg ptr addrspace(3) %ptr, i32 %1 acq_rel
            ret i32 %old`, int)(cast(long)dst, newVal);
    } else static if (mo == MemoryOrder.seq_cst) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(3)
            %old = atomicrmw xchg ptr addrspace(3) %ptr, i32 %1 seq_cst
            ret i32 %old`, int)(cast(long)dst, newVal);
    }
    else
        static assert(0, "atomicExchangeShared doesn't support memoryOrder " ~mo.stringof);
}

int atomicExchange(MemoryOrder mo = MemoryOrder.seq_cst)(GlobalPointer!int dst, int newVal)
{
    static if (mo == MemoryOrder.relaxed) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(1)
            %old = atomicrmw xchg ptr addrspace(1) %ptr, i32 %1 monotonic
            ret i32 %old`, int)(cast(long)dst, newVal);
    } else static if (mo == MemoryOrder.acquire) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(1)
            %old = atomicrmw xchg ptr addrspace(1) %ptr, i32 %1 acquire
            ret i32 %old`, int)(cast(long)dst, newVal);
    } else static if (mo == MemoryOrder.release) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(1)
            %old = atomicrmw xchg ptr addrspace(1) %ptr, i32 %1 release
            ret i32 %old`, int)(cast(long)dst, newVal);
    } else static if (mo == MemoryOrder.acq_rel) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(1)
            %old = atomicrmw xchg ptr addrspace(1) %ptr, i32 %1 acq_rel
            ret i32 %old`, int)(cast(long)dst, newVal);
    } else static if (mo == MemoryOrder.seq_cst) {
        return inlineIR!(`
            %ptr = inttoptr i64 %0 to ptr addrspace(1)
            %old = atomicrmw xchg ptr addrspace(1) %ptr, i32 %1 seq_cst
            ret i32 %old`, int)(cast(long)dst, newVal);
    }
    else
        static assert(0, "atomicExchange doesn't support memoryOrder " ~mo.stringof);
}
