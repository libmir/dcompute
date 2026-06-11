module dcompute.driver.metal.platform;

import dcompute.driver.metal.device;
import metal.device;

struct Platform
{
    static void initialize()
    {

    }

    // static Device[] getDevices()
    // {
    //     auto hardwareDevice = MTLCreateSystemDefaultDevice();
        
    //     if (hardwareDevice is null) {
    //         return [];
    //     }
        
    //     return [ Device(hardwareDevice) ];
    // }

    static Device getDefaultDevice()
    {
        auto device = Device(MTLCreateSystemDefaultDevice());
        return device;
    }
}