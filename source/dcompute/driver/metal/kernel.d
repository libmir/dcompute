module dcompute.driver.metal.kernel;
import metal.library;

struct Kernel(F) if (is(F==function) || is(F==void))
{
    MTLFunction kernelFunction;

    this(MTLFunction _kernelFunction)
    {
        kernelFunction = _kernelFunction;
    }
}
