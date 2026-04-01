module dcompute.driver.metal.encoder;

import dcompute.driver.metal.buffer;
import dcompute.driver.metal.program;
import dcompute.driver.metal.bindings;

struct Encoder {
    private void* raw_;

    @property MTLComputeCommandEncoder raw() {
        return cast(MTLComputeCommandEncoder) raw_;
    }

    @property void raw(MTLComputeCommandEncoder enc) {
        raw_ = cast(void*) enc;
    }

    void setPipeline(Pipeline pipeline) {
        auto enc = raw();
        if (enc !is null) enc.setComputePipelineState(pipeline.raw);
    }

    void setBuffer(T)(Buffer!T buffer, NSUInteger offset, NSUInteger index) {
        auto enc = raw();
        if (enc !is null) enc.setBuffer(buffer.raw, offset, index);
    }

    void dispatchThreads(MTLSize threadsPerGrid, MTLSize threadsPerThreadgroup) {
        auto enc = raw();
        if (enc !is null) enc.dispatchThreads(threadsPerGrid, threadsPerThreadgroup);
    }

    void endEncoding() {
        auto enc = raw();
        if (enc !is null) enc.endEncoding();
    }

    void release() {
        auto enc = raw();
        if (enc !is null) enc.release();
        raw_ = null;
    }
}
