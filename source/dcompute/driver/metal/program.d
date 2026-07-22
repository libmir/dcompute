module dcompute.driver.metal.program;

import dcompute.driver.metal.device;
import dcompute.driver.metal.bindings;

struct Library {
    private void* raw_;

    @property MTLLibrary raw() {
        return cast(MTLLibrary) raw_;
    }

    @property void raw(MTLLibrary lib) {
        raw_ = cast(void*) lib;
    }

    void release() {
        auto lib = raw();
        if (lib !is null) lib.release();
        raw_ = null;
    }

    MTLFunction newFunction(const(char)[] name) {
        auto lib = raw();
        return (lib is null) ? null : lib.newFunctionWithName(nsString(name));
    }
}

struct Pipeline {
    private void* raw_;

    @property MTLComputePipelineState raw() {
        return cast(MTLComputePipelineState) raw_;
    }

    @property void raw(MTLComputePipelineState pso) {
        raw_ = cast(void*) pso;
    }

    void release() {
        auto pso = raw();
        if (pso !is null) pso.release();
        raw_ = null;
    }
}

struct Kernel {
    Pipeline pipeline;

    void release() {
        pipeline.release();
    }
}

struct Program {
    Device device;
    Library library;

    static Program fromDefaultDevice() {
        Program p;
        p.device = defaultDevice();
        return p;
    }

    Library loadLibrary(const(char)[] path) {
        auto dev = device.raw;
        library.raw = (dev is null) ? null : dev.newLibraryWithFile(nsString(path), null);
        return library;
    }

    Pipeline makePipeline(MTLFunction fn) {
        Pipeline pso;
        auto dev = device.raw;
        pso.raw = (dev is null) ? null : dev.newComputePipelineStateWithFunction(fn, null);
        return pso;
    }

    Kernel getKernel(const(char)[] name) {
        Kernel k;
        auto lib = library.raw;
        if (lib is null) return k;
        auto fn = lib.newFunctionWithName(nsString(name));
        if (fn is null) return k;
        k.pipeline = makePipeline(fn);
        fn.release();
        return k;
    }

    void release() {
        library.release();
    }
}
