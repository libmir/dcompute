Installation
============

LDC
---

As mentioned previously DCompute requires the use of LDC as the D compiler.
All [recent releases of LDC](https://github.com/ldc-developers/ldc/releases)
have the NVPTX backend enabled for targetting NVidia hardware via CUDA.

To verify that your LDC build can target both nvptx and spirv backends, you
can run `ldc2 --version` and look for `nvptx` and `nvptx64` as well as
`spirv32` and `spirv64` under Registered targets.

DCompute
--------

If you are using dub (highly recommended) then all you need to do is add 
`"dcompute": "~>0.1.1"` to your dub.json or 
`dependency "dcompute" version="~>0.1.1"` to your dub.sdl 
dependencies and you should be good to go and can ignore the rest of this section.

If you are not using dub DCompute has a few of dependencies that you need to 
include:

* [derelict-cl](https://github.com/DerelictOrg/DerelictCL) for OpenCL bindings
* [bindbc-cuda](https://github.com/BindBC/bindbc-cuda) for CUDA bindings
* [derelict-util](https://github.com/DerelictOrg/DerelictUtil) shared library loading utilities used by derelict-cl

Configuring bindbc-cuda
-----------------------

Unlike the previous Derelict bindings, `bindbc-cuda` requires you to specify which
CUDA Driver API version to target via a D version flag in your `dub.json`.
This controls which host-side CUDA functions (e.g. `cuMemPrefetchAsync`) are available.

Add the appropriate version to your `dub.json` configuration:

```json
"versions": ["CUDA_120"]
```

Supported version flags: `CUDA_100`, `CUDA_101`, `CUDA_102`, `CUDA_110`, `CUDA_111`,
`CUDA_112`, `CUDA_118`, `CUDA_120`, `CUDA_122`, `CUDA_124`, `CUDA_130`, `CUDA_132`.

If no version flag is specified, `bindbc-cuda` defaults to `CUDA_100` (CUDA 10.0).
Choose the version that matches the CUDA toolkit installed on your system — you can
check yours by running `nvcc --version`.

**Note:** This version flag is independent of the LDC `-mdcompute-targets` flag.
The `dflags` target (e.g. `cuda-210`) controls which GPU hardware architecture
LDC generates PTX code for, while the `versions` flag controls which driver API
functions are available on the host side.

Drivers
-------

To utilise the hardware you need drivers that implement OpenCL 2.1 or higher or CUDA.
Please consult your hardware vendors website for drivers.

TODO: add a list.
