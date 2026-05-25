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



