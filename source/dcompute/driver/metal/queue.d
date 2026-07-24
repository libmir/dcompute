module dcompute.driver.metal.queue;
import dcompute.driver.metal.buffer;

import dcompute.driver.metal;
import dcompute.driver.metal.device;
import dcompute.driver.metal.program;
import metal;
import metal.argument;
import metal.types;
import core.stdc.stdio;
import objc;
import foundation;

struct Queue
{
    Device device;
    MTLCommandQueue commandQueue;
    MTLCommandBuffer lastActiveBuffer;
    
    // TODO(asadbek): explore options to make the use of async execution with events
    this (Device _device /*bool async*/)
    {
        device = _device;
        commandQueue = device.mtlDevice.newCommandQueue();
    }

    auto enqueue(alias k)(uint[3] _grid, uint[3] _block)
    {
        static struct Call
        {
            Queue* q;
            uint[3] grid, block;

            this(Queue* _q, uint[3] _grid, uint[3] _block)
            {
                q = _q;
                grid = _grid;
                block = _block;
            }

            void opCall(HostArgsOf!(typeof(k)) args)
            {
                NSError error;

                auto kernel = Program.globalProgram.getKernel!k();
                
                auto pipelineState = q.device.mtlDevice.newComputePipelineStateWithFunction(
                    kernel.kernelFunction,
                    MTLPipelineOption.None,
                    null,
                    error
                );

                if (pipelineState is null)
                {
                    printf("Error: Backend compilation failed: %s\n", error.localizedDescription().ptr);
                    assert(0);
                }

                auto commandBuffer = q.commandQueue.commandBuffer();

                auto computeEncoder = commandBuffer.computeCommandEncoder();

                computeEncoder.setComputePipelineState(pipelineState);

                foreach (i, arg; args)
                {
                    static if (is(typeof(arg): Buffer!U, U))
                    {
                        computeEncoder.setBuffer(arg.mtlBuffer, 0, i);
                    } else static if (__traits(isScalar, typeof(arg)))
                    {
                        computeEncoder.setBytes(&arg, typeof(arg).sizeof, i);
                    }
                    else 
                    {
                        static assert(0, "Unsupported argument type for Metal kernel dispatch!");
                    }
                }

                auto threadgroupsPerGrid = MTLSize(grid[0], grid[1], grid[2]);
                
                auto threadsPerThreadgroup = MTLSize(block[0], block[1], block[2]);

                computeEncoder.dispatchThreads(threadgroupsPerGrid, threadsPerThreadgroup);
                
                computeEncoder.endEncoding();
                commandBuffer.commit();

                q.lastActiveBuffer = commandBuffer;
            }
        }

        return Call(&this, _grid, _block);
    }

    void finish() {
        if (lastActiveBuffer !is null) { 
            lastActiveBuffer.waitUntilCompleted();
            lastActiveBuffer.release();

            lastActiveBuffer = null;
        }
    }
}
