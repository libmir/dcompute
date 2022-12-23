@compute(CompileFor.hostAndDevice) module dcompute.std.memory;

import ldc.dcompute;

pragma(LDC_inline_ir)
    R __irEx(string prefix, string code, string suffix, R, P...)(P) @trusted nothrow @nogc;

pragma(LDC_inline_ir)
    R inlineIR(string s, R, P...)(P) @trusted nothrow @nogc;
/*
 *Pointer conversions:
 * *Pointer!T genericPtrTo*(GenericPointer!T ptr)
 * GenericPointer!T *toGenericPtr(*Pointer!T ptr)
 *
 *Shared memory:
 * SharedPointer!T sharedStaticReserve!(T[N])
 * SharedPointer!void sharedDynamicBase();
 * auto sharedIndices!(Ts...) if(isSharedIndex!(Ts...) // (T, alias length) pairs
       see http://stackoverflow.com/questions/15435559/use-dynamic-shared-memory-allocation-for-two-different-vectors
       for what this emulates any why. Memory aligned to A = reduce!max(T.alignof)
       Returns a tuple of {SharedPointer!(align(A) T), length} "arrays"
 */

@nogc nothrow:

// SharedPointer and constant memory allocations, only tested for Cuda backend

SharedPointer!T sharedStaticReserve(T : T[N], string uniqueName, size_t N)(){
    void* address = __irEx!(`@`~uniqueName~` = addrspace(3) global [`~Itoa!N~` x `~llvmType!T~`] zeroinitializer, align 4 ;
        %Dummy = type { `~llvmType!T~` addrspace(3)* }    
            `, `
        %sharedptr = getelementptr inbounds [`~Itoa!N~` x `~llvmType!T~`], [`~Itoa!N~` x `~llvmType!T~`] addrspace(3)* @`~uniqueName~`, i32 0, i32 0
  
        %.structliteral = alloca %Dummy, align 8 

        %dumptr = getelementptr inbounds %Dummy, %Dummy* %.structliteral, i32 0, i32 0

        store `~llvmType!T~` addrspace(3)* %sharedptr, `~llvmType!T~` addrspace(3)** %dumptr
        
        %vptr = bitcast %Dummy* %.structliteral to i8*
        ret i8* %vptr
            `, ``, void*)();
    return *(cast(SharedPointer!(T)*)address);
}

/+ defines and allocates a global constant. Host code must initialize this array like
	`
	size_t nbytes;
    	size_t _gaussConstAddr = Program.getGlobal(nbytes, "gauss0"); // uniqueName must match here
    	cuMemcpyHtoD(_gaussConstAddr, Gaussian.ptr, nbytes);
	`
    This type is immutable for device, but the memory can be updated in host code.
+/
immutable(T)* constStaticReserve(T : T[N], string uniqueName, size_t N)(){
    if(__dcompute_reflect(ReflectTarget.CUDA)){
        immutable(T)* address = __irEx!(`@`~uniqueName~` = addrspace(4) externally_initialized global [`~Itoa!N~` x `~llvmType!T~`] zeroinitializer, align 4
            `, `
            %mptr = getelementptr inbounds [`~Itoa!N~` x `~llvmType!T~`], [`~Itoa!N~` x `~llvmType!T~`] addrspace(4)* @`~uniqueName~`, i32 0, i32 0

            %r = addrspacecast `~llvmType!T~` addrspace(4)* %mptr to `~llvmType!T~`*
            ret `~llvmType!T~`* %r
            `, ``, immutable(T)*)();
        return address;
	// returning a ConstPointer!T causes an LLVM error for CUDA backend. immutable(T)* is a convenient type anyway.
    } else if(__dcompute_reflect(ReflectTarget.OpenCL)){
	immutable(T)* address = __irEx!(`@`~uniqueName~` = addrspace(2) global [`~Itoa!N~` x `~llvmType!T~`] zeroinitializer, align 4
            `, `
            %mptr = getelementptr inbounds [`~Itoa!N~` x `~llvmType!T~`], [`~Itoa!N~` x `~llvmType!T~`] addrspace(2)* @`~uniqueName~`, i32 0, i32 0

            %r = addrspacecast `~llvmType!T~` addrspace(2)* %mptr to `~llvmType!T~`*
            ret `~llvmType!T~`* %r
            `, ``, immutable(T)*)();
        return address;
    } else
	assert(0);
    
}

immutable(string) Digit(size_t n)()
{
    static if(n == 0)
	    return 0.stringof;
    else static if(n == 1)
	    return 1.stringof;
    else static if(n == 2)
	    return 2.stringof;
    else static if(n == 3)
	    return 3.stringof;
    else static if(n == 4)
	    return 4.stringof;
    else static if(n == 5)
	    return 5.stringof;
    else static if(n == 6)
	    return 6.stringof;
    else static if(n == 7)
	    return 7.stringof;
    else static if(n == 8)
	    return 8.stringof;
    else static if(n == 9)
	    return 9.stringof;
    else static assert(0);
}


immutable(string) Itoa(uint n)()
{
	static if(n < 0){
		enum ret = "-" ~ Itoa!(-n);
        return ret;
    }
	else static if (n < 10){
		enum ret = Digit!(n);
        return ret;
    }
	else{
		enum ret = Itoa!(n / 10) ~ Digit!(n % 10);
        return ret;
    }
}

immutable(string) llvmType(T)()
{
    static if(is(T == float))
        return "float";
    else static if(is(T == double))
        return "double";
    else static if(is(T == byte) || is(T == ubyte) || is(T == void))
        return "i8";
    else static if(is(T == short) || is(T == ushort))
        return "i16";
    else static if(is(T == int) || is(T == uint))
        return "i32";
    else static if(is(T == long) || is(T == ulong))
        return "i64";
    else
        static assert(0,
            "Can't determine llvm type for D type " ~ T.stringof);
}
