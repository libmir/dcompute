#dcompute

[![Join the chat at https://gitter.im/thewilsonator/dcompute](https://badges.gitter.im/thewilsonator/dcompute.svg)](https://gitter.im/thewilsonator/dcompute?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

##About

This project is a set of libraries designed to work with a modified ldc to 
enable native execution of D on GPUs (and other more exotic target of OpenCL, hereafter just 'GPUs').

There are three main parts 
* A standard library 'std' containing standard functionality for targetting GPUs.
* A driver library to handle all the compute API interactions and provide a friendly easy-to-use consistent interface. Of course you can always get down to a lower level of interaction if you need to.
* A set of standard kernels to cover a large number of use cases and serve as documentation on how (and how not) to use this library.

##Build Instructions

To build DCompute you will need a modified ldc available [here](https://github.com/thewilsonator/ldc/tree/dcompute).
 In addition you will need Khronos's SPIRV-LLVM (available [here](https://github.com/KhronosGroup/SPIRV-LLVM)) (use the spirv-3.8 branch) as well as a dmd compatible d compiler and cmake for building ldc.
 
 ##Getting Started
 
 Please see the [wiki](https://github.com/thewilsonator/dcompute/wiki).

 ##TODO
 
 Find out what khronos's clang mangles the OpenCL builtins' names to so that we can use the correct ones.
 
 Get D versions of the OpenCL and CUDA APIs so that work can begin on a unified D driver API.

