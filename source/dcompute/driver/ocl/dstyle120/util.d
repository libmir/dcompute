module dcompute.driver.ocl.dstyle120.util;

import std.range;

//deal with arrays seperately, in part to avoid any
//narrow-string idiocy
@property auto memSize(R)(R r)
if (is(R : T[], T))
{
    static if (is(R : T[], T))
        return r.length * T.sizeof;
    else
        static assert(false);
}

@property auto memSize(R)(R r)
if(isInputRange!R && hasLength!R && !is(R : T[], T))
{
    return r.length * (ElementType!R).sizeof;
}

T[Args.length + 1] propertyList(T,Args...)(Args args)
{
    T[Args.length + 1] props;
    foreach(i, arg; args)
    props[i] = *cast(T*)(&arg);
    return props;
}

struct EnumAndReturnType(alias flag_, ReturnT_, alias handler_ = null)
{
    alias flag = flag_;
    alias ReturnT = ReturnT_;
    static if(!is(typeof(handler_) == typeof(null)))
        alias handler = handler_;
}

alias EART = EnumAndReturnType;

struct EARTGroup(alias F_, EARTs_...)
if (allSatisfy!(ApplyLeft!(isInstanceOf, EART), EARTs_))
{
    alias F = F_;
    alias EARTs = EARTs_;
}
