# dcompute

[![Latest version](https://img.shields.io/dub/v/dcompute.svg)](http://code.dlang.org/packages/dcompute)
[![Latest version](https://img.shields.io/github/tag/libmir/dcompute.svg?maxAge=3600)](http://code.dlang.org/packages/dcompute)
[![License](https://img.shields.io/dub/l/dcompute.svg)](http://code.dlang.org/packages/dcompute)
[![Gitter](https://img.shields.io/gitter/room/libmir/public.svg)](https://gitter.im/libmir/public)

## About

This project is a set of libraries designed to work with a modified ldc to 
enable native execution of D on GPUs (and other more exotic targets of OpenCL such as FPGAs DSPs, hereafter just 'GPUs').

There are three main parts 
* A standard library 'std' containing standard functionality for targetting GPUs, an abstraction layer over the intrinsics.
* A driver library to handle all the compute API interactions and provide a friendly, easy-to-use, consistent interface. Of course you can always get down to a lower level of interaction if you need to.
* A set of standard kernels and primitives to cover a large number of use cases and serve as documentation on how (and how not) to use this library.

## Build Instructions

To build DCompute you will need to use [ldc](https://github.com/ldc-developers/ldc) as the D dcompiler.
In addition you will need a SPIRV capable LLVM (available [here](https://github.com/thewilsonator/llvm/tree/compute) to support SPIRV.
NVPTX sould work with any LLVM 3.9.1 or greater. A dmd compatible d compiler,[dmd](https://github.com/dlang/dmd), ldmd or gdmd (available as part of [ldc](https://github.com/ldc-developers/ldc) and [gdc](https://github.com/D-Programming-GDC/GDC) respectively) and cmake for building ldc is also required if you build it yourself.
 
## Getting Started

Please see the [wiki](https://github.com/libmir/dcompute/wiki).

## TODO

Generate OpenCL builtins from [here](https://github.com/KhronosGroup/SPIR-Tools/wiki/SPIR-2.0-built-in-functions)

Get D versions of the OpenCL and CUDA APIs so that work can begin on a unified D driver API.

Add code examples to the readme.
