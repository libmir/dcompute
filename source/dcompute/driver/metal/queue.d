/**
 * Metal command queue and kernel dispatch.
 *
 * Wraps MTLCommandQueue / MTLCommandBuffer / MTLComputeCommandEncoder
 * to provide kernel dispatch, matching dcompute.driver.cuda.queue.
 */
module dcompute.driver.metal.queue;

version (OSX):

import dcompute.driver.metal.buffer;
import dcompute.driver.metal.program;

/// Grid dimensions for kernel dispatch (threadgroups × threads-per-threadgroup).
/// Equivalent to CUDA's grid/block dimensions.
struct MTLSize
{
    size_t width  = 1;
    size_t height = 1;
    size_t depth  = 1;
}

/// A Metal command queue for submitting compute work to the GPU.
struct MetalQueue
{
    // Opaque handles
    private void* _device;       // MTLDevice*
    private void* _commandQueue; // MTLCommandQueue*

    /// Dispatch a compute kernel.
    ///
    /// Params:
    ///   program  = compiled Metal program containing the kernel
    ///   kernel   = name of the kernel function
    ///   grid     = number of threadgroups
    ///   tgSize   = threads per threadgroup
    void dispatch(ref MetalProgram program, string kernel,
                  MTLSize grid, MTLSize tgSize)
    {
        // TODO: Implementation outline:
        // 1. auto fn = program.getFunction(kernel);
        // 2. auto pso = _device.newComputePipelineStateWithFunction(fn);
        // 3. auto cmdBuf = _commandQueue.commandBuffer();
        // 4. auto encoder = cmdBuf.computeCommandEncoder();
        // 5. encoder.setComputePipelineState(pso);
        // 6. encoder.dispatchThreadgroups(grid, tgSize);
        // 7. encoder.endEncoding();
        // 8. cmdBuf.commit();
    }

    /// Dispatch and wait for completion (synchronous).
    void dispatchSync(ref MetalProgram program, string kernel,
                      MTLSize grid, MTLSize tgSize)
    {
        dispatch(program, kernel, grid, tgSize);
        // TODO: cmdBuf.waitUntilCompleted();
    }

    /// Allocate a shared-memory buffer accessible by both CPU and GPU.
    MetalBuffer!T allocate(T)(size_t count)
    {
        // TODO: _device.newBufferWithLength(count * T.sizeof, shared)
        MetalBuffer!T buf;
        buf._count = count;
        return buf;
    }
}

/// Create a command queue on the default Metal device.
MetalQueue createQueue()
{
    // TODO: MTLCreateSystemDefaultDevice() -> newCommandQueue()
    MetalQueue q;
    return q;
}
