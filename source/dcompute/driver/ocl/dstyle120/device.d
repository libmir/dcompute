module dcompute.driver.ocl.dstyle120.device;

import derelict.opencl.cl;
import dcompute.driver.ocl.raw120;
import dcompute.driver.ocl.dstyle120.errors;

struct Device
{
    cl_device_id raw;
    /*getInfo*/
    //Is this a double call function? Also what to do about properties
    //its zero terminated an can contain numbers
    //see http://www.khronos.org/registry/cl/sdk/1.2/docs/man/xhtml/clCreateSubDevices.html under the examples
    /*Device[] createSubDevices(cl.device_partition_property[] properites
                                cl.uint_ numSubDevices)
    {
        
    }
    */
    cl_device_partition_property[Args.length + 1] partitionProperyList(Args...)(Args args)
    {
        typeof(return) ret;
        foreach(i, arg; args)
        ret[i] = *cast(cl.device_partition_property*)(&arg);
        return ret;
    }
    void retain()
    {
        clRetainDevice(raw);
    }
    
    void release()
    {
        clReleaseDevice(raw);
    }
    
}
