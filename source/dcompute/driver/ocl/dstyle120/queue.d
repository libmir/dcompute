module dcompute.driver.ocl.dstyle120.queue;

import dcompute.driver.ocl.raw120;
import dcompute.driver.ocl.dstyle120.errors;
import dcompute.driver.ocl.dstyle120.util;
import dcompute.driver.ocl.dstyle120.context;
import dcompute.driver.ocl.dstyle120.device;
import dcompute.driver.ocl.dstyle120.event;
import dcompute.driver.ocl.dstyle120.kernel;


import std.typecons;

struct Queue
{
    cl_command_queue raw;
    
    static Queue create(Context c, Device dev,command_queue_properties props)
    {
        cl_int status;
        scope(exit) status.clEnforce();
        return Queue(clCreateCommandQueue(c.raw,dev.raw,cast(ulong)props,&status));
    }
    
    
    void write(T)(cl.mem buffer, T[] data,
            Flag!"Blocking" blocking = Yes.Blocking, size_t offset = 0, const cl.event[] waitList = null,
            cl.event* event = null)
    {
        clEnqueueWriteBuffer(queue, buffer, blocking, offset, data.memSize, data.ptr,
        cast(uint)waitList.length, waitList.ptr, event)
        .clEnforce();
    }
    
    void read(T)(cl.mem buffer, T[] data,
            Flag!"Blocking" blocking = Yes.Blocking, size_t offset = 0, const cl.event[] waitList = null,
            cl.event* event = null)
    {
        clEnqueueReadBuffer(queue, buffer, blocking, offset, data.memSize, data.ptr,
        cast(uint)waitList.length, waitList.ptr, event)
        .clEnforce();
    }
    
    Event enqueueKernel(Kernel kernel,const size_t[] globalWorkSize,
                        const size_t[] globalWorkOffset = null, const size_t[] localWorkSize = null,
                        const cl_event[] waitList = null)
    in
    {
        if(globalWorkOffset)
            assert(globalWorkSize.length == globalWorkOffset.length);
        if(localWorkSize)
            assert(globalWorkSize.length == localWorkSize.length);
    }
    body
    {
        cl_event ev;
        clEnqueueNDRangeKernel(raw, kernel.raw, cast(uint)globalWorkSize.length,
                globalWorkOffset.ptr, globalWorkSize.ptr, localWorkSize.ptr,
                cast(uint)waitList.length, waitList.ptr, &ev)
                .clEnforce();
        return Event(ev);
    }
    
    //TODO: fill, copy, marker, barrier

    
}
