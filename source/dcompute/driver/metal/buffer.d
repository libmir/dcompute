module dcompute.driver.metal.buffer;
import metal;
import dcompute.driver.metal.program;
import dcompute.driver.metal;
import core.stdc.string;

struct Buffer(T)
{
    MTLBuffer mtlBuffer;

    // Host memory associated with this buffer
    T[] hostMemory;

    this(T[] array)
    {
        auto device = Program.globalProgram.device;

        size_t sizeInBytes = array.length * T.sizeof;

        mtlBuffer = device.newBuffer(sizeInBytes);

        hostMemory = array;

        if (array.ptr !is null && sizeInBytes > 0)
        {
            memcpy(mtlBuffer.contents(), array.ptr, sizeInBytes);
        }
    }

    T* contents()
    {
        return cast(T*) mtlBuffer.contents();
    }

    void release()
    {
        mtlBuffer = null;
        hostMemory = null;
    }
}