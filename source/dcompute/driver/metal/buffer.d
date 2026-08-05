/**
 * Metal GPU buffer abstraction.
 *
 * Wraps MTLBuffer to provide GPU memory allocation with shared or
 * device-only storage modes. Mirrors dcompute.driver.cuda.buffer.
 */
module dcompute.driver.metal.buffer;

version (OSX):

/// Metal resource storage modes.
/// These map directly to MTLResourceOptions / MTLStorageMode.
enum StorageMode
{
    /// CPU and GPU can both read/write. No explicit sync needed.
    /// Best for small buffers or buffers that change every frame.
    shared_,

    /// GPU-only memory. Faster GPU access but requires explicit
    /// copies to/from CPU-accessible staging buffers.
    private_,

    /// CPU-writable, GPU-readable. The driver manages coherency.
    /// Only available on macOS (not iOS).
    managed,
}

/// A typed GPU buffer backed by MTLBuffer.
struct MetalBuffer(T)
{
    // Opaque handle to MTLBuffer
    private void* _handle;
    private size_t _count;

    /// Number of elements in this buffer
    @property size_t length() const { return _count; }

    /// Size in bytes
    @property size_t sizeBytes() const { return _count * T.sizeof; }

    /// Get a CPU-side slice of the buffer contents.
    /// Only valid for shared or managed storage mode.
    @property T[] contents()
    {
        // TODO: cast MTLBuffer.contents to T* and slice
        return null;
    }

    /// Copy data from a host array into this buffer.
    void upload(const T[] data)
    {
        assert(data.length <= _count, "Source data exceeds buffer size");
        // TODO: memcpy into MTLBuffer.contents
    }

    /// Copy data from this buffer into a host array.
    void download(T[] dest)
    {
        assert(dest.length <= _count, "Destination array too small");
        // TODO: memcpy from MTLBuffer.contents
    }
}
