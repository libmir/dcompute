/**
 * Metal device abstraction.
 *
 * Wraps MTLDevice to provide GPU device discovery and info queries,
 * matching the interface of dcompute.driver.cuda.device.
 */
module dcompute.driver.metal.device;

version (OSX):

/// Represents a Metal-capable GPU device.
/// On Apple Silicon, there is typically one device (the integrated GPU).
/// On Intel Macs with discrete GPUs, there may be multiple.
struct MetalDevice
{
    // Opaque handle to the underlying MTLDevice
    // Will be populated via extern(Objective-C) bindings from metal-d
    private void* _handle;

    /// Returns the device name (e.g. "Apple M1", "AMD Radeon Pro 5500M")
    @property string name()
    {
        // TODO: call [_handle name] via extern(Objective-C)
        return "Metal Device (stub)";
    }

    /// Returns true if this device supports the Metal GPU family needed
    /// for compute shaders
    @property bool supportsCompute()
    {
        // All Metal devices support compute shaders
        return true;
    }

    /// Maximum threads per threadgroup (typically 1024 on Apple Silicon)
    @property size_t maxThreadsPerThreadgroup()
    {
        // TODO: query MTLDevice.maxThreadsPerThreadgroup
        return 1024;
    }

    /// Maximum buffer length in bytes
    @property size_t maxBufferLength()
    {
        // TODO: query MTLDevice.maxBufferLength
        return 256 * 1024 * 1024; // 256 MB default
    }
}

/// Get the system default Metal device.
/// Returns null-state device if no Metal GPU is available.
MetalDevice systemDefaultDevice()
{
    // TODO: wrap MTLCreateSystemDefaultDevice()
    MetalDevice dev;
    return dev;
}
