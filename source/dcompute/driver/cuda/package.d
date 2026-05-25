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

/**
 * Launch kernel `k` on the calling thread's default Queue using the globally
 * loaded Program.  Platform, Device, Context, Queue and Program are all
 * initialised lazily on the first call — the user needs no boilerplate.
 *
 * This function is callable via UFCS, so both of the following are valid:
 *
 *   saxpy.launch([N,1,1], [1,1,1], b_res, alpha, b_x, b_y, N);
 *   launch!saxpy([N,1,1], [1,1,1], b_res, alpha, b_x, b_y, N);
 *
 * Params:
 *   grid      = Grid  dimensions [x, y, z].
 *   block     = Block dimensions [x, y, z].
 *   args      = Kernel arguments (host types, Buffer/UnifiedBuffer ).
 */
auto launch(alias k)(uint[3] grid, uint[3] block,
                     HostArgsOf!(typeof(k)) args)
{
    if (Program.globalProgram.raw is null)
    {
        ensureInit();

        // SM level to PTX filename fragment, resolved inside client compilation
        version      (DComputeCUDA_1200) enum _arch = "cuda1200";
        else version (DComputeCUDA_900)  enum _arch = "cuda900";
        else version (DComputeCUDA_800)  enum _arch = "cuda800";
        else version (DComputeCUDA_750)  enum _arch = "cuda750";
        else version (DComputeCUDA_700)  enum _arch = "cuda700";
        else version (DComputeCUDA_600)  enum _arch = "cuda600";
        else version (DComputeCUDA_500)  enum _arch = "cuda500";
        else version (DComputeCUDA_300)  enum _arch = "cuda300";
        else version (DComputeCUDA_210)  enum _arch = "cuda210";
        else static assert(false,
            "Add a DComputeCUDA_XXX version to your dub config " ~
            "matching your --mdcompute-targets=cuda-XXX dflag. " ~
            "Example: \"versions\": [\"DComputeCUDA_800\"]");

        Program.globalProgram =
            Program.fromEmbedded!(import("kernels_" ~ _arch ~ "_64.ptx"))();
    }
    defaultQueue().enqueue!k(grid, block)(args);
}
