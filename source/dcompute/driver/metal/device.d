module dcompute.driver.metal.device;
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
}