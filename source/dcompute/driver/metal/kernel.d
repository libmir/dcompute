module dcompute.driver.metal.kernel;
import metal.computepipeline;

struct Kernel(F) if (is(F==function) || is(F==void))
{
    MTLComputePipelineState pipelineState;

    this(MTLComputePipelineState ps)
    {
        pipelineState = ps;
    }
}