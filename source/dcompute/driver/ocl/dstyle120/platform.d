module dcompute.driver.ocl.dstyle120.platform;

import dcompute.driver.ocl.dstyle120.errors;
import dcompute.driver.ocl.dstyle120.device;
import dcompute.driver.ocl.raw120;

struct Platform
{
    cl_platform_id raw;
    static Platform[] getPlatforms()
    {
        cl_uint numPlatforms;
        clGetPlatformIDs(0,null,&numPlatforms).clEnforce();
        cl_platform_id[] ret = new cl_platform_id[numPlatforms];
        clGetPlatformIDs(numPlatforms,cast(cl_platform_id*)ret.ptr,null).clEnforce();
        return cast(Platform[])ret;
    }
    /*getInfo*/
    Device[] getDevices(device_type device_type = DEVICE_TYPE_ALL)
    {
        cl_uint numDevices;
        clGetDeviceIDs(
            raw,
            cast(cl_device_type)device_type,
            0,
            null,
            &numDevices).clEnforce();
        
        auto deviceIDs = new cl_device_id[numDevices];
        
        clGetDeviceIDs(
            raw,
            cast(cl_device_type)device_type,
            numDevices,
            deviceIDs.ptr,
            null).clEnforce();
        
        return cast(Device[])deviceIDs;
    }
}