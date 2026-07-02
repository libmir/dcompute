module dcompute.tests.main;

version (DComputeTesting) {
    version = DComputeTestCUDA;
}

//import dcompute.tests.test;

import std.algorithm;
import std.stdio;
import std.file;
import std.traits;
import std.meta;
import std.exception : enforce;
import std.experimental.allocator;
import std.array;
import std.typecons;
import std.conv : to;
import std.math.traits : isNaN;

import dcompute.tests.dummykernels : saxpy;

version(DComputeTestOpenCL)
    import dcompute.driver.ocl;
else version(DComputeTestCUDA) {
    import dcompute.driver.cuda.unified_buffer;
    import dcompute.driver.cuda;
}
else
    static assert(false, "Need to test something!");

// Index of OpenCL 2.1 capable platform returned by Platform.getPlatforms
enum CL_PLATFORM_INDEX = 2;

int main(string[] args)
{
    enum size_t N = 128;
    float alpha = 5.0;
    float[N] res, x,y;
    foreach (i; 0 .. N)
    { 
        x[i] = N - i;
        y[i] = i * i;
    }

    version(DComputeTestOpenCL)
    {
        Platform.initialise();
        onDriverError = (Status _status) { throw new DComputeDriverException(_status); };
        auto platforms = Platform.getPlatforms(theAllocator);
        auto platform = platforms[CL_PLATFORM_INDEX];
        DerelictCL.reload(CLVersion.CL21);

        writeln("Platforms:");
        foreach (i, ref p; platforms)
        {
            writefln("\t[%d%1s] %s", i, (i == CL_PLATFORM_INDEX) ? "*" : "", p.name);
        }
        writeln("\tChosen: ", platform.name);

        auto devices  = platform.getDevices(theAllocator);
        writeln("Devices:");
        foreach (i, ref d; devices)
        {
            writefln("\t[%d] %s", i, d.name);
            writefln("\t\t%s", d.vendor);
            writefln("\t\t(%d)%s", d.type, d.type);
            writefln("\t\t(%d)%s", d.queueProperties, d.queueProperties);
            writefln("\t\t(%d)%s", d.floatFPConfig, d.floatFPConfig);
            writefln("\t\t(%d)%s", d.GLobalMemoryCacheType, d.GLobalMemoryCacheType);
            writefln("\t\t(%d)%s", d.executionCapabilities, d.executionCapabilities);
            // writefln("\t\t%s", d.OpenCLCVersion);
            // writefln("\t\t%s", d.deviceVersion);
            // writefln("\t\t%s", d.builtinKernels);
        }
        writeln("\tChosen: ", devices[0].name);

        auto plist    = propertyList!(Context.Properties)(Context.Properties.platform, platform.raw);
        writeln(plist);
        auto ctx      = Context(devices[0 ..1],null /*FIXME: plist[]*/);
	    // Change the file to the built OpenCL version.
        version (Windows) {
            Program.globalProgram = ctx.createProgram(cast(ubyte[]) read("./kernels_ocl200_64.spv"));
        } else {
            Program.globalProgram = ctx.createProgram(cast(ubyte[]) read("./.dub/obj/kernels_ocl200_64.spv"));
        }

        try
        {
            Program.globalProgram.build(devices,"");
        }
            catch(DComputeDriverException e)
        {
            auto b = Build(Program.globalProgram, devices[0]);
            writeln(b.log);
        }
        
        auto queue    = ctx.createQueue(devices[0],Queue.Properties.outOfOrderExecution);

        Buffer!(float) b_res, b_x, b_y;

        b_res = ctx.createBuffer(res[], Memory.Flags.useHostPointer | Memory.Flags.readWrite);
        b_x = ctx.createBuffer(x[],Memory.Flags.useHostPointer | Memory.Flags.readWrite);
        b_y = ctx.createBuffer(y[],Memory.Flags.useHostPointer | Memory.Flags.readWrite);

        Event e = queue.enqueue!(saxpy)([N])(b_res,alpha,b_x,b_y, N);
        e.wait();

        // zero-copy failed
        if (isNaN(res[0])) {
            writeln("Read buffer from device");
            queue.read!(float)(b_res, res);
        }
    }

    version(DComputeTestCUDA)
    {
        // The injected-PTX feature (Program.fromModule / launch!) needs an LDC that
        // embeds device PTX into the binary: D frontend __VERSION__ >= 2113 (LDC >= 1.43).
        // On older compilers these tests are skipped rather than failing to build.
        static if (__VERSION__ >= 2113)
        {
        // 1. Manual test
        {
            Platform.initialise();
            auto devs = Platform.getDevices(theAllocator);
            auto dev   = devs[0]; 
            auto ctx   = Context(dev); scope(exit) ctx.detach();

            Program.globalProgram = Program.fromModule!("dcompute.tests.dummykernels")();
            auto q = Queue(false);

            Buffer!(float) b_res, b_x, b_y;
            b_res =  Buffer!(float)(res[]); scope(exit) b_res.release();
            b_x   =  Buffer!(float)(x[]);   scope(exit) b_x.release();
            b_y   =  Buffer!(float)(y[]);   scope(exit) b_y.release();

            b_x.copy!(Copy.hostToDevice);
            b_y.copy!(Copy.hostToDevice);

            q.enqueue!(saxpy)
                      ([N,1,1],[1,1,1])
                      (b_res,alpha,b_x,b_y, N);
            b_res.copy!(Copy.deviceToHost);
            
            // Validate 
            foreach(i; 0 .. N) enforce(res[i] == alpha * x[i] + y[i]);
            res[] = 0.0f; // reset
            Program.globalProgram.raw = null; // reset global state so lazy init triggers
        }

        // 2. New test
        {
            Buffer!(float) b_res, b_x, b_y;
            b_res =  Buffer!(float)(res[]); scope(exit) b_res.release();
            b_x   =  Buffer!(float)(x[]);   scope(exit) b_x.release();
            b_y   =  Buffer!(float)(y[]);   scope(exit) b_y.release();

            b_x.copy!(Copy.hostToDevice);
            b_y.copy!(Copy.hostToDevice);
    
            launch!saxpy([N,1,1],[1,1,1], b_res, alpha, b_x, b_y, N);
            b_res.copy!(Copy.deviceToHost);

            //  Unified Memory test (runs only when the device supports it) 
            if (defaultDevice().supportsUnifiedMemory)
            {
                writeln("\nDevice supports Unified Memory — running UnifiedBuffer test...");

                // Allocate managed memory and initialise from host slices.
                // No explicit H2D copy is needed; the runtime migrates pages.
                auto ub_x   = UnifiedBuffer!float(x[]);   scope(exit) ub_x.release();
                auto ub_y   = UnifiedBuffer!float(y[]);   scope(exit) ub_y.release();
                auto ub_res = UnifiedBuffer!float(N);     scope(exit) ub_res.release();

                launch!saxpy([N,1,1],[1,1,1], ub_res, alpha, ub_x, ub_y, N);

                // Synchronise so that host can safely read results.
                // (No D2H copy — the host slice is the same allocation.)
                Context.sync();

                foreach (i; 0 .. N)
                    enforce(ub_res.hostSlice[i] == alpha * x[i] + y[i],
                            "Unified Memory verification failed at index " ~ i.to!string ~ "!");

                writeln("UnifiedBuffer test PASSED.");
            }
            else
            {
                writeln("\nDevice does not support Unified Memory — skipping UnifiedBuffer test.");
            }
        }
        }
        else
        {
            writeln("DCompute injected-PTX tests (fromModule / launch!) require LDC >= 1.43 " ~
                    "(D frontend __VERSION__ >= 2113); this compiler reports an older " ~
                    "__VERSION__ — skipping the CUDA embedded-PTX tests.");
            return 0;
        }
    }

    foreach(i; 0 .. N)
        enforce(res[i] == alpha * x[i] + y[i]);
    writeln(res[]);
    return 0;
}


