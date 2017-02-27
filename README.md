#dcompute

[![Latest version](https://img.shields.io/dub/v/dcompute.svg)](http://code.dlang.org/packages/dcompute)
[![Latest version](https://img.shields.io/github/tag/libmir/dcompute.svg?maxAge=3600)](http://code.dlang.org/packages/dcompute)
[![License](https://img.shields.io/dub/l/dcompute.svg)](http://code.dlang.org/packages/dcompute)
[![Gitter](https://img.shields.io/gitter/room/libmir/public.svg)](https://gitter.im/libmir/public)

##About

This project is a set of libraries designed to work with a modified ldc to 
enable native execution of D on GPUs (and other more exotic target of OpenCL, hereafter just 'GPUs').

There are three main parts 
* A standard library 'std' containing standard functionality for targetting GPUs.
* A driver library to handle all the compute API interactions and provide a friendly easy-to-use consistent interface. Of course you can always get down to a lower level of interaction if you need to.
* A set of standard kernels to cover a large number of use cases and serve as documentation on how (and how not) to use this library.

##Build Instructions

To build DCompute you will need a modified ldc available [here](https://github.com/ldc-developers/ldc/tree/dcompute).
 In addition you will need a SPIRV capable LLVM (available [here](https://github.com/thewilsonator/llvm/tree/compute) as well as a dmd compatible d compiler and cmake for building ldc.
 
##Getting Started

Please see the [wiki](https://github.com/thewilsonator/dcompute/wiki).

##TODO

Generate OpenCL builtins from [here](https://github.com/KhronosGroup/SPIR-Tools/wiki/SPIR-2.0-built-in-functions)

Get D versions of the OpenCL and CUDA APIs so that work can begin on a unified D driver API.

