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
import dcompute.tests.dummykernels : saxpy, abi_test, ComplexScalar;

version(DComputeTestOpenCL)
    import dcompute.driver.ocl;
else version(DComputeTestCUDA) {
    import dcompute.driver.cuda.unified_buffer;
    import dcompute.driver.cuda;
}
else version(DComputeTestDirectX) {
    import dcompute.driver.d3d12.unified_buffer;
    import dcompute.driver.d3d12.image;
    import dcompute.driver.d3d12;
}
else
    static assert(false, "Need to test something!");

// Index of OpenCL 2.1 capable platform returned by Platform.getPlatforms
enum CL_PLATFORM_INDEX = 2;

version(unittest)
{
    import core.runtime : Runtime;
    shared static this()
    {
        Runtime.moduleUnitTester = {
            foreach (m; ModuleInfo)
            {
                if (m !is null && m.unitTest !is null)
                    m.unitTest()();
            }
            return true;
        };
    }
}

int main(string[] args)
{
    version (DComputeTestCUDA)
    {
        // Soft-fail init test (see dcompute.tests.runtime_init).  Opt-in via
        // env var because it must run with the CUDA devices masked, e.g.:
        //     DCOMPUTE_TEST_NO_CUDA=1 CUDA_VISIBLE_DEVICES="" ./dcompute
        import std.process : environment;
        if (environment.get("DCOMPUTE_TEST_NO_CUDA") !is null)
        {
            import dcompute.tests.runtime_init : runNoCudaInitTest;
            return runNoCudaInitTest();
        }
    }

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
        // Exercise RC wrappers for CUDA driver objects.
        runRaiiDestructorTests();

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

    version(DComputeTestDirectX)
    {
        static if (__VERSION__ >= 2113)
        {
            // 0. Hardware Capabilities Discovery
            {
                writeln("=== D3D12 Hardware Capabilities ===");
                Platform.initialise();
                auto devs = Platform.getDevices();
                auto dev = devs.length > 0 ? devs[0] : Platform.getWarpDevice();

                auto devInfo = dev.info;
                writefln("  Adapter:            %s", devInfo.description);
                writefln("  Vendor ID:          0x%04X", devInfo.vendorId);
                writefln("  VRAM:               %d MB", devInfo.dedicatedVideoMemory / (1024*1024));

                auto sm = dev.highestShaderModel;
                writefln("  Highest SM:         %d.%d", sm >> 4, sm & 0xF);
                writefln("  Binding Tier:       %d", dev.resourceBindingTier);
                writefln("  Bindless (SM 6.6):  %s", dev.supportsBindless ? "YES" : "NO");
                writefln("  Wave Intrinsics:    %s", dev.supportsWaveIntrinsics ? "YES" : "NO");
                writefln("  Unified Memory:     %s", dev.supportsUnifiedMemory ? "YES" : "NO");
                writeln("===================================\n");
            }

            // 1. Manual test
            {

                // D3D12 uses embedded DXIL blob
                Program.globalProgram = Program.fromModule!("dcompute.tests.dummykernels")();
                auto q = Queue(false);
                scope(exit) q.release();

                Buffer!(float) b_res, b_x, b_y;
                b_res = Buffer!(float)(res[]); scope(exit) b_res.release();
                b_x   = Buffer!(float)(x[]);   scope(exit) b_x.release();
                b_y   = Buffer!(float)(y[]);   scope(exit) b_y.release();

                b_x.copy!(Copy.hostToDevice);
                b_y.copy!(Copy.hostToDevice);

                auto e = q.enqueue!(saxpy)([N,1,1],[1,1,1])(b_res, alpha, b_x, b_y, N);
                q.wait(e); // test GPU-side sync
                
                b_res.copy!(Copy.deviceToHost);
                q.finish(); // Ensure all transfers are done

                // Validate
                foreach(i; 0 .. N) enforce(res[i] == alpha * x[i] + y[i], "D3D12 Standard Buffer copy failed!");
                res[] = 0.0f; // reset
                Program.globalProgram.unload();
                Program.globalProgram = Program();
            }

            // 2. Launch / USM test
            {
                Buffer!(float) b_res, b_x, b_y;
                b_res = Buffer!(float)(res[]); scope(exit) b_res.release();
                b_x   = Buffer!(float)(x[]);   scope(exit) b_x.release();
                b_y   = Buffer!(float)(y[]);   scope(exit) b_y.release();

                b_x.copy!(Copy.hostToDevice);
                b_y.copy!(Copy.hostToDevice);
        
                launch!saxpy([N,1,1],[1,1,1], b_res, alpha, b_x, b_y, N);
                b_res.copy!(Copy.deviceToHost);

                defaultQueue().finish();

                foreach(i; 0 .. N) enforce(res[i] == alpha * x[i] + y[i], "D3D12 Launch wrapper failed!");
                res[] = 0.0f; // reset

                // Unified Memory test
                if (defaultDevice().supportsUnifiedMemory)
                {
                    writeln("\nDevice supports Unified Memory — running UnifiedBuffer test...");

                    auto ub_x   = UnifiedBuffer!float(x[]);   scope(exit) ub_x.release();
                    auto ub_y   = UnifiedBuffer!float(y[]);   scope(exit) ub_y.release();
                    auto ub_res = UnifiedBuffer!float(N);     scope(exit) ub_res.release();

                    launch!saxpy([N,1,1],[1,1,1], ub_res, alpha, ub_x, ub_y, N);
                    defaultQueue().finish(); // synchronize

                    foreach (i; 0 .. N)
                        enforce(ub_res.hostSlice[i] == alpha * x[i] + y[i],
                                "D3D12 Unified Memory verification failed!");

                    writeln("D3D12 UnifiedBuffer test PASSED.");
                }
                else
                {
                    writeln("\nDevice does not support Unified Memory — skipping UnifiedBuffer test.");
                }
            }

            // 3. ABI Packing Test
            {
                writeln("\nRunning ABI Test...");
                int scalar1 = 5;
                ComplexScalar scalar2 = ComplexScalar(1.5f, 2.5f, 10);
                float scalar3 = 42.0f;
                
                float[N] host_buf0;
                int[N] host_buf1;
                float[N] host_buf2;
                
                Buffer!(float) buf0 = Buffer!(float)(host_buf0[]); scope(exit) buf0.release();
                Buffer!(int) buf1   = Buffer!(int)(host_buf1[]);   scope(exit) buf1.release();
                Buffer!(float) buf2 = Buffer!(float)(host_buf2[]); scope(exit) buf2.release();
                
                launch!abi_test([N,1,1],[1,1,1], scalar1, buf0, scalar2, buf1, scalar3, buf2, N);
                
                buf0.copy!(Copy.deviceToHost);
                buf1.copy!(Copy.deviceToHost);
                buf2.copy!(Copy.deviceToHost);
                defaultQueue().finish();
                
                foreach(i; 0 .. N) {
                    enforce(host_buf0[i] == scalar2.x + scalar2.y + scalar3, "ABI Test failed at buf0!");
                    enforce(host_buf1[i] == scalar1 + scalar2.z, "ABI Test failed at buf1!");
                }
                writeln("D3D12 ABI Test PASSED.");
            }

            // 4. Auto Index Test
            {
                writeln("\nRunning Auto Index Test...");
                float[N] host_a, host_b, host_c;
                foreach(i; 0 .. N) { host_b[i] = i; host_c[i] = i * 2.0f; }
                
                Buffer!(float) buf_a = Buffer!(float)(host_a[]); scope(exit) buf_a.release();
                Buffer!(float) buf_b = Buffer!(float)(host_b[]); scope(exit) buf_b.release();
                Buffer!(float) buf_c = Buffer!(float)(host_c[]); scope(exit) buf_c.release();
                
                buf_b.copy!(Copy.hostToDevice);
                buf_c.copy!(Copy.hostToDevice);
                
                import dcompute.tests.dummykernels : auto_index_test;
                launch!auto_index_test([N,1,1],[1,1,1], buf_a, buf_b, buf_c);
                
                buf_a.copy!(Copy.deviceToHost);
                defaultQueue().finish();
                
                foreach(i; 0 .. N) {
                    enforce(host_a[i] == host_b[i] + host_c[i], "Auto Index Test failed!");
                }
                writeln("D3D12 Auto Index Test PASSED.");
            }

            // 5. Image ABI Test
            {
                writeln("\nRunning Image ABI Test...");
                import dcompute.tests.dummykernels : image_test, Texture2D;
                
                float[N] host_out;
                Buffer!(float) buf_out = Buffer!(float)(host_out[]); scope(exit) buf_out.release();
                
                Texture2D!float dummyTex;
                dummyTex.dummy = 0;
                
                launch!image_test([N,1,1],[1,1,1], dummyTex, buf_out, N, 1);
                
                buf_out.copy!(Copy.deviceToHost);
                defaultQueue().finish();
                
                foreach(i; 0 .. N) {
                    enforce(host_out[i] == 1.0f, "Image ABI Test failed!");
                }
                writeln("D3D12 Image ABI Test PASSED.");
            }
        }
        else
        {
            writeln("DCompute injected-DXIL tests require LDC >= 1.43 " ~
                    "(D frontend __VERSION__ >= 2113).");
            return 0;
        }
    }

    foreach(i; 0 .. N)
        enforce(res[i] == alpha * x[i] + y[i]);
    writeln(res[]);
    return 0;
}

version(DComputeTestCUDA)
{
    struct RaiiTests
    {
        import dcompute.driver.cuda.rc : Buffer, Context, Event, Program, Queue;
        static import driver = dcompute.driver.cuda;

        private static void dropBufferCopy(Buffer!float copy) {}
        private static void dropQueueCopy(Queue copy) {}

        // Refcount keeps the device allocation alive across copies.
        private static void testBufferRefcountSurvivesCopy()
        {
            enum size_t M = 64;
            float[M] src, back;
            foreach (i; 0 .. M) src[i] = cast(float)(i * 3 + 1);
            back[] = 0.0f;

            auto b = Buffer!float(src[]);
            enforce(b.raw != 0, "Buffer allocation failed");

            dropBufferCopy(b);

            {
                Buffer!float[1] arr;
                arr[0] = b;
            }

            b.copy!(Copy.hostToDevice);
            b.hostMemory = back[];
            b.copy!(Copy.deviceToHost);
            foreach (i; 0 .. M)
                enforce(back[i] == src[i],
                        "Buffer H2D/D2H mismatch after copy dtor at " ~ i.to!string);
        }

        // Refcount keeps the CUstream alive across copies.
        private static void testQueueRefcountSurvivesCopy()
        {
            auto q = Queue(false);
            enforce(q.raw !is null, "Queue creation failed");

            dropQueueCopy(q);

            {
                Queue[1] arr;
                arr[0] = q;
            }

            q.async;
            enforce(q.raw !is null, "Queue handle nulled unexpectedly");
        }

        // Last owner frees exactly once; nested copies destroyed in sequence.
        private static void testLastOwnerFreesNoDoubleFree()
        {
            enum size_t M = 32;
            float[M] src;
            foreach (i; 0 .. M) src[i] = cast(float) i;
            {
                auto a = Buffer!float(src[]);
                {
                    auto bb = a;
                    {
                        auto cc = bb;
                    }
                }
                a.copy!(Copy.hostToDevice);
            }

            auto d = Buffer!float(M);
            enforce(d.raw != 0, "post-free allocation failed (context may be corrupt)");
        }

        private static size_t deviceFreeBytes()
        {
            size_t freeB, totalB;
            immutable r = cuMemGetInfo(&freeB, &totalB);
            enforce(r == 0, "cuMemGetInfo failed with CUresult " ~ r.to!string);
            return freeB;
        }

        private enum size_t MiB = 1024 * 1024;
        private enum size_t BIG_BYTES = 128 * MiB;
        private enum size_t BIG_ELEMS = BIG_BYTES / float.sizeof;
        private enum size_t MEM_SLACK = 32 * MiB;

        // Scope exit alone must return device memory to driver.
        private static void testScopedDtorReturnsDeviceMemory()
        {
            { auto warm = Buffer!float(BIG_ELEMS); }

            immutable before = deviceFreeBytes();
            size_t during;
            {
                auto big = Buffer!float(BIG_ELEMS);
                enforce(big.raw != 0, "128 MiB device allocation failed");
                during = deviceFreeBytes();
            }
            immutable after = deviceFreeBytes();

            enforce(before >= during + BIG_BYTES,
                    "allocation not visible in cuMemGetInfo");
            enforce(after + MEM_SLACK >= before,
                    "dtor did NOT return device memory");
        }

        // Static/factory calls stay on driver types; caller wraps in RC: Program(driver.Program.fromString(...))
        private static void testProgramRcWrap()
        {
            enum string ptx =
                ".version 6.0\n" ~
                ".target sm_52\n" ~
                ".address_size 64\n" ~
                ".visible .entry _dcompute_raii_noop() { ret; }\n";
            try
            {
                {
                    auto p = Program(driver.Program.fromString(ptx));
                    enforce(p.raw !is null, "driver module load returned null");
                    auto copy = p;
                }
                writeln("  Program wrapped from driver.Program.fromString: PASS");
            }
            catch (Exception e)
            {
                writeln("  Program RC test SKIPPED: ", e.msg);
            }
        }

        static void run()
        {
            ensureInit();
            writeln("RAII destructor / refcount tests:");
            testBufferRefcountSurvivesCopy();
            writeln("  Buffer refcount survives copies: PASS");
            testQueueRefcountSurvivesCopy();
            writeln("  Queue refcount survives copies: PASS");
            testLastOwnerFreesNoDoubleFree();
            writeln("  last-owner-frees / no double free: PASS");
            testScopedDtorReturnsDeviceMemory();
            writeln("  scoped dtor returns device memory (cuMemGetInfo): PASS");
            testProgramRcWrap();
            writeln("RAII destructor tests complete.\n");
        }
    }

    void runRaiiDestructorTests()
    {
        RaiiTests.run();
    }
}
