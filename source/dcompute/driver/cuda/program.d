module dcompute.driver.cuda.program;

import dcompute.driver.cuda;

import std.string;
struct Program
{
    CUmodule raw;
    
    Kernel!void getKernelByName(immutable(char)* name)
    {
        Kernel!void ret;
        status = cast(Status)cuModuleGetFunction(&ret.raw,this.raw,name);
        checkErrors();
        return ret;
    }
    Kernel!(typeof(k)) getKernel(alias k)()
    {
        return cast(typeof(return)) getKernelByName(k.mangleof.ptr);
    }
    // TODO: Support globals & images. Requires competent compiler. 
    //cuModuleGetGlobal
    //cuModuleGetTexRef
    //cuModuleGetSurfRef
    
    static Program fromFile(string name)
    {
        Program ret;
        status = cast(Status)cuModuleLoad(&ret.raw,name.toStringz);
        checkErrors();
        return ret;
    }

    static Program fromString(string name)
    {
        Program ret;
        status = cast(Status)cuModuleLoadData(&ret.raw,name.toStringz);
        checkErrors();
        return ret;
    }

    /**
     * Load a program from a PTX global variable injected into the binary by LDC.
     *
     * Relies on LDC embedding the device PTX into the binary as
     * `__dcompute_ptx_<arch>_<module>` globals. That support exists only when the
     * D frontend `__VERSION__` is >= 2113 (LDC >= 1.43). NOTE: released LDC 1.42.0
     * *and* pre-1.43 master both report `__VERSION__` == 2112, so 2113 is the
     * lowest frontend version guaranteed to carry the PTX-embedding fix. On any
     * older compiler the `else` overload below fails with a clear message on use.
     */
    static if (__VERSION__ >= 2113)
    static Program fromModule(string moduleName)()
    {
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

        import std.array : replace;
        
        enum mangledName = moduleName.replace(".", "_");
        enum symbolName = "__dcompute_ptx_" ~ _arch ~ "_" ~ mangledName;

        mixin("pragma(mangle, \"" ~ symbolName ~ "\") extern(C) extern __gshared const char " ~ symbolName ~ ";");

        Program ret;
        mixin("status = cast(Status)cuModuleLoadData(&ret.raw, &" ~ symbolName ~ ");");
        checkErrors();
        return ret;
    }
    else
    static Program fromModule(string moduleName)()
    {
        static assert(false,
            "Program.fromModule (used directly or via launch!) requires an LDC that " ~
            "embeds device PTX into the binary as `__dcompute_ptx_*` globals: D " ~
            "frontend __VERSION__ >= 2113 (LDC >= 1.43). This compiler is too old — " ~
            "both released 1.42.0 and pre-1.43 master report __VERSION__ 2112. " ~
            "Upgrade LDC to >= 1.43, or generate the .ptx file and load it via " ~
            "Program.fromFile / Program.fromString.");
    }

    __gshared static Program globalProgram;
    //cuModuleLoadDataEx
    //cuModuleLoadFatBinary
    
    void unload()
    {
        status = cast(Status)cuModuleUnload(raw);
        checkErrors();
    }
    
    //TODO: linkstate
}



