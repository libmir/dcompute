@compute(CompileFor.deviceOnly) module dcompute.std.opencl.trig;

import ldc.dcompute;//https://github.com/KhronosGroup/SPIR-Tools/wiki/SPIR-2.0-built-in-functions
import dcompute.std.opencl.util;

pure:
nothrow:
@nogc:


pragma(mangle, "_Z4acosf")
float acos(float);

pragma(mangle, "_Z4acosDv2_f")
float2 acos(float2);

pragma(mangle, "_Z4acosDv3_f")
float3 acos(float3);

pragma(mangle, "_Z4acosDv4_f")
float4 acos(float4);

pragma(mangle, "_Z4acosDv8_f")
float8 acos(float8);

pragma(mangle, "_Z4acosDv16_f")
float16 acos(float16);

pragma(mangle, "_Z4acosd")
double acos(double);

pragma(mangle, "_Z4acosDv2_d")
double2 acos(double2);

pragma(mangle, "_Z4acosDv3_d")
double3 acos(double3);

pragma(mangle, "_Z4acosDv4_d")
double4 acos(double4);

pragma(mangle, "_Z4acosDv8_d")
double8 acos(double8);

pragma(mangle, "_Z4acosDv16_d")
double16 acosh(double16);

pragma(mangle, "_Z5acoshf")
float acosh(float);

pragma(mangle, "_Z5acoshDv2_f")
float2 acosh(float2);

pragma(mangle, "_Z5acoshDv3_f")
float3 acosh(float3);

pragma(mangle, "_Z5acoshDv4_f")
float4 acosh(float4);

pragma(mangle, "_Z5acoshDv8_f")
float8 acosh(float8);

pragma(mangle, "_Z5acoshDv16_f")
float16 acosh(float16);

pragma(mangle, "_Z5acoshd")
double acosh(double);

pragma(mangle, "_Z5acoshDv2_d")
double2 acosh(double2);

pragma(mangle, "_Z5acoshDv3_d")
double3 acosh(double3);

pragma(mangle, "_Z5acoshDv4_d")
double4 acosh(double4);

pragma(mangle, "_Z5coshDv8_d")
double8 acosh(double8);

pragma(mangle, "_Z5acoshDv16_d")
double16 acosh(double16);

pragma(mangle, "_Z6acospif")
float acospi(float);

pragma(mangle, "_Z6acospiDv2_f")
float2 acospi(float2);

pragma(mangle, "_Z6acospiDv3_f")
float3 acospi(float3);

pragma(mangle, "_Z6acospiDv4_f")
float4 acospi(float4);

pragma(mangle, "_Z6acospiDv8_f")
float8 acospi(float8);

pragma(mangle, "_Z6acospiDv16_f")
float16 acospi(float16);

pragma(mangle, "_Z6acospid")
double acospi(double);

pragma(mangle, "_Z6acospiDv2_d")
double2 acospi(double2);

pragma(mangle, "_Z6acospiDv3_d")
double3 acospi(double3);

pragma(mangle, "_Z6acospiDv4_d")
double4 acospi(double4);

pragma(mangle, "_Z6acospiDv8_d")
double8 acospi(double8);

pragma(mangle, "_Z6acospiDv16_d")
double16 acospi(double16);

pragma(mangle, "_Z4asinf")
float asin(float);

pragma(mangle, "_Z4asinDv2_f")
float2 asin(float2);

pragma(mangle, "_Z4asinDv3_f")
float3 asin(float3);

pragma(mangle, "_Z4asinDv4_f")
float4 asin(float4);

pragma(mangle, "_Z4asinDv8_f")
float8 asin(float8);

pragma(mangle, "_Z4asinDv16_f")
float16 asin(float16);

pragma(mangle, "_Z4asind")
double asin(double);

pragma(mangle, "_Z4asinDv2_d")
double2 asin(double2);

pragma(mangle, "_Z4asinDv3_d")
double3 asin(double3);

pragma(mangle, "_Z4asinDv4_d")
double4 asin(double4);

pragma(mangle, "_Z4asinDv8_d")
double8 asin(double8);

pragma(mangle, "_Z4asinDv16_d")
double16 asin(double16);

pragma(mangle, "_Z5asinhf")
float asinh(float);

pragma(mangle, "_Z5asinhDv2_f")
float2 asinh(float2);

pragma(mangle, "_Z5asinhDv3_f")
float3 asinh(float3);

pragma(mangle, "_Z5asinhDv4_f")
float4 asinh(float4);

pragma(mangle, "_Z5asinhDv8_f")
float8 asinh(float8);

pragma(mangle, "_Z5asinhDv16_f")
float16 asinh(float16);

pragma(mangle, "_Z5asinhd")
float asinh(double);

pragma(mangle, "_Z5asinhDv2_d")
double2 asinh(double2);

pragma(mangle, "_Z5asinhDv3_d")
double3 asinh(double3);

pragma(mangle, "_Z5asinhDv4_d")
double4 asinh(double4);

pragma(mangle, "_Z5asinhDv8_d")
double8 asinh(double8);

pragma(mangle, "_Z5asinhDv16_d")
double16 asinh(double16);

pragma(mangle, "_Z6asinpif")
float asinpi(float);

pragma(mangle, "_Z6asinpiDv2_f")
float2 asinpi(float2);

pragma(mangle, "_Z6asinpiDv3_f")
float3 asinpi(float3);

pragma(mangle, "_Z6asinpiDv4_f")
float4 asinpi(float4);

pragma(mangle, "_Z6asinpiDv8_f")
float8 asinpi(float8);

pragma(mangle, "_Z6asinpiDv16_f")
float16 asinpi(float16);

pragma(mangle, "_Z6asinpid")
double asinpi(double);

pragma(mangle, "_Z6asinpiDv2_d")
double2 asinpi(double2);

pragma(mangle, "_Z6asinpiDv3_d")
double3 asinpi(double3);

pragma(mangle, "_Z6asinpiDv4_d")
double4 asinpi(double4);

pragma(mangle, "_Z6asinpiDv8_d")
double8 asinpi(double8);

pragma(mangle, "_Z6asinpiDv16_d")
double16 asinpi(double16);

