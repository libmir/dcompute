module dcompute.driver.metal.platform;

import dcompute.driver.metal.device;
import metal.device;

struct Platform
{
    static Device[] getDevices()
    {
        auto mtlDevices = MTLCopyAllDevices();
        auto devices = new Device[mtlDevices.length];

        for(int i=0;i < mtlDevices.length;i ++)
        {
            devices[i] = Device(mtlDevices[i]);
        }

        return devices;
    }
    
    static Device getDefaultDevice()
    {
        auto device = Device(MTLCreateSystemDefaultDevice());
        return device;
    }
}
