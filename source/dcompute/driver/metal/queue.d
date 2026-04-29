module dcompute.driver.metal.queue;

import dcompute.driver.metal.device;
import dcompute.driver.metal.encoder;
import dcompute.driver.metal.program;
import dcompute.driver.metal.bindings;
import dcompute.driver.metal.buffer;
import std.meta : allSatisfy;

private enum isBuffer(T) = is(T == Buffer!U, U);

struct CommandBuffer {
    private void* raw_;

    @property MTLCommandBuffer raw() {
        return cast(MTLCommandBuffer) raw_;
    }

    @property void raw(MTLCommandBuffer buf) {
        raw_ = cast(void*) buf;
    }

    void commit() {
        auto buf = raw();
        if (buf !is null) buf.commit();
    }

    void waitUntilCompleted() {
        auto buf = raw();
        if (buf !is null) buf.waitUntilCompleted();
    }

    Encoder computeEncoder() {
        Encoder enc;
        auto buf = raw();
        enc.raw = (buf is null) ? null : buf.computeCommandEncoder();
        return enc;
    }

    void release() {
        auto buf = raw();
        if (buf !is null) buf.release();
        raw_ = null;
    }
}

struct Queue {
    private void* raw_;

    this(Device dev) {
        auto q = dev.raw.newCommandQueue();
        raw_ = cast(void*) q;
    }

    @property MTLCommandQueue raw() {
        return cast(MTLCommandQueue) raw_;
    }

    @property void raw(MTLCommandQueue q) {
        raw_ = cast(void*) q;
    }

    CommandBuffer commandBuffer() {
        CommandBuffer cb;
        auto q = raw();
        cb.raw = (q is null) ? null : q.commandBuffer();
        return cb;
    }

    void release() {
        auto q = raw();
        if (q !is null) q.release();
        raw_ = null;
    }

    void enqueue(Buffers...)(Pipeline pipeline, MTLSize grid, MTLSize group, Buffers buffers)
        if (allSatisfy!(isBuffer, Buffers)) {
        auto cmdBuffer = commandBuffer();
        if (cmdBuffer.raw is null) return;
        auto encoder = cmdBuffer.computeEncoder();
        if (encoder.raw is null) {
            cmdBuffer.release();
            return;
        }
        scope(exit) cmdBuffer.release();
        scope(exit) encoder.release();

        encoder.setPipeline(pipeline);
        foreach (i, ref buf; buffers) {
            encoder.setBuffer(buf, 0, cast(NSUInteger) i);
        }
        encoder.dispatchThreads(grid, group);
        encoder.endEncoding();
        cmdBuffer.commit();
        cmdBuffer.waitUntilCompleted();
    }


    auto enqueue(Kernel kernel, MTLSize grid, MTLSize group) {
        static struct Launch {
            Queue q;
            Kernel k;
            MTLSize grid;
            MTLSize group;

            this(Queue q, Kernel k, MTLSize grid, MTLSize group) {
                this.q = q;
                this.k = k;
                this.grid = grid;
                this.group = group;
            }

            void opCall(Buffers...)(Buffers buffers)
                if (allSatisfy!(isBuffer, Buffers)) {
                q.enqueue(k.pipeline, grid, group, buffers);
            }
        }

        return Launch(this, kernel, grid, group);
    }
}
