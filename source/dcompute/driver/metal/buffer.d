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

    this(MTLBuffer _mtlBuffer, T[] array)
    {
        mtlBuffer = _mtlBuffer;
        hostMemory = array;
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
