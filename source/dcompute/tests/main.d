import dcompute.tests.test;

import std.stdio;
import std.traits;
import std.meta;

import std.experimental.allocator;

import dcompute.tests.dummykernels : saxpy;

import dcompute.driver.ocl120;

ubyte[] readBinaryFromDisk()
{
    return typeof(return).init;
}

float[] somedata() { return [1,2,3,4,5]; }
int main(string[] args)
{
    auto platform = Platform.getPlatforms(theAllocator)[0];
    auto devices  = platform.getDevices(theAllocator);
    auto plist    = propertyList!(Context.Properties)(Context.Properties.platform);
    auto context  = Context(devices,plist);
    Program.globalProgram = context.createProgramFromSPIR(theAllocator,devices,readBinaryFromDisk());
    auto queue    = context.createQueue(devices[0],Queue.Properties.outOfOrderExecution);
    auto data     = somedata();
    auto buf      = context.createBuffer!(float)(Memory.Flags.none,data);
    Event e = queue.enqueue!(saxpy)([5])(buf,buf,42.0);
    e.wait();
    return 0;
}


