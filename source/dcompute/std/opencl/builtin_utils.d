/**
Provides a helper function `callBuiltin` which allows for easy calling of
OpenCL built-in functions.

See_Also: [6.15. Built-in Functions](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#built-in-functions)
Standards: [The OpenCL™ C Specification](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html)
License:  [Boost License 1.0](https://boost.org/LICENSE_1_0.txt).
*/
@compute(CompileFor.deviceOnly) module dcompute.std.opencl.builtin_utils;

import ldc.dcompute;
import ldc.attributes;
import std.meta;

nothrow:
@nogc:

/**
Calls an OpenCL built-in function.
Examples:
---
callBuiltin!("acos", float)(1.0f);
---
---
T acos(T)(T x)
{
    return callBuiltin!("acos", T)(x);
}
---

Params:
    funName = The name of the function to call.
    returnT = The return type of the function.
    args    = The arguments to pass to the function.

Returns: The return value of the called OpenCL function.

Note:
Calling this function from CUDA is undefined behavior.$(BR)
This function doesn't check if the called OpenCL function is valid.
Calling an OpenCL function with an invalid name or any invalid return
types or arguments is undefined behavior.
*/

@llvmAttr("inlinehint")
returnT callBuiltin(string funName, returnT, Args...)(Args args)
{
    if(__dcompute_reflect(ReflectTarget.OpenCL))
    {
        mixin(MangleBuilder!(funName), "\n",
              DefBuilder!(funName, returnT, Args));
        // Can't use a semicolon or it won't compile for some reason.
        return mixin(funName, "(", args.stringof, ")");
    }
    else
    {
        return returnT.init;
    }
}

/**
Generates an `AliasSeq` of strings, which when summed
form a pragma declaration.
Examples:
---
pragma(mangle, "_Z4acos")
---

Params:
    funName = The function name to be inserted into the mangle.

Returns: An `AliasSeq` of strings.
*/
// LLVM does't check the mangle for types, just the "_Z", length and name.
// Saves a lot of pain here.
private template MangleBuilder(string funName)
{
    // Need the cast or else the length will have an "LU" attached.
    alias MangleBuilder = AliasSeq!("pragma(mangle, \"_Z",
                                    cast(int) funName.length, funName, "\")");
}

/**
Generates an `AliasSeq` of strings, which when summed
form a function prototype.
Examples:
---
extern (C) float acos(float);
---

Params:
    funName = The function name.
    returnT = The return type of the function.
    Args... = A type sequence of types which will form the function parameters.

Returns: An `AliasSeq` of strings.
*/
private template DefBuilder(string funName, returnT, Args...)
{
    // Need the `extern (C)` or else the llvm ir function will have a
    // `ptr nonnull null` as the first parameter for some reason.
    alias A = AliasSeq!("extern (C) nothrow @nogc ", returnT.stringof, " ", funName, "(");
    static foreach (i, Arg; Args)
    {
        A = AliasSeq!(A, Arg.stringof);
        static if (i != Args.length - 1)
        {
            A = AliasSeq!(A, ", ");
        }
    }
    A = AliasSeq!(A, ");");
    alias DefBuilder = A;
}
