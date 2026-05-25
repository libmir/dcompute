/**
 * dcompute.driver.cuda.runtime
 *
 *  initialisation of the CUDA runtime:
 *
 *   shared static this()  — runs once at program startup (before main()), on
 *                           the main thread.  Initialises Platform, Device,
 *                           Context and the embedded Program.
 *
 *   static this()         — runs once per thread (including the main thread)
 *                           when that thread starts.  Creates the thread-local
 *                           Queue and pushes the shared Context onto the
 *                           thread's CUDA context stack.
 *
 *
 * ensureInit() is kept as a defensive fallback.  It is a no-op once the
 * module constructors have run, so calling it is always safe and costs only
 * a single bool check on the fast path.
 */
module dcompute.driver.cuda.runtime;

import dcompute.driver.cuda;
import std.experimental.allocator.mallocator : Mallocator;

// Global state (shared across every thread)
// __gshared: lives in a single memory location, accessible from all threads.
private __gshared Device  _defaultDevice;
private __gshared Context _defaultContext;
private __gshared bool    _platformReady = false; // safety-net flag

// Thread-local state
// plain `static`: D gives each thread its own copy automatically.
private static Queue _threadQueue;
private static bool  _threadReady = false; // safety-net flag

// Primary init: shared static constructor
// D runtime calls this exactly once, before main(), on the main thread,
// in module-dependency order.  No locking needed here.
shared static this()
{
    _initPlatform();
}

// Per-thread init: thread-local static constructor
// D runtime calls this automatically for every thread (including main) when
// that thread begins.  For the main thread it runs after shared static this().
static this()
{
    _initThread();
}

// Public API

/**
 * Defensive fallback: ensures the runtime is fully initialised for the
 * calling thread.
 *
 * Under normal operation this is a no-op (both flags are already true before
 * main() starts).  It guards against unusual call sites — e.g. Buffer
 * constructed at global scope, or code reached before module constructors
 * have finished in a pathological import order.
 *
 * Cost on the fast path: two bool reads, no locking.
 */
void ensureInit()
{
    if (!_platformReady) _initPlatform(); // global guard (synchronized inside)
    if (!_threadReady)   _initThread();   // per-thread guard (no lock, TLS)
}

/**
 * Returns the default Device (same object from every thread).
 */
Device defaultDevice()
{
    return _defaultDevice;
}

/**
 * Returns the default Queue for the *calling* thread.
 * Each thread gets its own independent Queue — no contention, no locking.
 */
Queue defaultQueue()
{
    return _threadQueue;
}

// Private implementation

private void _initPlatform()
{
    // Double-checked locking: fast no-lock path after first init.
    if (_platformReady) return;

    synchronized
    {
        if (_platformReady) return;

        Platform.initialise();
        // Device 0 is the default.  Users needing a specific device can call
        // Platform.getDevices() and manage their own Context + Queue.
        
        // TODO : Make multi-device usage better and easy.
        _defaultDevice = Platform.getDevices(Mallocator.instance)[0];

        // cuCtxCreate creates the context AND pushes it onto the calling
        // thread's CUDA context stack.
        _defaultContext = Context(_defaultDevice);

        // Compile-time PTX embedding
        // LDC compiles @compute modules to PTX first, then compiles host code,
        // so import() resolves in a single build pass with no file I/O at
        // runtime.
        // The version ladder is pure data — one line per SM level.  Adding a
        // new target only requires one new `else version` line here plus the
        // matching "DComputeCUDA_XXX" entry in dub.json.

        _platformReady = true;
    }
}

private void _initThread()
{
    if (_threadReady) return;

    // The thread that ran _initPlatform() already has _defaultContext on its
    // CUDA context stack (cuCtxCreate pushes automatically).
    // Every other thread must push it explicitly before creating a stream.
    if (Context.current.raw != _defaultContext.raw)
        Context.push(_defaultContext);

    _threadQueue = Queue(false); // non-async stream, bound to this thread
    _threadReady = true;
}
