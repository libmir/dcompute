module dcompute.driver.metal.buffer;

import dcompute.driver.metal.device;
import dcompute.driver.metal.bindings;

// No need for host<->device copy calls, since Metal buffers can be shared between CPU and GPU.
// Just create the buffer with storageModeShared and use contents() to get a pointer to the data for both host and device access.
struct Buffer(T) {

    // Store as void* to avoid emitting RTTI/classinfo for extern(Objective-C) interfaces.
    private void* raw_;

    this(size_t elems) {
        auto dev = defaultDevice().raw;
        auto byteCount = cast(NSUInteger)(elems * T.sizeof);
        raw = dev.newBufferWithLength(byteCount, MTLResourceOptions.storageModeShared);
    }

    this(const(T)[] arr) {
        auto dev = defaultDevice().raw;
        auto byteCount = cast(NSUInteger)(arr.length * T.sizeof);
        raw = dev.newBufferWithBytes(arr.ptr, byteCount, MTLResourceOptions.storageModeShared);
    }

    @property MTLBuffer raw() {
        return cast(MTLBuffer) raw_;
    }

    @property void raw(MTLBuffer buf) {
        raw_ = cast(void*) buf;
    }

    void* contents() {
        auto buf = raw();
        return (buf is null) ? null : buf.contents();
    }

    void release() {
        auto buf = raw();
        if (buf !is null) buf.release();
        raw_ = null;
    }
}
