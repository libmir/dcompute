version = DComputeTestCUDA;

import dcompute.tests.test;

import std.stdio;
import std.traits;
import std.meta;
import std.exception : enforce;
import std.experimental.allocator;
import std.array;

import dcompute.tests.dummykernels : saxpy;

version(DComputeTestOpenCL)
    import dcompute.driver.ocl120;
version(DComputeTestCUDA)
    import dcompute.driver.cuda;

ubyte[] readBinaryFromDisk()
{
    return typeof(return).init;
}

float[] somedata() { return [1,2,3,4,5]; }
int main(string[] args)
{
    version(DComputeTestOpenCL)
    {
        auto platform = Platform.getPlatforms(theAllocator)[0];
        auto devices  = platform.getDevices(theAllocator);
        auto plist    = propertyList!(Context.Properties)(Context.Properties.platform);
        auto ctx      = Context(devices,plist);
        Program.globalProgram = context.createProgramFromSPIR(theAllocator,devices,readBinaryFromDisk());
        auto queue    = context.createQueue(devices[0],Queue.Properties.outOfOrderExecution);
        auto data     = somedata();
        auto buf      = context.createBuffer!(float)(Memory.Flags.none,data);
        Event e = queue.enqueue!(saxpy)([5])(buf,buf,42.0);
        e.wait();
    }
    version(DComputeTestCUDA)
    {
        Platform.initialise();
        
        auto devs    = Platform.getDevices(theAllocator);
        auto dev    = devs[0]; 
        auto ctx    = Context(dev); scope(exit) ctx.detach();

        // Change the file to match your GPU.
        Program.globalProgram = Program.fromFile("./.dub/obj/kernels_cuda210_64.ptx");
        auto q = Queue(false);

        enum size_t N = 128;
        float alpha = 5.0;
        float[N] res, x,y;
        foreach (i; 0 .. N)
        {
            x[i] = N - i;
            y[i] = i * i;
        }
        Buffer!(float) b_res, b_x, b_y;
        b_res      =  Buffer!(float)(res[]); scope(exit) b_res.release();
        b_x        =  Buffer!(float)(x[]);   scope(exit) b_x.release();
        b_y        =  Buffer!(float)(y[]);   scope(exit) b_y.release();

        b_x.copy!(Copy.hostToDevice);
        b_y.copy!(Copy.hostToDevice);

        q.enqueue!(saxpy)
            ([N,1,1],[1,1,1])
            (b_res,alpha,b_x,b_y, N);
        b_res.copy!(Copy.deviceToHost);
        foreach(i; 0 .. N)
            enforce(res[i] == alpha * x[i] + y[i]);
        writeln(res[]);
    }

    return 0;
}


