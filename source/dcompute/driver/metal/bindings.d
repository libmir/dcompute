module dcompute.driver.metal.bindings;

import core.attribute : selector;

alias NSUInteger = ulong;

enum MTLResourceOptions : NSUInteger {
    storageModeShared = 0,
}

struct MTLSize {
    NSUInteger width;
    NSUInteger height;
    NSUInteger depth;
}

extern(Objective-C) interface NSObject {
    void release();
}

extern(Objective-C) interface NSAutoreleasePool : NSObject {
    void drain();
}

extern(Objective-C) interface NSString : NSObject {}

extern(Objective-C) interface MTLBuffer : NSObject {
    void* contents();
}

extern(Objective-C) interface MTLFunction : NSObject {}

extern(Objective-C) interface MTLLibrary : NSObject {
    @selector("newFunctionWithName:")
    MTLFunction newFunctionWithName(NSString name);
}

extern(Objective-C) interface MTLComputePipelineState : NSObject {}

extern(Objective-C) interface MTLComputeCommandEncoder : NSObject {
    @selector("setComputePipelineState:")
    void setComputePipelineState(MTLComputePipelineState state);

    @selector("setBuffer:offset:atIndex:")
    void setBuffer(MTLBuffer buffer, NSUInteger offset, NSUInteger index);

    @selector("dispatchThreads:threadsPerThreadgroup:")
    void dispatchThreads(MTLSize threadsPerGrid, MTLSize threadsPerThreadgroup);

    void endEncoding();
}

extern(Objective-C) interface MTLCommandBuffer : NSObject {
    MTLComputeCommandEncoder computeCommandEncoder();
    void commit();
    void waitUntilCompleted();
}

extern(Objective-C) interface MTLCommandQueue : NSObject {
    MTLCommandBuffer commandBuffer();
}

extern(Objective-C) interface MTLDevice : NSObject {
    MTLCommandQueue newCommandQueue();

    @selector("newLibraryWithFile:error:")
    MTLLibrary newLibraryWithFile(NSString filePath, void* error);

    @selector("newComputePipelineStateWithFunction:error:")
    MTLComputePipelineState newComputePipelineStateWithFunction(MTLFunction function_, void* error);

    @selector("newBufferWithBytes:length:options:")
    MTLBuffer newBufferWithBytes(const(void)* bytes, NSUInteger length, MTLResourceOptions options);

    @selector("newBufferWithLength:options:")
    MTLBuffer newBufferWithLength(NSUInteger length, MTLResourceOptions options);
}

extern(C) {
    alias CFAllocatorRef = const(void)*;
    alias CFStringEncoding = uint;

    pragma(mangle, "MTLCreateSystemDefaultDevice")
    MTLDevice mtlCreateSystemDefaultDevice();

    void* CFStringCreateWithCString(CFAllocatorRef alloc, const(char)* cStr, CFStringEncoding encoding);
}

enum kCFStringEncodingUTF8 = 0x08000100;

MTLSize mtlSize(NSUInteger w, NSUInteger h = 1, NSUInteger d = 1) {
    return MTLSize(w, h, d);
}

NSString nsString(const(char)[] text) {
    auto cfStr = CFStringCreateWithCString(null, (text ~ "\0").ptr, kCFStringEncodingUTF8);
    return cast(NSString) cfStr;
}

