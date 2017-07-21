module dcompute.driver.ocl120.util;

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

struct ArrayAccesssor(alias ptr, alias len) {}

struct StringzAccessor(alias ptr) {}

struct ZeroTerminatedArrayAccessor(alias ptr) {}

mixin template generateGetInfo(alias func)
{
    //TODO
    //
}
