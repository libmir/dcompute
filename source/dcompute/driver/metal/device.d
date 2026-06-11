module dcompute.driver.metal.device;
import metal;

struct Device
{
    MTLDevice raw;
    
    this(MTLDevice device)
    {
        raw = device;
    }

    MTLBuffer newBuffer(size_t sizeInBytes)
    {
        return raw.newBuffer(sizeInBytes, MTLResourceOptions.StorageModeShared);
    }
}