module dcompute.driver.cuda.rc;

import core.stdc.stdlib : malloc, free;
import bindbc.cuda;
static import driver = dcompute.driver.cuda;

/// Generic reference-counted wrapper for CUDA driver objects.
struct RC(T, alias release)
{
    T payload;
    private int* count;
    alias payload this;

    this(T val)
    {
        payload = val;
        count = cast(int*) malloc(int.sizeof);
        if (count is null)
        {
            import core.exception : onOutOfMemoryError;
            onOutOfMemoryError();
        }
        *count = 1;
    }

    this(Args...)(auto ref Args args)
        if (Args.length > 0 && !(Args.length == 1 && (is(Args[0] : T) || is(Args[0] : typeof(this)))) && is(typeof(T(args))))
    {
        import std.functional : forward;
        this(T(forward!args));
    }

    this(this)
    {
        if (count !is null) ++(*count);
    }

    ~this()
    {
        if (count !is null && --(*count) == 0)
        {
            free(count);
            count = null;
            cast(void) release(payload.raw);
        }
    }

    ref RC opAssign(RC rhs)
    {
        import std.algorithm.mutation : swap;
        swap(this.payload, rhs.payload);
        swap(this.count, rhs.count);
        return this;
    }
}

alias Buffer(T) = RC!(driver.Buffer!T, cuMemFree);
alias Context   = RC!(driver.Context, cuCtxDestroy);
alias Event     = RC!(driver.Event, cuEventDestroy);
alias Program   = RC!(driver.Program, cuModuleUnload);
alias Queue     = RC!(driver.Queue, cuStreamDestroy);

version(unittest)
{
    private __gshared int s_relCount = 0, s_lastRaw = 0;
    private void fakeRel(int raw) nothrow @nogc { s_relCount++; s_lastRaw = raw; }
    private struct Dummy { int raw; }
    private alias DummyRC = RC!(Dummy, fakeRel);

    unittest
    {
        // 1. Scope exit releases once
        {
            auto r1 = DummyRC(Dummy(42));
            assert(r1.raw == 42 && s_relCount == 0);
        }
        assert(s_relCount == 1 && s_lastRaw == 42);

        // 2. Refcount survives copies, last owner frees
        s_relCount = 0;
        {
            auto r1 = DummyRC(Dummy(100));
            {
                auto r2 = r1;
                { auto r3 = r2; }
                assert(s_relCount == 0);
            }
            assert(s_relCount == 0 && r1.raw == 100);
        }
        assert(s_relCount == 1 && s_lastRaw == 100);

        // 3. Assign releases old, self-assign safe
        s_relCount = 0;
        {
            auto r1 = DummyRC(Dummy(10)), r2 = DummyRC(Dummy(20));
            r2 = r1; // releases 20
            assert(s_relCount == 1 && s_lastRaw == 20 && r2.raw == 10);
            r2 = r2; // self-assign safe
            assert(s_relCount == 1 && r2.raw == 10);
        }
        assert(s_relCount == 2 && s_lastRaw == 10);
    }
}
