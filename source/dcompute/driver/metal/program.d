module dcompute.driver.metal.program;
import dcompute.driver.metal.device;
import dcompute.driver.metal.kernel;
import objc;
import foundation;
import core.stdc.stdio;
import std.string;
import std.path;
import metal.library;
import metal.device;

struct Program
{
    MTLLibrary metalLibrary;

    Device device;

    Kernel!void getKernelByName(immutable(char)* name)
    {
        auto kName = fromStringz(name);

        auto kNameInNSString = NSString.create(kName);

        auto kernelFunction = metalLibrary.newFunctionWithName(kNameInNSString);

        if (kernelFunction is null)
        {
            printf("Error: Could not find kernel function %s in library.\n", name);
            assert(0);
        }

        NSError error;

        auto pipelineState = device.raw.newComputePipelineStateWithFunction(
            kernelFunction,
            MTLPipelineOption.None,
            null,
            error
        );

        if (pipelineState is null)
        {
            printf("Error: Backend compilation failed: %s\n", error.localizedDescription().ptr);
            assert(0);
        }

        return Kernel!void(pipelineState);
    }

    Kernel!(typeof(k)) getKernel(alias k)()
    {
        return cast(typeof(return)) getKernelByName(k.mangleof.ptr);
    }

    static Program fromFile(Device device, string path)
    {
        NSError error;
        auto nsPath = NSString.create(absolutePath(path));

        auto library = device.raw.newLibrary(NSURL.fromPath(nsPath), error);

        if (library is null)
        {
            printf("Error loading .metallib: %s\n", error.localizedDescription().ptr);
            assert(0);
        }

        foreach(function_; library.functionNames)
        {
            auto functionName = cast(NSString) function_;

            auto r = functionName.ptr();

            printf("kernel: %s\n", r);
        }

        return Program(library, device);
    }

    __gshared static Program globalProgram;

    void unload()
    {
        metalLibrary = null;
    }
}