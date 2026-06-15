module dcompute.driver.metal.device;
import dcompute.driver.metal.buffer;
import core.stdc.string;
import metal;

struct Device
{
    /**
        A pointer to $(D MTLDevice). It is $(D void*) because upon storing array of $(D Device), 
        linker look for the $(D MTLDevice) but fails to 
        find it as it is Objective-C binding hence had to wrap it as such
    */
    void* raw;

    @property MTLDevice mtlDevice()
    {
        return cast(MTLDevice) raw;
    }


    this(MTLDevice device)
    {
        raw = cast(void*)device;
    }

    MTLBuffer newBuffer(size_t sizeInBytes)
    {
        return mtlDevice.newBuffer(sizeInBytes, MTLResourceOptions.StorageModeShared);
    }

    Buffer!T makeBuffer(T)(T[] hostMemory)
    {
        size_t sizeInBytes = hostMemory.length * T.sizeof;

        auto mtlBuffer = newBuffer(sizeInBytes);
        auto buffer = Buffer!T(mtlBuffer, hostMemory);

        if (buffer.hostMemory.ptr !is null && sizeInBytes > 0)
        {
            memcpy(buffer.mtlBuffer.contents(), buffer.hostMemory.ptr, sizeInBytes);
        }

        return buffer;
    }
}
