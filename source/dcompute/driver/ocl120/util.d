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

struct ArrayAccesssor(alias ptr, alias len) 
{
    alias elementType = typeof(*ptr);
}

struct ArrayAccesssor2D(alias ptr, alias lens, alias len) 
{
    alias elementType = typeof(**ptr);
}

// C style char*
struct StringzAccessor(alias ptr) {}

// A propertyList
struct ZeroTerminatedArrayAccessor(alias ptr) {}

mixin template generateGetInfo(alias func)
{
    //TODO
    //
}

// Returned by ArrayAccesssor2D
struct RangeOfArray(T)
{
    T**     ptr;
    size_t* lengths;
    size_t  length;
    size_t  index;
    
    bool empty()
    {
        return index == length;
    }
    
    @property T[] front()
    {
        return ptr[index][0 .. lengths[index]];
    }
    
    void popFront()
    {
        ++index;
    }
}
