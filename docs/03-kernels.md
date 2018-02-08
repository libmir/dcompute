Kernels
=======

At the heart of DCompute is are the special attributes `@compute` and `@kernel` from the module `ldc.dcompute`

`@compute` tell the d compiler that this module should be built to target the device. 
`@compute` takes a single parameter that Indicate wether to target only the device 
(`@compute(CompileFor.deviceOnly)`) or to target host as well (`@compute(CompileFor.hostAndDevice)`).

`@kernel` specifies that the attached function should be an entry point for the device,
i.e. you can tell the driver to execute this function on the device, 
whereas you can't for functions that aren't marked `@kernel`.

Address Spaces 
--------------

Also critical in using DCompute is the notion of address spaced pointers.
These are available from the module `ldc.dcompute` in the form of the magic template
`Pointer!(uint addrspace,T)` which is a pointer to a `T` that resides in the address space `addrspace`. 
there are 5 address spaces Global, Shared, Constant, Private and Generic.

Global is available to all tasks on the device. It is the only address space that the host can both read and write. 

Shared is memory that is local to a group of threads/work items. 
Threads (or work items in OpenCL speak) are the unit of execution.

Constant memory is memory that is writeable by the host but read only by the device
and is kind of like read only pages but is has some spacial chaching properties.

Private memory is local to a thread and contains its registers and stack. 

Generic is not really an address space but a Generic pointer can point anywhere in 
the other address spaces and is useful if you are writing library routines that 
don't know ahead of time where the pointer will point to. You could of course just template the address space.

For more information on this concept just search for documentation on OpenCL and/or CUDA.

The table below shows the equivalent terms in DCompute, OpenCL and CUDA.

|  DCompute  |  OpenCL    |   CUDA         |
|------------|------------|----------------|
|   Global   | `__global`   |  `__device__`    |
|   Shared   | `__local`    |  `__shared__`    |
|   Constant | `__constant` |  `__constant__`  |
|   Private  | `__private`  |  `__local__ `    |
|   Generic  | `__generic`  | (no qualifier) |


Hello World
-----------

About the simplest kernel you can have is shown below (note that @kernel functions MUST return `void` or you'll get errors)

```d
@compute(CompileFor.deviceOnly) module mykernels;
import ldc.dcompute;
@kernel void mykernel(GlobalPointer!float a,GlobalPointer!float b, float c)
{
*a = *b + c;
}
```

Its not a very useful kernel because it only assigns to the first element of `a`.

Compile with `ldc2 -mdcompute-targets=ocl-210,cuda-350 -oq` to target OpenCL 2.1 and CUDA SM 3.5.
