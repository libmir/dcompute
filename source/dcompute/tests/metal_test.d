module dcompute.tests.metal_test;

import std.math : fabs;
import std.stdio : writeln;
import dcompute.driver.metal;

private int fail(const(char)[] msg) {
    writeln(msg);
    return 1;
}

int main() {
    enum n = 1024;
    float[n] hostA;
    float[n] hostB;
    foreach (i; 0 .. n) {
        hostA[i] = cast(float) i;
        hostB[i] = cast(float) (i * 2);
    }

    Platform.initialise();
    auto devices = Platform.getDevices();
    auto dev = devices[0];
    auto device = dev.raw;
    if (device is null) return fail("FAIL: MTLCreateSystemDefaultDevice returned null.");
    scope(exit) dev.release();

    auto queue = Queue(dev);
    if (queue.raw is null) return fail("FAIL: newCommandQueue returned null.");
    scope(exit) queue.release();

    auto program = Program.fromDefaultDevice();
    auto library = program.loadLibrary("add.metallib");
    if (library.raw is null) return fail("FAIL: cannot load add.metallib");
    scope(exit) program.release();

    auto kernel = program.getKernel("vec_add");
    if (kernel.pipeline.raw is null) return fail("FAIL: newComputePipelineStateWithFunction failed.");
    scope(exit) kernel.release();

    Buffer!float aBuffer = Buffer!float(hostA[]);
    Buffer!float bBuffer = Buffer!float(hostB[]);
    Buffer!float outBuffer = Buffer!float(n);
    if (aBuffer.raw is null || bBuffer.raw is null || outBuffer.raw is null) {
        return fail("FAIL: buffer allocation failed.");
    }
    scope(exit) aBuffer.release();
    scope(exit) bBuffer.release();
    scope(exit) outBuffer.release();

    queue.enqueue(kernel, mtlSize(n, 1, 1), mtlSize(64, 1, 1))
        (aBuffer, bBuffer, outBuffer);

    auto outPtr = cast(float*) outBuffer.contents();
    if (outPtr is null) return fail("FAIL: output buffer has null contents.");

    bool ok = true;
    foreach (i; 0 .. n) {
        auto expected = hostA[i] + hostB[i];
        if (fabs(outPtr[i] - expected) > 1e-6f) {
            ok = false;
            writeln("Mismatch at ", i, ": got=", outPtr[i], " expected=", expected);
            break;
        }
    }

    writeln("Sample output: out[0]=", outPtr[0], ", out[1]=", outPtr[1], ", out[2]=", outPtr[2]);
    writeln(ok ? "PASS: Metal vector add succeeded." : "FAIL: Metal vector add validation failed.");
    return ok ? 0 : 2;
}
