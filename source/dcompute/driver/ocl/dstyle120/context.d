module dcompute.driver.ocl.dstyle120.context;

import dcompute.driver.ocl.dstyle120.errors;
import dcompute.driver.ocl.dstyle120.device;
import dcompute.driver.ocl.raw120;

struct Context
{
    cl_context raw;
    cl.context_properties[Args.length + 1] contextPropertyList(Args...)(Args args)
    {
        cl.context_properties[Args.length + 1] props;
        foreach(i, arg; args)
        props[i] = *cast(cl.context_properties*)(&arg);
        return props;
    }
    this(Device[] devs)
    {
        
    }
    
    void retain()
    {
        clRetainContext(raw);
    }
    
    void release()
    {
        clReleaseContext(raw);
    }
}
