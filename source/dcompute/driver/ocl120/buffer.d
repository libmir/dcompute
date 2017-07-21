module dcompute.driver.ocl120.buffer;

import dcompute.driver.ocl120;

struct Buffer(T)
{
    cl_mem raw;

    enum CreateType
    {
        region =0x1220,
    }
    // opSlice clCreateSubBuffer
}
