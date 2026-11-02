module dcompute.driver.d3d12.traits;

import dcompute.driver.d3d12.buffer;
import dcompute.driver.d3d12.image;
import std.traits;
import std.meta;

/// Transforms a kernel function's parameter types into the corresponding host
/// types. Specifically, replaces `GlobalPointer!T` with `Buffer!T`.
template HostArgsOf(F) {
    import ldc.dcompute : Pointer; // Pointer!T is aliased to GlobalPointer!T in dcompute
    alias HostArgsOf = staticMap!(ReplaceTemplate!(Pointer, Buffer), Parameters!F);
}

private template ReplaceTemplate(alias needle, alias replacement) {
    template ReplaceTemplate(T) {
        static if (is(T : needle!Args, Args...)) {
            // Replaces Pointer!T with Buffer!T
            alias ReplaceTemplate = replacement!(Args[1]);
        } else {
            alias ReplaceTemplate = T;
        }
    }
}

/// Utility trait to check if a type is a D3D12 Buffer!T
template isBufferArg(T) {
    static if (is(T : Buffer!U, U))
        enum isBufferArg = true;
    else
        enum isBufferArg = false;
}

/// Utility trait to check if a type is a D3D12 Image!(Dim, T)
template isImageArg(T) {
    static if (is(T : Image!(Dim, U), uint Dim, U))
        enum isImageArg = true;
    else
        enum isImageArg = false;
}

/// Count the number of UAV (Buffer) parameters in a kernel signature
template countUAVs(alias k) {
    enum countUAVs = getUAVCount!(HostArgsOf!(typeof(k)))();
}

private size_t getUAVCount(Args...)() {
    size_t count = 0;
    static foreach (arg; Args) {
        static if (isBufferArg!arg || isImageArg!arg)
            count++;
    }
    return count;
}

/// Count the number of scalar (non-Buffer) parameters in a kernel signature
template countScalars(alias k) {
    enum countScalars = getScalarCount!(HostArgsOf!(typeof(k)))();
}

private size_t getScalarCount(Args...)() {
    size_t count = 0;
    static foreach (arg; Args) {
        static if (!isBufferArg!arg && !isImageArg!arg)
            count++;
    }
    return count;
}

/// Calculate the total packed byte size of scalar arguments
template scalarSize(alias k) {
    enum scalarSize = getScalarSize!(HostArgsOf!(typeof(k)))();
}

private size_t getScalarSize(Args...)() {
    size_t sz = 0;
    static foreach (arg; Args) {
        static if (!isBufferArg!arg && !isImageArg!arg)
            sz += arg.sizeof;
    }
    return sz;
}

/// Validates that a kernel function complies with the DCompute Driver ABI.
/// The ABI requires:
/// 1. All Buffer (GlobalPointer) arguments are mapped sequentially to Space 0/Set 0.
/// 2. All Scalar arguments must be Plain Old Data (POD) / trivially copyable.
/// 3. The maximum scalar constant buffer size must not exceed limits (e.g. 64KB).
template checkKernelABI(alias k) {
    import std.traits : isAggregateType, hasUnsharedAliasing;
    
    enum checkKernelABI = enforceABI!(HostArgsOf!(typeof(k)))();
}

private bool enforceABI(Args...)() {
    static foreach (i, arg; Args) {
        static if (!isBufferArg!arg && !isImageArg!arg) {
            static assert(!hasUnsharedAliasing!arg, 
                "DCompute ABI Error: Scalar argument `" ~ arg.stringof ~ "` contains unshared aliasing (pointers/references). " ~
                "Kernel arguments must be trivially copyable PODs or GlobalPointers or Images.");
            static assert(!is(arg == class), 
                "DCompute ABI Error: Kernel scalar arguments cannot be classes.");
        }
    }
    
    // Constant buffers must typically fit in 64KB for maximum portability across hardware.
    static assert(getScalarSize!(Args)() <= 65536,
        "DCompute ABI Error: Total size of scalar arguments exceeds the 64KB constant buffer limit.");
        
    return true;
}
