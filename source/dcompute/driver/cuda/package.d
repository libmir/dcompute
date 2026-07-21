module dcompute.driver.cuda;

public import ldc.dcompute;
public import bindbc.cuda;

public import dcompute.driver.error;

public import dcompute.driver.cuda.buffer;
public import dcompute.driver.cuda.context;
public import dcompute.driver.cuda.device;
public import dcompute.driver.cuda.event;
public import dcompute.driver.cuda.kernel;
public import dcompute.driver.cuda.memory;
public import dcompute.driver.cuda.platform;
public import dcompute.driver.cuda.program;
public import dcompute.driver.cuda.queue;
public import dcompute.driver.cuda.unified_buffer;
public import dcompute.driver.cuda.runtime;

// ---------------------------------------------------------------------------
// Shared atomic refcount helpers for the RAII driver wrappers (Buffer, Queue,
// Context, Program, Event).
//
// The counter is allocated with C malloc, NOT the GC: struct destructors also
// run as GC finalizers, and during a GC sweep other GC blocks (which a
// GC-allocated counter would be) may already have been freed — touching them
// from a finalizer is undefined behaviour. malloc'd memory stays valid until
// we free() it ourselves, which happens exactly once, when the count hits 0.
// ---------------------------------------------------------------------------

/// Allocate a new refcount initialised to 1 (a single owner).
/// Returns null on out-of-memory; callers treat null as "non-owning", so the
/// handle is then never auto-destroyed (a leak, never a crash/double-free).
package shared(int)* rcCreate() nothrow @nogc
{
    import core.stdc.stdlib : malloc;
    auto rc = cast(shared(int)*) malloc(int.sizeof);
    if (rc !is null)
    {
        import core.atomic : atomicStore;
        atomicStore(*rc, 1);
    }
    return rc;
}

/// Postblit helper: one more owner shares the handle. Safe on null.
package void rcRetain(shared(int)* rc) nothrow @nogc
{
    import core.atomic : atomicOp;
    if (rc !is null)
        atomicOp!"+="(*rc, 1);
}

/// Destructor/release helper: drop one owner. Returns true iff this was the
/// LAST owner — the caller must then destroy the CUDA handle. Frees the
/// counter and nulls the caller's pointer either way, so any subsequent
/// ~this()/release() on the same struct is a guaranteed no-op.
package bool rcRelease(ref shared(int)* rc) nothrow @nogc
{
    import core.atomic : atomicOp;
    if (rc is null)
        return false;
    immutable last = atomicOp!"-="(*rc, 1) == 0;
    if (last)
    {
        import core.stdc.stdlib : free;
        free(cast(void*) rc);
    }
    rc = null;
    return last;
}

enum Copy
{
    hostToDevice,
    deviceToHost,
    array,
}

enum MemoryBankConfig : int
{
    default_,
    fourBytes,
    eightBytes,
}
template HostArgsOf(F) {
    import std.meta, std.traits;
    alias HostArgsOf = staticMap!(ReplaceTemplate!(Pointer, Buffer), Parameters!F);
}
private template ReplaceTemplate(alias needle, alias replacement) {
    template ReplaceTemplate(T) {
        static if (is(T : needle!Args, Args...)) {
            alias ReplaceTemplate = replacement!(Args[1]);
        } else {
            alias ReplaceTemplate = T;
        }
    }
}

