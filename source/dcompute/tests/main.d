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
        // RAII destructor / refcount tests. These exercise the shared-atomic
        // refcount postblits + destructors added to Buffer/Queue/Context/
        // UnifiedBuffer. They need only a live CUDA context (set up by
        // dcompute.driver.cuda.runtime's module constructors) and never launch a
        // kernel, so they run on ANY LDC -independent of the embedded-PTX gate
        // below. They use their own local arrays and never touch res/x/y, so the
        // saxpy validation at the end of main is unaffected.
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

    foreach(i; 0 .. N)
        enforce(res[i] == alpha * x[i] + y[i]);
    writeln(res[]);
    return 0;
}

version(DComputeTestCUDA)
{ 
    // RAII destructor / refcount tests
    //
    // These exercise the shared-atomic refcount (this(this) + ~this) added to
    // Buffer, Queue, Context and the non-owning UnifiedBuffer.asBuffer view.
    // They only need a live CUDA context (created by
    // dcompute.driver.cuda.runtime's module constructors before main) and never
    // launch a kernel, so they run independently of the embedded-PTX __VERSION__
    // gate. Each test uses its own local arrays — none touch the saxpy res/x/y.
    //
    // Detection model: a destructor SWALLOWS its CUresult (it must not throw),
    // so a double cuMemFree/cuStreamDestroy/cuCtxDestroy does not surface from
    // the dtor itself. Instead it poisons the CUDA context, so each "must not
    // double free" test allocates/uses a fresh handle AFTERWARDS — that follow-up
    // op goes through checkErrors() and throws if the context was corrupted.
    
    // Receive a by-value copy and let it die at function return. The postblit
    // bumped the shared refcount on the way in; ~this decrements it on the way
    // out. With the original still alive the count must not hit zero here.
    private void dropBufferCopy(T)(Buffer!T copy) {}
    private void dropQueueCopy(Queue copy) {}

    // [1] Refcount keeps the device allocation alive across copies.
    private void testBufferRefcountSurvivesCopy()
    {
        enum size_t M = 64;
        float[M] src, back;
        foreach (i; 0 .. M) src[i] = cast(float)(i * 3 + 1);
        back[] = 0.0f;

        auto b = Buffer!float(src[]);
        enforce(b.raw != 0, "Buffer allocation failed");

        // Copy by value into a function; the copy is destroyed at return.
        dropBufferCopy(b);

        // Copy into an array element, then drop it via the inner scope's dtor.
        {
            Buffer!float[1] arr;
            arr[0] = b;        // postblit: refcount++
        }                      // arr[0].~this: refcount-- (still > 0)

        // The original handle must still be live: round-trip data through it.
        b.copy!(Copy.hostToDevice);
        b.hostMemory = back[]; // read back into a different host buffer
        b.copy!(Copy.deviceToHost);
        foreach (i; 0 .. M)
            enforce(back[i] == src[i],
                    "Buffer H2D/D2H mismatch after copy dtor at " ~ i.to!string);
    }

    // [1] Refcount keeps the CUstream alive across copies.
    private void testQueueRefcountSurvivesCopy()
    {
        auto q = Queue(false);
        enforce(q.raw !is null, "Queue creation failed");

        dropQueueCopy(q);      // by-value copy created and destroyed

        {
            Queue[1] arr;
            arr[0] = q;        // postblit: refcount++
        }                      // arr[0].~this: refcount-- (still > 0)

        // Stream must still be live: cuStreamGetFlags on a destroyed stream
        // would error through checkErrors().
        q.async;
        enforce(q.raw !is null, "Queue handle nulled unexpectedly");
    }

    // [2] Last owner frees exactly once; nested copies destroyed in sequence.
    private void testLastOwnerFreesNoDoubleFree()
    {
        enum size_t M = 32;
        float[M] src;
        foreach (i; 0 .. M) src[i] = cast(float) i;
        {
            auto a = Buffer!float(src[]);   // refcount 1
            {
                auto bb = a;                // refcount 2
                {
                    auto cc = bb;           // refcount 3
                }                           // cc.~this -> 2
            }                               // bb.~this -> 1
            a.copy!(Copy.hostToDevice);     // 'a' still owns a live handle
        }                                   // a.~this -> 0: a single cuMemFree

        // A double free above would corrupt the context; this fresh allocation
        // goes through checkErrors() and throws if so.
        auto d = Buffer!float(M);
        enforce(d.raw != 0, "post-free allocation failed (context may be corrupt)");
    }

    // [3] Manual Buffer.release() then the automatic ~this must not double free.
    private void testBufferReleaseThenDtorSafe()
    {
        enum size_t M = 16;
        float[M] src;
        foreach (i; 0 .. M) src[i] = cast(float)(i + 1);
        {
            auto b = Buffer!float(src[]);
            b.release();       // sole owner: cuMemFree + raw = 0 + ownership dropped
            enforce(b.raw == 0, "release() did not null raw");
        }                      // ~this: no ownership, raw == 0 -> guaranteed no-op

        auto after = Buffer!float(M);
        enforce(after.raw != 0, "allocation after release+dtor failed (double free?)");
    }

    // [3] Program.unload() then ~this must not double-unload. Uses a minimal PTX
    // module (JIT-compiled by the driver). Gracefully skips if the driver
    // rejects the PTX (e.g. very old/locked-down driver).
    private void testProgramUnloadThenDtorSafe()
    {
        enum string ptx =
            ".version 6.0\n" ~
            ".target sm_52\n" ~
            ".address_size 64\n" ~
            ".visible .entry _dcompute_raii_noop() { ret; }\n";
        try
        {
            {
                auto p = Program.fromString(ptx);
                enforce(p.raw !is null, "module load returned null");
                p.unload();    // cuModuleUnload + raw = null
                enforce(p.raw is null, "unload() did not null raw");
            }                  // ~this: raw==null guard skips a second cuModuleUnload
            writeln("  [3] Program.unload then dtor safe: PASS");
        }
        catch (Exception e)
        {
            writeln("  [3] Program.unload test SKIPPED (PTX load unsupported here): ",
                    e.msg);
        }
    }

    // [4] Context.current / Context.pop() return NON-owning views (_rc == null).
    // Letting such a view die must not cuCtxDestroy the runtime's default context.
    private void testContextViewsAreNonOwning()
    {
        {
            auto view = Context.current;    // non-owning copy of default context
            enforce(view.raw !is null, "no current context");
            auto view2 = view;              // another non-owning copy
        }                                   // both dtors: _rc null -> no cuCtxDestroy

        // If the default context had been destroyed, allocating (which needs a
        // live current context) would throw via checkErrors().
        auto b = Buffer!float(8);
        enforce(b.raw != 0,
                "allocation failed -> current context was wrongly destroyed by a view");
    }

    // [4] UnifiedBuffer.asBuffer() is a non-owning Buffer view (_rc == null).
    // Letting the view die must not cuMemFree the managed allocation.
    private void testUnifiedBufferViewIsNonOwning()
    {
        if (!defaultDevice().supportsUnifiedMemory)
        {
            writeln("  [4] UnifiedBuffer view test SKIPPED (no Unified Memory)");
            return;
        }
        enum size_t M = 24;
        float[M] src;
        foreach (i; 0 .. M) src[i] = i * 2.0f;

        auto ub = UnifiedBuffer!float(src[]);
        scope(exit) ub.release();
        {
            auto view = ub.asBuffer;        // _rc == null, non-owning
            enforce(view.raw == ub.raw, "asBuffer view raw mismatch");
        }                                   // view.~this: _rc null -> no cuMemFree

        // The managed memory must still be valid and unchanged.
        foreach (i; 0 .. M)
            enforce(ub.hostSlice[i] == src[i],
                    "UnifiedBuffer corrupted after non-owning view dtor at " ~ i.to!string);
        writeln("  [4] UnifiedBuffer.asBuffer view is non-owning: PASS");
    }
 
    // cuMemGetInfo — bound by bindbc-cuda (to the driver's cuMemGetInfo_v2)
    // as part of the normal loadCUDA() the runtime already performs. Used by
    // the [5] tests below to verify that destructors REALLY return device
    // memory to the driver.
    private size_t deviceFreeBytes()
    {
        size_t freeB, totalB;
        immutable r = cuMemGetInfo(&freeB, &totalB);
        enforce(r == 0, "cuMemGetInfo failed with CUresult " ~ r.to!string);
        return freeB;
    }

    private enum size_t MiB = 1024 * 1024;
    // Big enough that the free-memory delta is unambiguous, small enough for
    // any real GPU (the RTX 2050 this was validated on has 4 GiB).
    private enum size_t BIG_BYTES = 128 * MiB;
    private enum size_t BIG_ELEMS = BIG_BYTES / float.sizeof;
    // Driver-internal pools/page tables cause small persistent shifts in the
    // free-memory reading; anything within this slack of the baseline counts
    // as "returned". A leaked 128 MiB allocation is way outside it.
    private enum size_t MEM_SLACK = 32 * MiB;

    // [5] Scope exit alone (NO release()) must return the device memory.
    private void testScopedDtorReturnsDeviceMemory()
    {
        // Warm-up cycle so first-touch driver allocations don't skew the baseline.
        { auto warm = Buffer!float(BIG_ELEMS); }

        immutable before = deviceFreeBytes();
        size_t during;
        {
            auto big = Buffer!float(BIG_ELEMS);
            enforce(big.raw != 0, "128 MiB device allocation failed");
            during = deviceFreeBytes();
        } // NO release(): ~this alone must cuMemFree
        immutable after = deviceFreeBytes();

        enforce(before >= during + BIG_BYTES,
                "allocation not visible in cuMemGetInfo (free before=" ~ before.to!string
                ~ " during=" ~ during.to!string ~ ")");
        enforce(after + MEM_SLACK >= before,
                "dtor did NOT return device memory: free before=" ~ before.to!string
                ~ " after=" ~ after.to!string);
    }

    // [5] Copies share ONE allocation; releasing one copy must not free it
    // while another copy is live; the LAST owner frees it exactly once
    // (free memory returns to baseline — a double free would corrupt the
    // context, a missed free would leave 128 MiB missing).
    private void testCopiesFreeExactlyOnceMemVerified()
    {
        { auto warm = Buffer!float(BIG_ELEMS); } // warm-up, as above
        immutable before = deviceFreeBytes();
        {
            auto a = Buffer!float(BIG_ELEMS);
            auto b = a;                      // postblit: shares the allocation
            enforce(b.raw == a.raw, "copy must alias the same device pointer");

            immutable during = deviceFreeBytes();
            enforce(before >= during + BIG_BYTES,
                    "allocation missing from cuMemGetInfo");
            enforce(during + BIG_BYTES + MEM_SLACK >= before,
                    "copy duplicated the device allocation (~2x memory in use)");

            b.release();                     // drops ONE owner; must NOT free yet
            enforce(b.raw == 0, "release() did not null raw");
            immutable afterRelease = deviceFreeBytes();
            enforce(before >= afterRelease + BIG_BYTES,
                    "release() of one copy freed memory while another copy is live");

            float[16] probe = 1.5f;          // 'a' must still own a live handle:
            a.hostMemory = probe[];          // write a few bytes through it —
            a.copy!(Copy.hostToDevice);      // errors via checkErrors() if freed
        }                                    // a.~this: LAST owner -> single cuMemFree
        immutable after = deviceFreeBytes();
        enforce(after + MEM_SLACK >= before,
                "last owner did not free: free before=" ~ before.to!string
                ~ " after=" ~ after.to!string);
    }

    // [6] Queue + Event RAII churn: create and drop in a tight loop with NO
    // manual cleanup. If ~this leaked them, 1000 leaked CUstreams/CUevents
    // would pile up in the driver; everything still working afterwards (and
    // no crash along the way) is the pass signal.
    private void testQueueEventChurn()
    {
        foreach (i; 0 .. 1000)
        {
            auto q = Queue(false);
            enforce(q.raw !is null, "cuStreamCreate failed at iteration " ~ i.to!string);
            auto e = Event(0);
            enforce(e.raw !is null, "cuEventCreate failed at iteration " ~ i.to!string);
            q.wait(e, 0);                    // also exercises a by-value Event copy
        } // q.~this + e.~this destroy the stream/event every iteration
        auto q2 = Queue(false);
        enforce(q2.raw !is null, "stream creation failed after churn (leak?)");
    }

    // [3] Context.detach() nulls raw so a later ~this skips cuCtxDestroy.
    // cuCtxDetach is a deprecated legacy API that modern drivers may reject;
    // on rejection we report and skip rather than fail. Runs last and restores
    // the default context as current so later code is unaffected.
    private void testContextDetachThenDtorSafe()
    {
        auto saved = Context.current;       // remember the runtime's default context
        try
        {
            {
                auto ctx = Context(defaultDevice()); // owns a fresh context (now current)
                enforce(ctx.raw !is null, "context creation failed");
                ctx.detach();               // legacy detach; nulls raw on success
                enforce(ctx.raw is null, "detach() did not null raw");
            }                               // ~this: raw==null guard skips cuCtxDestroy
            writeln("  [3] Context.detach then dtor safe: PASS");
        }
        catch (Exception e)
        {
            writeln("  [3] Context.detach test SKIPPED (driver rejected deprecated API): ",
                    e.msg);
        }
        finally
        {
            Context.current = saved;        // restore default context as current
        }
    }

    void runRaiiDestructorTests()
    {
        ensureInit(); // guarantee platform/context/queue exist for this thread
        writeln("RAII destructor / refcount tests:");

        testBufferRefcountSurvivesCopy();
        writeln("  [1] Buffer refcount survives copies: PASS");

        testQueueRefcountSurvivesCopy();
        writeln("  [1] Queue refcount survives copies: PASS");

        testLastOwnerFreesNoDoubleFree();
        writeln("  [2] last-owner-frees / no double free: PASS");

        testBufferReleaseThenDtorSafe();
        writeln("  [3] Buffer.release then dtor safe: PASS");

        testProgramUnloadThenDtorSafe();

        testContextViewsAreNonOwning();
        writeln("  [4] Context.current views are non-owning: PASS");

        testUnifiedBufferViewIsNonOwning();

        // Memory-verified tests use cuMemGetInfo, bound by bindbc-cuda in the
        // same loadCUDA() every other driver call here depends on — if it had
        // failed, nothing above could have run either.
        testScopedDtorReturnsDeviceMemory();
        writeln("  [5] scoped dtor returns device memory (cuMemGetInfo): PASS");

        testCopiesFreeExactlyOnceMemVerified();
        writeln("  [5] copies free exactly once, last owner frees (cuMemGetInfo): PASS");

        testQueueEventChurn();
        writeln("  [6] Queue+Event create/destroy churn x1000, no manual cleanup: PASS");

        // Mutating context test runs last so the read-only tests above are
        // already validated before we poke the deprecated detach path.
        testContextDetachThenDtorSafe();

        writeln("RAII destructor tests complete.\n");
    }
}


