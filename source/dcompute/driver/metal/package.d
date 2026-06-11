module dcompute.driver.metal;
import dcompute.driver.metal.buffer;
import ldc.dcompute;
import std.range;
import std.meta;
import std.traits;

template HostArgsOf(F)
{
    template toBuffer(T)
    {
        static if (is(T: Pointer!(n,U), uint n, U))
            alias toBuffer = Buffer!U;
        else
            alias toBuffer = T;
    }

    alias HostArgsOf = staticMap!(toBuffer, Parameters!F);
}
