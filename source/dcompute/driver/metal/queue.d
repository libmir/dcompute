module dcompute.driver.metal.queue;
import dcompute.driver.metal.buffer;

import dcompute.driver.metal;
import dcompute.driver.metal.device;
import dcompute.driver.metal.program;
import metal;
import metal.argument;
import metal.types;

struct Queue
{
    Device device;
    MTLCommandQueue commandQueue;
    MTLCommandBuffer lastActiveBuffer;
    
    this (Device _device /*bool async*/)
    {
        device = _device;
        commandQueue = device.raw.newCommandQueue();
    }

    auto enqueue(alias k)(uint[3] _grid, uint[3] _block)
    {
        static struct Call
        {
            Queue q;
            uint[3] grid, block;

            this(Queue _q, uint[3] _grid, uint[3] _block)
            {
                q = _q;
                grid = _grid;
                block = _block;
            }

            void opCall(HostArgsOf!(typeof(k)) args)
            {
                auto kernel = Program.globalProgram.getKernel!k();
                
                auto commandBuffer = q.commandQueue.commandBuffer();

                auto computeEncoder = commandBuffer.computeCommandEncoder();

                computeEncoder.setComputePipelineState(kernel.pipelineState);

                foreach (i, arg; args)
                {
                    static if (is(typeof(arg): Buffer!U, U))
                    {
                        computeEncoder.setBuffer(arg.mtlBuffer, 0, i);
                    }
                    else static if (__traits(isPOD, typeof(arg)) && !is(typeof(arg) == class))
                    {
                        computeEncoder.setBytes(&val, typeof(val).sizeof, i);
                    }
                    else 
                    {
                        static assert(0, "Unsupported argument type for Metal kernel dispatch!");
                    }
                }

                // specify the grid size
                auto threadgroupsPerGrid = MTLSize(grid[0], grid[1], grid[2]);
                
                // thread group size
                auto threadsPerThreadgroup = MTLSize(block[0], block[1], block[2]);

                // dispatchThreads using compute encoder
                computeEncoder.dispatchThreads(threadgroupsPerGrid, threadsPerThreadgroup);
                
                // commit the commandBuffer
                computeEncoder.endEncoding();
                commandBuffer.commit();
                commandBuffer.waitUntilCompleted();

                // q.lastActiveBuffer = commandBuffer;
            }
        }

        return Call(this, _grid, _block);
    }

    void finish() {
        import std.stdio;
        printf("waiting until completed......\n");
        if (lastActiveBuffer !is null) {
            lastActiveBuffer.waitUntilCompleted();
            lastActiveBuffer = null;

            printf("kernel call completed......\n");
        }
    }
}