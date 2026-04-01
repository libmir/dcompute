module dcompute.driver.metal.device;

import dcompute.driver.metal.bindings;

struct Device {
    private void* raw_;

    @property MTLDevice raw() {
        return cast(MTLDevice) raw_;
    }

    @property void raw(MTLDevice device) {
        raw_ = cast(void*) device;
    }

    void release() {
        auto dev = raw();
        if (dev !is null) dev.release();
    }
}

__gshared void* g_defaultDevice;

Device defaultDevice() {
    Device dev;
    if (g_defaultDevice is null) {
        g_defaultDevice = cast(void*) mtlCreateSystemDefaultDevice();
    }
    dev.raw = cast(MTLDevice) g_defaultDevice;
    return dev;
}

void setDefaultDevice(MTLDevice device) {
    g_defaultDevice = cast(void*) device;
}
