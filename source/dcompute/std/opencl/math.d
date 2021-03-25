@compute(CompileFor.deviceOnly) module dcompute.std.opencl.math;

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

pragma(mangle, "_Z5atan2ff")
float atan2(float, float);

pragma(mangle, "_Z5atan2Dv2_fDv2_f")
float2 atan2(float2, float2);

pragma(mangle, "_Z5atan2Dv3_fDv3_f")
float3 atan2(float3, float3);

pragma(mangle, "_Z5atan2Dv4_fDv4_f")
float4 atan2(float4, float4);

pragma(mangle, "_Z5atan2Dv8_fDv8_f")
float8 atan2(float8, float8); 	

pragma(mangle, "_Z5atan2Dv16_fDv16_f")
float16 atan2(float16, float16); 	

pragma(mangle, "_Z5atan2dd")
double atan2(double, double); 	

pragma(mangle, "_Z5atan2Dv2_dDv2_d")
double2 atan2(double2, double2);

pragma(mangle, "_Z5atan2Dv3_dDv3_d")
double3 atan2(double3, double3);

pragma(mangle, "_Z5atan2Dv4_dDv4_d")
double4 atan2(double4, double4);

pragma(mangle, "_Z5atan2Dv8_dDv8_d")
double8 atan2(double8, double8);

pragma(mangle, "_Z5atan2Dv16_dDv16_d")
double16 atan2(double16, double16);

pragma(mangle, "_Z7atan2piff")
float atan2pi(float, float);

pragma(mangle, "_Z7atan2piDv2_fDv2_f")
float2 atan2pi(float2, float2);

pragma(mangle, "_Z7atan2piDv3_fDv3_f")
float3 atan2pi(float3, float3);

pragma(mangle, "_Z7atan2piDv4_fDv4_f")
float4 atan2pi(float4, float4);

pragma(mangle, "_Z7atan2piDv8_fDv8_f")
float8 atan2pi(float8, float8);

pragma(mangle, "_Z7atan2piDv16_fDv16_f")
float16 atan2pi(float16, float16);

pragma(mangle, "_Z7atan2pidd")
double atan2pi(double, double);

pragma(mangle, "_Z7atan2piDv2_dDv2_d")
double2 atan2pi(double2, double2);

pragma(mangle, "_Z7atan2piDv3_dDv3_d")
double3 atan2pi(double3, double3);

pragma(mangle, "_Z7atan2piDv4_dDv4_d")
double4 atan2pi(double4, double4);

pragma(mangle, "_Z7atan2piDv8_dDv8_d")
double8 atan2pi(double8, double8);

pragma(mangle, "_Z7atan2piDv16_dDv16_d")
double16 atan2pi(double16, double16);

pragma(mangle, "_Z5atanhf")
float atanh(float);

pragma(mangle, "_Z5atanhDv2_f")
float2 atanh(float2);

pragma(mangle, "_Z5atanhDv3_f")
float3 atanh(float3);

pragma(mangle, "_Z5atanhDv4_f")
float4 atanh(float4);

pragma(mangle, "_Z5atanhDv8_f")
float8 atanh(float8);

pragma(mangle, "_Z5atanhDv16_f")
float16 atanh(float16);

pragma(mangle, "_Z5atanhd")
double atanh(double);

pragma(mangle, "_Z5atanhDv2_d")
double2 atanh(double2);

pragma(mangle, "_Z5atanhDv3_d")
double3 atanh(double3);

pragma(mangle, "_Z5atanhDv4_d")
double4 atanh(double4);

pragma(mangle, "_Z5atanhDv8_d")
double8 atanh(double8);

pragma(mangle, "_Z5atanhDv16_d")
double16 atanh(double16);

pragma(mangle, "_Z6atanpif")
float atanpi(float);

pragma(mangle, "_Z6atanpiDv2_f")
float2 atanpi(float2);

pragma(mangle, "_Z6atanpiDv3_f")
float3 atanpi(float3);

pragma(mangle, "_Z6atanpiDv4_f")
float4 atanpi(float4);

pragma(mangle, "_Z6atanpiDv8_f")
float8 atanpi(float8);

pragma(mangle, "_Z6atanpiDv16_f")
float16 atanpi(float16);

pragma(mangle, "_Z6atanpid")
double atanpi(double);

pragma(mangle, "_Z6atanpiDv2_d")
double2 atanpi(double2);

pragma(mangle, "_Z6atanpiDv3_d")
double3 atanpi(double3);

pragma(mangle, "_Z6atanpiDv4_d")
double4 atanpi(double4);

pragma(mangle, "_Z6atanpiDv8_d")
double8 atanpi(double8);

pragma(mangle, "_Z6atanpiDv16_d")
double16 atanpi(double16);

pragma(mangle, "_Z4cbrtf")
float cbrt(float); 	

pragma(mangle, "_Z4cbrtDv2_f")
float2 cbrt(float2); 	

pragma(mangle, "_Z4cbrtDv3_f")
float3 cbrt(float3); 	

pragma(mangle, "_Z4cbrtDv4_f")
float4 cbrt(float4); 	

pragma(mangle, "_Z4cbrtDv8_f")
float8 cbrt(float8); 	

pragma(mangle, "_Z4cbrtDv16_f")
float16 cbrt(float16); 	

pragma(mangle, "_Z4cbrtd")
double cbrt(double); 	

pragma(mangle, "_Z4cbrtDv2_d")
double2 cbrt(double2); 	

pragma(mangle, "_Z4cbrtDv3_d")
double3 cbrt(double3); 	

pragma(mangle, "_Z4cbrtDv4_d")
double4 cbrt(double4); 	

pragma(mangle, "_Z4cbrtDv8_d")
double8 cbrt(double8); 	

pragma(mangle, "_Z4cbrtDv16_d")
double16 cbrt(double16); 	

pragma(mangle, "_Z4ceilf")
float ceil(float); 	

pragma(mangle, "_Z4ceilDv2_f")
float2 ceil(float2); 	

pragma(mangle, "_Z4ceilDv3_f")
float3 ceil(float3); 	

pragma(mangle, "_Z4ceilDv4_f")
float4 ceil(float4); 	

pragma(mangle, "_Z4ceilDv8_f")
float8 ceil(float8); 	

pragma(mangle, "_Z4ceilDv16_f")
float16 ceil(float16); 	

pragma(mangle, "_Z4ceild")
double ceil(double); 	

pragma(mangle, "_Z4ceilDv2_d")
double2 ceil(double2); 	

pragma(mangle, "_Z4ceilDv3_d")
double3 ceil(double3); 	

pragma(mangle, "_Z4ceilDv4_d")
double4 ceil(double4); 	

pragma(mangle, "_Z4ceilDv8_d")
double8 ceil(double8); 	

pragma(mangle, "_Z4ceilDv16_d")
double16 ceil(double16); 	

pragma(mangle, "_Z8copysignff")
float copysign(float, float); 	

pragma(mangle, "_Z8copysignDv2_fDv2_f")
float2 copysign(float2, float2); 	

pragma(mangle, "_Z8copysignDv3_fDv3_f")
float3 copysign(float3, float3); 	

pragma(mangle, "_Z8copysignDv4_fDv4_f")
float4 copysign(float4, float4); 	

pragma(mangle, "_Z8copysignDv8_fDv8_f")
float8 copysign(float8, float8); 	

pragma(mangle, "_Z8copysignDv16_fDv16_f")
float16 copysign(float16, float16); 	

pragma(mangle, "_Z8copysigndd")
double copysign(double, double); 	

pragma(mangle, "_Z8copysignDv2_dDv2_d")
double2 copysign(double2, double2); 	

pragma(mangle, "_Z8copysignDv3_dDv3_d")
double3 copysign(double3, double3); 	

pragma(mangle, "_Z8copysignDv4_dDv4_d")
double4 copysign(double4, double4); 	

pragma(mangle, "_Z8copysignDv8_dDv8_d")
double8 copysign(double8, double8); 	

pragma(mangle, "_Z8copysignDv16_dDv16_d")
double16 copysign(double16, double16); 	

pragma(mangle, "_Z3cosf")
float cos(float); 	

pragma(mangle, "_Z3cosDv2_f")
float2 cos(float2); 	

pragma(mangle, "_Z3cosDv3_f")
float3 cos(float3); 	

pragma(mangle, "_Z3cosDv4_f")
float4 cos(float4); 	

pragma(mangle, "_Z3cosDv8_f")
float8 cos(float8); 	

pragma(mangle, "_Z3cosDv16_f")
float16 cos(float16); 	

pragma(mangle, "_Z3cosd")
double cos(double); 	

pragma(mangle, "_Z3cosDv2_d")
double2 cos(double2); 	

pragma(mangle, "_Z3cosDv3_d")
double3 cos(double3); 	

pragma(mangle, "_Z3cosDv4_d")
double4 cos(double4); 	

pragma(mangle, "_Z3cosDv8_d")
double8 cos(double8); 	

pragma(mangle, "_Z3cosDv16_d")
double16 cos(double16); 	

pragma(mangle, "_Z4coshf")
float cosh(float); 	

pragma(mangle, "_Z4coshDv2_f")
float2 cosh(float2); 	

pragma(mangle, "_Z4coshDv3_f")
float3 cosh(float3); 	

pragma(mangle, "_Z4coshDv4_f")
float4 cosh(float4); 	

pragma(mangle, "_Z4coshDv8_f")
float8 cosh(float8); 	

pragma(mangle, "_Z4coshDv16_f")
float16 cosh(float16); 	

pragma(mangle, "_Z4coshd")
double cosh(double); 	

pragma(mangle, "_Z4coshDv2_d")
double2 cosh(double2); 	

pragma(mangle, "_Z4coshDv3_d")
double3 cosh(double3); 	

pragma(mangle, "_Z4coshDv4_d")
double4 cosh(double4); 	

pragma(mangle, "_Z4coshDv8_d")
double8 cosh(double8); 	

pragma(mangle, "_Z4coshDv16_d")
double16 cosh(double16); 	

pragma(mangle, "_Z5cospif")
float cospi(float); 	

pragma(mangle, "_Z5cospiDv2_f")
float2 cospi(float2); 	

pragma(mangle, "_Z5cospiDv3_f")
float3 cospi(float3); 	

pragma(mangle, "_Z5cospiDv4_f")
float4 cospi(float4); 	

pragma(mangle, "_Z5cospiDv8_f")
float8 cospi(float8); 	

pragma(mangle, "_Z5cospiDv16_f")
float16 cospi(float16); 	

pragma(mangle, "_Z5cospid")
double cospi(double); 	

pragma(mangle, "_Z5cospiDv2_d")
double2 cospi(double2); 	

pragma(mangle, "_Z5cospiDv3_d")
double3 cospi(double3); 	

pragma(mangle, "_Z5cospiDv4_d")
double4 cospi(double4); 	

pragma(mangle, "_Z5cospiDv8_d")
double8 cospi(double8); 	

pragma(mangle, "_Z5cospiDv16_d")
double16 cospi(double16); 	

pragma(mangle, "_Z3erff")
float erf(float); 	

pragma(mangle, "_Z3erfDv2_f")
float2 erf(float2); 	

pragma(mangle, "_Z3erfDv3_f")
float3 erf(float3); 	

pragma(mangle, "_Z3erfDv4_f")
float4 erf(float4); 	

pragma(mangle, "_Z3erfDv8_f")
float8 erf(float8); 	

pragma(mangle, "_Z3erfDv16_f")
float16 erf(float16); 	

pragma(mangle, "_Z3erfd")
double erf(double); 	

pragma(mangle, "_Z3erfDv2_d")
double2 erf(double2); 	

pragma(mangle, "_Z3erfDv3_d")
double3 erf(double3); 	

pragma(mangle, "_Z3erfDv4_d")
double4 erf(double4); 	

pragma(mangle, "_Z3erfDv8_d")
double8 erf(double8); 	

pragma(mangle, "_Z3erfDv16_d")
double16 erf(double16); 	

pragma(mangle, "_Z4erfcf")
float erfc(float); 	

pragma(mangle, "_Z4erfcDv2_f")
float2 erfc(float2); 	

pragma(mangle, "_Z4erfcDv3_f")
float3 erfc(float3); 	

pragma(mangle, "_Z4erfcDv4_f")
float4 erfc(float4); 	

pragma(mangle, "_Z4erfcDv8_f")
float8 erfc(float8); 	

pragma(mangle, "_Z4erfcDv16_f")
float16 erfc(float16); 	

pragma(mangle, "_Z4erfcd")
double erfc(double); 	

pragma(mangle, "_Z4erfcDv2_d")
double2 erfc(double2); 	

pragma(mangle, "_Z4erfcDv3_d")
double3 erfc(double3); 	

pragma(mangle, "_Z4erfcDv4_d")
double4 erfc(double4); 	

pragma(mangle, "_Z4erfcDv8_d")
double8 erfc(double8); 	

pragma(mangle, "_Z4erfcDv16_d")
double16 erfc(double16); 	

pragma(mangle, "_Z3expf")
float exp(float); 	

pragma(mangle, "_Z3expDv2_f")
float2 exp(float2); 	

pragma(mangle, "_Z3expDv3_f")
float3 exp(float3); 	

pragma(mangle, "_Z3expDv4_f")
float4 exp(float4); 	

pragma(mangle, "_Z3expDv8_f")
float8 exp(float8); 	

pragma(mangle, "_Z3expDv16_f")
float16 exp(float16); 	

pragma(mangle, "_Z3expd")
double exp(double); 	

pragma(mangle, "_Z3expDv2_d")
double2 exp(double2); 	

pragma(mangle, "_Z3expDv3_d")
double3 exp(double3); 	

pragma(mangle, "_Z3expDv4_d")
double4 exp(double4); 	

pragma(mangle, "_Z3expDv8_d")
double8 exp(double8); 	

pragma(mangle, "_Z3expDv16_d")
double16 exp(double16); 	

pragma(mangle, "_Z5exp10f")
float exp10(float); 	

pragma(mangle, "_Z5exp10Dv2_f")
float2 exp10(float2); 	

pragma(mangle, "_Z5exp10Dv3_f")
float3 exp10(float3); 	

pragma(mangle, "_Z5exp10Dv4_f")
float4 exp10(float4); 	

pragma(mangle, "_Z5exp10Dv8_f")
float8 exp10(float8); 	

pragma(mangle, "_Z5exp10Dv16_f")
float16 exp10(float16); 	

pragma(mangle, "_Z5exp10d")
double exp10(double); 	

pragma(mangle, "_Z5exp10Dv2_d")
double2 exp10(double2); 	

pragma(mangle, "_Z5exp10Dv3_d")
double3 exp10(double3); 	

pragma(mangle, "_Z5exp10Dv4_d")
double4 exp10(double4); 	

pragma(mangle, "_Z5exp10Dv8_d")
double8 exp10(double8); 	

pragma(mangle, "_Z5exp10Dv16_d")
double16 exp10(double16); 	

pragma(mangle, "_Z4exp2f")
float exp2(float); 	

pragma(mangle, "_Z4exp2Dv2_f")
float2 exp2(float2); 	

pragma(mangle, "_Z4exp2Dv3_f")
float3 exp2(float3); 	

pragma(mangle, "_Z4exp2Dv4_f")
float4 exp2(float4); 	

pragma(mangle, "_Z4exp2Dv8_f")
float8 exp2(float8); 	

pragma(mangle, "_Z4exp2Dv16_f")
float16 exp2(float16); 	

pragma(mangle, "_Z4exp2d")
double exp2(double); 	

pragma(mangle, "_Z4exp2Dv2_d")
double2 exp2(double2); 	

pragma(mangle, "_Z4exp2Dv3_d")
double3 exp2(double3); 	

pragma(mangle, "_Z4exp2Dv4_d")
double4 exp2(double4); 	

pragma(mangle, "_Z4exp2Dv8_d")
double8 exp2(double8); 	

pragma(mangle, "_Z4exp2Dv16_d")
double16 exp2(double16); 	

pragma(mangle, "_Z5expm1f")
float expm1(float); 	

pragma(mangle, "_Z5expm1Dv2_f")
float2 expm1(float2); 	

pragma(mangle, "_Z5expm1Dv3_f")
float3 expm1(float3); 	

pragma(mangle, "_Z5expm1Dv4_f")
float4 expm1(float4); 	

pragma(mangle, "_Z5expm1Dv8_f")
float8 expm1(float8); 	

pragma(mangle, "_Z5expm1Dv16_f")
float16 expm1(float16); 	

pragma(mangle, "_Z5expm1d")
double expm1(double); 	

pragma(mangle, "_Z5expm1Dv2_d")
double2 expm1(double2); 	

pragma(mangle, "_Z5expm1Dv3_d")
double3 expm1(double3); 	

pragma(mangle, "_Z5expm1Dv4_d")
double4 expm1(double4); 	

pragma(mangle, "_Z5expm1Dv8_d")
double8 expm1(double8); 	

pragma(mangle, "_Z5expm1Dv16_d")
double16 expm1(double16); 	

pragma(mangle, "_Z4fabsf")
float fabs(float); 	

pragma(mangle, "_Z4fabsDv2_f")
float2 fabs(float2); 	

pragma(mangle, "_Z4fabsDv3_f")
float3 fabs(float3); 	

pragma(mangle, "_Z4fabsDv4_f")
float4 fabs(float4); 	

pragma(mangle, "_Z4fabsDv8_f")
float8 fabs(float8); 	

pragma(mangle, "_Z4fabsDv16_f")
float16 fabs(float16); 	

pragma(mangle, "_Z4fabsd")
double fabs(double); 	

pragma(mangle, "_Z4fabsDv2_d")
double2 fabs(double2); 	

pragma(mangle, "_Z4fabsDv3_d")
double3 fabs(double3); 	

pragma(mangle, "_Z4fabsDv4_d")
double4 fabs(double4); 	

pragma(mangle, "_Z4fabsDv8_d")
double8 fabs(double8); 	

pragma(mangle, "_Z4fabsDv16_d")
double16 fabs(double16); 	

pragma(mangle, "_Z4fdimff")
float fdim(float, float); 	

pragma(mangle, "_Z4fdimDv2_fDv2_f")
float2 fdim(float2, float2); 	

pragma(mangle, "_Z4fdimDv3_fDv3_f")
float3 fdim(float3, float3); 	

pragma(mangle, "_Z4fdimDv4_fDv4_f")
float4 fdim(float4, float4); 	

pragma(mangle, "_Z4fdimDv8_fDv8_f")
float8 fdim(float8, float8); 	

pragma(mangle, "_Z4fdimDv16_fDv16_f")
float16 fdim(float16, float16); 	

pragma(mangle, "_Z4fdimdd")
double fdim(double, double); 	

pragma(mangle, "_Z4fdimDv2_dDv2_d")
double2 fdim(double2, double2); 	

pragma(mangle, "_Z4fdimDv3_dDv3_d")
double3 fdim(double3, double3); 	

pragma(mangle, "_Z4fdimDv4_dDv4_d")
double4 fdim(double4, double4); 	

pragma(mangle, "_Z4fdimDv8_dDv8_d")
double8 fdim(double8, double8); 	

pragma(mangle, "_Z4fdimDv16_dDv16_d")
double16 fdim(double16, double16); 	

pragma(mangle, "_Z5floorf")
float floor(float); 	

pragma(mangle, "_Z5floorDv2_f")
float2 floor(float2); 	

pragma(mangle, "_Z5floorDv3_f")
float3 floor(float3); 	

pragma(mangle, "_Z5floorDv4_f")
float4 floor(float4); 	

pragma(mangle, "_Z5floorDv8_f")
float8 floor(float8); 	

pragma(mangle, "_Z5floorDv16_f")
float16 floor(float16); 	

pragma(mangle, "_Z5floord")
double floor(double); 	

pragma(mangle, "_Z5floorDv2_d")
double2 floor(double2); 	

pragma(mangle, "_Z5floorDv3_d")
double3 floor(double3); 	

pragma(mangle, "_Z5floorDv4_d")
double4 floor(double4); 	

pragma(mangle, "_Z5floorDv8_d")
double8 floor(double8); 	

pragma(mangle, "_Z5floorDv16_d")
double16 floor(double16); 	

pragma(mangle, "_Z3fmafff")
float fma(float, float, float); 	

pragma(mangle, "_Z3fmaDv2_fDv2_fDv2_f")
float2 fma(float2, float2, float2); 	

pragma(mangle, "_Z3fmaDv3_fDv3_fDv3_f")
float3 fma(float3, float3, float3); 	

pragma(mangle, "_Z3fmaDv4_fDv4_fDv4_f")
float4 fma(float4, float4, float4); 	

pragma(mangle, "_Z3fmaDv8_fDv8_fDv8_f")
float8 fma(float8, float8, float8); 	

pragma(mangle, "_Z3fmaDv16_fDv16_fDv16_f")
float16 fma(float16, float16, float16); 	

pragma(mangle, "_Z3fmaddd")
double fma(double, double, double); 	

pragma(mangle, "_Z3fmaDv2_dDv2_dDv2_d")
double2 fma(double2, double2, double2); 	

pragma(mangle, "_Z3fmaDv3_dDv3_dDv3_d")
double3 fma(double3, double3, double3); 	

pragma(mangle, "_Z3fmaDv4_dDv4_dDv4_d")
double4 fma(double4, double4, double4); 	

pragma(mangle, "_Z3fmaDv8_dDv8_dDv8_d")
double8 fma(double8, double8, double8); 	

pragma(mangle, "_Z3fmaDv16_dDv16_dDv16_d")
double16 fma(double16, double16, double16); 	

pragma(mangle, "_Z4fmaxff")
float fmax(float, float); 	

pragma(mangle, "_Z4fmaxDv2_fDv2_f")
float2 fmax(float2, float2); 	

pragma(mangle, "_Z4fmaxDv3_fDv3_f")
float3 fmax(float3, float3); 	

pragma(mangle, "_Z4fmaxDv4_fDv4_f")
float4 fmax(float4, float4); 	

pragma(mangle, "_Z4fmaxDv8_fDv8_f")
float8 fmax(float8, float8); 	

pragma(mangle, "_Z4fmaxDv16_fDv16_f")
float16 fmax(float16, float16); 	

pragma(mangle, "_Z4fmaxdd")
double fmax(double, double); 	

pragma(mangle, "_Z4fmaxDv2_dDv2_d")
double2 fmax(double2, double2); 	

pragma(mangle, "_Z4fmaxDv3_dDv3_d")
double3 fmax(double3, double3); 	

pragma(mangle, "_Z4fmaxDv4_dDv4_d")
double4 fmax(double4, double4); 	

pragma(mangle, "_Z4fmaxDv8_dDv8_d")
double8 fmax(double8, double8); 	

pragma(mangle, "_Z4fmaxDv16_dDv16_d")
double16 fmax(double16, double16); 	

pragma(mangle, "_Z4fmaxDv2_ff")
float fmax(float2, float); 	

pragma(mangle, "_Z4fmaxDv3_ff")
float fmax(float3, float); 	

pragma(mangle, "_Z4fmaxDv4_ff")
float fmax(float4, float); 	

pragma(mangle, "_Z4fmaxDv8_ff")
float fmax(float8, float); 	

pragma(mangle, "_Z4fmaxDv16_ff")
float fmax(float16, float); 	

pragma(mangle, "_Z4fmaxDv2_dd")
double fmax(double2, double); 	

pragma(mangle, "_Z4fmaxDv3_dd")
double fmax(double3, double); 	

pragma(mangle, "_Z4fmaxDv4_dd")
double fmax(double4, double); 	

pragma(mangle, "_Z4fmaxDv8_dd")
double fmax(double8, double); 	

pragma(mangle, "_Z4fmaxDv16_dd")
double fmax(double16, double); 	

pragma(mangle, "_Z4fminff")
float fmin(float, float); 	

pragma(mangle, "_Z4fminDv2_fDv2_f")
float2 fmin(float2, float2); 	

pragma(mangle, "_Z4fminDv3_fDv3_f")
float3 fmin(float3, float3); 	

pragma(mangle, "_Z4fminDv4_fDv4_f")
float4 fmin(float4, float4); 	

pragma(mangle, "_Z4fminDv8_fDv8_f")
float8 fmin(float8, float8); 	

pragma(mangle, "_Z4fminDv16_fDv16_f")
float16 fmin(float16, float16); 	

pragma(mangle, "_Z4fmindd")
double fmin(double, double); 	

pragma(mangle, "_Z4fminDv2_dDv2_d")
double2 fmin(double2, double2); 	

pragma(mangle, "_Z4fminDv3_dDv3_d")
double3 fmin(double3, double3); 	

pragma(mangle, "_Z4fminDv4_dDv4_d")
double4 fmin(double4, double4); 	

pragma(mangle, "_Z4fminDv8_dDv8_d")
double8 fmin(double8, double8); 	

pragma(mangle, "_Z4fminDv16_dDv16_d")
double16 fmin(double16, double16); 	

pragma(mangle, "_Z4fminDv2_ff")
float fmin(float2, float); 	

pragma(mangle, "_Z4fminDv3_ff")
float fmin(float3, float); 	

pragma(mangle, "_Z4fminDv4_ff")
float fmin(float4, float); 	

pragma(mangle, "_Z4fminDv8_ff")
float fmin(float8, float); 	

pragma(mangle, "_Z4fminDv16_ff")
float fmin(float16, float); 	

pragma(mangle, "_Z4fminDv2_dd")
double fmin(double2, double); 	

pragma(mangle, "_Z4fminDv3_dd")
double fmin(double3, double); 	

pragma(mangle, "_Z4fminDv4_dd")
double fmin(double4, double); 	

pragma(mangle, "_Z4fminDv8_dd")
double fmin(double8, double); 	

pragma(mangle, "_Z4fminDv16_dd")
double fmin(double16, double); 	

pragma(mangle, "_Z4fmodff")
float fmod(float, float); 	

pragma(mangle, "_Z4fmodDv2_fDv2_f")
float2 fmod(float2, float2); 	

pragma(mangle, "_Z4fmodDv3_fDv3_f")
float3 fmod(float3, float3); 	

pragma(mangle, "_Z4fmodDv4_fDv4_f")
float4 fmod(float4, float4); 	

pragma(mangle, "_Z4fmodDv8_fDv8_f")
float8 fmod(float8, float8); 	

pragma(mangle, "_Z4fmodDv16_fDv16_f")
float16 fmod(float16, float16); 	

pragma(mangle, "_Z4fmoddd")
double fmod(double, double); 	

pragma(mangle, "_Z4fmodDv2_dDv2_d")
double2 fmod(double2, double2); 	

pragma(mangle, "_Z4fmodDv3_dDv3_d")
double3 fmod(double3, double3); 	

pragma(mangle, "_Z4fmodDv4_dDv4_d")
double4 fmod(double4, double4); 	

pragma(mangle, "_Z4fmodDv8_dDv8_d")
double8 fmod(double8, double8); 	

pragma(mangle, "_Z4fmodDv16_dDv16_d")
double16 fmod(double16, double16); 	

pragma(mangle, "_Z5fractfPU3AS1f")
float fract(float, GlobalFloat); 	

pragma(mangle, "_Z5fractDv2_fPU3AS1Dv2_f")
float2 fract(float2, GlobalFloat2); 	

pragma(mangle, "_Z5fractDv3_fPU3AS1Dv3_f")
float3 fract(float3, GlobalFloat3); 	

pragma(mangle, "_Z5fractDv4_fPU3AS1Dv4_f")
float4 fract(float4, GlobalFloat4); 	

pragma(mangle, "_Z5fractDv8_fPU3AS1Dv8_f")
float8 fract(float8, GlobalFloat8); 	

pragma(mangle, "_Z5fractDv16_fPU3AS1Dv16_f")
float16 fract(float16, GlobalFloat16); 	

pragma(mangle, "_Z5fractdPU3AS1d")
double fract(double, GlobalDouble); 	

pragma(mangle, "_Z5fractDv2_dPU3AS1Dv2_d")
double2 fract(double2, GlobalDouble2); 	

pragma(mangle, "_Z5fractDv3_dPU3AS1Dv3_d")
double3 fract(double3, GlobalDouble3); 	

pragma(mangle, "_Z5fractDv4_dPU3AS1Dv4_d")
double4 fract(double4, GlobalDouble4); 	

pragma(mangle, "_Z5fractDv8_dPU3AS1Dv8_d")
double8 fract(double8, GlobalDouble8); 	

pragma(mangle, "_Z5fractDv16_dPU3AS1Dv16_d")
double16 fract(double16, GlobalDouble16); 	

pragma(mangle, "_Z5fractfPU3AS3f")
float fract(float, LocalFloat); 	

pragma(mangle, "_Z5fractDv2_fPU3AS3Dv2_f")
float2 fract(float2, LocalFloat2); 	

pragma(mangle, "_Z5fractDv3_fPU3AS3Dv3_f")
float3 fract(float3, LocalFloat3); 	

pragma(mangle, "_Z5fractDv4_fPU3AS3Dv4_f")
float4 fract(float4, LocalFloat4); 	

pragma(mangle, "_Z5fractDv8_fPU3AS3Dv8_f")
float8 fract(float8, LocalFloat8); 	

pragma(mangle, "_Z5fractDv16_fPU3AS3Dv16_f")
float16 fract(float16, LocalFloat16); 	

pragma(mangle, "_Z5fractdPU3AS3d")
double fract(double, LocalDouble); 	

pragma(mangle, "_Z5fractDv2_dPU3AS3Dv2_d")
double2 fract(double2, LocalDouble2); 	

pragma(mangle, "_Z5fractDv3_dPU3AS3Dv3_d")
double3 fract(double3, LocalDouble3); 	

pragma(mangle, "_Z5fractDv4_dPU3AS3Dv4_d")
double4 fract(double4, LocalDouble4); 	

pragma(mangle, "_Z5fractDv8_dPU3AS3Dv8_d")
double8 fract(double8, LocalDouble8); 	

pragma(mangle, "_Z5fractDv16_dPU3AS3Dv16_d")
double16 fract(double16, LocalDouble16); 	

pragma(mangle, "_Z5fractfPf")
float fract(float, PrivateFloat); 	

pragma(mangle, "_Z5fractDv2_fPDv2_f")
float2 fract(float2, PrivateFloat2); 	

pragma(mangle, "_Z5fractDv3_fPDv3_f")
float3 fract(float3, PrivateFloat3); 	

pragma(mangle, "_Z5fractDv4_fPDv4_f")
float4 fract(float4, PrivateFloat4); 	

pragma(mangle, "_Z5fractDv8_fPDv8_f")
float8 fract(float8, PrivateFloat8); 	

pragma(mangle, "_Z5fractDv16_fPDv16_f")
float16 fract(float16, PrivateFloat16); 	

pragma(mangle, "_Z5fractdPd")
double fract(double, PrivateDouble); 	

pragma(mangle, "_Z5fractDv2_dPDv2_d")
double2 fract(double2, PrivateDouble2); 	

pragma(mangle, "_Z5fractDv3_dPDv3_d");
double3 fract(double3, PrivateDouble3); 	

pragma(mangle, "_Z5fractDv4_dPDv4_d");
double4 fract(double4, PrivateDouble4); 	

pragma(mangle, "_Z5fractDv8_dPDv8_d");
double8 fract(double8, PrivateDouble8); 	

pragma(mangle, "_Z5fractDv16_dPDv16_d")
double16 fract(double16, PrivateDouble16); 	

pragma(mangle, "_Z5frexpfPU3AS1i")
float frexp(float, GlobalInt); 	

pragma(mangle, "_Z5frexpDv2_fPU3AS1Dv2_i")
float2 frexp(float2, GlobalInt2); 	

pragma(mangle, "_Z5frexpDv3_fPU3AS1Dv3_i")
float3 frexp(float3, GlobalInt3); 	

pragma(mangle, "_Z5frexpDv4_fPU3AS1Dv4_i")
float4 frexp(float4, GlobalInt4); 	

pragma(mangle, "_Z5frexpDv8_fPU3AS1Dv8_i")
float8 frexp(float8, GlobalInt8); 	

pragma(mangle, "_Z5frexpDv16_fPU3AS1Dv16_i")
float16 frexp(float16, GlobalInt16); 	

pragma(mangle, "_Z5frexpdPU3AS1i")
double frexp(double, GlobalInt); 	

pragma(mangle, "_Z5frexpDv2_dPU3AS1Dv2_i")
double2 frexp(double2, GlobalInt2); 	

pragma(mangle, "_Z5frexpDv3_dPU3AS1Dv3_i")
double3 frexp(double3, GlobalInt3); 	

pragma(mangle, "_Z5frexpDv4_dPU3AS1Dv4_i")
double4 frexp(double4, GlobalInt4); 	

pragma(mangle, "_Z5frexpDv8_dPU3AS1Dv8_i")
double8 frexp(double8, GlobalInt8); 	

pragma(mangle, "_Z5frexpDv16_dPU3AS1Dv16_i")
double16 frexp(double16, GlobalInt16); 	

pragma(mangle, "_Z5frexpfPU3AS3i")
float frexp(float, LocalInt); 	

pragma(mangle, "_Z5frexpDv2_fPU3AS3Dv2_i")
float2 frexp(float2, LocalInt2); 	

pragma(mangle, "_Z5frexpDv3_fPU3AS3Dv3_i")
float3 frexp(float3, LocalInt3); 	

pragma(mangle, "_Z5frexpDv4_fPU3AS3Dv4_i")
float4 frexp(float4, LocalInt4); 	

pragma(mangle, "_Z5frexpDv8_fPU3AS3Dv8_i")
float8 frexp(float8, LocalInt8); 	

pragma(mangle, "_Z5frexpDv16_fPU3AS3Dv16_i")
float16 frexp(float16, LocalInt16); 	

pragma(mangle, "_Z5frexpdPU3AS3i")
double frexp(double, LocalInt); 	

pragma(mangle, "_Z5frexpDv2_dPU3AS3Dv2_i")
double2 frexp(double2, LocalInt2); 	

pragma(mangle, "_Z5frexpDv3_dPU3AS3Dv3_i")
double3 frexp(double3, LocalInt3); 	

pragma(mangle, "_Z5frexpDv4_dPU3AS3Dv4_i")
double4 frexp(double4, LocalInt4); 	

pragma(mangle, "_Z5frexpDv8_dPU3AS3Dv8_i")
double8 frexp(double8, LocalInt8); 	

pragma(mangle, "_Z5frexpDv16_dPU3AS3Dv16_i")
double16 frexp(double16, LocalInt16); 	

pragma(mangle, "_Z5frexpfPi")
float frexp(float, PrivateInt); 	

pragma(mangle, "_Z5frexpDv2_fPDv2_i")
float2 frexp(float2, PrivateInt2);	

pragma(mangle, "_Z5frexpDv3_fPDv3_i")
float3 frexp(float3, PrivateInt3); 	

pragma(mangle, "_Z5frexpDv4_fPDv4_i")
float4 frexp(float4, PrivateInt4); 	

pragma(mangle, "_Z5frexpDv8_fPDv8_i")
float8 frexp(float8, PrivateInt8); 	

pragma(mangle, "_Z5frexpDv16_fPDv16_i")
float16 frexp(float16, PrivateInt16); 	

pragma(mangle, "_Z5frexpdPi")
double frexp(double, PrivateInt); 	

pragma(mangle, "_Z5frexpDv2_dPDv2_i")
double2 frexp(double2, PrivateInt2); 	

pragma(mangle, "_Z5frexpDv3_dPDv3_i")
double3 frexp(double3, PrivateInt3);	

pragma(mangle, "_Z5frexpDv4_dPDv4_i")
double4 frexp(double4, PrivateInt4); 	

pragma(mangle, "_Z5frexpDv8_dPDv8_i")
double8 frexp(double8, PrivateInt8); 	

pragma(mangle, "_Z5frexpDv16_dPDv16_i")
double16 frexp(double16, PrivateInt16); 	

pragma(mangle, "_Z5hypotff")
float hypot(float, float); 	

pragma(mangle, "_Z5hypotDv2_fDv2_f")
float2 hypot(float2, float2); 	

pragma(mangle, "_Z5hypotDv3_fDv3_f")
float3 hypot(float3, float3); 	

pragma(mangle, "_Z5hypotDv4_fDv4_f")
float4 hypot(float4, float4); 	

pragma(mangle, "_Z5hypotDv8_fDv8_f")
float8 hypot(float8, float8); 	

pragma(mangle, "_Z5hypotDv16_fDv16_f")
float16 hypot(float16, float16); 	

pragma(mangle, "_Z5hypotdd")
double hypot(double, double); 	

pragma(mangle, "_Z5hypotDv2_dDv2_d")
double2 hypot(double2, double2); 	

pragma(mangle, "_Z5hypotDv3_dDv3_d")
double3 hypot(double3, double3); 	

pragma(mangle, "_Z5hypotDv4_dDv4_d")
double4 hypot(double4, double4); 	

pragma(mangle, "_Z5hypotDv8_dDv8_d")
double8 hypot(double8, double8); 	

pragma(mangle, "_Z5hypotDv16_dDv16_d")
double16 hypot(double16, double16); 	

pragma(mangle, "_Z5ilogbf")
float ilogb(float); 	

pragma(mangle, "_Z5ilogbDv2_f")
float2 ilogb(float2); 	

pragma(mangle, "_Z5ilogbDv3_f")
float3 ilogb(float3); 	

pragma(mangle, "_Z5ilogbDv4_f")
float4 ilogb(float4); 	

pragma(mangle, "_Z5ilogbDv8_f")
float8 ilogb(float8); 	

pragma(mangle, "_Z5ilogbDv16_f")
float16 ilogb(float16); 	

pragma(mangle, "_Z5ilogbd")
double ilogb(double); 	

pragma(mangle, "_Z5ilogbDv2_d")
double2 ilogb(double2); 	

pragma(mangle, "_Z5ilogbDv3_d")
double3 ilogb(double3); 	

pragma(mangle, "_Z5ilogbDv4_d")
double4 ilogb(double4); 	

pragma(mangle, "_Z5ilogbDv8_d")
double8 ilogb(double8); 	

pragma(mangle, "_Z5ilogbDv16_d")
double16 ilogb(double16); 	

pragma(mangle, "_Z5ldexpfi")
int ldexp(float, int); 	

pragma(mangle, "_Z5ldexpDv2_fDv2_i")
int2 ldexp(float2, int2); 	

pragma(mangle, "_Z5ldexpDv3_fDv3_i")
int3 ldexp(float3, int3); 	

pragma(mangle, "_Z5ldexpDv4_fDv4_i")
int4 ldexp(float4, int4); 	

pragma(mangle, "_Z5ldexpDv8_fDv8_i")
int8 ldexp(float8, int8); 	

pragma(mangle, "_Z5ldexpDv16_fDv16_i")
int16 ldexp(float16, int16); 	

pragma(mangle, "_Z5ldexpdi")
int ldexp(double, int); 	

pragma(mangle, "_Z5ldexpDv2_dDv2_i")
int2 ldexp(double2, int2); 	

pragma(mangle, "_Z5ldexpDv3_dDv3_i")
int3 ldexp(double3, int3); 	

pragma(mangle, "_Z5ldexpDv4_dDv4_i")
int4 ldexp(double4, int4); 	

pragma(mangle, "_Z5ldexpDv8_dDv8_i")
int8 ldexp(double8, int8); 	

pragma(mangle, "_Z5ldexpDv16_dDv16_i")
int16 ldexp(double16, int16); 	

pragma(mangle, "_Z5ldexpDv2_fi")
int ldexp(float2, int); 	

pragma(mangle, "_Z5ldexpDv3_fi")
int ldexp(float3, int); 	

pragma(mangle, "_Z5ldexpDv4_fi")
int ldexp(float4, int); 	

pragma(mangle, "_Z5ldexpDv8_fi")
int ldexp(float8, int); 	

pragma(mangle, "_Z5ldexpDv16_fi")
int ldexp(float16, int); 	

pragma(mangle, "_Z5ldexpDv2_di")
int ldexp(double2, int); 	

pragma(mangle, "_Z5ldexpDv3_di")
int ldexp(double3, int); 	

pragma(mangle, "_Z5ldexpDv4_di")
int ldexp(double4, int); 	

pragma(mangle, "_Z5ldexpDv8_di")
int ldexp(double8, int); 	

pragma(mangle, "_Z5ldexpDv16_di")
int ldexp(double16, int); 	

pragma(mangle, "_Z6lgammaf")
float lgamma(float); 	

pragma(mangle, "_Z6lgammaDv2_f")
float2 lgamma(float2); 	

pragma(mangle, "_Z6lgammaDv3_f")
float3 lgamma(float3); 	

pragma(mangle, "_Z6lgammaDv4_f")
float4 lgamma(float4); 	

pragma(mangle, "_Z6lgammaDv8_f")
float8 lgamma(float8); 	

pragma(mangle, "_Z6lgammaDv16_f")
float16 lgamma(float16); 	

pragma(mangle, "_Z6lgammad")
double lgamma(double); 	

pragma(mangle, "_Z6lgammaDv2_d")
double2 lgamma(double2); 	

pragma(mangle, "_Z6lgammaDv3_d")
double3 lgamma(double3); 	

pragma(mangle, "_Z6lgammaDv4_d")
double4 lgamma(double4); 	

pragma(mangle, "_Z6lgammaDv8_d")
double8 lgamma(double8); 	

pragma(mangle, "_Z6lgammaDv16_d")
double16 lgamma(double16); 	

pragma(mangle, "_Z8lgamma_rfPU3AS1i")
float lgamma_r(float, GlobalInt); 	

pragma(mangle, "_Z8lgamma_rDv2_fPU3AS1Dv2_i")
float2 lgamma_r(float2, GlobalInt2); 	

pragma(mangle, "_Z8lgamma_rDv3_fPU3AS1Dv3_i")
float3 lgamma_r(float3, GlobalInt3 *); 	

pragma(mangle, "_Z8lgamma_rDv4_fPU3AS1Dv4_i")
float4 lgamma_r(float4, GlobalInt4 *); 	

pragma(mangle, "_Z8lgamma_rDv8_fPU3AS1Dv8_i")
float8 lgamma_r(float8, GlobalInt8 *); 	

pragma(mangle, "_Z8lgamma_rDv16_fPU3AS1Dv16_i")
float16 lgamma_r(float16, GlobalInt16 *); 	

pragma(mangle, "_Z8lgamma_rdPU3AS1i")
double lgamma_r(double, GlobalInt); 	

pragma(mangle, "_Z8lgamma_rDv2_dPU3AS1Dv2_i")
double2 lgamma_r(double2, GlobalInt2); 	

pragma(mangle, "_Z8lgamma_rDv3_dPU3AS1Dv3_i")
double3 lgamma_r(double3, GlobalInt3); 	

pragma(mangle, "_Z8lgamma_rDv4_dPU3AS1Dv4_i")
double4 lgamma_r(double4, GlobalInt4); 	

pragma(mangle, "_Z8lgamma_rDv8_dPU3AS1Dv8_i")
double8 lgamma_r(double8, GlobalInt8); 	

pragma(mangle, "_Z8lgamma_rDv16_dPU3AS1Dv16_i")
double16 lgamma_r(double16, GlobalInt16) ;	

pragma(mangle, "_Z8lgamma_rfPU3AS3i")
float lgamma_r(float, LocalInt); 	

pragma(mangle, "_Z8lgamma_rDv2_fPU3AS3Dv2_i")
float2 lgamma_r(float2, LocalInt2); 	

pragma(mangle, "_Z8lgamma_rDv3_fPU3AS3Dv3_i")
float3 lgamma_r(float3, LocalInt3); 	

pragma(mangle, "_Z8lgamma_rDv4_fPU3AS3Dv4_i")
float4 lgamma_r(float4, LocalInt4); 	

pragma(mangle, "_Z8lgamma_rDv8_fPU3AS3Dv8_i")
float8 lgamma_r(float8, LocalInt8); 	

pragma(mangle, "_Z8lgamma_rDv16_fPU3AS3Dv16_i")
float16 lgamma_r(float16, LocalInt16); 	

pragma(mangle, "_Z8lgamma_rdPU3AS3i")
double lgamma_r(double, LocalInt); 	

pragma(mangle, "_Z8lgamma_rDv2_dPU3AS3Dv2_i")
double2 lgamma_r(double2, LocalInt2); 	

pragma(mangle, "_Z8lgamma_rDv3_dPU3AS3Dv3_i")
double3 lgamma_r(double3, LocalInt3); 	

pragma(mangle, "_Z8lgamma_rDv4_dPU3AS3Dv4_i")
double4 lgamma_r(double4, LocalInt4); 	

pragma(mangle, "_Z8lgamma_rDv8_dPU3AS3Dv8_i")
double8 lgamma_r(double8, LocalInt8); 	

pragma(mangle, "_Z8lgamma_rDv16_dPU3AS3Dv16_i")
double16 lgamma_r(double16, LocalInt16); 	

pragma(mangle, "_Z8lgamma_rfPi")
float lgamma_r(float, PrivateInt); 	

pragma(mangle, "_Z8lgamma_rDv2_fPDv2_i")
float2 lgamma_r(float2, PrivateInt2); 	

pragma(mangle, "_Z8lgamma_rDv3_fPDv3_i")
float3 lgamma_r(float3, PrivateInt3); 	

pragma(mangle, "_Z8lgamma_rDv4_fPDv4_i")
float4 lgamma_r(float4, PrivateInt4); 	

pragma(mangle, "_Z8lgamma_rDv8_fPDv8_i")
float8 lgamma_r(float8, PrivateInt8); 	

pragma(mangle, "_Z8lgamma_rDv16_fPDv16_i")
float16 lgamma_r(float16, PrivateInt16); 	

pragma(mangle, "_Z8lgamma_rdPi")
double lgamma_r(double, PrivateInt); 	

pragma(mangle, "_Z8lgamma_rDv2_dPDv2_i")
double2 lgamma_r(double2, PrivateInt2); 	

pragma(mangle, "_Z8lgamma_rDv3_dPDv3_i")
double3 lgamma_r(double3, PrivateInt3); 	

pragma(mangle, "_Z8lgamma_rDv4_dPDv4_i")
double4 lgamma_r(double4, PrivateInt4); 	

pragma(mangle, "_Z8lgamma_rDv8_dPDv8_i")
double8 lgamma_r(double8, PrivateInt8); 	

pragma(mangle, "_Z8lgamma_rDv16_dPDv16_i")
double16 lgamma_r(double16, PrivateInt16); 	

pragma(mangle, "_Z3logf")
float log(float); 	

pragma(mangle, "_Z3logDv2_f")
float2 log(float2); 	

pragma(mangle, "_Z3logDv3_f")
float3 log(float3); 	

pragma(mangle, "_Z3logDv4_f")
float4 log(float4); 	

pragma(mangle, "_Z3logDv8_f")
float8 log(float8); 	

pragma(mangle, "_Z3logDv16_f")
float16 log(float16); 	

pragma(mangle, "_Z3logd")
double log(double); 	

pragma(mangle, "_Z3logDv2_d")
double2 log(double2); 	

pragma(mangle, "_Z3logDv3_d")
double3 log(double3); 	

pragma(mangle, "_Z3logDv4_d")
double4 log(double4); 	

pragma(mangle, "_Z3logDv8_d")
double8 log(double8); 	

pragma(mangle, "_Z3logDv16_d")
double16 log(double16); 	

pragma(mangle, "_Z5log10f")
float log10(float); 	

pragma(mangle, "_Z5log10Dv2_f")
float2 log10(float2); 	

pragma(mangle, "_Z5log10Dv3_f")
float3 log10(float3); 	

pragma(mangle, "_Z5log10Dv4_f")
float4 log10(float4); 	

pragma(mangle, "_Z5log10Dv8_f")
float8 log10(float8); 	

pragma(mangle, "_Z5log10Dv16_f")
float16 log10(float16); 	

pragma(mangle, "_Z5log10d")
double log10(double); 	

pragma(mangle, "_Z5log10Dv2_d")
double2 log10(double2); 	

pragma(mangle, "_Z5log10Dv3_d")
double3 log10(double3); 	

pragma(mangle, "_Z5log10Dv4_d")
double4 log10(double4); 	

pragma(mangle, "_Z5log10Dv8_d")
double8 log10(double8); 	

pragma(mangle, "_Z5log10Dv16_d")
double16 log10(double16); 	

pragma(mangle, "_Z5log1pf")
float log1p(float); 	

pragma(mangle, "_Z5log1pDv2_f")
float2 log1p(float2); 	

pragma(mangle, "_Z5log1pDv3_f")
float3 log1p(float3); 	

pragma(mangle, "_Z5log1pDv4_f")
float4 log1p(float4); 	

pragma(mangle, "_Z5log1pDv8_f")
float8 log1p(float8); 	

pragma(mangle, "_Z5log1pDv16_f")
float16 log1p(float16); 	

pragma(mangle, "_Z5log1pd")
double log1p(double); 	

pragma(mangle, "_Z5log1pDv2_d")
double2 log1p(double2); 	

pragma(mangle, "_Z5log1pDv3_d")
double3 log1p(double3); 	

pragma(mangle, "_Z5log1pDv4_d")
double4 log1p(double4); 	

pragma(mangle, "_Z5log1pDv8_d")
double8 log1p(double8); 	

pragma(mangle, "_Z5log1pDv16_d")
double16 log1p(double16); 	

pragma(mangle, "_Z4log2f")
float log2(float); 	

pragma(mangle, "_Z4log2Dv2_f")
float2 log2(float2); 	

pragma(mangle, "_Z4log2Dv3_f")
float3 log2(float3); 	

pragma(mangle, "_Z4log2Dv4_f")
float4 log2(float4); 	

pragma(mangle, "_Z4log2Dv8_f")
float8 log2(float8); 	

pragma(mangle, "_Z4log2Dv16_f")
float16 log2(float16); 	

pragma(mangle, "_Z4log2d")
double log2(double); 	

pragma(mangle, "_Z4log2Dv2_d")
double2 log2(double2); 	

pragma(mangle, "_Z4log2Dv3_d")
double3 log2(double3); 	

pragma(mangle, "_Z4log2Dv4_d")
double4 log2(double4); 	

pragma(mangle, "_Z4log2Dv8_d")
double8 log2(double8); 	

pragma(mangle, "_Z4log2Dv16_d")
double16 log2(double16); 	

pragma(mangle, "_Z4logbf")
float logb(float); 	

pragma(mangle, "_Z4logbDv2_f")
float2 logb(float2); 	

pragma(mangle, "_Z4logbDv3_f")
float3 logb(float3); 	

pragma(mangle, "_Z4logbDv4_f")
float4 logb(float4); 	

pragma(mangle, "_Z4logbDv8_f")
float8 logb(float8); 	

pragma(mangle, "_Z4logbDv16_f")
float16 logb(float16); 	

pragma(mangle, "_Z4logbd")
double logb(double); 	

pragma(mangle, "_Z4logbDv2_d")
double2 logb(double2); 	

pragma(mangle, "_Z4logbDv3_d")
double3 logb(double3); 	

pragma(mangle, "_Z4logbDv4_d")
double4 logb(double4); 	

pragma(mangle, "_Z4logbDv8_d")
double8 logb(double8); 	

pragma(mangle, "_Z4logbDv16_d")
double16 logb(double16); 	

pragma(mangle, "_Z3madfff")
float mad(float, float, float); 	

pragma(mangle, "_Z3madDv2_fDv2_fDv2_f")
float2 mad(float2, float2, float2); 	

pragma(mangle, "_Z3madDv3_fDv3_fDv3_f")
float3 mad(float3, float3, float3); 	

pragma(mangle, "_Z3madDv4_fDv4_fDv4_f")
float4 mad(float4, float4, float4); 	

pragma(mangle, "_Z3madDv8_fDv8_fDv8_f")
float8 mad(float8, float8, float8); 	

pragma(mangle, "_Z3madDv16_fDv16_fDv16_f")
float16 mad(float16, float16, float16); 	

pragma(mangle, "_Z3madddd")
double mad(double, double, double); 	

pragma(mangle, "_Z3madDv2_dDv2_dDv2_d")
double2 mad(double2, double2, double2); 	

pragma(mangle, "_Z3madDv3_dDv3_dDv3_d")
double3 mad(double3, double3, double3); 	

pragma(mangle, "_Z3madDv4_dDv4_dDv4_d")
double4 mad(double4, double4, double4); 	

pragma(mangle, "_Z3madDv8_dDv8_dDv8_d")
double8 mad(double8, double8, double8); 	

pragma(mangle, "_Z3madDv16_dDv16_dDv16_d")
double16 mad(double16, double16, double16); 	

pragma(mangle, "_Z6maxmagff")
float maxmag(float, float); 	

pragma(mangle, "_Z6maxmagDv2_fDv2_f")
float2 maxmag(float2, float2); 	

pragma(mangle, "_Z6maxmagDv3_fDv3_f")
float3 maxmag(float3, float3); 	

pragma(mangle, "_Z6maxmagDv4_fDv4_f")
float4 maxmag(float4, float4); 	

pragma(mangle, "_Z6maxmagDv8_fDv8_f")
float8 maxmag(float8, float8); 	

pragma(mangle, "_Z6maxmagDv16_fDv16_f")
float16 maxmag(float16, float16); 	

pragma(mangle, "_Z6maxmagdd")
double maxmag(double, double); 	

pragma(mangle, "_Z6maxmagDv2_dDv2_d")
double2 maxmag(double2, double2); 	

pragma(mangle, "_Z6maxmagDv3_dDv3_d")
double3 maxmag(double3, double3); 	

pragma(mangle, "_Z6maxmagDv4_dDv4_d")
double4 maxmag(double4, double4); 	

pragma(mangle, "_Z6maxmagDv8_dDv8_d")
double8 maxmag(double8, double8); 	

pragma(mangle, "_Z6maxmagDv16_dDv16_d")
double16 maxmag(double16, double16); 	

pragma(mangle, "_Z6minmagff")
float minmag(float, float); 	

pragma(mangle, "_Z6minmagDv2_fDv2_f")
float2 minmag(float2, float2); 	

pragma(mangle, "_Z6minmagDv3_fDv3_f")
float3 minmag(float3, float3); 	

pragma(mangle, "_Z6minmagDv4_fDv4_f")
float4 minmag(float4, float4); 	

pragma(mangle, "_Z6minmagDv8_fDv8_f")
float8 minmag(float8, float8); 	

pragma(mangle, "_Z6minmagDv16_fDv16_f")
float16 minmag(float16, float16); 	

pragma(mangle, "_Z6minmagdd")
double minmag(double, double); 	

pragma(mangle, "_Z6minmagDv2_dDv2_d")
double2 minmag(double2, double2); 	

pragma(mangle, "_Z6minmagDv3_dDv3_d")
double3 minmag(double3, double3); 	

pragma(mangle, "_Z6minmagDv4_dDv4_d")
double4 minmag(double4, double4); 	

pragma(mangle, "_Z6minmagDv8_dDv8_d")
double8 minmag(double8, double8); 	

pragma(mangle, "_Z6minmagDv16_dDv16_d")
double16 minmag(double16, double16); 	

pragma(mangle, "_Z4modffPU3AS1f")
float modf(float, GlobalFloat); 	

pragma(mangle, "_Z4modfDv2_fPU3AS1Dv2_f")
float2 modf(float2, GlobalFloat2); 	

pragma(mangle, "_Z4modfDv3_fPU3AS1Dv3_f")
float3 modf(float3, GlobalFloat3); 	

pragma(mangle, "_Z4modfDv4_fPU3AS1Dv4_f")
float4 modf(float4, GlobalFloat4); 	

pragma(mangle, "_Z4modfDv8_fPU3AS1Dv8_f")
float8 modf(float8, GlobalFloat8); 	

pragma(mangle, "_Z4modfDv16_fPU3AS1Dv16_f")
float16 modf(float16, GlobalFloat16); 	

pragma(mangle, "_Z4modfdPU3AS1d")
double modf(double, GlobalDouble); 	

pragma(mangle, "_Z4modfDv2_dPU3AS1Dv2_d")
double2 modf(double2, GlobalDouble2); 	

pragma(mangle, "_Z4modfDv3_dPU3AS1Dv3_d")
double3 modf(double3, GlobalDouble3); 	

pragma(mangle, "_Z4modfDv4_dPU3AS1Dv4_d")
double4 modf(double4, GlobalDouble4); 	

pragma(mangle, "_Z4modfDv8_dPU3AS1Dv8_d")
double8 modf(double8, GlobalDouble8); 	

pragma(mangle, "_Z4modfDv16_dPU3AS1Dv16_d")
double16 modf(double16, GlobalDouble16); 	

pragma(mangle, "_Z4modffPU3AS3f")
float modf(float, LocalFloat); 	

pragma(mangle, "_Z4modfDv2_fPU3AS3Dv2_f")
float2 modf(float2, LocalFloat2); 	

pragma(mangle, "_Z4modfDv3_fPU3AS3Dv3_f")
float3 modf(float3, LocalFloat3); 	

pragma(mangle, "_Z4modfDv4_fPU3AS3Dv4_f")
float4 modf(float4, LocalFloat4); 	

pragma(mangle, "_Z4modfDv8_fPU3AS3Dv8_f")
float8 modf(float8, LocalFloat8); 	

pragma(mangle, "_Z4modfDv16_fPU3AS3Dv16_f")
float16 modf(float16, LocalFloat16); 	

pragma(mangle, "_Z4modfdPU3AS3d")
double modf(double, LocalDouble); 	

pragma(mangle, "_Z4modfDv2_dPU3AS3Dv2_d")
double2 modf(double2, LocalDouble2); 	

pragma(mangle, "_Z4modfDv3_dPU3AS3Dv3_d")
double3 modf(double3, LocalDouble3); 	

pragma(mangle, "_Z4modfDv4_dPU3AS3Dv4_d")
double4 modf(double4, LocalDouble4); 	

pragma(mangle, "_Z4modfDv8_dPU3AS3Dv8_d")
double8 modf(double8, LocalDouble8); 	

pragma(mangle, "_Z4modfDv16_dPU3AS3Dv16_d")
double16 modf(double16, LocalDouble16); 	

pragma(mangle, "_Z4modffPf")
float modf(float, PrivateFloat); 	

pragma(mangle, "_Z4modfDv2_fPDv2_f")
float2 modf(float2, PrivateFloat2); 	

pragma(mangle, "_Z4modfDv3_fPDv3_f")
float3 modf(float3, PrivateFloat3); 	

pragma(mangle, "_Z4modfDv4_fPDv4_f")
float4 modf(float4, PrivateFloat4); 	

pragma(mangle, "_Z4modfDv8_fPDv8_f")
float8 modf(float8, PrivateFloat8); 	

pragma(mangle, "_Z4modfDv16_fPDv16_f")
float16 modf(float16, PrivateFloat16); 	

pragma(mangle, "_Z4modfdPd")
double modf(double, PrivateDouble); 	

pragma(mangle, "_Z4modfDv2_dPDv2_d")
double2 modf(double2, PrivateDouble2); 	

pragma(mangle, "_Z4modfDv3_dPDv3_d")
double3 modf(double3, PrivateDouble3); 	

pragma(mangle, "_Z4modfDv4_dPDv4_d")
double4 modf(double4, PrivateDouble4); 	

pragma(mangle, "_Z4modfDv8_dPDv8_d")
double8 modf(double8, PrivateDouble8); 	

pragma(mangle, "_Z4modfDv16_dPDv16_d")
double16 modf(double16, PrivateDouble16); 	

pragma(mangle, "_Z3nanj")
uint nan(uint); 	

pragma(mangle, "_Z3nanDv2_j")
uint2 nan(uint2); 	

pragma(mangle, "_Z3nanDv3_j")
uint3 nan(uint3); 	

pragma(mangle, "_Z3nanDv4_j")
uint4 nan(uint4); 	

pragma(mangle, "_Z3nanDv8_j")
uint8 nan(uint8); 	

pragma(mangle, "_Z3nanDv16_j")
uint16 nan(uint16); 	

pragma(mangle, "_Z3nanm")
ulong nan(ulong); 	

pragma(mangle, "_Z3nanDv2_m")
ulong2 nan(ulong2); 	

pragma(mangle, "_Z3nanDv3_m")
ulong3 nan(ulong3); 	

pragma(mangle, "_Z3nanDv4_m")
ulong4 nan(ulong4); 	

pragma(mangle, "_Z3nanDv8_m")
ulong8 nan(ulong8); 	

pragma(mangle, "_Z3nanDv16_m")
ulong16 nan(ulong16); 	

pragma(mangle, "_Z9nextafterff")
float nextafter(float, float); 	

pragma(mangle, "_Z9nextafterDv2_fDv2_f")
float2 nextafter(float2, float2); 	

pragma(mangle, "_Z9nextafterDv3_fDv3_f")
float3 nextafter(float3, float3); 	

pragma(mangle, "_Z9nextafterDv4_fDv4_f")
float4 nextafter(float4, float4); 	

pragma(mangle, "_Z9nextafterDv8_fDv8_f")
float8 nextafter(float8, float8); 	

pragma(mangle, "_Z9nextafterDv16_fDv16_f")
float16 nextafter(float16, float16); 	

pragma(mangle, "_Z9nextafterdd")
double nextafter(double, double); 	

pragma(mangle, "_Z9nextafterDv2_dDv2_d")
double2 nextafter(double2, double2); 	

pragma(mangle, "_Z9nextafterDv3_dDv3_d")
double3 nextafter(double3, double3); 	

pragma(mangle, "_Z9nextafterDv4_dDv4_d")
double4 nextafter(double4, double4); 	

pragma(mangle, "_Z9nextafterDv8_dDv8_d")
double8 nextafter(double8, double8); 	

pragma(mangle, "_Z9nextafterDv16_dDv16_d")
double16 nextafter(double16, double16); 	

pragma(mangle, "_Z3powff")
float pow(float, float); 	

pragma(mangle, "_Z3powDv2_fDv2_f")
float2 pow(float2, float2); 	

pragma(mangle, "_Z3powDv3_fDv3_f")
float3 pow(float3, float3); 	

pragma(mangle, "_Z3powDv4_fDv4_f")
float4 pow(float4, float4); 	

pragma(mangle, "_Z3powDv8_fDv8_f")
float8 pow(float8, float8); 	

pragma(mangle, "_Z3powDv16_fDv16_f")
float16 pow(float16, float16); 	

pragma(mangle, "_Z3powdd")
double pow(double, double); 	

pragma(mangle, "_Z3powDv2_dDv2_d")
double2 pow(double2, double2); 	

pragma(mangle, "_Z3powDv3_dDv3_d")
double3 pow(double3, double3); 	

pragma(mangle, "_Z3powDv4_dDv4_d")
double4 pow(double4, double4); 	

pragma(mangle, "_Z3powDv8_dDv8_d")
double8 pow(double8, double8); 	

pragma(mangle, "_Z3powDv16_dDv16_d")
double16 pow(double16, double16); 	

pragma(mangle, "_Z4pownfi")
int pown(float, int); 	

pragma(mangle, "_Z4pownDv2_fDv2_i")
int2 pown(float2, int2); 	

pragma(mangle, "_Z4pownDv3_fDv3_i")
int3 pown(float3, int3); 	

pragma(mangle, "_Z4pownDv4_fDv4_i")
int4 pown(float4, int4); 	

pragma(mangle, "_Z4pownDv8_fDv8_i")
int8 pown(float8, int8); 	

pragma(mangle, "_Z4pownDv16_fDv16_i")
int16 pown(float16, int16); 	

pragma(mangle, "_Z4powndi")
int pown(double, int); 	

pragma(mangle, "_Z4pownDv2_dDv2_i")
int2 pown(double2, int2); 	

pragma(mangle, "_Z4pownDv3_dDv3_i")
int3 pown(double3, int3); 	

pragma(mangle, "_Z4pownDv4_dDv4_i")
int4 pown(double4, int4); 	

pragma(mangle, "_Z4pownDv8_dDv8_i")
int8 pown(double8, int8); 	

pragma(mangle, "_Z4pownDv16_dDv16_i")
int16 pown(double16, int16); 	

pragma(mangle, "_Z4powrff")
float powr(float, float); 	

pragma(mangle, "_Z4powrDv2_fDv2_f")
float2 powr(float2, float2); 	

pragma(mangle, "_Z4powrDv3_fDv3_f")
float3 powr(float3, float3); 	

pragma(mangle, "_Z4powrDv4_fDv4_f")
float4 powr(float4, float4); 	

pragma(mangle, "_Z4powrDv8_fDv8_f")
float8 powr(float8, float8); 	

pragma(mangle, "_Z4powrDv16_fDv16_f")
float16 powr(float16, float16); 	

pragma(mangle, "_Z4powrdd")
double powr(double, double); 	

pragma(mangle, "_Z4powrDv2_dDv2_d")
double2 powr(double2, double2); 	

pragma(mangle, "_Z4powrDv3_dDv3_d")
double3 powr(double3, double3); 	

pragma(mangle, "_Z4powrDv4_dDv4_d")
double4 powr(double4, double4); 	

pragma(mangle, "_Z4powrDv8_dDv8_d")
double8 powr(double8, double8); 	

pragma(mangle, "_Z4powrDv16_dDv16_d")
double16 powr(double16, double16); 	

pragma(mangle, "_Z9remainderff")
float remainder(float, float); 	

pragma(mangle, "_Z9remainderDv2_fDv2_f")
float2 remainder(float2, float2); 	

pragma(mangle, "_Z9remainderDv3_fDv3_f")
float3 remainder(float3, float3); 	

pragma(mangle, "_Z9remainderDv4_fDv4_f")
float4 remainder(float4, float4); 	

pragma(mangle, "_Z9remainderDv8_fDv8_f")
float8 remainder(float8, float8); 	

pragma(mangle, "_Z9remainderDv16_fDv16_f")
float16 remainder(float16, float16); 	

pragma(mangle, "_Z9remainderdd")
double remainder(double, double); 	

pragma(mangle, "_Z9remainderDv2_dDv2_d")
double2 remainder(double2, double2); 	

pragma(mangle, "_Z9remainderDv3_dDv3_d")
double3 remainder(double3, double3); 	

pragma(mangle, "_Z9remainderDv4_dDv4_d")
double4 remainder(double4, double4); 	

pragma(mangle, "_Z9remainderDv8_dDv8_d")
double8 remainder(double8, double8); 	

pragma(mangle, "_Z9remainderDv16_dDv16_d")
double16 remainder(double16, double16); 	

pragma(mangle, "_Z6remquoffPU3AS1i")
float remquo(float, float, GlobalInt); 	

pragma(mangle, "_Z6remquoDv2_fDv2_fPU3AS1Dv2_i")
float2 remquo(float2, float2, GlobalInt2);	

pragma(mangle, "_Z6remquoDv3_fDv3_fPU3AS1Dv3_i")
float3 remquo(float3, float3, GlobalInt3); 	

pragma(mangle, "_Z6remquoDv4_fDv4_fPU3AS1Dv4_i")
float4 remquo(float4, float4, GlobalInt4); 	

pragma(mangle, "_Z6remquoDv8_fDv8_fPU3AS1Dv8_i")
float8 remquo(float8, float8, GlobalInt8); 	

pragma(mangle, "_Z6remquoDv16_fDv16_fPU3AS1Dv16_i")
float16 remquo(float16, float16, GlobalInt16); 	

pragma(mangle, "_Z6remquoddPU3AS1i")
double remquo(double, double, GlobalInt); 	

pragma(mangle, "_Z6remquoDv2_dDv2_dPU3AS1Dv2_i")
double2 remquo(double2, double2, GlobalInt2); 	

pragma(mangle, "_Z6remquoDv3_dDv3_dPU3AS1Dv3_i")
double3 remquo(double3, double3, GlobalInt3); 	

pragma(mangle, "_Z6remquoDv4_dDv4_dPU3AS1Dv4_i")
double4 remquo(double4, double4, GlobalInt4); 	

pragma(mangle, "_Z6remquoDv8_dDv8_dPU3AS1Dv8_i")
double8 remquo(double8, double8, GlobalInt8); 	

pragma(mangle, "_Z6remquoDv16_dDv16_dPU3AS1Dv16_i")
double16 remquo(double16, double16, GlobalInt16); 	

pragma(mangle, "_Z6remquoffPU3AS3i")
float remquo(float, float, LocalInt); 	

pragma(mangle, "_Z6remquoDv2_fDv2_fPU3AS3Dv2_i")
float2 remquo(float2, float2, LocalInt2); 	

pragma(mangle, "_Z6remquoDv3_fDv3_fPU3AS3Dv3_i")
float3 remquo(float3, float3, LocalInt3); 	

pragma(mangle, "_Z6remquoDv4_fDv4_fPU3AS3Dv4_i")
float4 remquo(float4, float4, LocalInt4); 	

pragma(mangle, "_Z6remquoDv8_fDv8_fPU3AS3Dv8_i")
float8 remquo(float8, float8, LocalInt8); 	

pragma(mangle, "_Z6remquoDv16_fDv16_fPU3AS3Dv16_i")
float16 remquo(float16, float16, LocalInt16); 	

pragma(mangle, "_Z6remquoddPU3AS3i")
double remquo(double, double, LocalInt); 	

pragma(mangle, "_Z6remquoDv2_dDv2_dPU3AS3Dv2_i")
double2 remquo(double2, double2, LocalInt2); 	

pragma(mangle, "_Z6remquoDv3_dDv3_dPU3AS3Dv3_i")
double3 remquo(double3, double3, LocalInt3); 	

pragma(mangle, "_Z6remquoDv4_dDv4_dPU3AS3Dv4_i")
double4 remquo(double4, double4, LocalInt4); 	

pragma(mangle, "_Z6remquoDv8_dDv8_dPU3AS3Dv8_i")
double8 remquo(double8, double8, LocalInt8); 	

pragma(mangle, "_Z6remquoDv16_dDv16_dPU3AS3Dv16_i")
double16 remquo(double16, double16, LocalInt16); 	

pragma(mangle, "_Z6remquoffPi")
float remquo(float, float, PrivateInt); 	

pragma(mangle, "_Z6remquoDv2_fDv2_fPDv2_i")
float2 remquo(float2, float2, PrivateInt2); 	

pragma(mangle, "_Z6remquoDv3_fDv3_fPDv3_i")
float3 remquo(float3, float3, PrivateInt3); 	

pragma(mangle, "_Z6remquoDv4_fDv4_fPDv4_i")
float4 remquo(float4, float4, PrivateInt4); 	

pragma(mangle, "_Z6remquoDv8_fDv8_fPDv8_i")
float8 remquo(float8, float8, PrivateInt8); 	

pragma(mangle, "_Z6remquoDv16_fDv16_fPDv16_i")
float16 remquo(float16, float16, PrivateInt16); 	

pragma(mangle, "_Z6remquoddPi")
double remquo(double, double, PrivateInt); 	

pragma(mangle, "_Z6remquoDv2_dDv2_dPDv2_i")
double2 remquo(double2, double2, PrivateInt2); 	

pragma(mangle, "_Z6remquoDv3_dDv3_dPDv3_i")
double3 remquo(double3, double3, PrivateInt3); 	

pragma(mangle, "_Z6remquoDv4_dDv4_dPDv4_i")
double4 remquo(double4, double4, PrivateInt4); 	

pragma(mangle, "_Z6remquoDv8_dDv8_dPDv8_i")
double8 remquo(double8, double8, PrivateInt8); 	

pragma(mangle, "_Z6remquoDv16_dDv16_dPDv16_i")
double16 remquo(double16, double16, PrivateInt16); 	

pragma(mangle, "_Z4rintf")
float rint(float); 	

pragma(mangle, "_Z4rintDv2_f")
float2 rint(float2); 	

pragma(mangle, "_Z4rintDv3_f")
float3 rint(float3); 	

pragma(mangle, "_Z4rintDv4_f")
float4 rint(float4); 	

pragma(mangle, "_Z4rintDv8_f")
float8 rint(float8); 	

pragma(mangle, "_Z4rintDv16_f")
float16 rint(float16); 	

pragma(mangle, "_Z4rintd")
double rint(double); 	

pragma(mangle, "_Z4rintDv2_d")
double2 rint(double2); 	

pragma(mangle, "_Z4rintDv3_d")
double3 rint(double3); 	

pragma(mangle, "_Z4rintDv4_d")
double4 rint(double4); 	

pragma(mangle, "_Z4rintDv8_d")
double8 rint(double8); 	

pragma(mangle, "_Z4rintDv16_d")
double16 rint(double16); 	

pragma(mangle, "_Z5rootnfi")
int rootn(float, int); 	

pragma(mangle, "_Z5rootnDv2_fDv2_i")
int2 rootn(float2, int2); 	

pragma(mangle, "_Z5rootnDv3_fDv3_i")
int3 rootn(float3, int3); 	

pragma(mangle, "_Z5rootnDv4_fDv4_i")
int4 rootn(float4, int4); 	

pragma(mangle, "_Z5rootnDv8_fDv8_i")
int8 rootn(float8, int8); 	

pragma(mangle, "_Z5rootnDv16_fDv16_i")
int16 rootn(float16, int16); 	

pragma(mangle, "_Z5rootndi")
int rootn(double, int); 	

pragma(mangle, "_Z5rootnDv2_dDv2_i")
int2 rootn(double2, int2); 	

pragma(mangle, "_Z5rootnDv3_dDv3_i")
int3 rootn(double3, int3); 	

pragma(mangle, "_Z5rootnDv4_dDv4_i")
int4 rootn(double4, int4); 	

pragma(mangle, "_Z5rootnDv8_dDv8_i")
int8 rootn(double8, int8); 	

pragma(mangle, "_Z5rootnDv16_dDv16_i")
int16 rootn(double16, int16); 	

pragma(mangle, "_Z5roundf")
float round(float); 	

pragma(mangle, "_Z5roundDv2_f")
float2 round(float2); 	

pragma(mangle, "_Z5roundDv3_f")
float3 round(float3); 	

pragma(mangle, "_Z5roundDv4_f")
float4 round(float4); 	

pragma(mangle, "_Z5roundDv8_f")
float8 round(float8); 	

pragma(mangle, "_Z5roundDv16_f")
float16 round(float16); 	

pragma(mangle, "_Z5roundd")
double round(double); 	

pragma(mangle, "_Z5roundDv2_d")
double2 round(double2); 	

pragma(mangle, "_Z5roundDv3_d")
double3 round(double3); 	

pragma(mangle, "_Z5roundDv4_d")
double4 round(double4); 	

pragma(mangle, "_Z5roundDv8_d")
double8 round(double8); 	

pragma(mangle, "_Z5roundDv16_d")
double16 round(double16); 	

pragma(mangle, "_Z5rsqrtf")
float rsqrt(float); 	

pragma(mangle, "_Z5rsqrtDv2_f")
float2 rsqrt(float2); 	

pragma(mangle, "_Z5rsqrtDv3_f")
float3 rsqrt(float3); 	

pragma(mangle, "_Z5rsqrtDv4_f")
float4 rsqrt(float4); 	

pragma(mangle, "_Z5rsqrtDv8_f")
float8 rsqrt(float8); 	

pragma(mangle, "_Z5rsqrtDv16_f")
float16 rsqrt(float16); 	

pragma(mangle, "_Z5rsqrtd")
double rsqrt(double); 	

pragma(mangle, "_Z5rsqrtDv2_d")
double2 rsqrt(double2); 	

pragma(mangle, "_Z5rsqrtDv3_d")
double3 rsqrt(double3); 	

pragma(mangle, "_Z5rsqrtDv4_d")
double4 rsqrt(double4); 	

pragma(mangle, "_Z5rsqrtDv8_d")
double8 rsqrt(double8); 	

pragma(mangle, "_Z5rsqrtDv16_d")
double16 rsqrt(double16); 	

pragma(mangle, "_Z3sinf")
float sin(float); 	

pragma(mangle, "_Z3sinDv2_f")
float2 sin(float2); 	

pragma(mangle, "_Z3sinDv3_f")
float3 sin(float3); 	

pragma(mangle, "_Z3sinDv4_f")
float4 sin(float4); 	

pragma(mangle, "_Z3sinDv8_f")
float8 sin(float8); 	

pragma(mangle, "_Z3sinDv16_f")
float16 sin(float16); 	

pragma(mangle, "_Z3sind")
double sin(double); 	

pragma(mangle, "_Z3sinDv2_d")
double2 sin(double2); 	

pragma(mangle, "_Z3sinDv3_d")
double3 sin(double3); 	

pragma(mangle, "_Z3sinDv4_d")
double4 sin(double4); 	

pragma(mangle, "_Z3sinDv8_d")
double8 sin(double8); 	

pragma(mangle, "_Z3sinDv16_d")
double16 sin(double16); 	

pragma(mangle, "_Z6sincosfPU3AS1f")
float sincos(float, GlobalFloat); 	

pragma(mangle, "_Z6sincosDv2_fPU3AS1Dv2_f")
float2 sincos(float2, GlobalFloat2); 	

pragma(mangle, "_Z6sincosDv3_fPU3AS1Dv3_f")
float3 sincos(float3, GlobalFloat3); 	

pragma(mangle, "_Z6sincosDv4_fPU3AS1Dv4_f")
float4 sincos(float4, GlobalFloat4); 	

pragma(mangle, "_Z6sincosDv8_fPU3AS1Dv8_f")
float8 sincos(float8, GlobalFloat8); 	

pragma(mangle, "_Z6sincosDv16_fPU3AS1Dv16_f")
float16 sincos(float16, GlobalFloat16); 	

pragma(mangle, "_Z6sincosdPU3AS1d")
double sincos(double, GlobalDouble); 	

pragma(mangle, "_Z6sincosDv2_dPU3AS1Dv2_d")
double2 sincos(double2, GlobalDouble2); 	

pragma(mangle, "_Z6sincosDv3_dPU3AS1Dv3_d")
double3 sincos(double3, GlobalDouble3); 	

pragma(mangle, "_Z6sincosDv4_dPU3AS1Dv4_d")
double4 sincos(double4, GlobalDouble4); 	

pragma(mangle, "_Z6sincosDv8_dPU3AS1Dv8_d")
double8 sincos(double8, GlobalDouble8); 	

pragma(mangle, "_Z6sincosDv16_dPU3AS1Dv16_d")
double16 sincos(double16, GlobalDouble16); 	

pragma(mangle, "_Z6sincosfPU3AS3f")
float sincos(float, LocalFloat); 	

pragma(mangle, "_Z6sincosDv2_fPU3AS3Dv2_f")
float2 sincos(float2, LocalFloat2); 	

pragma(mangle, "_Z6sincosDv3_fPU3AS3Dv3_f")
float3 sincos(float3, LocalFloat3); 	

pragma(mangle, "_Z6sincosDv4_fPU3AS3Dv4_f")
float4 sincos(float4, LocalFloat4); 	

pragma(mangle, "_Z6sincosDv8_fPU3AS3Dv8_f")
float8 sincos(float8, LocalFloat8); 	

pragma(mangle, "_Z6sincosDv16_fPU3AS3Dv16_f")
float16 sincos(float16, LocalFloat16); 	

pragma(mangle, "_Z6sincosdPU3AS3d")
double sincos(double, LocalDouble); 	

pragma(mangle, "_Z6sincosDv2_dPU3AS3Dv2_d")
double2 sincos(double2, LocalDouble2); 	

pragma(mangle, "_Z6sincosDv3_dPU3AS3Dv3_d")
double3 sincos(double3, LocalDouble3); 	

pragma(mangle, "_Z6sincosDv4_dPU3AS3Dv4_d")
double4 sincos(double4, LocalDouble4); 	

pragma(mangle, "_Z6sincosDv8_dPU3AS3Dv8_d")
double8 sincos(double8, LocalDouble8); 	

pragma(mangle, "_Z6sincosDv16_dPU3AS3Dv16_d")
double16 sincos(double16, LocalDouble16); 	

pragma(mangle, "_Z6sincosfPf")
float sincos(float, PrivateFloat); 	

pragma(mangle, "_Z6sincosDv2_fPDv2_f")
float2 sincos(float2, PrivateFloat2); 	

pragma(mangle, "_Z6sincosDv3_fPDv3_f")
float3 sincos(float3, PrivateFloat3); 	

pragma(mangle, "_Z6sincosDv4_fPDv4_f")
float4 sincos(float4, PrivateFloat4); 	

pragma(mangle, "_Z6sincosDv8_fPDv8_f")
float8 sincos(float8, PrivateFloat8); 	

pragma(mangle, "_Z6sincosDv16_fPDv16_f")
float16 sincos(float16, PrivateFloat16); 	

pragma(mangle, "_Z6sincosdPd")
double sincos(double, PrivateDouble); 	

pragma(mangle, "_Z6sincosDv2_dPDv2_d")
double2 sincos(double2, PrivateDouble2); 	

pragma(mangle, "_Z6sincosDv3_dPDv3_d")
double3 sincos(double3, PrivateDouble3); 	

pragma(mangle, "_Z6sincosDv4_dPDv4_d")
double4 sincos(double4, PrivateDouble4);	

pragma(mangle, "_Z6sincosDv8_dPDv8_d")
double8 sincos(double8, PrivateDouble8); 	

pragma(mangle, "_Z6sincosDv16_dPDv16_d")
double16 sincos(double16, PrivateDouble16); 	

pragma(mangle, "_Z4sinhf")
float sinh(float); 	

pragma(mangle, "_Z4sinhDv2_f")
float2 sinh(float2); 	

pragma(mangle, "_Z4sinhDv3_f")
float3 sinh(float3); 	

pragma(mangle, "_Z4sinhDv4_f")
float4 sinh(float4); 	

pragma(mangle, "_Z4sinhDv8_f")
float8 sinh(float8); 	

pragma(mangle, "_Z4sinhDv16_f")
float16 sinh(float16); 	

pragma(mangle, "_Z4sinhd")
double sinh(double); 	

pragma(mangle, "_Z4sinhDv2_d")
double2 sinh(double2); 	

pragma(mangle, "_Z4sinhDv3_d")
double3 sinh(double3); 	

pragma(mangle, "_Z4sinhDv4_d")
double4 sinh(double4); 	

pragma(mangle, "_Z4sinhDv8_d")
double8 sinh(double8); 	

pragma(mangle, "_Z4sinhDv16_d")
double16 sinh(double16); 	

pragma(mangle, "_Z5sinpif")
float sinpi(float); 	

pragma(mangle, "_Z5sinpiDv2_f")
float2 sinpi(float2); 	

pragma(mangle, "_Z5sinpiDv3_f")
float3 sinpi(float3); 	

pragma(mangle, "_Z5sinpiDv4_f")
float4 sinpi(float4); 	

pragma(mangle, "_Z5sinpiDv8_f")
float8 sinpi(float8); 	

pragma(mangle, "_Z5sinpiDv16_f")
float16 sinpi(float16); 	

pragma(mangle, "_Z5sinpid")
double sinpi(double); 	

pragma(mangle, "_Z5sinpiDv2_d")
double2 sinpi(double2); 	

pragma(mangle, "_Z5sinpiDv3_d")
double3 sinpi(double3); 	

pragma(mangle, "_Z5sinpiDv4_d")
double4 sinpi(double4); 	

pragma(mangle, "_Z5sinpiDv8_d")
double8 sinpi(double8); 	

pragma(mangle, "_Z5sinpiDv16_d")
double16 sinpi(double16); 	

pragma(mangle, "_Z4sqrtf")
float sqrt(float); 	

pragma(mangle, "_Z4sqrtDv2_f")
float2 sqrt(float2); 	

pragma(mangle, "_Z4sqrtDv3_f")
float3 sqrt(float3); 	

pragma(mangle, "_Z4sqrtDv4_f")
float4 sqrt(float4); 	

pragma(mangle, "_Z4sqrtDv8_f")
float8 sqrt(float8); 	

pragma(mangle, "_Z4sqrtDv16_f")
float16 sqrt(float16); 	

pragma(mangle, "_Z4sqrtd")
double sqrt(double); 	

pragma(mangle, "_Z4sqrtDv2_d")
double2 sqrt(double2); 	

pragma(mangle, "_Z4sqrtDv3_d")
double3 sqrt(double3); 	

pragma(mangle, "_Z4sqrtDv4_d")
double4 sqrt(double4); 	

pragma(mangle, "_Z4sqrtDv8_d")
double8 sqrt(double8); 	

pragma(mangle, "_Z4sqrtDv16_d")
double16 sqrt(double16); 	

pragma(mangle, "_Z3tanf")
float tan(float); 	

pragma(mangle, "_Z3tanDv2_f")
float2 tan(float2); 	

pragma(mangle, "_Z3tanDv3_f")
float3 tan(float3); 	

pragma(mangle, "_Z3tanDv4_f")
float4 tan(float4); 	

pragma(mangle, "_Z3tanDv8_f")
float8 tan(float8); 	

pragma(mangle, "_Z3tanDv16_f")
float16 tan(float16); 	

pragma(mangle, "_Z3tand")
double tan(double); 	

pragma(mangle, "_Z3tanDv2_d")
double2 tan(double2); 	

pragma(mangle, "_Z3tanDv3_d")
double3 tan(double3); 	

pragma(mangle, "_Z3tanDv4_d")
double4 tan(double4); 	

pragma(mangle, "_Z3tanDv8_d")
double8 tan(double8); 	

pragma(mangle, "_Z3tanDv16_d")
double16 tan(double16); 	

pragma(mangle, "_Z4tanhf")
float tanh(float); 	

pragma(mangle, "_Z4tanhDv2_f")
float2 tanh(float2); 	

pragma(mangle, "_Z4tanhDv3_f")
float3 tanh(float3); 	

pragma(mangle, "_Z4tanhDv4_f")
float4 tanh(float4); 	

pragma(mangle, "_Z4tanhDv8_f")
float8 tanh(float8); 	

pragma(mangle, "_Z4tanhDv16_f")
float16 tanh(float16); 	

pragma(mangle, "_Z4tanhd")
double tanh(double); 	

pragma(mangle, "_Z4tanhDv2_d")
double2 tanh(double2); 	

pragma(mangle, "_Z4tanhDv3_d")
double3 tanh(double3); 	

pragma(mangle, "_Z4tanhDv4_d")
double4 tanh(double4); 	

pragma(mangle, "_Z4tanhDv8_d")
double8 tanh(double8); 	

pragma(mangle, "_Z4tanhDv16_d")
double16 tanh(double16); 	

pragma(mangle, "_Z5tanpif")
float tanpi(float); 	

pragma(mangle, "_Z5tanpiDv2_f")
float2 tanpi(float2); 	

pragma(mangle, "_Z5tanpiDv3_f")
float3 tanpi(float3); 	

pragma(mangle, "_Z5tanpiDv4_f")
float4 tanpi(float4); 	

pragma(mangle, "_Z5tanpiDv8_f")
float8 tanpi(float8); 	

pragma(mangle, "_Z5tanpiDv16_f")
float16 tanpi(float16); 	

pragma(mangle, "_Z5tanpid")
double tanpi(double); 	

pragma(mangle, "_Z5tanpiDv2_d")
double2 tanpi(double2); 	

pragma(mangle, "_Z5tanpiDv3_d")
double3 tanpi(double3); 	

pragma(mangle, "_Z5tanpiDv4_d")
double4 tanpi(double4); 	

pragma(mangle, "_Z5tanpiDv8_d")
double8 tanpi(double8); 	

pragma(mangle, "_Z5tanpiDv16_d")
double16 tanpi(double16); 	

pragma(mangle, "_Z6tgammaf")
float tgamma(float); 	

pragma(mangle, "_Z6tgammaDv2_f")
float2 tgamma(float2); 	

pragma(mangle, "_Z6tgammaDv3_f")
float3 tgamma(float3); 	

pragma(mangle, "_Z6tgammaDv4_f")
float4 tgamma(float4); 	

pragma(mangle, "_Z6tgammaDv8_f")
float8 tgamma(float8); 	

pragma(mangle, "_Z6tgammaDv16_f")
float16 tgamma(float16); 	

pragma(mangle, "_Z6tgammad")
double tgamma(double); 	

pragma(mangle, "_Z6tgammaDv2_d")
double2 tgamma(double2); 	

pragma(mangle, "_Z6tgammaDv3_d")
double3 tgamma(double3); 	

pragma(mangle, "_Z6tgammaDv4_d")
double4 tgamma(double4); 	

pragma(mangle, "_Z6tgammaDv8_d")
double8 tgamma(double8); 	

pragma(mangle, "_Z6tgammaDv16_d")
double16 tgamma(double16); 	

pragma(mangle, "_Z5truncf")
float trunc(float); 	

pragma(mangle, "_Z5truncDv2_f")
float2 trunc(float2); 	

pragma(mangle, "_Z5truncDv3_f")
float3 trunc(float3); 	

pragma(mangle, "_Z5truncDv4_f")
float4 trunc(float4); 	

pragma(mangle, "_Z5truncDv8_f")
float8 trunc(float8); 	

pragma(mangle, "_Z5truncDv16_f")
float16 trunc(float16); 	

pragma(mangle, "_Z5truncd")
double trunc(double); 	

pragma(mangle, "_Z5truncDv2_d")
double2 trunc(double2); 	

pragma(mangle, "_Z5truncDv3_d")
double3 trunc(double3); 	

pragma(mangle, "_Z5truncDv4_d")
double4 trunc(double4); 	

pragma(mangle, "_Z5truncDv8_d")
double8 trunc(double8); 	

pragma(mangle, "_Z5truncDv16_d")
double16 trunc(double16); 	