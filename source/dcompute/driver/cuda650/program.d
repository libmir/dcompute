module dcompute.driver.cuda650.program;

struct Program
{
    void* raw;
    
    Kernel!void getKernelByName(immutable(char)* name)
    {
        Kernel ret;
        status = cast(Sataus)cuModuleGetFunction(ret.raw,this.raw,name);
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
        status = cast(Sataus)cuModuleLoad(&ret.raw,name.toStringz);
        checkErrors();
        return ret;
    }

    static Program fromString(string name)
    {
        Program ret;
        status = cast(Sataus)cuModuleLoadData(&ret.raw,name.toStringz);
        checkErrors();
        return ret;
    }
    
    //cuModuleLoadDataEx
    //cuModuleLoadFatBinary
    
    void unload()
    {
        status = cast(Sataus)cuModuleUnload(raw);
        checkErrors();
    }
    static Program globalProgram;
    //TODO: linkstate
}



