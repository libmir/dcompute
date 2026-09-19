module dcompute.driver.metal;
import ldc.dcompute;
import std.range;
import std.meta;
import std.traits;

public import dcompute.driver.metal.buffer;
public import dcompute.driver.metal.device;
public import dcompute.driver.metal.kernel;
public import dcompute.driver.metal.platform;
public import dcompute.driver.metal.program;
public import dcompute.driver.metal.queue;


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
