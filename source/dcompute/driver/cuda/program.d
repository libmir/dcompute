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
     * Load a program from a compile-time embedded PTX file.
     *
     * The PTX file is read and embedded at compile time via the D compiler's
     * string import mechanism (-J / stringImportPaths in dub.json).  No file
     * I/O occurs at runtime.
     *
     * Example:
     *   Program p = Program.fromEmbedded!"kernel.ptx"();
     */
    static Program fromEmbedded(string filename)()
    {
        Program ret;
        enum ptx = import(filename);
        status = cast(Status)cuModuleLoadData(&ret.raw, ptx.ptr);
        checkErrors();
        return ret;
    }

    /**
     * Load a program from a compile-time embedded PTX file for the active architecture.
     */
    static Program fromEmbedded()()
    {
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

        return fromEmbedded!("kernels_" ~ _arch ~ "_64.ptx")();
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



