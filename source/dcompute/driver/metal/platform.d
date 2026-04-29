module dcompute.driver.metal.platform;

import dcompute.driver.metal.device;

struct Platform {
    static void initialise() {
        // Metal has no explicit global init step in this backend.
    }

    static Device[] getDevices() {
        // Current implementation exposes only the default device.
        // TODO: Enumerate all Metal devices (for multi-GPU systems).
        return [defaultDevice()];
    }
}
