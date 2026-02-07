/**
Provides access to the OpenCL C math functions and constants.

These functions are only callable from opencl kernels.
Functions taking or returning half floats and half float constants are not supported.
Standards: [6.15.2. Math Functions](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html#math-functions)$(BR)
           [The OpenCL™ C Specification](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html)
License:  [Boost License 1.0](https://boost.org/LICENSE_1_0.txt).
*/

@compute(CompileFor.deviceOnly)
module dcompute.std.opencl.math;

import ldc.dcompute;

// Constants
enum MAXFLOAT  = float.max;
enum HUGE_VALF = float.infinity;
enum INFINITY  = float.infinity;
enum NAN       = float.nan;
enum HUGE_VAL  = double.infinity;

enum FLT_DIG        = float.dig;
enum FLT_MANT_DIG   = float.mant_dig;
enum FLT_MAX_10_EXP = float.max_10_exp;
enum FLT_MAX_EXP    = float.max_exp;
enum FLT_MIN_10_EXP = float.min_10_exp;
enum FLT_MIN_EXP    = float.min_exp;
enum FLT_RADIX      = 2;
enum FLT_MAX        = float.max;
enum FLT_MIN        = float.min_normal;
enum FLT_EPSILON    = float.epsilon;

enum FP_ILOGB0   = int.min;
enum FP_ILOGBNAN = int.max;

enum M_E_F        = 2.71828182845904523536028747135266250f;
enum M_LOG2E_F    = 1.44269504088896340735992468100189214f;
enum M_LOG10E_F   = 0.434294481903251827651128918916605082f;
enum M_LN2_F      = 0.693147180559945309417232121458176568f;
enum M_LN10_F     = 2.30258509299404568401799145468436421f;
enum M_PI_F       = 3.14159265358979323846264338327950288f;
enum M_PI_2_F     = 1.57079632679489661923132169163975144f;
enum M_PI_4_F     = 0.785398163397448309615660845819875721f;
enum M_1_PI_F     = 0.318309886183790671537767526745028724f;
enum M_2_PI_F     = 0.636619772367581343075535053490057448f;
enum M_2_SQRTPI_F = 1.12837916709551257389615890312154517f;
enum M_SQRT2_F    = 1.41421356237309504880168872420969808f;
enum M_SQRT1_2_F  = 0.707106781186547524400844362104849039f;

enum DBL_DIG        = double.dig;
enum DBL_MANT_DIG   = double.mant_dig;
enum DBL_MAX_10_EXP = double.max_10_exp;
enum DBL_MAX_EXP    = double.max_exp;
enum DBL_MIN_10_EXP = double.min_10_exp;
enum DBL_MIN_EXP    = double.min_exp;
enum DBL_MAX        = double.max;
enum DBL_MIN        = double.min_normal;
enum DBL_EPSILON    = double.epsilon;

enum M_E        = 0x1.5bf0a8b145769p+1;
enum M_LOG2E    = 0x1.71547652b82fep+0;
enum M_LOG10E   = 0x1.bcb7b1526e50ep-2;
enum M_LN2      = 0x1.62e42fefa39efp-1;
enum M_LN10     = 0x1.26bb1bbb55516p+1;
enum M_PI       = 0x1.921fb54442d18p+1;
enum M_PI_2     = 0x1.921fb54442d18p+0;
enum M_PI_4     = 0x1.921fb54442d18p-1;
enum M_1_PI     = 0x1.45f306dc9c883p-2;
enum M_2_PI     = 0x1.45f306dc9c883p-1;
enum M_2_SQRTPI = 0x1.20dd750429b6dp+0;
enum M_SQRT2    = 0x1.6a09e667f3bcdp+0;
enum M_SQRT1_2  = 0x1.6a09e667f3bcdp-1;

// acos
pragma(mangle,"_Z4acosf")               float       acos(         float);
pragma(mangle,"_Z4acosDv2_f")  __vector(float[2])   acos(__vector(float[2]));
pragma(mangle,"_Z4acosDv3_f")  __vector(float[3])   acos(__vector(float[3]));
pragma(mangle,"_Z4acosDv4_f")  __vector(float[4])   acos(__vector(float[4]));
pragma(mangle,"_Z4acosDv8_f")  __vector(float[8])   acos(__vector(float[8]));
pragma(mangle,"_Z4acosDv16_f") __vector(float[16])  acos(__vector(float[16]));
pragma(mangle,"_Z4acosd")               double      acos(         double);
pragma(mangle,"_Z4acosDv2_d")  __vector(double[2])  acos(__vector(double[2]));
pragma(mangle,"_Z4acosDv3_d")  __vector(double[3])  acos(__vector(double[3]));
pragma(mangle,"_Z4acosDv4_d")  __vector(double[4])  acos(__vector(double[4]));
pragma(mangle,"_Z4acosDv8_d")  __vector(double[8])  acos(__vector(double[8]));
pragma(mangle,"_Z4acosDv16_d") __vector(double[16]) acos(__vector(double[16]));

// acosh
pragma(mangle,"_Z5acoshf")               float       acosh(         float);
pragma(mangle,"_Z5acoshDv2_f")  __vector(float[2])   acosh(__vector(float[2]));
pragma(mangle,"_Z5acoshDv3_f")  __vector(float[3])   acosh(__vector(float[3]));
pragma(mangle,"_Z5acoshDv4_f")  __vector(float[4])   acosh(__vector(float[4]));
pragma(mangle,"_Z5acoshDv8_f")  __vector(float[8])   acosh(__vector(float[8]));
pragma(mangle,"_Z5acoshDv16_f") __vector(float[16])  acosh(__vector(float[16]));
pragma(mangle,"_Z5acoshd")               double      acosh(         double);
pragma(mangle,"_Z5acoshDv2_d")  __vector(double[2])  acosh(__vector(double[2]));
pragma(mangle,"_Z5acoshDv3_d")  __vector(double[3])  acosh(__vector(double[3]));
pragma(mangle,"_Z5acoshDv4_d")  __vector(double[4])  acosh(__vector(double[4]));
pragma(mangle,"_Z5acoshDv8_d")  __vector(double[8])  acosh(__vector(double[8]));
pragma(mangle,"_Z5acoshDv16_d") __vector(double[16]) acosh(__vector(double[16]));

// acospi
pragma(mangle,"_Z6acospif")               float       acospi(         float);
pragma(mangle,"_Z6acospiDv2_f")  __vector(float[2])   acospi(__vector(float[2]));
pragma(mangle,"_Z6acospiDv3_f")  __vector(float[3])   acospi(__vector(float[3]));
pragma(mangle,"_Z6acospiDv4_f")  __vector(float[4])   acospi(__vector(float[4]));
pragma(mangle,"_Z6acospiDv8_f")  __vector(float[8])   acospi(__vector(float[8]));
pragma(mangle,"_Z6acospiDv16_f") __vector(float[16])  acospi(__vector(float[16]));
pragma(mangle,"_Z6acospid")               double      acospi(         double);
pragma(mangle,"_Z6acospiDv2_d")  __vector(double[2])  acospi(__vector(double[2]));
pragma(mangle,"_Z6acospiDv3_d")  __vector(double[3])  acospi(__vector(double[3]));
pragma(mangle,"_Z6acospiDv4_d")  __vector(double[4])  acospi(__vector(double[4]));
pragma(mangle,"_Z6acospiDv8_d")  __vector(double[8])  acospi(__vector(double[8]));
pragma(mangle,"_Z6acospiDv16_d") __vector(double[16]) acospi(__vector(double[16]));

// asin
pragma(mangle,"_Z4asinf")               float       asin(         float);
pragma(mangle,"_Z4asinDv2_f")  __vector(float[2])   asin(__vector(float[2]));
pragma(mangle,"_Z4asinDv3_f")  __vector(float[3])   asin(__vector(float[3]));
pragma(mangle,"_Z4asinDv4_f")  __vector(float[4])   asin(__vector(float[4]));
pragma(mangle,"_Z4asinDv8_f")  __vector(float[8])   asin(__vector(float[8]));
pragma(mangle,"_Z4asinDv16_f") __vector(float[16])  asin(__vector(float[16]));
pragma(mangle,"_Z4asind")               double      asin(         double);
pragma(mangle,"_Z4asinDv2_d")  __vector(double[2])  asin(__vector(double[2]));
pragma(mangle,"_Z4asinDv3_d")  __vector(double[3])  asin(__vector(double[3]));
pragma(mangle,"_Z4asinDv4_d")  __vector(double[4])  asin(__vector(double[4]));
pragma(mangle,"_Z4asinDv8_d")  __vector(double[8])  asin(__vector(double[8]));
pragma(mangle,"_Z4asinDv16_d") __vector(double[16]) asin(__vector(double[16]));

// asinh
pragma(mangle,"_Z5asinhf")               float       asinh(         float);
pragma(mangle,"_Z5asinhDv2_f")  __vector(float[2])   asinh(__vector(float[2]));
pragma(mangle,"_Z5asinhDv3_f")  __vector(float[3])   asinh(__vector(float[3]));
pragma(mangle,"_Z5asinhDv4_f")  __vector(float[4])   asinh(__vector(float[4]));
pragma(mangle,"_Z5asinhDv8_f")  __vector(float[8])   asinh(__vector(float[8]));
pragma(mangle,"_Z5asinhDv16_f") __vector(float[16])  asinh(__vector(float[16]));
pragma(mangle,"_Z5asinhd")               double      asinh(         double);
pragma(mangle,"_Z5asinhDv2_d")  __vector(double[2])  asinh(__vector(double[2]));
pragma(mangle,"_Z5asinhDv3_d")  __vector(double[3])  asinh(__vector(double[3]));
pragma(mangle,"_Z5asinhDv4_d")  __vector(double[4])  asinh(__vector(double[4]));
pragma(mangle,"_Z5asinhDv8_d")  __vector(double[8])  asinh(__vector(double[8]));
pragma(mangle,"_Z5asinhDv16_d") __vector(double[16]) asinh(__vector(double[16]));

// asinpi
pragma(mangle,"_Z6asinpif")               float       asinpi(         float);
pragma(mangle,"_Z6asinpiDv2_f")  __vector(float[2])   asinpi(__vector(float[2]));
pragma(mangle,"_Z6asinpiDv3_f")  __vector(float[3])   asinpi(__vector(float[3]));
pragma(mangle,"_Z6asinpiDv4_f")  __vector(float[4])   asinpi(__vector(float[4]));
pragma(mangle,"_Z6asinpiDv8_f")  __vector(float[8])   asinpi(__vector(float[8]));
pragma(mangle,"_Z6asinpiDv16_f") __vector(float[16])  asinpi(__vector(float[16]));
pragma(mangle,"_Z6asinpid")               double      asinpi(         double);
pragma(mangle,"_Z6asinpiDv2_d")  __vector(double[2])  asinpi(__vector(double[2]));
pragma(mangle,"_Z6asinpiDv3_d")  __vector(double[3])  asinpi(__vector(double[3]));
pragma(mangle,"_Z6asinpiDv4_d")  __vector(double[4])  asinpi(__vector(double[4]));
pragma(mangle,"_Z6asinpiDv8_d")  __vector(double[8])  asinpi(__vector(double[8]));
pragma(mangle,"_Z6asinpiDv16_d") __vector(double[16]) asinpi(__vector(double[16]));

// atan
pragma(mangle,"_Z4atanf")               float       atan(         float);
pragma(mangle,"_Z4atanDv2_f")  __vector(float[2])   atan(__vector(float[2]));
pragma(mangle,"_Z4atanDv3_f")  __vector(float[3])   atan(__vector(float[3]));
pragma(mangle,"_Z4atanDv4_f")  __vector(float[4])   atan(__vector(float[4]));
pragma(mangle,"_Z4atanDv8_f")  __vector(float[8])   atan(__vector(float[8]));
pragma(mangle,"_Z4atanDv16_f") __vector(float[16])  atan(__vector(float[16]));
pragma(mangle,"_Z4atand")               double      atan(         double);
pragma(mangle,"_Z4atanDv2_d")  __vector(double[2])  atan(__vector(double[2]));
pragma(mangle,"_Z4atanDv3_d")  __vector(double[3])  atan(__vector(double[3]));
pragma(mangle,"_Z4atanDv4_d")  __vector(double[4])  atan(__vector(double[4]));
pragma(mangle,"_Z4atanDv8_d")  __vector(double[8])  atan(__vector(double[8]));
pragma(mangle,"_Z4atanDv16_d") __vector(double[16]) atan(__vector(double[16]));

// atan2
pragma(mangle,"_Z5atan2ff")                float       atan2(         float,                float);
pragma(mangle,"_Z5atan2Dv2_fS_")  __vector(float[2])   atan2(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z5atan2Dv3_fS_")  __vector(float[3])   atan2(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z5atan2Dv4_fS_")  __vector(float[4])   atan2(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z5atan2Dv8_fS_")  __vector(float[8])   atan2(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z5atan2Dv16_fS_") __vector(float[16])  atan2(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z5atan2dd")                double      atan2(         double,              double);
pragma(mangle,"_Z5atan2Dv2_dS_")  __vector(double[2])  atan2(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z5atan2Dv3_dS_")  __vector(double[3])  atan2(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z5atan2Dv4_dS_")  __vector(double[4])  atan2(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z5atan2Dv8_dS_")  __vector(double[8])  atan2(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z5atan2Dv16_dS_") __vector(double[16]) atan2(__vector(double[16]), __vector(double[16]));

// atanh
pragma(mangle,"_Z5atanhf")               float       atanh(         float);
pragma(mangle,"_Z5atanhDv2_f")  __vector(float[2])   atanh(__vector(float[2]));
pragma(mangle,"_Z5atanhDv3_f")  __vector(float[3])   atanh(__vector(float[3]));
pragma(mangle,"_Z5atanhDv4_f")  __vector(float[4])   atanh(__vector(float[4]));
pragma(mangle,"_Z5atanhDv8_f")  __vector(float[8])   atanh(__vector(float[8]));
pragma(mangle,"_Z5atanhDv16_f") __vector(float[16])  atanh(__vector(float[16]));
pragma(mangle,"_Z5atanhd")               double      atanh(         double);
pragma(mangle,"_Z5atanhDv2_d")  __vector(double[2])  atanh(__vector(double[2]));
pragma(mangle,"_Z5atanhDv3_d")  __vector(double[3])  atanh(__vector(double[3]));
pragma(mangle,"_Z5atanhDv4_d")  __vector(double[4])  atanh(__vector(double[4]));
pragma(mangle,"_Z5atanhDv8_d")  __vector(double[8])  atanh(__vector(double[8]));
pragma(mangle,"_Z5atanhDv16_d") __vector(double[16]) atanh(__vector(double[16]));

// atanpi
pragma(mangle,"_Z6atanpif")               float       atanpi(         float);
pragma(mangle,"_Z6atanpiDv2_f")  __vector(float[2])   atanpi(__vector(float[2]));
pragma(mangle,"_Z6atanpiDv3_f")  __vector(float[3])   atanpi(__vector(float[3]));
pragma(mangle,"_Z6atanpiDv4_f")  __vector(float[4])   atanpi(__vector(float[4]));
pragma(mangle,"_Z6atanpiDv8_f")  __vector(float[8])   atanpi(__vector(float[8]));
pragma(mangle,"_Z6atanpiDv16_f") __vector(float[16])  atanpi(__vector(float[16]));
pragma(mangle,"_Z6atanpid")               double      atanpi(         double);
pragma(mangle,"_Z6atanpiDv2_d")  __vector(double[2])  atanpi(__vector(double[2]));
pragma(mangle,"_Z6atanpiDv3_d")  __vector(double[3])  atanpi(__vector(double[3]));
pragma(mangle,"_Z6atanpiDv4_d")  __vector(double[4])  atanpi(__vector(double[4]));
pragma(mangle,"_Z6atanpiDv8_d")  __vector(double[8])  atanpi(__vector(double[8]));
pragma(mangle,"_Z6atanpiDv16_d") __vector(double[16]) atanpi(__vector(double[16]));

// atan2pi
pragma(mangle,"_Z7atan2piff")                float       atan2pi(         float,                float);
pragma(mangle,"_Z7atan2piDv2_fS_")  __vector(float[2])   atan2pi(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z7atan2piDv3_fS_")  __vector(float[3])   atan2pi(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z7atan2piDv4_fS_")  __vector(float[4])   atan2pi(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z7atan2piDv8_fS_")  __vector(float[8])   atan2pi(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z7atan2piDv16_fS_") __vector(float[16])  atan2pi(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z7atan2pidd")                double      atan2pi(         double,               double);
pragma(mangle,"_Z7atan2piDv2_dS_")  __vector(double[2])  atan2pi(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z7atan2piDv3_dS_")  __vector(double[3])  atan2pi(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z7atan2piDv4_dS_")  __vector(double[4])  atan2pi(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z7atan2piDv8_dS_")  __vector(double[8])  atan2pi(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z7atan2piDv16_dS_") __vector(double[16]) atan2pi(__vector(double[16]), __vector(double[16]));

// cbrt
pragma(mangle,"_Z4cbrtf")               float       cbrt(         float);
pragma(mangle,"_Z4cbrtDv2_f")  __vector(float[2])   cbrt(__vector(float[2]));
pragma(mangle,"_Z4cbrtDv3_f")  __vector(float[3])   cbrt(__vector(float[3]));
pragma(mangle,"_Z4cbrtDv4_f")  __vector(float[4])   cbrt(__vector(float[4]));
pragma(mangle,"_Z4cbrtDv8_f")  __vector(float[8])   cbrt(__vector(float[8]));
pragma(mangle,"_Z4cbrtDv16_f") __vector(float[16])  cbrt(__vector(float[16]));
pragma(mangle,"_Z4cbrtd")               double      cbrt(         double);
pragma(mangle,"_Z4cbrtDv2_d")  __vector(double[2])  cbrt(__vector(double[2]));
pragma(mangle,"_Z4cbrtDv3_d")  __vector(double[3])  cbrt(__vector(double[3]));
pragma(mangle,"_Z4cbrtDv4_d")  __vector(double[4])  cbrt(__vector(double[4]));
pragma(mangle,"_Z4cbrtDv8_d")  __vector(double[8])  cbrt(__vector(double[8]));
pragma(mangle,"_Z4cbrtDv16_d") __vector(double[16]) cbrt(__vector(double[16]));

// ceil
pragma(mangle,"_Z4ceilf")               float       ceil(         float);
pragma(mangle,"_Z4ceilDv2_f")  __vector(float[2])   ceil(__vector(float[2]));
pragma(mangle,"_Z4ceilDv3_f")  __vector(float[3])   ceil(__vector(float[3]));
pragma(mangle,"_Z4ceilDv4_f")  __vector(float[4])   ceil(__vector(float[4]));
pragma(mangle,"_Z4ceilDv8_f")  __vector(float[8])   ceil(__vector(float[8]));
pragma(mangle,"_Z4ceilDv16_f") __vector(float[16])  ceil(__vector(float[16]));
pragma(mangle,"_Z4ceild")               double      ceil(         double);
pragma(mangle,"_Z4ceilDv2_d")  __vector(double[2])  ceil(__vector(double[2]));
pragma(mangle,"_Z4ceilDv3_d")  __vector(double[3])  ceil(__vector(double[3]));
pragma(mangle,"_Z4ceilDv4_d")  __vector(double[4])  ceil(__vector(double[4]));
pragma(mangle,"_Z4ceilDv8_d")  __vector(double[8])  ceil(__vector(double[8]));
pragma(mangle,"_Z4ceilDv16_d") __vector(double[16]) ceil(__vector(double[16]));

// copysign
pragma(mangle,"_Z8copysignff")                float       copysign(         float,                float);
pragma(mangle,"_Z8copysignDv2_fS_")  __vector(float[2])   copysign(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z8copysignDv3_fS_")  __vector(float[3])   copysign(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z8copysignDv4_fS_")  __vector(float[4])   copysign(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z8copysignDv8_fS_")  __vector(float[8])   copysign(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z8copysignDv16_fS_") __vector(float[16])  copysign(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z8copysigndd")                double      copysign(         double,               double);
pragma(mangle,"_Z8copysignDv2_dS_")  __vector(double[2])  copysign(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z8copysignDv3_dS_")  __vector(double[3])  copysign(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z8copysignDv4_dS_")  __vector(double[4])  copysign(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z8copysignDv8_dS_")  __vector(double[8])  copysign(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z8copysignDv16_dS_") __vector(double[16]) copysign(__vector(double[16]), __vector(double[16]));

// cos
pragma(mangle,"_Z3cosf")               float       cos(         float);
pragma(mangle,"_Z3cosDv2_f")  __vector(float[2])   cos(__vector(float[2]));
pragma(mangle,"_Z3cosDv3_f")  __vector(float[3])   cos(__vector(float[3]));
pragma(mangle,"_Z3cosDv4_f")  __vector(float[4])   cos(__vector(float[4]));
pragma(mangle,"_Z3cosDv8_f")  __vector(float[8])   cos(__vector(float[8]));
pragma(mangle,"_Z3cosDv16_f") __vector(float[16])  cos(__vector(float[16]));
pragma(mangle,"_Z3cosd")               double      cos(         double);
pragma(mangle,"_Z3cosDv2_d")  __vector(double[2])  cos(__vector(double[2]));
pragma(mangle,"_Z3cosDv3_d")  __vector(double[3])  cos(__vector(double[3]));
pragma(mangle,"_Z3cosDv4_d")  __vector(double[4])  cos(__vector(double[4]));
pragma(mangle,"_Z3cosDv8_d")  __vector(double[8])  cos(__vector(double[8]));
pragma(mangle,"_Z3cosDv16_d") __vector(double[16]) cos(__vector(double[16]));

// cosh
pragma(mangle,"_Z4coshf")               float       cosh(         float);
pragma(mangle,"_Z4coshDv2_f")  __vector(float[2])   cosh(__vector(float[2]));
pragma(mangle,"_Z4coshDv3_f")  __vector(float[3])   cosh(__vector(float[3]));
pragma(mangle,"_Z4coshDv4_f")  __vector(float[4])   cosh(__vector(float[4]));
pragma(mangle,"_Z4coshDv8_f")  __vector(float[8])   cosh(__vector(float[8]));
pragma(mangle,"_Z4coshDv16_f") __vector(float[16])  cosh(__vector(float[16]));
pragma(mangle,"_Z4coshd")               double      cosh(         double);
pragma(mangle,"_Z4coshDv2_d")  __vector(double[2])  cosh(__vector(double[2]));
pragma(mangle,"_Z4coshDv3_d")  __vector(double[3])  cosh(__vector(double[3]));
pragma(mangle,"_Z4coshDv4_d")  __vector(double[4])  cosh(__vector(double[4]));
pragma(mangle,"_Z4coshDv8_d")  __vector(double[8])  cosh(__vector(double[8]));
pragma(mangle,"_Z4coshDv16_d") __vector(double[16]) cosh(__vector(double[16]));

// cospi
pragma(mangle,"_Z5cospif")               float       cospi(         float);
pragma(mangle,"_Z5cospiDv2_f")  __vector(float[2])   cospi(__vector(float[2]));
pragma(mangle,"_Z5cospiDv3_f")  __vector(float[3])   cospi(__vector(float[3]));
pragma(mangle,"_Z5cospiDv4_f")  __vector(float[4])   cospi(__vector(float[4]));
pragma(mangle,"_Z5cospiDv8_f")  __vector(float[8])   cospi(__vector(float[8]));
pragma(mangle,"_Z5cospiDv16_f") __vector(float[16])  cospi(__vector(float[16]));
pragma(mangle,"_Z5cospid")               double      cospi(         double);
pragma(mangle,"_Z5cospiDv2_d")  __vector(double[2])  cospi(__vector(double[2]));
pragma(mangle,"_Z5cospiDv3_d")  __vector(double[3])  cospi(__vector(double[3]));
pragma(mangle,"_Z5cospiDv4_d")  __vector(double[4])  cospi(__vector(double[4]));
pragma(mangle,"_Z5cospiDv8_d")  __vector(double[8])  cospi(__vector(double[8]));
pragma(mangle,"_Z5cospiDv16_d") __vector(double[16]) cospi(__vector(double[16]));

// erfc
pragma(mangle,"_Z4erfcf")               float       erfc(         float);
pragma(mangle,"_Z4erfcDv2_f")  __vector(float[2])   erfc(__vector(float[2]));
pragma(mangle,"_Z4erfcDv3_f")  __vector(float[3])   erfc(__vector(float[3]));
pragma(mangle,"_Z4erfcDv4_f")  __vector(float[4])   erfc(__vector(float[4]));
pragma(mangle,"_Z4erfcDv8_f")  __vector(float[8])   erfc(__vector(float[8]));
pragma(mangle,"_Z4erfcDv16_f") __vector(float[16])  erfc(__vector(float[16]));
pragma(mangle,"_Z4erfcd")               double      erfc(         double);
pragma(mangle,"_Z4erfcDv2_d")  __vector(double[2])  erfc(__vector(double[2]));
pragma(mangle,"_Z4erfcDv3_d")  __vector(double[3])  erfc(__vector(double[3]));
pragma(mangle,"_Z4erfcDv4_d")  __vector(double[4])  erfc(__vector(double[4]));
pragma(mangle,"_Z4erfcDv8_d")  __vector(double[8])  erfc(__vector(double[8]));
pragma(mangle,"_Z4erfcDv16_d") __vector(double[16]) erfc(__vector(double[16]));

// erf
pragma(mangle,"_Z3erff")               float       erf(         float);
pragma(mangle,"_Z3erfDv2_f")  __vector(float[2])   erf(__vector(float[2]));
pragma(mangle,"_Z3erfDv3_f")  __vector(float[3])   erf(__vector(float[3]));
pragma(mangle,"_Z3erfDv4_f")  __vector(float[4])   erf(__vector(float[4]));
pragma(mangle,"_Z3erfDv8_f")  __vector(float[8])   erf(__vector(float[8]));
pragma(mangle,"_Z3erfDv16_f") __vector(float[16])  erf(__vector(float[16]));
pragma(mangle,"_Z3erfd")               double      erf(         double);
pragma(mangle,"_Z3erfDv2_d")  __vector(double[2])  erf(__vector(double[2]));
pragma(mangle,"_Z3erfDv3_d")  __vector(double[3])  erf(__vector(double[3]));
pragma(mangle,"_Z3erfDv4_d")  __vector(double[4])  erf(__vector(double[4]));
pragma(mangle,"_Z3erfDv8_d")  __vector(double[8])  erf(__vector(double[8]));
pragma(mangle,"_Z3erfDv16_d") __vector(double[16]) erf(__vector(double[16]));

// exp
pragma(mangle,"_Z3expf")               float       exp(         float);
pragma(mangle,"_Z3expDv2_f")  __vector(float[2])   exp(__vector(float[2]));
pragma(mangle,"_Z3expDv3_f")  __vector(float[3])   exp(__vector(float[3]));
pragma(mangle,"_Z3expDv4_f")  __vector(float[4])   exp(__vector(float[4]));
pragma(mangle,"_Z3expDv8_f")  __vector(float[8])   exp(__vector(float[8]));
pragma(mangle,"_Z3expDv16_f") __vector(float[16])  exp(__vector(float[16]));
pragma(mangle,"_Z3expd")               double      exp(         double);
pragma(mangle,"_Z3expDv2_d")  __vector(double[2])  exp(__vector(double[2]));
pragma(mangle,"_Z3expDv3_d")  __vector(double[3])  exp(__vector(double[3]));
pragma(mangle,"_Z3expDv4_d")  __vector(double[4])  exp(__vector(double[4]));
pragma(mangle,"_Z3expDv8_d")  __vector(double[8])  exp(__vector(double[8]));
pragma(mangle,"_Z3expDv16_d") __vector(double[16]) exp(__vector(double[16]));

// exp2
pragma(mangle,"_Z4exp2f")               float       exp2(         float);
pragma(mangle,"_Z4exp2Dv2_f")  __vector(float[2])   exp2(__vector(float[2]));
pragma(mangle,"_Z4exp2Dv3_f")  __vector(float[3])   exp2(__vector(float[3]));
pragma(mangle,"_Z4exp2Dv4_f")  __vector(float[4])   exp2(__vector(float[4]));
pragma(mangle,"_Z4exp2Dv8_f")  __vector(float[8])   exp2(__vector(float[8]));
pragma(mangle,"_Z4exp2Dv16_f") __vector(float[16])  exp2(__vector(float[16]));
pragma(mangle,"_Z4exp2d")               double      exp2(         double);
pragma(mangle,"_Z4exp2Dv2_d")  __vector(double[2])  exp2(__vector(double[2]));
pragma(mangle,"_Z4exp2Dv3_d")  __vector(double[3])  exp2(__vector(double[3]));
pragma(mangle,"_Z4exp2Dv4_d")  __vector(double[4])  exp2(__vector(double[4]));
pragma(mangle,"_Z4exp2Dv8_d")  __vector(double[8])  exp2(__vector(double[8]));
pragma(mangle,"_Z4exp2Dv16_d") __vector(double[16]) exp2(__vector(double[16]));

// exp10
pragma(mangle,"_Z5exp10f")               float       exp10(         float);
pragma(mangle,"_Z5exp10Dv2_f")  __vector(float[2])   exp10(__vector(float[2]));
pragma(mangle,"_Z5exp10Dv3_f")  __vector(float[3])   exp10(__vector(float[3]));
pragma(mangle,"_Z5exp10Dv4_f")  __vector(float[4])   exp10(__vector(float[4]));
pragma(mangle,"_Z5exp10Dv8_f")  __vector(float[8])   exp10(__vector(float[8]));
pragma(mangle,"_Z5exp10Dv16_f") __vector(float[16])  exp10(__vector(float[16]));
pragma(mangle,"_Z5exp10d")               double      exp10(         double);
pragma(mangle,"_Z5exp10Dv2_d")  __vector(double[2])  exp10(__vector(double[2]));
pragma(mangle,"_Z5exp10Dv3_d")  __vector(double[3])  exp10(__vector(double[3]));
pragma(mangle,"_Z5exp10Dv4_d")  __vector(double[4])  exp10(__vector(double[4]));
pragma(mangle,"_Z5exp10Dv8_d")  __vector(double[8])  exp10(__vector(double[8]));
pragma(mangle,"_Z5exp10Dv16_d") __vector(double[16]) exp10(__vector(double[16]));

// expm1
pragma(mangle,"_Z5expm1f")               float       expm1(         float);
pragma(mangle,"_Z5expm1Dv2_f")  __vector(float[2])   expm1(__vector(float[2]));
pragma(mangle,"_Z5expm1Dv3_f")  __vector(float[3])   expm1(__vector(float[3]));
pragma(mangle,"_Z5expm1Dv4_f")  __vector(float[4])   expm1(__vector(float[4]));
pragma(mangle,"_Z5expm1Dv8_f")  __vector(float[8])   expm1(__vector(float[8]));
pragma(mangle,"_Z5expm1Dv16_f") __vector(float[16])  expm1(__vector(float[16]));
pragma(mangle,"_Z5expm1d")               double      expm1(         double);
pragma(mangle,"_Z5expm1Dv2_d")  __vector(double[2])  expm1(__vector(double[2]));
pragma(mangle,"_Z5expm1Dv3_d")  __vector(double[3])  expm1(__vector(double[3]));
pragma(mangle,"_Z5expm1Dv4_d")  __vector(double[4])  expm1(__vector(double[4]));
pragma(mangle,"_Z5expm1Dv8_d")  __vector(double[8])  expm1(__vector(double[8]));
pragma(mangle,"_Z5expm1Dv16_d") __vector(double[16]) expm1(__vector(double[16]));

// fabs
pragma(mangle,"_Z4fabsf")               float       fabs(         float);
pragma(mangle,"_Z4fabsDv2_f")  __vector(float[2])   fabs(__vector(float[2]));
pragma(mangle,"_Z4fabsDv3_f")  __vector(float[3])   fabs(__vector(float[3]));
pragma(mangle,"_Z4fabsDv4_f")  __vector(float[4])   fabs(__vector(float[4]));
pragma(mangle,"_Z4fabsDv8_f")  __vector(float[8])   fabs(__vector(float[8]));
pragma(mangle,"_Z4fabsDv16_f") __vector(float[16])  fabs(__vector(float[16]));
pragma(mangle,"_Z4fabsd")               double      fabs(         double);
pragma(mangle,"_Z4fabsDv2_d")  __vector(double[2])  fabs(__vector(double[2]));
pragma(mangle,"_Z4fabsDv3_d")  __vector(double[3])  fabs(__vector(double[3]));
pragma(mangle,"_Z4fabsDv4_d")  __vector(double[4])  fabs(__vector(double[4]));
pragma(mangle,"_Z4fabsDv8_d")  __vector(double[8])  fabs(__vector(double[8]));
pragma(mangle,"_Z4fabsDv16_d") __vector(double[16]) fabs(__vector(double[16]));

// fdim
pragma(mangle,"_Z4fdimff")                float       fdim(         float,                float);
pragma(mangle,"_Z4fdimDv2_fS_")  __vector(float[2])   fdim(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z4fdimDv3_fS_")  __vector(float[3])   fdim(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z4fdimDv4_fS_")  __vector(float[4])   fdim(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z4fdimDv8_fS_")  __vector(float[8])   fdim(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z4fdimDv16_fS_") __vector(float[16])  fdim(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z4fdimdd")                double      fdim(         double,               double);
pragma(mangle,"_Z4fdimDv2_dS_")  __vector(double[2])  fdim(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z4fdimDv3_dS_")  __vector(double[3])  fdim(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z4fdimDv4_dS_")  __vector(double[4])  fdim(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z4fdimDv8_dS_")  __vector(double[8])  fdim(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z4fdimDv16_dS_") __vector(double[16]) fdim(__vector(double[16]), __vector(double[16]));

// floor
pragma(mangle,"_Z5floorf")               float       floor(         float);
pragma(mangle,"_Z5floorDv2_f")  __vector(float[2])   floor(__vector(float[2]));
pragma(mangle,"_Z5floorDv3_f")  __vector(float[3])   floor(__vector(float[3]));
pragma(mangle,"_Z5floorDv4_f")  __vector(float[4])   floor(__vector(float[4]));
pragma(mangle,"_Z5floorDv8_f")  __vector(float[8])   floor(__vector(float[8]));
pragma(mangle,"_Z5floorDv16_f") __vector(float[16])  floor(__vector(float[16]));
pragma(mangle,"_Z5floord")               double      floor(         double);
pragma(mangle,"_Z5floorDv2_d")  __vector(double[2])  floor(__vector(double[2]));
pragma(mangle,"_Z5floorDv3_d")  __vector(double[3])  floor(__vector(double[3]));
pragma(mangle,"_Z5floorDv4_d")  __vector(double[4])  floor(__vector(double[4]));
pragma(mangle,"_Z5floorDv8_d")  __vector(double[8])  floor(__vector(double[8]));
pragma(mangle,"_Z5floorDv16_d") __vector(double[16]) floor(__vector(double[16]));

// fma
pragma(mangle,"_Z3fmafff")                float      fma(         float,                float,               float);
pragma(mangle,"_Z3fmaDv2_fS_S_") __vector(float[2])  fma(__vector(float[2]),  __vector(float[2]),  __vector(float[2]));
pragma(mangle,"_Z3fmaDv3_fS_S_") __vector(float[3])  fma(__vector(float[3]),  __vector(float[3]),  __vector(float[3]));
pragma(mangle,"_Z3fmaDv4_fS_S_") __vector(float[4])  fma(__vector(float[4]),  __vector(float[4]),  __vector(float[4]));
pragma(mangle,"_Z3fmaDv8_fS_S_") __vector(float[8])  fma(__vector(float[8]),  __vector(float[8]),  __vector(float[8]));
pragma(mangle,"_Z3fmaDv16_fS_S_")__vector(float[16]) fma(__vector(float[16]), __vector(float[16]), __vector(float[16]));
pragma(mangle,"_Z3fmaddd")                double     fma(         double,              double,              double);
pragma(mangle,"_Z3fmaDv2_dS_S_") __vector(double[2]) fma(__vector(double[2]), __vector(double[2]), __vector(double[2]));
pragma(mangle,"_Z3fmaDv3_dS_S_") __vector(double[3]) fma(__vector(double[3]), __vector(double[3]), __vector(double[3]));
pragma(mangle,"_Z3fmaDv4_dS_S_") __vector(double[4]) fma(__vector(double[4]), __vector(double[4]), __vector(double[4]));
pragma(mangle,"_Z3fmaDv8_dS_S_") __vector(double[8]) fma(__vector(double[8]), __vector(double[8]), __vector(double[8]));
pragma(mangle,"_Z3fmaDv16_dS_S_")__vector(double[16])fma(__vector(double[16]),__vector(double[16]),__vector(double[16]));

// fmax
pragma(mangle,"_Z4fmaxff")                float       fmax(         float,                float);
pragma(mangle,"_Z4fmaxDv2_fS_")  __vector(float[2])   fmax(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z4fmaxDv3_fS_")  __vector(float[3])   fmax(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z4fmaxDv4_fS_")  __vector(float[4])   fmax(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z4fmaxDv8_fS_")  __vector(float[8])   fmax(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z4fmaxDv16_fS_") __vector(float[16])  fmax(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z4fmaxDv2_ff")   __vector(float[2])   fmax(__vector(float[2]),            float);
pragma(mangle,"_Z4fmaxDv3_ff")   __vector(float[3])   fmax(__vector(float[3]),            float);
pragma(mangle,"_Z4fmaxDv4_ff")   __vector(float[4])   fmax(__vector(float[4]),            float);
pragma(mangle,"_Z4fmaxDv8_ff")   __vector(float[8])   fmax(__vector(float[8]),            float);
pragma(mangle,"_Z4fmaxDv16_ff")  __vector(float[16])  fmax(__vector(float[16]),           float);
pragma(mangle,"_Z4fmaxdd")                double      fmax(         double,               double);
pragma(mangle,"_Z4fmaxDv2_dS_")  __vector(double[2])  fmax(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z4fmaxDv3_dS_")  __vector(double[3])  fmax(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z4fmaxDv4_dS_")  __vector(double[4])  fmax(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z4fmaxDv8_dS_")  __vector(double[8])  fmax(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z4fmaxDv16_dS_") __vector(double[16]) fmax(__vector(double[16]), __vector(double[16]));
pragma(mangle,"_Z4fmaxDv2_dd")   __vector(double[2])  fmax(__vector(double[2]),           double);
pragma(mangle,"_Z4fmaxDv3_dd")   __vector(double[3])  fmax(__vector(double[3]),           double);
pragma(mangle,"_Z4fmaxDv4_dd")   __vector(double[4])  fmax(__vector(double[4]),           double);
pragma(mangle,"_Z4fmaxDv8_dd")   __vector(double[8])  fmax(__vector(double[8]),           double);
pragma(mangle,"_Z4fmaxDv16_dd")  __vector(double[16]) fmax(__vector(double[16]),          double);

// fmin
pragma(mangle,"_Z4fminff")                float       fmin(         float,                float);
pragma(mangle,"_Z4fminDv2_fS_")  __vector(float[2])   fmin(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z4fminDv3_fS_")  __vector(float[3])   fmin(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z4fminDv4_fS_")  __vector(float[4])   fmin(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z4fminDv8_fS_")  __vector(float[8])   fmin(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z4fminDv16_fS_") __vector(float[16])  fmin(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z4fminDv2_ff")   __vector(float[2])   fmin(__vector(float[2]),            float);
pragma(mangle,"_Z4fminDv3_ff")   __vector(float[3])   fmin(__vector(float[3]),            float);
pragma(mangle,"_Z4fminDv4_ff")   __vector(float[4])   fmin(__vector(float[4]),            float);
pragma(mangle,"_Z4fminDv8_ff")   __vector(float[8])   fmin(__vector(float[8]),            float);
pragma(mangle,"_Z4fminDv16_ff")  __vector(float[16])  fmin(__vector(float[16]),           float);
pragma(mangle,"_Z4fmindd")                double      fmin(         double,               double);
pragma(mangle,"_Z4fminDv2_dS_")  __vector(double[2])  fmin(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z4fminDv3_dS_")  __vector(double[3])  fmin(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z4fminDv4_dS_")  __vector(double[4])  fmin(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z4fminDv8_dS_")  __vector(double[8])  fmin(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z4fminDv16_dS_") __vector(double[16]) fmin(__vector(double[16]), __vector(double[16]));
pragma(mangle,"_Z4fminDv2_dd")   __vector(double[2])  fmin(__vector(double[2]),           double);
pragma(mangle,"_Z4fminDv3_dd")   __vector(double[3])  fmin(__vector(double[3]),           double);
pragma(mangle,"_Z4fminDv4_dd")   __vector(double[4])  fmin(__vector(double[4]),           double);
pragma(mangle,"_Z4fminDv8_dd")   __vector(double[8])  fmin(__vector(double[8]),           double);
pragma(mangle,"_Z4fminDv16_dd")  __vector(double[16]) fmin(__vector(double[16]),          double);

// fmod
pragma(mangle,"_Z4fmodff")                float       fmod(         float,                float);
pragma(mangle,"_Z4fmodDv2_fS_")  __vector(float[2])   fmod(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z4fmodDv3_fS_")  __vector(float[3])   fmod(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z4fmodDv4_fS_")  __vector(float[4])   fmod(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z4fmodDv8_fS_")  __vector(float[8])   fmod(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z4fmodDv16_fS_") __vector(float[16])  fmod(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z4fmoddd")                double      fmod(         double,               double);
pragma(mangle,"_Z4fmodDv2_dS_")  __vector(double[2])  fmod(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z4fmodDv3_dS_")  __vector(double[3])  fmod(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z4fmodDv4_dS_")  __vector(double[4])  fmod(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z4fmodDv8_dS_")  __vector(double[8])  fmod(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z4fmodDv16_dS_") __vector(double[16]) fmod(__vector(double[16]), __vector(double[16]));

// fract
pragma(mangle,"_Z5fractfPU3AS4f")
        float       fract(          float,       GenericPointer!(         float));
pragma(mangle,"_Z5fractDv2_fPU3AS4S_")
__vector(float[2])   fract(__vector(float[2]),   GenericPointer!(__vector(float[2])));
pragma(mangle,"_Z5fractDv3_fPU3AS4S_")
__vector(float[3])   fract(__vector(float[3]),   GenericPointer!(__vector(float[3])));
pragma(mangle,"_Z5fractDv4_fPU3AS4S_")
__vector(float[4])   fract(__vector(float[4]),   GenericPointer!(__vector(float[4])));
pragma(mangle,"_Z5fractDv8_fPU3AS4S_")
__vector(float[8])   fract(__vector(float[8]),   GenericPointer!(__vector(float[8])));
pragma(mangle,"_Z5fractDv16_fPU3AS4S_")
__vector(float[16])  fract(__vector(float[16]),  GenericPointer!(__vector(float[16])));
pragma(mangle,"_Z5fractdPU3AS4d")
        double      fract(          double,      GenericPointer!(         double));
pragma(mangle,"_Z5fractDv2_dPU3AS4S_")
__vector(double[2])  fract(__vector(double[2]),  GenericPointer!(__vector(double[2])));
pragma(mangle,"_Z5fractDv3_dPU3AS4S_")
__vector(double[3])  fract(__vector(double[3]),  GenericPointer!(__vector(double[3])));
pragma(mangle,"_Z5fractDv4_dPU3AS4S_")
__vector(double[4])  fract(__vector(double[4]),  GenericPointer!(__vector(double[4])));
pragma(mangle,"_Z5fractDv8_dPU3AS4S_")
__vector(double[8])  fract(__vector(double[8]),  GenericPointer!(__vector(double[8])));
pragma(mangle,"_Z5fractDv16_dPU3AS4S_")
__vector(double[16]) fract(__vector(double[16]), GenericPointer!(__vector(double[16])));
pragma(mangle,"_Z5fractfPU3AS1f")
        float       fract(          float,       GlobalPointer!(         float));
pragma(mangle,"_Z5fractDv2_fPU3AS1S_")
__vector(float[2])   fract(__vector(float[2]),   GlobalPointer!(__vector(float[2])));
pragma(mangle,"_Z5fractDv3_fPU3AS1S_")
__vector(float[3])   fract(__vector(float[3]),   GlobalPointer!(__vector(float[3])));
pragma(mangle,"_Z5fractDv4_fPU3AS1S_")
__vector(float[4])   fract(__vector(float[4]),   GlobalPointer!(__vector(float[4])));
pragma(mangle,"_Z5fractDv8_fPU3AS1S_")
__vector(float[8])   fract(__vector(float[8]),   GlobalPointer!(__vector(float[8])));
pragma(mangle,"_Z5fractDv16_fPU3AS1S_")
__vector(float[16])  fract(__vector(float[16]),  GlobalPointer!(__vector(float[16])));
pragma(mangle,"_Z5fractdPU3AS1d")
        double      fract(          double,      GlobalPointer!(         double));
pragma(mangle,"_Z5fractDv2_dPU3AS1S_")
__vector(double[2])  fract(__vector(double[2]),  GlobalPointer!(__vector(double[2])));
pragma(mangle,"_Z5fractDv3_dPU3AS1S_")
__vector(double[3])  fract(__vector(double[3]),  GlobalPointer!(__vector(double[3])));
pragma(mangle,"_Z5fractDv4_dPU3AS1S_")
__vector(double[4])  fract(__vector(double[4]),  GlobalPointer!(__vector(double[4])));
pragma(mangle,"_Z5fractDv8_dPU3AS1S_")
__vector(double[8])  fract(__vector(double[8]),  GlobalPointer!(__vector(double[8])));
pragma(mangle,"_Z5fractDv16_dPU3AS1S_")
__vector(double[16]) fract(__vector(double[16]), GlobalPointer!(__vector(double[16])));
pragma(mangle,"_Z5fractfPU3AS3f")
        float       fract(          float,       SharedPointer!(         float));
pragma(mangle,"_Z5fractDv2_fPU3AS3S_")
__vector(float[2])   fract(__vector(float[2]),   SharedPointer!(__vector(float[2])));
pragma(mangle,"_Z5fractDv3_fPU3AS3S_")
__vector(float[3])   fract(__vector(float[3]),   SharedPointer!(__vector(float[3])));
pragma(mangle,"_Z5fractDv4_fPU3AS3S_")
__vector(float[4])   fract(__vector(float[4]),   SharedPointer!(__vector(float[4])));
pragma(mangle,"_Z5fractDv8_fPU3AS3S_")
__vector(float[8])   fract(__vector(float[8]),   SharedPointer!(__vector(float[8])));
pragma(mangle,"_Z5fractDv16_fPU3AS3S_")
__vector(float[16])  fract(__vector(float[16]),  SharedPointer!(__vector(float[16])));
pragma(mangle,"_Z5fractdPU3AS3d")
        double      fract(          double,      SharedPointer!(         double));
pragma(mangle,"_Z5fractDv2_dPU3AS3S_")
__vector(double[2])  fract(__vector(double[2]),  SharedPointer!(__vector(double[2])));
pragma(mangle,"_Z5fractDv3_dPU3AS3S_")
__vector(double[3])  fract(__vector(double[3]),  SharedPointer!(__vector(double[3])));
pragma(mangle,"_Z5fractDv4_dPU3AS3S_")
__vector(double[4])  fract(__vector(double[4]),  SharedPointer!(__vector(double[4])));
pragma(mangle,"_Z5fractDv8_dPU3AS3S_")
__vector(double[8])  fract(__vector(double[8]),  SharedPointer!(__vector(double[8])));
pragma(mangle,"_Z5fractDv16_dPU3AS3S_")
__vector(double[16]) fract(__vector(double[16]), SharedPointer!(__vector(double[16])));
pragma(mangle,"_Z5fractfPf")
        float       fract(          float,       PrivatePointer!(         float));
pragma(mangle,"_Z5fractDv2_fPS_")
__vector(float[2])   fract(__vector(float[2]),   PrivatePointer!(__vector(float[2])));
pragma(mangle,"_Z5fractDv3_fPS_")
__vector(float[3])   fract(__vector(float[3]),   PrivatePointer!(__vector(float[3])));
pragma(mangle,"_Z5fractDv4_fPS_")
__vector(float[4])   fract(__vector(float[4]),   PrivatePointer!(__vector(float[4])));
pragma(mangle,"_Z5fractDv8_fPS_")
__vector(float[8])   fract(__vector(float[8]),   PrivatePointer!(__vector(float[8])));
pragma(mangle,"_Z5fractDv16_fPS_")
__vector(float[16])  fract(__vector(float[16]),  PrivatePointer!(__vector(float[16])));
pragma(mangle,"_Z5fractdPd")
        double      fract(          double,      PrivatePointer!(         double));
pragma(mangle,"_Z5fractDv2_dPS_")
__vector(double[2])  fract(__vector(double[2]),  PrivatePointer!(__vector(double[2])));
pragma(mangle,"_Z5fractDv3_dPS_")
__vector(double[3])  fract(__vector(double[3]),  PrivatePointer!(__vector(double[3])));
pragma(mangle,"_Z5fractDv4_dPS_")
__vector(double[4])  fract(__vector(double[4]),  PrivatePointer!(__vector(double[4])));
pragma(mangle,"_Z5fractDv8_dPS_")
__vector(double[8])  fract(__vector(double[8]),  PrivatePointer!(__vector(double[8])));
pragma(mangle,"_Z5fractDv16_dPS_")
__vector(double[16]) fract(__vector(double[16]), PrivatePointer!(__vector(double[16])));

// frexp
pragma(mangle,"_Z5frexpfPU3AS4i")
        float       frexp(          float,       GenericPointer!(         int));
pragma(mangle,"_Z5frexpDv2_fPU3AS4Dv2_i")
__vector(float[2])   frexp(__vector(float[2]),   GenericPointer!(__vector(int[2])));
pragma(mangle,"_Z5frexpDv3_fPU3AS4Dv3_i")
__vector(float[3])   frexp(__vector(float[3]),   GenericPointer!(__vector(int[3])));
pragma(mangle,"_Z5frexpDv4_fPU3AS4Dv4_i")
__vector(float[4])   frexp(__vector(float[4]),   GenericPointer!(__vector(int[4])));
pragma(mangle,"_Z5frexpDv8_fPU3AS4Dv8_i")
__vector(float[8])   frexp(__vector(float[8]),   GenericPointer!(__vector(int[8])));
pragma(mangle,"_Z5frexpDv16_fPU3AS4Dv16_i")
__vector(float[16])  frexp(__vector(float[16]),  GenericPointer!(__vector(int[16])));
pragma(mangle,"_Z5frexpdPU3AS4i")
        double      frexp(          double,      GenericPointer!(         int));
pragma(mangle,"_Z5frexpDv2_dPU3AS4Dv2_i")
__vector(double[2])  frexp(__vector(double[2]),  GenericPointer!(__vector(int[2])));
pragma(mangle,"_Z5frexpDv3_dPU3AS4Dv3_i")
__vector(double[3])  frexp(__vector(double[3]),  GenericPointer!(__vector(int[3])));
pragma(mangle,"_Z5frexpDv4_dPU3AS4Dv4_i")
__vector(double[4])  frexp(__vector(double[4]),  GenericPointer!(__vector(int[4])));
pragma(mangle,"_Z5frexpDv8_dPU3AS4Dv8_i")
__vector(double[8])  frexp(__vector(double[8]),  GenericPointer!(__vector(int[8])));
pragma(mangle,"_Z5frexpDv16_dPU3AS4Dv16_i")
__vector(double[16]) frexp(__vector(double[16]), GenericPointer!(__vector(int[16])));
pragma(mangle,"_Z5frexpfPU3AS1i")
        float       frexp(          float,       GlobalPointer!(         int));
pragma(mangle,"_Z5frexpDv2_fPU3AS1Dv2_i")
__vector(float[2])   frexp(__vector(float[2]),   GlobalPointer!(__vector(int[2])));
pragma(mangle,"_Z5frexpDv3_fPU3AS1Dv3_i")
__vector(float[3])   frexp(__vector(float[3]),   GlobalPointer!(__vector(int[3])));
pragma(mangle,"_Z5frexpDv4_fPU3AS1Dv4_i")
__vector(float[4])   frexp(__vector(float[4]),   GlobalPointer!(__vector(int[4])));
pragma(mangle,"_Z5frexpDv8_fPU3AS1Dv8_i")
__vector(float[8])   frexp(__vector(float[8]),   GlobalPointer!(__vector(int[8])));
pragma(mangle,"_Z5frexpDv16_fPU3AS1Dv16_i")
__vector(float[16])  frexp(__vector(float[16]),  GlobalPointer!(__vector(int[16])));
pragma(mangle,"_Z5frexpdPU3AS1i")
        double      frexp(          double,      GlobalPointer!(         int));
pragma(mangle,"_Z5frexpDv2_dPU3AS1Dv2_i")
__vector(double[2])  frexp(__vector(double[2]),  GlobalPointer!(__vector(int[2])));
pragma(mangle,"_Z5frexpDv3_dPU3AS1Dv3_i")
__vector(double[3])  frexp(__vector(double[3]),  GlobalPointer!(__vector(int[3])));
pragma(mangle,"_Z5frexpDv4_dPU3AS1Dv4_i")
__vector(double[4])  frexp(__vector(double[4]),  GlobalPointer!(__vector(int[4])));
pragma(mangle,"_Z5frexpDv8_dPU3AS1Dv8_i")
__vector(double[8])  frexp(__vector(double[8]),  GlobalPointer!(__vector(int[8])));
pragma(mangle,"_Z5frexpDv16_dPU3AS1Dv16_i")
__vector(double[16]) frexp(__vector(double[16]), GlobalPointer!(__vector(int[16])));
pragma(mangle,"_Z5frexpfPU3AS3i")
        float       frexp(          float,       SharedPointer!(         int));
pragma(mangle,"_Z5frexpDv2_fPU3AS3Dv2_i")
__vector(float[2])   frexp(__vector(float[2]),   SharedPointer!(__vector(int[2])));
pragma(mangle,"_Z5frexpDv3_fPU3AS3Dv3_i")
__vector(float[3])   frexp(__vector(float[3]),   SharedPointer!(__vector(int[3])));
pragma(mangle,"_Z5frexpDv4_fPU3AS3Dv4_i")
__vector(float[4])   frexp(__vector(float[4]),   SharedPointer!(__vector(int[4])));
pragma(mangle,"_Z5frexpDv8_fPU3AS3Dv8_i")
__vector(float[8])   frexp(__vector(float[8]),   SharedPointer!(__vector(int[8])));
pragma(mangle,"_Z5frexpDv16_fPU3AS3Dv16_i")
__vector(float[16])  frexp(__vector(float[16]),  SharedPointer!(__vector(int[16])));
pragma(mangle,"_Z5frexpdPU3AS3i")
        double      frexp(          double,      SharedPointer!(         int));
pragma(mangle,"_Z5frexpDv2_dPU3AS3Dv2_i")
__vector(double[2])  frexp(__vector(double[2]),  SharedPointer!(__vector(int[2])));
pragma(mangle,"_Z5frexpDv3_dPU3AS3Dv3_i")
__vector(double[3])  frexp(__vector(double[3]),  SharedPointer!(__vector(int[3])));
pragma(mangle,"_Z5frexpDv4_dPU3AS3Dv4_i")
__vector(double[4])  frexp(__vector(double[4]),  SharedPointer!(__vector(int[4])));
pragma(mangle,"_Z5frexpDv8_dPU3AS3Dv8_i")
__vector(double[8])  frexp(__vector(double[8]),  SharedPointer!(__vector(int[8])));
pragma(mangle,"_Z5frexpDv16_dPU3AS3Dv16_i")
__vector(double[16]) frexp(__vector(double[16]), SharedPointer!(__vector(int[16])));
pragma(mangle,"_Z5frexpfPi")
        float       frexp(          float,       PrivatePointer!(         int));
pragma(mangle,"_Z5frexpDv2_fPDv2_i")
__vector(float[2])   frexp(__vector(float[2]),   PrivatePointer!(__vector(int[2])));
pragma(mangle,"_Z5frexpDv3_fPDv3_i")
__vector(float[3])   frexp(__vector(float[3]),   PrivatePointer!(__vector(int[3])));
pragma(mangle,"_Z5frexpDv4_fPDv4_i")
__vector(float[4])   frexp(__vector(float[4]),   PrivatePointer!(__vector(int[4])));
pragma(mangle,"_Z5frexpDv8_fPDv8_i")
__vector(float[8])   frexp(__vector(float[8]),   PrivatePointer!(__vector(int[8])));
pragma(mangle,"_Z5frexpDv16_fPDv16_i")
__vector(float[16])  frexp(__vector(float[16]),  PrivatePointer!(__vector(int[16])));
pragma(mangle,"_Z5frexpdPi")
        double      frexp(          double,      PrivatePointer!(         int));
pragma(mangle,"_Z5frexpDv2_dPDv2_i")
__vector(double[2])  frexp(__vector(double[2]),  PrivatePointer!(__vector(int[2])));
pragma(mangle,"_Z5frexpDv3_dPDv3_i")
__vector(double[3])  frexp(__vector(double[3]),  PrivatePointer!(__vector(int[3])));
pragma(mangle,"_Z5frexpDv4_dPDv4_i")
__vector(double[4])  frexp(__vector(double[4]),  PrivatePointer!(__vector(int[4])));
pragma(mangle,"_Z5frexpDv8_dPDv8_i")
__vector(double[8])  frexp(__vector(double[8]),  PrivatePointer!(__vector(int[8])));
pragma(mangle,"_Z5frexpDv16_dPDv16_i")
__vector(double[16]) frexp(__vector(double[16]), PrivatePointer!(__vector(int[16])));

// hypot
pragma(mangle,"_Z5hypotff")                float       hypot(         float,                float);
pragma(mangle,"_Z5hypotDv2_fS_")  __vector(float[2])   hypot(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z5hypotDv3_fS_")  __vector(float[3])   hypot(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z5hypotDv4_fS_")  __vector(float[4])   hypot(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z5hypotDv8_fS_")  __vector(float[8])   hypot(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z5hypotDv16_fS_") __vector(float[16])  hypot(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z5hypotdd")                double      hypot(         double,               double);
pragma(mangle,"_Z5hypotDv2_dS_")  __vector(double[2])  hypot(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z5hypotDv3_dS_")  __vector(double[3])  hypot(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z5hypotDv4_dS_")  __vector(double[4])  hypot(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z5hypotDv8_dS_")  __vector(double[8])  hypot(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z5hypotDv16_dS_") __vector(double[16]) hypot(__vector(double[16]), __vector(double[16]));

// ilogb
pragma(mangle,"_Z5ilogbf")               int      ilogb(         float);
pragma(mangle,"_Z5ilogbDv2_f")  __vector(int[2])  ilogb(__vector(float[2]));
pragma(mangle,"_Z5ilogbDv3_f")  __vector(int[3])  ilogb(__vector(float[3]));
pragma(mangle,"_Z5ilogbDv4_f")  __vector(int[4])  ilogb(__vector(float[4]));
pragma(mangle,"_Z5ilogbDv8_f")  __vector(int[8])  ilogb(__vector(float[8]));
pragma(mangle,"_Z5ilogbDv16_f") __vector(int[16]) ilogb(__vector(float[16]));
pragma(mangle,"_Z5ilogbd")               int      ilogb(         double);
pragma(mangle,"_Z5ilogbDv2_d")  __vector(int[2])  ilogb(__vector(double[2]));
pragma(mangle,"_Z5ilogbDv3_d")  __vector(int[3])  ilogb(__vector(double[3]));
pragma(mangle,"_Z5ilogbDv4_d")  __vector(int[4])  ilogb(__vector(double[4]));
pragma(mangle,"_Z5ilogbDv8_d")  __vector(int[8])  ilogb(__vector(double[8]));
pragma(mangle,"_Z5ilogbDv16_d") __vector(int[16]) ilogb(__vector(double[16]));

// ldexp
pragma(mangle,"_Z5ldexpfi")                    float       ldexp(         float,                int);
pragma(mangle,"_Z5ldexpDv2_fDv2_i")   __vector(float[2])   ldexp(__vector(float[2]),   __vector(int[2]));
pragma(mangle,"_Z5ldexpDv3_fDv3_i")   __vector(float[3])   ldexp(__vector(float[3]),   __vector(int[3]));
pragma(mangle,"_Z5ldexpDv4_fDv4_i")   __vector(float[4])   ldexp(__vector(float[4]),   __vector(int[4]));
pragma(mangle,"_Z5ldexpDv8_fDv8_i")   __vector(float[8])   ldexp(__vector(float[8]),   __vector(int[8]));
pragma(mangle,"_Z5ldexpDv16_fDv16_i") __vector(float[16])  ldexp(__vector(float[16]),  __vector(int[16]));
pragma(mangle,"_Z5ldexpDv2_fi")       __vector(float[2])   ldexp(__vector(float[2]),            int);
pragma(mangle,"_Z5ldexpDv3_fi")       __vector(float[3])   ldexp(__vector(float[3]),            int);
pragma(mangle,"_Z5ldexpDv4_fi")       __vector(float[4])   ldexp(__vector(float[4]),            int);
pragma(mangle,"_Z5ldexpDv8_fi")       __vector(float[8])   ldexp(__vector(float[8]),            int);
pragma(mangle,"_Z5ldexpDv16_fi")      __vector(float[16])  ldexp(__vector(float[16]),           int);
pragma(mangle,"_Z5ldexpdi")                    double      ldexp(         double,               int);
pragma(mangle,"_Z5ldexpDv2_dDv2_i")   __vector(double[2])  ldexp(__vector(double[2]),  __vector(int[2]));
pragma(mangle,"_Z5ldexpDv3_dDv3_i")   __vector(double[3])  ldexp(__vector(double[3]),  __vector(int[3]));
pragma(mangle,"_Z5ldexpDv4_dDv4_i")   __vector(double[4])  ldexp(__vector(double[4]),  __vector(int[4]));
pragma(mangle,"_Z5ldexpDv8_dDv8_i")   __vector(double[8])  ldexp(__vector(double[8]),  __vector(int[8]));
pragma(mangle,"_Z5ldexpDv16_dDv16_i") __vector(double[16]) ldexp(__vector(double[16]), __vector(int[16]));
pragma(mangle,"_Z5ldexpDv2_di")       __vector(double[2])  ldexp(__vector(double[2]),           int);
pragma(mangle,"_Z5ldexpDv3_di")       __vector(double[3])  ldexp(__vector(double[3]),           int);
pragma(mangle,"_Z5ldexpDv4_di")       __vector(double[4])  ldexp(__vector(double[4]),           int);
pragma(mangle,"_Z5ldexpDv8_di")       __vector(double[8])  ldexp(__vector(double[8]),           int);
pragma(mangle,"_Z5ldexpDv16_di")      __vector(double[16]) ldexp(__vector(double[16]),          int);

// lgamma
pragma(mangle,"_Z6lgammaf")               float       lgamma(         float);
pragma(mangle,"_Z6lgammaDv2_f")  __vector(float[2])   lgamma(__vector(float[2]));
pragma(mangle,"_Z6lgammaDv3_f")  __vector(float[3])   lgamma(__vector(float[3]));
pragma(mangle,"_Z6lgammaDv4_f")  __vector(float[4])   lgamma(__vector(float[4]));
pragma(mangle,"_Z6lgammaDv8_f")  __vector(float[8])   lgamma(__vector(float[8]));
pragma(mangle,"_Z6lgammaDv16_f") __vector(float[16])  lgamma(__vector(float[16]));
pragma(mangle,"_Z6lgammad")               double      lgamma(         double);
pragma(mangle,"_Z6lgammaDv2_d")  __vector(double[2])  lgamma(__vector(double[2]));
pragma(mangle,"_Z6lgammaDv3_d")  __vector(double[3])  lgamma(__vector(double[3]));
pragma(mangle,"_Z6lgammaDv4_d")  __vector(double[4])  lgamma(__vector(double[4]));
pragma(mangle,"_Z6lgammaDv8_d")  __vector(double[8])  lgamma(__vector(double[8]));
pragma(mangle,"_Z6lgammaDv16_d") __vector(double[16]) lgamma(__vector(double[16]));

// lgamma_r
pragma(mangle,"_Z8lgamma_rfPU3AS4i")
        float       lgamma_r(          float,       GenericPointer!(         int));
pragma(mangle,"_Z8lgamma_rDv2_fPU3AS4Dv2_i")
__vector(float[2])   lgamma_r(__vector(float[2]),   GenericPointer!(__vector(int[2])));
pragma(mangle,"_Z8lgamma_rDv3_fPU3AS4Dv3_i")
__vector(float[3])   lgamma_r(__vector(float[3]),   GenericPointer!(__vector(int[3])));
pragma(mangle,"_Z8lgamma_rDv4_fPU3AS4Dv4_i")
__vector(float[4])   lgamma_r(__vector(float[4]),   GenericPointer!(__vector(int[4])));
pragma(mangle,"_Z8lgamma_rDv8_fPU3AS4Dv8_i")
__vector(float[8])   lgamma_r(__vector(float[8]),   GenericPointer!(__vector(int[8])));
pragma(mangle,"_Z8lgamma_rDv16_fPU3AS4Dv16_i")
__vector(float[16])  lgamma_r(__vector(float[16]),  GenericPointer!(__vector(int[16])));
pragma(mangle,"_Z8lgamma_rdPU3AS4i")
        double      lgamma_r(          double,      GenericPointer!(         int));
pragma(mangle,"_Z8lgamma_rDv2_dPU3AS4Dv2_i")
__vector(double[2])  lgamma_r(__vector(double[2]),  GenericPointer!(__vector(int[2])));
pragma(mangle,"_Z8lgamma_rDv3_dPU3AS4Dv3_i")
__vector(double[3])  lgamma_r(__vector(double[3]),  GenericPointer!(__vector(int[3])));
pragma(mangle,"_Z8lgamma_rDv4_dPU3AS4Dv4_i")
__vector(double[4])  lgamma_r(__vector(double[4]),  GenericPointer!(__vector(int[4])));
pragma(mangle,"_Z8lgamma_rDv8_dPU3AS4Dv8_i")
__vector(double[8])  lgamma_r(__vector(double[8]),  GenericPointer!(__vector(int[8])));
pragma(mangle,"_Z8lgamma_rDv16_dPU3AS4Dv16_i")
__vector(double[16]) lgamma_r(__vector(double[16]), GenericPointer!(__vector(int[16])));
pragma(mangle,"_Z8lgamma_rfPU3AS1i")
        float       lgamma_r(          float,       GlobalPointer!(         int));
pragma(mangle,"_Z8lgamma_rDv2_fPU3AS1Dv2_i")
__vector(float[2])   lgamma_r(__vector(float[2]),   GlobalPointer!(__vector(int[2])));
pragma(mangle,"_Z8lgamma_rDv3_fPU3AS1Dv3_i")
__vector(float[3])   lgamma_r(__vector(float[3]),   GlobalPointer!(__vector(int[3])));
pragma(mangle,"_Z8lgamma_rDv4_fPU3AS1Dv4_i")
__vector(float[4])   lgamma_r(__vector(float[4]),   GlobalPointer!(__vector(int[4])));
pragma(mangle,"_Z8lgamma_rDv8_fPU3AS1Dv8_i")
__vector(float[8])   lgamma_r(__vector(float[8]),   GlobalPointer!(__vector(int[8])));
pragma(mangle,"_Z8lgamma_rDv16_fPU3AS1Dv16_i")
__vector(float[16])  lgamma_r(__vector(float[16]),  GlobalPointer!(__vector(int[16])));
pragma(mangle,"_Z8lgamma_rdPU3AS1i")
        double      lgamma_r(          double,      GlobalPointer!(         int));
pragma(mangle,"_Z8lgamma_rDv2_dPU3AS1Dv2_i")
__vector(double[2])  lgamma_r(__vector(double[2]),  GlobalPointer!(__vector(int[2])));
pragma(mangle,"_Z8lgamma_rDv3_dPU3AS1Dv3_i")
__vector(double[3])  lgamma_r(__vector(double[3]),  GlobalPointer!(__vector(int[3])));
pragma(mangle,"_Z8lgamma_rDv4_dPU3AS1Dv4_i")
__vector(double[4])  lgamma_r(__vector(double[4]),  GlobalPointer!(__vector(int[4])));
pragma(mangle,"_Z8lgamma_rDv8_dPU3AS1Dv8_i")
__vector(double[8])  lgamma_r(__vector(double[8]),  GlobalPointer!(__vector(int[8])));
pragma(mangle,"_Z8lgamma_rDv16_dPU3AS1Dv16_i")
__vector(double[16]) lgamma_r(__vector(double[16]), GlobalPointer!(__vector(int[16])));
pragma(mangle,"_Z8lgamma_rfPU3AS3i")
        float       lgamma_r(          float,       SharedPointer!(         int));
pragma(mangle,"_Z8lgamma_rDv2_fPU3AS3Dv2_i")
__vector(float[2])   lgamma_r(__vector(float[2]),   SharedPointer!(__vector(int[2])));
pragma(mangle,"_Z8lgamma_rDv3_fPU3AS3Dv3_i")
__vector(float[3])   lgamma_r(__vector(float[3]),   SharedPointer!(__vector(int[3])));
pragma(mangle,"_Z8lgamma_rDv4_fPU3AS3Dv4_i")
__vector(float[4])   lgamma_r(__vector(float[4]),   SharedPointer!(__vector(int[4])));
pragma(mangle,"_Z8lgamma_rDv8_fPU3AS3Dv8_i")
__vector(float[8])   lgamma_r(__vector(float[8]),   SharedPointer!(__vector(int[8])));
pragma(mangle,"_Z8lgamma_rDv16_fPU3AS3Dv16_i")
__vector(float[16])  lgamma_r(__vector(float[16]),  SharedPointer!(__vector(int[16])));
pragma(mangle,"_Z8lgamma_rdPU3AS3i")
        double      lgamma_r(          double,      SharedPointer!(         int));
pragma(mangle,"_Z8lgamma_rDv2_dPU3AS3Dv2_i")
__vector(double[2])  lgamma_r(__vector(double[2]),  SharedPointer!(__vector(int[2])));
pragma(mangle,"_Z8lgamma_rDv3_dPU3AS3Dv3_i")
__vector(double[3])  lgamma_r(__vector(double[3]),  SharedPointer!(__vector(int[3])));
pragma(mangle,"_Z8lgamma_rDv4_dPU3AS3Dv4_i")
__vector(double[4])  lgamma_r(__vector(double[4]),  SharedPointer!(__vector(int[4])));
pragma(mangle,"_Z8lgamma_rDv8_dPU3AS3Dv8_i")
__vector(double[8])  lgamma_r(__vector(double[8]),  SharedPointer!(__vector(int[8])));
pragma(mangle,"_Z8lgamma_rDv16_dPU3AS3Dv16_i")
__vector(double[16]) lgamma_r(__vector(double[16]), SharedPointer!(__vector(int[16])));
pragma(mangle,"_Z8lgamma_rfPi")
        float       lgamma_r(          float,       PrivatePointer!(         int));
pragma(mangle,"_Z8lgamma_rDv2_fPDv2_i")
__vector(float[2])   lgamma_r(__vector(float[2]),   PrivatePointer!(__vector(int[2])));
pragma(mangle,"_Z8lgamma_rDv3_fPDv3_i")
__vector(float[3])   lgamma_r(__vector(float[3]),   PrivatePointer!(__vector(int[3])));
pragma(mangle,"_Z8lgamma_rDv4_fPDv4_i")
__vector(float[4])   lgamma_r(__vector(float[4]),   PrivatePointer!(__vector(int[4])));
pragma(mangle,"_Z8lgamma_rDv8_fPDv8_i")
__vector(float[8])   lgamma_r(__vector(float[8]),   PrivatePointer!(__vector(int[8])));
pragma(mangle,"_Z8lgamma_rDv16_fPDv16_i")
__vector(float[16])  lgamma_r(__vector(float[16]),  PrivatePointer!(__vector(int[16])));
pragma(mangle,"_Z8lgamma_rdPi")
        double      lgamma_r(          double,      PrivatePointer!(         int));
pragma(mangle,"_Z8lgamma_rDv2_dPDv2_i")
__vector(double[2])  lgamma_r(__vector(double[2]),  PrivatePointer!(__vector(int[2])));
pragma(mangle,"_Z8lgamma_rDv3_dPDv3_i")
__vector(double[3])  lgamma_r(__vector(double[3]),  PrivatePointer!(__vector(int[3])));
pragma(mangle,"_Z8lgamma_rDv4_dPDv4_i")
__vector(double[4])  lgamma_r(__vector(double[4]),  PrivatePointer!(__vector(int[4])));
pragma(mangle,"_Z8lgamma_rDv8_dPDv8_i")
__vector(double[8])  lgamma_r(__vector(double[8]),  PrivatePointer!(__vector(int[8])));
pragma(mangle,"_Z8lgamma_rDv16_dPDv16_i")
__vector(double[16]) lgamma_r(__vector(double[16]), PrivatePointer!(__vector(int[16])));

// log
pragma(mangle,"_Z3logf")               float       log(         float);
pragma(mangle,"_Z3logDv2_f")  __vector(float[2])   log(__vector(float[2]));
pragma(mangle,"_Z3logDv3_f")  __vector(float[3])   log(__vector(float[3]));
pragma(mangle,"_Z3logDv4_f")  __vector(float[4])   log(__vector(float[4]));
pragma(mangle,"_Z3logDv8_f")  __vector(float[8])   log(__vector(float[8]));
pragma(mangle,"_Z3logDv16_f") __vector(float[16])  log(__vector(float[16]));
pragma(mangle,"_Z3logd")               double      log(         double);
pragma(mangle,"_Z3logDv2_d")  __vector(double[2])  log(__vector(double[2]));
pragma(mangle,"_Z3logDv3_d")  __vector(double[3])  log(__vector(double[3]));
pragma(mangle,"_Z3logDv4_d")  __vector(double[4])  log(__vector(double[4]));
pragma(mangle,"_Z3logDv8_d")  __vector(double[8])  log(__vector(double[8]));
pragma(mangle,"_Z3logDv16_d") __vector(double[16]) log(__vector(double[16]));

// log2
pragma(mangle,"_Z4log2f")               float       log2(         float);
pragma(mangle,"_Z4log2Dv2_f")  __vector(float[2])   log2(__vector(float[2]));
pragma(mangle,"_Z4log2Dv3_f")  __vector(float[3])   log2(__vector(float[3]));
pragma(mangle,"_Z4log2Dv4_f")  __vector(float[4])   log2(__vector(float[4]));
pragma(mangle,"_Z4log2Dv8_f")  __vector(float[8])   log2(__vector(float[8]));
pragma(mangle,"_Z4log2Dv16_f") __vector(float[16])  log2(__vector(float[16]));
pragma(mangle,"_Z4log2d")               double      log2(         double);
pragma(mangle,"_Z4log2Dv2_d")  __vector(double[2])  log2(__vector(double[2]));
pragma(mangle,"_Z4log2Dv3_d")  __vector(double[3])  log2(__vector(double[3]));
pragma(mangle,"_Z4log2Dv4_d")  __vector(double[4])  log2(__vector(double[4]));
pragma(mangle,"_Z4log2Dv8_d")  __vector(double[8])  log2(__vector(double[8]));
pragma(mangle,"_Z4log2Dv16_d") __vector(double[16]) log2(__vector(double[16]));

// log10
pragma(mangle,"_Z5log10f")               float       log10(         float);
pragma(mangle,"_Z5log10Dv2_f")  __vector(float[2])   log10(__vector(float[2]));
pragma(mangle,"_Z5log10Dv3_f")  __vector(float[3])   log10(__vector(float[3]));
pragma(mangle,"_Z5log10Dv4_f")  __vector(float[4])   log10(__vector(float[4]));
pragma(mangle,"_Z5log10Dv8_f")  __vector(float[8])   log10(__vector(float[8]));
pragma(mangle,"_Z5log10Dv16_f") __vector(float[16])  log10(__vector(float[16]));
pragma(mangle,"_Z5log10d")               double      log10(         double);
pragma(mangle,"_Z5log10Dv2_d")  __vector(double[2])  log10(__vector(double[2]));
pragma(mangle,"_Z5log10Dv3_d")  __vector(double[3])  log10(__vector(double[3]));
pragma(mangle,"_Z5log10Dv4_d")  __vector(double[4])  log10(__vector(double[4]));
pragma(mangle,"_Z5log10Dv8_d")  __vector(double[8])  log10(__vector(double[8]));
pragma(mangle,"_Z5log10Dv16_d") __vector(double[16]) log10(__vector(double[16]));

// log1p
pragma(mangle,"_Z5log1pf")               float       log1p(         float);
pragma(mangle,"_Z5log1pDv2_f")  __vector(float[2])   log1p(__vector(float[2]));
pragma(mangle,"_Z5log1pDv3_f")  __vector(float[3])   log1p(__vector(float[3]));
pragma(mangle,"_Z5log1pDv4_f")  __vector(float[4])   log1p(__vector(float[4]));
pragma(mangle,"_Z5log1pDv8_f")  __vector(float[8])   log1p(__vector(float[8]));
pragma(mangle,"_Z5log1pDv16_f") __vector(float[16])  log1p(__vector(float[16]));
pragma(mangle,"_Z5log1pd")               double      log1p(         double);
pragma(mangle,"_Z5log1pDv2_d")  __vector(double[2])  log1p(__vector(double[2]));
pragma(mangle,"_Z5log1pDv3_d")  __vector(double[3])  log1p(__vector(double[3]));
pragma(mangle,"_Z5log1pDv4_d")  __vector(double[4])  log1p(__vector(double[4]));
pragma(mangle,"_Z5log1pDv8_d")  __vector(double[8])  log1p(__vector(double[8]));
pragma(mangle,"_Z5log1pDv16_d") __vector(double[16]) log1p(__vector(double[16]));

// logb
pragma(mangle,"_Z4logbf")               float       logb(         float);
pragma(mangle,"_Z4logbDv2_f")  __vector(float[2])   logb(__vector(float[2]));
pragma(mangle,"_Z4logbDv3_f")  __vector(float[3])   logb(__vector(float[3]));
pragma(mangle,"_Z4logbDv4_f")  __vector(float[4])   logb(__vector(float[4]));
pragma(mangle,"_Z4logbDv8_f")  __vector(float[8])   logb(__vector(float[8]));
pragma(mangle,"_Z4logbDv16_f") __vector(float[16])  logb(__vector(float[16]));
pragma(mangle,"_Z4logbd")               double      logb(         double);
pragma(mangle,"_Z4logbDv2_d")  __vector(double[2])  logb(__vector(double[2]));
pragma(mangle,"_Z4logbDv3_d")  __vector(double[3])  logb(__vector(double[3]));
pragma(mangle,"_Z4logbDv4_d")  __vector(double[4])  logb(__vector(double[4]));
pragma(mangle,"_Z4logbDv8_d")  __vector(double[8])  logb(__vector(double[8]));
pragma(mangle,"_Z4logbDv16_d") __vector(double[16]) logb(__vector(double[16]));

// mad
pragma(mangle,"_Z3madfff")                float      mad(         float,                float,               float);
pragma(mangle,"_Z3madDv2_fS_S_") __vector(float[2])  mad(__vector(float[2]),  __vector(float[2]),  __vector(float[2]));
pragma(mangle,"_Z3madDv3_fS_S_") __vector(float[3])  mad(__vector(float[3]),  __vector(float[3]),  __vector(float[3]));
pragma(mangle,"_Z3madDv4_fS_S_") __vector(float[4])  mad(__vector(float[4]),  __vector(float[4]),  __vector(float[4]));
pragma(mangle,"_Z3madDv8_fS_S_") __vector(float[8])  mad(__vector(float[8]),  __vector(float[8]),  __vector(float[8]));
pragma(mangle,"_Z3madDv16_fS_S_")__vector(float[16]) mad(__vector(float[16]), __vector(float[16]), __vector(float[16]));
pragma(mangle,"_Z3madddd")                double     mad(         double,              double,              double);
pragma(mangle,"_Z3madDv2_dS_S_") __vector(double[2]) mad(__vector(double[2]), __vector(double[2]), __vector(double[2]));
pragma(mangle,"_Z3madDv3_dS_S_") __vector(double[3]) mad(__vector(double[3]), __vector(double[3]), __vector(double[3]));
pragma(mangle,"_Z3madDv4_dS_S_") __vector(double[4]) mad(__vector(double[4]), __vector(double[4]), __vector(double[4]));
pragma(mangle,"_Z3madDv8_dS_S_") __vector(double[8]) mad(__vector(double[8]), __vector(double[8]), __vector(double[8]));
pragma(mangle,"_Z3madDv16_dS_S_")__vector(double[16])mad(__vector(double[16]),__vector(double[16]),__vector(double[16]));

// maxmag
pragma(mangle,"_Z6maxmagff")                float       maxmag(         float,                float);
pragma(mangle,"_Z6maxmagDv2_fS_")  __vector(float[2])   maxmag(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z6maxmagDv3_fS_")  __vector(float[3])   maxmag(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z6maxmagDv4_fS_")  __vector(float[4])   maxmag(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z6maxmagDv8_fS_")  __vector(float[8])   maxmag(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z6maxmagDv16_fS_") __vector(float[16])  maxmag(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z6maxmagdd")                double      maxmag(         double,               double);
pragma(mangle,"_Z6maxmagDv2_dS_")  __vector(double[2])  maxmag(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z6maxmagDv3_dS_")  __vector(double[3])  maxmag(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z6maxmagDv4_dS_")  __vector(double[4])  maxmag(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z6maxmagDv8_dS_")  __vector(double[8])  maxmag(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z6maxmagDv16_dS_") __vector(double[16]) maxmag(__vector(double[16]), __vector(double[16]));

// minmag
pragma(mangle,"_Z6minmagff")                float       minmag(         float,                float);
pragma(mangle,"_Z6minmagDv2_fS_")  __vector(float[2])   minmag(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z6minmagDv3_fS_")  __vector(float[3])   minmag(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z6minmagDv4_fS_")  __vector(float[4])   minmag(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z6minmagDv8_fS_")  __vector(float[8])   minmag(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z6minmagDv16_fS_") __vector(float[16])  minmag(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z6minmagdd")                double      minmag(         double,               double);
pragma(mangle,"_Z6minmagDv2_dS_")  __vector(double[2])  minmag(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z6minmagDv3_dS_")  __vector(double[3])  minmag(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z6minmagDv4_dS_")  __vector(double[4])  minmag(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z6minmagDv8_dS_")  __vector(double[8])  minmag(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z6minmagDv16_dS_") __vector(double[16]) minmag(__vector(double[16]), __vector(double[16]));

// modf
pragma(mangle,"_Z4modffPU3AS4f")               float      modf(         float,      GenericPointer!(         float));
pragma(mangle,"_Z4modfDv2_fPU3AS4S_") __vector(float[2])  modf(__vector(float[2]),  GenericPointer!(__vector(float[2])));
pragma(mangle,"_Z4modfDv3_fPU3AS4S_") __vector(float[3])  modf(__vector(float[3]),  GenericPointer!(__vector(float[3])));
pragma(mangle,"_Z4modfDv4_fPU3AS4S_") __vector(float[4])  modf(__vector(float[4]),  GenericPointer!(__vector(float[4])));
pragma(mangle,"_Z4modfDv8_fPU3AS4S_") __vector(float[8])  modf(__vector(float[8]),  GenericPointer!(__vector(float[8])));
pragma(mangle,"_Z4modfDv16_fPU3AS4S_")__vector(float[16]) modf(__vector(float[16]), GenericPointer!(__vector(float[16])));
pragma(mangle,"_Z4modfdPU3AS4d")               double     modf(         double,     GenericPointer!(         double));
pragma(mangle,"_Z4modfDv2_dPU3AS4S_") __vector(double[2]) modf(__vector(double[2]), GenericPointer!(__vector(double[2])));
pragma(mangle,"_Z4modfDv3_dPU3AS4S_") __vector(double[3]) modf(__vector(double[3]), GenericPointer!(__vector(double[3])));
pragma(mangle,"_Z4modfDv4_dPU3AS4S_") __vector(double[4]) modf(__vector(double[4]), GenericPointer!(__vector(double[4])));
pragma(mangle,"_Z4modfDv8_dPU3AS4S_") __vector(double[8]) modf(__vector(double[8]), GenericPointer!(__vector(double[8])));
pragma(mangle,"_Z4modfDv16_dPU3AS4S_")__vector(double[16])modf(__vector(double[16]),GenericPointer!(__vector(double[16])));
pragma(mangle,"_Z4modffPU3AS1f")               float      modf(         float,      GlobalPointer!(         float));
pragma(mangle,"_Z4modfDv2_fPU3AS1S_") __vector(float[2])  modf(__vector(float[2]),  GlobalPointer!(__vector(float[2])));
pragma(mangle,"_Z4modfDv3_fPU3AS1S_") __vector(float[3])  modf(__vector(float[3]),  GlobalPointer!(__vector(float[3])));
pragma(mangle,"_Z4modfDv4_fPU3AS1S_") __vector(float[4])  modf(__vector(float[4]),  GlobalPointer!(__vector(float[4])));
pragma(mangle,"_Z4modfDv8_fPU3AS1S_") __vector(float[8])  modf(__vector(float[8]),  GlobalPointer!(__vector(float[8])));
pragma(mangle,"_Z4modfDv16_fPU3AS1S_")__vector(float[16]) modf(__vector(float[16]), GlobalPointer!(__vector(float[16])));
pragma(mangle,"_Z4modfdPU3AS1d")               double     modf(         double,     GlobalPointer!(         double));
pragma(mangle,"_Z4modfDv2_dPU3AS1S_") __vector(double[2]) modf(__vector(double[2]), GlobalPointer!(__vector(double[2])));
pragma(mangle,"_Z4modfDv3_dPU3AS1S_") __vector(double[3]) modf(__vector(double[3]), GlobalPointer!(__vector(double[3])));
pragma(mangle,"_Z4modfDv4_dPU3AS1S_") __vector(double[4]) modf(__vector(double[4]), GlobalPointer!(__vector(double[4])));
pragma(mangle,"_Z4modfDv8_dPU3AS1S_") __vector(double[8]) modf(__vector(double[8]), GlobalPointer!(__vector(double[8])));
pragma(mangle,"_Z4modfDv16_dPU3AS1S_")__vector(double[16])modf(__vector(double[16]),GlobalPointer!(__vector(double[16])));
pragma(mangle,"_Z4modffPU3AS3f")               float      modf(         float,      SharedPointer!(         float));
pragma(mangle,"_Z4modfDv2_fPU3AS3S_") __vector(float[2])  modf(__vector(float[2]),  SharedPointer!(__vector(float[2])));
pragma(mangle,"_Z4modfDv3_fPU3AS3S_") __vector(float[3])  modf(__vector(float[3]),  SharedPointer!(__vector(float[3])));
pragma(mangle,"_Z4modfDv4_fPU3AS3S_") __vector(float[4])  modf(__vector(float[4]),  SharedPointer!(__vector(float[4])));
pragma(mangle,"_Z4modfDv8_fPU3AS3S_") __vector(float[8])  modf(__vector(float[8]),  SharedPointer!(__vector(float[8])));
pragma(mangle,"_Z4modfDv16_fPU3AS3S_")__vector(float[16]) modf(__vector(float[16]), SharedPointer!(__vector(float[16])));
pragma(mangle,"_Z4modfdPU3AS3d")               double     modf(         double,     SharedPointer!(         double));
pragma(mangle,"_Z4modfDv2_dPU3AS3S_") __vector(double[2]) modf(__vector(double[2]), SharedPointer!(__vector(double[2])));
pragma(mangle,"_Z4modfDv3_dPU3AS3S_") __vector(double[3]) modf(__vector(double[3]), SharedPointer!(__vector(double[3])));
pragma(mangle,"_Z4modfDv4_dPU3AS3S_") __vector(double[4]) modf(__vector(double[4]), SharedPointer!(__vector(double[4])));
pragma(mangle,"_Z4modfDv8_dPU3AS3S_") __vector(double[8]) modf(__vector(double[8]), SharedPointer!(__vector(double[8])));
pragma(mangle,"_Z4modfDv16_dPU3AS3S_")__vector(double[16])modf(__vector(double[16]),SharedPointer!(__vector(double[16])));
pragma(mangle,"_Z4modffPf")                    float      modf(         float,      PrivatePointer!(         float));
pragma(mangle,"_Z4modfDv2_fPS_")      __vector(float[2])  modf(__vector(float[2]),  PrivatePointer!(__vector(float[2])));
pragma(mangle,"_Z4modfDv3_fPS_")      __vector(float[3])  modf(__vector(float[3]),  PrivatePointer!(__vector(float[3])));
pragma(mangle,"_Z4modfDv4_fPS_")      __vector(float[4])  modf(__vector(float[4]),  PrivatePointer!(__vector(float[4])));
pragma(mangle,"_Z4modfDv8_fPS_")      __vector(float[8])  modf(__vector(float[8]),  PrivatePointer!(__vector(float[8])));
pragma(mangle,"_Z4modfDv16_fPS_")     __vector(float[16]) modf(__vector(float[16]), PrivatePointer!(__vector(float[16])));
pragma(mangle,"_Z4modfdPd")                    double     modf(         double,     PrivatePointer!(         double));
pragma(mangle,"_Z4modfDv2_dPS_")      __vector(double[2]) modf(__vector(double[2]), PrivatePointer!(__vector(double[2])));
pragma(mangle,"_Z4modfDv3_dPS_")      __vector(double[3]) modf(__vector(double[3]), PrivatePointer!(__vector(double[3])));
pragma(mangle,"_Z4modfDv4_dPS_")      __vector(double[4]) modf(__vector(double[4]), PrivatePointer!(__vector(double[4])));
pragma(mangle,"_Z4modfDv8_dPS_")      __vector(double[8]) modf(__vector(double[8]), PrivatePointer!(__vector(double[8])));
pragma(mangle,"_Z4modfDv16_dPS_")     __vector(double[16])modf(__vector(double[16]),PrivatePointer!(__vector(double[16])));

// nan
pragma(mangle,"_Z3nanj")               float       nan(         uint);
pragma(mangle,"_Z3nanDv2_j")  __vector(float[2])   nan(__vector(uint[2]));
pragma(mangle,"_Z3nanDv3_j")  __vector(float[3])   nan(__vector(uint[3]));
pragma(mangle,"_Z3nanDv4_j")  __vector(float[4])   nan(__vector(uint[4]));
pragma(mangle,"_Z3nanDv8_j")  __vector(float[8])   nan(__vector(uint[8]));
pragma(mangle,"_Z3nanDv16_j") __vector(float[16])  nan(__vector(uint[16]));
pragma(mangle,"_Z3nanm")               double      nan(         ulong);
pragma(mangle,"_Z3nanDv2_m")  __vector(double[2])  nan(__vector(ulong[2]));
pragma(mangle,"_Z3nanDv3_m")  __vector(double[3])  nan(__vector(ulong[3]));
pragma(mangle,"_Z3nanDv4_m")  __vector(double[4])  nan(__vector(ulong[4]));
pragma(mangle,"_Z3nanDv8_m")  __vector(double[8])  nan(__vector(ulong[8]));
pragma(mangle,"_Z3nanDv16_m") __vector(double[16]) nan(__vector(ulong[16]));

// nextafter
pragma(mangle,"_Z9nextafterff")                float       nextafter(         float,                float);
pragma(mangle,"_Z9nextafterDv2_fS_")  __vector(float[2])   nextafter(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z9nextafterDv3_fS_")  __vector(float[3])   nextafter(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z9nextafterDv4_fS_")  __vector(float[4])   nextafter(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z9nextafterDv8_fS_")  __vector(float[8])   nextafter(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z9nextafterDv16_fS_") __vector(float[16])  nextafter(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z9nextafterdd")                double      nextafter(         double,               double);
pragma(mangle,"_Z9nextafterDv2_dS_")  __vector(double[2])  nextafter(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z9nextafterDv3_dS_")  __vector(double[3])  nextafter(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z9nextafterDv4_dS_")  __vector(double[4])  nextafter(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z9nextafterDv8_dS_")  __vector(double[8])  nextafter(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z9nextafterDv16_dS_") __vector(double[16]) nextafter(__vector(double[16]), __vector(double[16]));

// pow
pragma(mangle,"_Z3powff")                float       pow(         float,                float);
pragma(mangle,"_Z3powDv2_fS_")  __vector(float[2])   pow(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z3powDv3_fS_")  __vector(float[3])   pow(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z3powDv4_fS_")  __vector(float[4])   pow(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z3powDv8_fS_")  __vector(float[8])   pow(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z3powDv16_fS_") __vector(float[16])  pow(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z3powdd")                double      pow(         double,               double);
pragma(mangle,"_Z3powDv2_dS_")  __vector(double[2])  pow(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z3powDv3_dS_")  __vector(double[3])  pow(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z3powDv4_dS_")  __vector(double[4])  pow(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z3powDv8_dS_")  __vector(double[8])  pow(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z3powDv16_dS_") __vector(double[16]) pow(__vector(double[16]), __vector(double[16]));

// pown
pragma(mangle,"_Z4pownfi")                    float       pown(         float,                int);
pragma(mangle,"_Z4pownDv2_fDv2_i")   __vector(float[2])   pown(__vector(float[2]),   __vector(int[2]));
pragma(mangle,"_Z4pownDv3_fDv3_i")   __vector(float[3])   pown(__vector(float[3]),   __vector(int[3]));
pragma(mangle,"_Z4pownDv4_fDv4_i")   __vector(float[4])   pown(__vector(float[4]),   __vector(int[4]));
pragma(mangle,"_Z4pownDv8_fDv8_i")   __vector(float[8])   pown(__vector(float[8]),   __vector(int[8]));
pragma(mangle,"_Z4pownDv16_fDv16_i") __vector(float[16])  pown(__vector(float[16]),  __vector(int[16]));
pragma(mangle,"_Z4powndi")                    double      pown(         double,               int);
pragma(mangle,"_Z4pownDv2_dDv2_i")   __vector(double[2])  pown(__vector(double[2]),  __vector(int[2]));
pragma(mangle,"_Z4pownDv3_dDv3_i")   __vector(double[3])  pown(__vector(double[3]),  __vector(int[3]));
pragma(mangle,"_Z4pownDv4_dDv4_i")   __vector(double[4])  pown(__vector(double[4]),  __vector(int[4]));
pragma(mangle,"_Z4pownDv8_dDv8_i")   __vector(double[8])  pown(__vector(double[8]),  __vector(int[8]));
pragma(mangle,"_Z4pownDv16_dDv16_i") __vector(double[16]) pown(__vector(double[16]), __vector(int[16]));

// powr
pragma(mangle,"_Z4powrff")                float       powr(         float,                float);
pragma(mangle,"_Z4powrDv2_fS_")  __vector(float[2])   powr(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z4powrDv3_fS_")  __vector(float[3])   powr(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z4powrDv4_fS_")  __vector(float[4])   powr(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z4powrDv8_fS_")  __vector(float[8])   powr(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z4powrDv16_fS_") __vector(float[16])  powr(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z4powrdd")                double      powr(         double,               double);
pragma(mangle,"_Z4powrDv2_dS_")  __vector(double[2])  powr(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z4powrDv3_dS_")  __vector(double[3])  powr(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z4powrDv4_dS_")  __vector(double[4])  powr(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z4powrDv8_dS_")  __vector(double[8])  powr(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z4powrDv16_dS_") __vector(double[16]) powr(__vector(double[16]), __vector(double[16]));

// remainder
pragma(mangle,"_Z9remainderff")                float       remainder(         float,                float);
pragma(mangle,"_Z9remainderDv2_fS_")  __vector(float[2])   remainder(__vector(float[2]),   __vector(float[2]));
pragma(mangle,"_Z9remainderDv3_fS_")  __vector(float[3])   remainder(__vector(float[3]),   __vector(float[3]));
pragma(mangle,"_Z9remainderDv4_fS_")  __vector(float[4])   remainder(__vector(float[4]),   __vector(float[4]));
pragma(mangle,"_Z9remainderDv8_fS_")  __vector(float[8])   remainder(__vector(float[8]),   __vector(float[8]));
pragma(mangle,"_Z9remainderDv16_fS_") __vector(float[16])  remainder(__vector(float[16]),  __vector(float[16]));
pragma(mangle,"_Z9remainderdd")                double      remainder(         double,               double);
pragma(mangle,"_Z9remainderDv2_dS_")  __vector(double[2])  remainder(__vector(double[2]),  __vector(double[2]));
pragma(mangle,"_Z9remainderDv3_dS_")  __vector(double[3])  remainder(__vector(double[3]),  __vector(double[3]));
pragma(mangle,"_Z9remainderDv4_dS_")  __vector(double[4])  remainder(__vector(double[4]),  __vector(double[4]));
pragma(mangle,"_Z9remainderDv8_dS_")  __vector(double[8])  remainder(__vector(double[8]),  __vector(double[8]));
pragma(mangle,"_Z9remainderDv16_dS_") __vector(double[16]) remainder(__vector(double[16]), __vector(double[16]));

// remquo
pragma(mangle,"_Z6remquoffPU3AS4i")
        float       remquo(          float,                float,       GenericPointer!(         int));
pragma(mangle,"_Z6remquoDv2_fS_PU3AS4Dv2_i")
__vector(float[2])   remquo(__vector(float[2]),   __vector(float[2]),   GenericPointer!(__vector(int[2])));
pragma(mangle,"_Z6remquoDv3_fS_PU3AS4Dv3_i")
__vector(float[3])   remquo(__vector(float[3]),   __vector(float[3]),   GenericPointer!(__vector(int[3])));
pragma(mangle,"_Z6remquoDv4_fS_PU3AS4Dv4_i")
__vector(float[4])   remquo(__vector(float[4]),   __vector(float[4]),   GenericPointer!(__vector(int[4])));
pragma(mangle,"_Z6remquoDv8_fS_PU3AS4Dv8_i")
__vector(float[8])   remquo(__vector(float[8]),   __vector(float[8]),   GenericPointer!(__vector(int[8])));
pragma(mangle,"_Z6remquoDv16_fS_PU3AS4Dv16_i")
__vector(float[16])  remquo(__vector(float[16]),  __vector(float[16]),  GenericPointer!(__vector(int[16])));
pragma(mangle,"_Z6remquoddPU3AS4i")
        double      remquo(          double,               double,      GenericPointer!(         int));
pragma(mangle,"_Z6remquoDv2_dS_PU3AS4Dv2_i")
__vector(double[2])  remquo(__vector(double[2]),  __vector(double[2]),  GenericPointer!(__vector(int[2])));
pragma(mangle,"_Z6remquoDv3_dS_PU3AS4Dv3_i")
__vector(double[3])  remquo(__vector(double[3]),  __vector(double[3]),  GenericPointer!(__vector(int[3])));
pragma(mangle,"_Z6remquoDv4_dS_PU3AS4Dv4_i")
__vector(double[4])  remquo(__vector(double[4]),  __vector(double[4]),  GenericPointer!(__vector(int[4])));
pragma(mangle,"_Z6remquoDv8_dS_PU3AS4Dv8_i")
__vector(double[8])  remquo(__vector(double[8]),  __vector(double[8]),  GenericPointer!(__vector(int[8])));
pragma(mangle,"_Z6remquoDv16_dS_PU3AS4Dv16_i")
__vector(double[16]) remquo(__vector(double[16]), __vector(double[16]), GenericPointer!(__vector(int[16])));
pragma(mangle,"_Z6remquoffPU3AS1i")
        float       remquo(          float,                float,       GlobalPointer!(         int));
pragma(mangle,"_Z6remquoDv2_fS_PU3AS1Dv2_i")
__vector(float[2])   remquo(__vector(float[2]),   __vector(float[2]),   GlobalPointer!(__vector(int[2])));
pragma(mangle,"_Z6remquoDv3_fS_PU3AS1Dv3_i")
__vector(float[3])   remquo(__vector(float[3]),   __vector(float[3]),   GlobalPointer!(__vector(int[3])));
pragma(mangle,"_Z6remquoDv4_fS_PU3AS1Dv4_i")
__vector(float[4])   remquo(__vector(float[4]),   __vector(float[4]),   GlobalPointer!(__vector(int[4])));
pragma(mangle,"_Z6remquoDv8_fS_PU3AS1Dv8_i")
__vector(float[8])   remquo(__vector(float[8]),   __vector(float[8]),   GlobalPointer!(__vector(int[8])));
pragma(mangle,"_Z6remquoDv16_fS_PU3AS1Dv16_i")
__vector(float[16])  remquo(__vector(float[16]),  __vector(float[16]),  GlobalPointer!(__vector(int[16])));
pragma(mangle,"_Z6remquoddPU3AS1i")
        double      remquo(          double,               double,      GlobalPointer!(         int));
pragma(mangle,"_Z6remquoDv2_dS_PU3AS1Dv2_i")
__vector(double[2])  remquo(__vector(double[2]),  __vector(double[2]),  GlobalPointer!(__vector(int[2])));
pragma(mangle,"_Z6remquoDv3_dS_PU3AS1Dv3_i")
__vector(double[3])  remquo(__vector(double[3]),  __vector(double[3]),  GlobalPointer!(__vector(int[3])));
pragma(mangle,"_Z6remquoDv4_dS_PU3AS1Dv4_i")
__vector(double[4])  remquo(__vector(double[4]),  __vector(double[4]),  GlobalPointer!(__vector(int[4])));
pragma(mangle,"_Z6remquoDv8_dS_PU3AS1Dv8_i")
__vector(double[8])  remquo(__vector(double[8]),  __vector(double[8]),  GlobalPointer!(__vector(int[8])));
pragma(mangle,"_Z6remquoDv16_dS_PU3AS1Dv16_i")
__vector(double[16]) remquo(__vector(double[16]), __vector(double[16]), GlobalPointer!(__vector(int[16])));
pragma(mangle,"_Z6remquoffPU3AS3i")
        float       remquo(          float,                float,       SharedPointer!(         int));
pragma(mangle,"_Z6remquoDv2_fS_PU3AS3Dv2_i")
__vector(float[2])   remquo(__vector(float[2]),   __vector(float[2]),   SharedPointer!(__vector(int[2])));
pragma(mangle,"_Z6remquoDv3_fS_PU3AS3Dv3_i")
__vector(float[3])   remquo(__vector(float[3]),   __vector(float[3]),   SharedPointer!(__vector(int[3])));
pragma(mangle,"_Z6remquoDv4_fS_PU3AS3Dv4_i")
__vector(float[4])   remquo(__vector(float[4]),   __vector(float[4]),   SharedPointer!(__vector(int[4])));
pragma(mangle,"_Z6remquoDv8_fS_PU3AS3Dv8_i")
__vector(float[8])   remquo(__vector(float[8]),   __vector(float[8]),   SharedPointer!(__vector(int[8])));
pragma(mangle,"_Z6remquoDv16_fS_PU3AS3Dv16_i")
__vector(float[16])  remquo(__vector(float[16]),  __vector(float[16]),  SharedPointer!(__vector(int[16])));
pragma(mangle,"_Z6remquoddPU3AS3i")
        double      remquo(          double,               double,      SharedPointer!(         int));
pragma(mangle,"_Z6remquoDv2_dS_PU3AS3Dv2_i")
__vector(double[2])  remquo(__vector(double[2]),  __vector(double[2]),  SharedPointer!(__vector(int[2])));
pragma(mangle,"_Z6remquoDv3_dS_PU3AS3Dv3_i")
__vector(double[3])  remquo(__vector(double[3]),  __vector(double[3]),  SharedPointer!(__vector(int[3])));
pragma(mangle,"_Z6remquoDv4_dS_PU3AS3Dv4_i")
__vector(double[4])  remquo(__vector(double[4]),  __vector(double[4]),  SharedPointer!(__vector(int[4])));
pragma(mangle,"_Z6remquoDv8_dS_PU3AS3Dv8_i")
__vector(double[8])  remquo(__vector(double[8]),  __vector(double[8]),  SharedPointer!(__vector(int[8])));
pragma(mangle,"_Z6remquoDv16_dS_PU3AS3Dv16_i")
__vector(double[16]) remquo(__vector(double[16]), __vector(double[16]), SharedPointer!(__vector(int[16])));
pragma(mangle,"_Z6remquoffPi")
        float       remquo(          float,                float,       PrivatePointer!(         int));
pragma(mangle,"_Z6remquoDv2_fS_PDv2_i")
__vector(float[2])   remquo(__vector(float[2]),   __vector(float[2]),   PrivatePointer!(__vector(int[2])));
pragma(mangle,"_Z6remquoDv3_fS_PDv3_i")
__vector(float[3])   remquo(__vector(float[3]),   __vector(float[3]),   PrivatePointer!(__vector(int[3])));
pragma(mangle,"_Z6remquoDv4_fS_PDv4_i")
__vector(float[4])   remquo(__vector(float[4]),   __vector(float[4]),   PrivatePointer!(__vector(int[4])));
pragma(mangle,"_Z6remquoDv8_fS_PDv8_i")
__vector(float[8])   remquo(__vector(float[8]),   __vector(float[8]),   PrivatePointer!(__vector(int[8])));
pragma(mangle,"_Z6remquoDv16_fS_PDv16_i")
__vector(float[16])  remquo(__vector(float[16]),  __vector(float[16]),  PrivatePointer!(__vector(int[16])));
pragma(mangle,"_Z6remquoddPi")
        double      remquo(          double,               double,      PrivatePointer!(         int));
pragma(mangle,"_Z6remquoDv2_dS_PDv2_i")
__vector(double[2])  remquo(__vector(double[2]),  __vector(double[2]),  PrivatePointer!(__vector(int[2])));
pragma(mangle,"_Z6remquoDv3_dS_PDv3_i")
__vector(double[3])  remquo(__vector(double[3]),  __vector(double[3]),  PrivatePointer!(__vector(int[3])));
pragma(mangle,"_Z6remquoDv4_dS_PDv4_i")
__vector(double[4])  remquo(__vector(double[4]),  __vector(double[4]),  PrivatePointer!(__vector(int[4])));
pragma(mangle,"_Z6remquoDv8_dS_PDv8_i")
__vector(double[8])  remquo(__vector(double[8]),  __vector(double[8]),  PrivatePointer!(__vector(int[8])));
pragma(mangle,"_Z6remquoDv16_dS_PDv16_i")
__vector(double[16]) remquo(__vector(double[16]), __vector(double[16]), PrivatePointer!(__vector(int[16])));

// rint
pragma(mangle,"_Z4rintf")               float       rint(         float);
pragma(mangle,"_Z4rintDv2_f")  __vector(float[2])   rint(__vector(float[2]));
pragma(mangle,"_Z4rintDv3_f")  __vector(float[3])   rint(__vector(float[3]));
pragma(mangle,"_Z4rintDv4_f")  __vector(float[4])   rint(__vector(float[4]));
pragma(mangle,"_Z4rintDv8_f")  __vector(float[8])   rint(__vector(float[8]));
pragma(mangle,"_Z4rintDv16_f") __vector(float[16])  rint(__vector(float[16]));
pragma(mangle,"_Z4rintd")               double      rint(         double);
pragma(mangle,"_Z4rintDv2_d")  __vector(double[2])  rint(__vector(double[2]));
pragma(mangle,"_Z4rintDv3_d")  __vector(double[3])  rint(__vector(double[3]));
pragma(mangle,"_Z4rintDv4_d")  __vector(double[4])  rint(__vector(double[4]));
pragma(mangle,"_Z4rintDv8_d")  __vector(double[8])  rint(__vector(double[8]));
pragma(mangle,"_Z4rintDv16_d") __vector(double[16]) rint(__vector(double[16]));

// rootn
pragma(mangle,"_Z5rootnfi")                    float       rootn(         float,                int);
pragma(mangle,"_Z5rootnDv2_fDv2_i")   __vector(float[2])   rootn(__vector(float[2]),   __vector(int[2]));
pragma(mangle,"_Z5rootnDv3_fDv3_i")   __vector(float[3])   rootn(__vector(float[3]),   __vector(int[3]));
pragma(mangle,"_Z5rootnDv4_fDv4_i")   __vector(float[4])   rootn(__vector(float[4]),   __vector(int[4]));
pragma(mangle,"_Z5rootnDv8_fDv8_i")   __vector(float[8])   rootn(__vector(float[8]),   __vector(int[8]));
pragma(mangle,"_Z5rootnDv16_fDv16_i") __vector(float[16])  rootn(__vector(float[16]),  __vector(int[16]));
pragma(mangle,"_Z5rootndi")                    double      rootn(         double,               int);
pragma(mangle,"_Z5rootnDv2_dDv2_i")   __vector(double[2])  rootn(__vector(double[2]),  __vector(int[2]));
pragma(mangle,"_Z5rootnDv3_dDv3_i")   __vector(double[3])  rootn(__vector(double[3]),  __vector(int[3]));
pragma(mangle,"_Z5rootnDv4_dDv4_i")   __vector(double[4])  rootn(__vector(double[4]),  __vector(int[4]));
pragma(mangle,"_Z5rootnDv8_dDv8_i")   __vector(double[8])  rootn(__vector(double[8]),  __vector(int[8]));
pragma(mangle,"_Z5rootnDv16_dDv16_i") __vector(double[16]) rootn(__vector(double[16]), __vector(int[16]));

// round
pragma(mangle,"_Z5roundf")               float       round(         float);
pragma(mangle,"_Z5roundDv2_f")  __vector(float[2])   round(__vector(float[2]));
pragma(mangle,"_Z5roundDv3_f")  __vector(float[3])   round(__vector(float[3]));
pragma(mangle,"_Z5roundDv4_f")  __vector(float[4])   round(__vector(float[4]));
pragma(mangle,"_Z5roundDv8_f")  __vector(float[8])   round(__vector(float[8]));
pragma(mangle,"_Z5roundDv16_f") __vector(float[16])  round(__vector(float[16]));
pragma(mangle,"_Z5roundd")               double      round(         double);
pragma(mangle,"_Z5roundDv2_d")  __vector(double[2])  round(__vector(double[2]));
pragma(mangle,"_Z5roundDv3_d")  __vector(double[3])  round(__vector(double[3]));
pragma(mangle,"_Z5roundDv4_d")  __vector(double[4])  round(__vector(double[4]));
pragma(mangle,"_Z5roundDv8_d")  __vector(double[8])  round(__vector(double[8]));
pragma(mangle,"_Z5roundDv16_d") __vector(double[16]) round(__vector(double[16]));

// rsqrt
pragma(mangle,"_Z5rsqrtf")               float       rsqrt(         float);
pragma(mangle,"_Z5rsqrtDv2_f")  __vector(float[2])   rsqrt(__vector(float[2]));
pragma(mangle,"_Z5rsqrtDv3_f")  __vector(float[3])   rsqrt(__vector(float[3]));
pragma(mangle,"_Z5rsqrtDv4_f")  __vector(float[4])   rsqrt(__vector(float[4]));
pragma(mangle,"_Z5rsqrtDv8_f")  __vector(float[8])   rsqrt(__vector(float[8]));
pragma(mangle,"_Z5rsqrtDv16_f") __vector(float[16])  rsqrt(__vector(float[16]));
pragma(mangle,"_Z5rsqrtd")               double      rsqrt(         double);
pragma(mangle,"_Z5rsqrtDv2_d")  __vector(double[2])  rsqrt(__vector(double[2]));
pragma(mangle,"_Z5rsqrtDv3_d")  __vector(double[3])  rsqrt(__vector(double[3]));
pragma(mangle,"_Z5rsqrtDv4_d")  __vector(double[4])  rsqrt(__vector(double[4]));
pragma(mangle,"_Z5rsqrtDv8_d")  __vector(double[8])  rsqrt(__vector(double[8]));
pragma(mangle,"_Z5rsqrtDv16_d") __vector(double[16]) rsqrt(__vector(double[16]));

// sin
pragma(mangle,"_Z3sinf")               float       sin(         float);
pragma(mangle,"_Z3sinDv2_f")  __vector(float[2])   sin(__vector(float[2]));
pragma(mangle,"_Z3sinDv3_f")  __vector(float[3])   sin(__vector(float[3]));
pragma(mangle,"_Z3sinDv4_f")  __vector(float[4])   sin(__vector(float[4]));
pragma(mangle,"_Z3sinDv8_f")  __vector(float[8])   sin(__vector(float[8]));
pragma(mangle,"_Z3sinDv16_f") __vector(float[16])  sin(__vector(float[16]));
pragma(mangle,"_Z3sind")               double      sin(         double);
pragma(mangle,"_Z3sinDv2_d")  __vector(double[2])  sin(__vector(double[2]));
pragma(mangle,"_Z3sinDv3_d")  __vector(double[3])  sin(__vector(double[3]));
pragma(mangle,"_Z3sinDv4_d")  __vector(double[4])  sin(__vector(double[4]));
pragma(mangle,"_Z3sinDv8_d")  __vector(double[8])  sin(__vector(double[8]));
pragma(mangle,"_Z3sinDv16_d") __vector(double[16]) sin(__vector(double[16]));

// sincos
pragma(mangle,"_Z6sincosfPU3AS4f")
        float       sincos(          float,       GenericPointer!(         float));
pragma(mangle,"_Z6sincosDv2_fPU3AS4S_")
__vector(float[2])   sincos(__vector(float[2]),   GenericPointer!(__vector(float[2])));
pragma(mangle,"_Z6sincosDv3_fPU3AS4S_")
__vector(float[3])   sincos(__vector(float[3]),   GenericPointer!(__vector(float[3])));
pragma(mangle,"_Z6sincosDv4_fPU3AS4S_")
__vector(float[4])   sincos(__vector(float[4]),   GenericPointer!(__vector(float[4])));
pragma(mangle,"_Z6sincosDv8_fPU3AS4S_")
__vector(float[8])   sincos(__vector(float[8]),   GenericPointer!(__vector(float[8])));
pragma(mangle,"_Z6sincosDv16_fPU3AS4S_")
__vector(float[16])  sincos(__vector(float[16]),  GenericPointer!(__vector(float[16])));
pragma(mangle,"_Z6sincosdPU3AS4d")
        double      sincos(          double,      GenericPointer!(         double));
pragma(mangle,"_Z6sincosDv2_dPU3AS4S_")
__vector(double[2])  sincos(__vector(double[2]),  GenericPointer!(__vector(double[2])));
pragma(mangle,"_Z6sincosDv3_dPU3AS4S_")
__vector(double[3])  sincos(__vector(double[3]),  GenericPointer!(__vector(double[3])));
pragma(mangle,"_Z6sincosDv4_dPU3AS4S_")
__vector(double[4])  sincos(__vector(double[4]),  GenericPointer!(__vector(double[4])));
pragma(mangle,"_Z6sincosDv8_dPU3AS4S_")
__vector(double[8])  sincos(__vector(double[8]),  GenericPointer!(__vector(double[8])));
pragma(mangle,"_Z6sincosDv16_dPU3AS4S_")
__vector(double[16]) sincos(__vector(double[16]), GenericPointer!(__vector(double[16])));
pragma(mangle,"_Z6sincosfPU3AS1f")
        float       sincos(          float,       GlobalPointer!(         float));
pragma(mangle,"_Z6sincosDv2_fPU3AS1S_")
__vector(float[2])   sincos(__vector(float[2]),   GlobalPointer!(__vector(float[2])));
pragma(mangle,"_Z6sincosDv3_fPU3AS1S_")
__vector(float[3])   sincos(__vector(float[3]),   GlobalPointer!(__vector(float[3])));
pragma(mangle,"_Z6sincosDv4_fPU3AS1S_")
__vector(float[4])   sincos(__vector(float[4]),   GlobalPointer!(__vector(float[4])));
pragma(mangle,"_Z6sincosDv8_fPU3AS1S_")
__vector(float[8])   sincos(__vector(float[8]),   GlobalPointer!(__vector(float[8])));
pragma(mangle,"_Z6sincosDv16_fPU3AS1S_")
__vector(float[16])  sincos(__vector(float[16]),  GlobalPointer!(__vector(float[16])));
pragma(mangle,"_Z6sincosdPU3AS1d")
        double      sincos(          double,      GlobalPointer!(         double));
pragma(mangle,"_Z6sincosDv2_dPU3AS1S_")
__vector(double[2])  sincos(__vector(double[2]),  GlobalPointer!(__vector(double[2])));
pragma(mangle,"_Z6sincosDv3_dPU3AS1S_")
__vector(double[3])  sincos(__vector(double[3]),  GlobalPointer!(__vector(double[3])));
pragma(mangle,"_Z6sincosDv4_dPU3AS1S_")
__vector(double[4])  sincos(__vector(double[4]),  GlobalPointer!(__vector(double[4])));
pragma(mangle,"_Z6sincosDv8_dPU3AS1S_")
__vector(double[8])  sincos(__vector(double[8]),  GlobalPointer!(__vector(double[8])));
pragma(mangle,"_Z6sincosDv16_dPU3AS1S_")
__vector(double[16]) sincos(__vector(double[16]), GlobalPointer!(__vector(double[16])));
pragma(mangle,"_Z6sincosfPU3AS3f")
        float       sincos(          float,       SharedPointer!(         float));
pragma(mangle,"_Z6sincosDv2_fPU3AS3S_")
__vector(float[2])   sincos(__vector(float[2]),   SharedPointer!(__vector(float[2])));
pragma(mangle,"_Z6sincosDv3_fPU3AS3S_")
__vector(float[3])   sincos(__vector(float[3]),   SharedPointer!(__vector(float[3])));
pragma(mangle,"_Z6sincosDv4_fPU3AS3S_")
__vector(float[4])   sincos(__vector(float[4]),   SharedPointer!(__vector(float[4])));
pragma(mangle,"_Z6sincosDv8_fPU3AS3S_")
__vector(float[8])   sincos(__vector(float[8]),   SharedPointer!(__vector(float[8])));
pragma(mangle,"_Z6sincosDv16_fPU3AS3S_")
__vector(float[16])  sincos(__vector(float[16]),  SharedPointer!(__vector(float[16])));
pragma(mangle,"_Z6sincosdPU3AS3d")
        double      sincos(          double,      SharedPointer!(         double));
pragma(mangle,"_Z6sincosDv2_dPU3AS3S_")
__vector(double[2])  sincos(__vector(double[2]),  SharedPointer!(__vector(double[2])));
pragma(mangle,"_Z6sincosDv3_dPU3AS3S_")
__vector(double[3])  sincos(__vector(double[3]),  SharedPointer!(__vector(double[3])));
pragma(mangle,"_Z6sincosDv4_dPU3AS3S_")
__vector(double[4])  sincos(__vector(double[4]),  SharedPointer!(__vector(double[4])));
pragma(mangle,"_Z6sincosDv8_dPU3AS3S_")
__vector(double[8])  sincos(__vector(double[8]),  SharedPointer!(__vector(double[8])));
pragma(mangle,"_Z6sincosDv16_dPU3AS3S_")
__vector(double[16]) sincos(__vector(double[16]), SharedPointer!(__vector(double[16])));
pragma(mangle,"_Z6sincosfPf")
        float       sincos(          float,       PrivatePointer!(         float));
pragma(mangle,"_Z6sincosDv2_fPS_")
__vector(float[2])   sincos(__vector(float[2]),   PrivatePointer!(__vector(float[2])));
pragma(mangle,"_Z6sincosDv3_fPS_")
__vector(float[3])   sincos(__vector(float[3]),   PrivatePointer!(__vector(float[3])));
pragma(mangle,"_Z6sincosDv4_fPS_")
__vector(float[4])   sincos(__vector(float[4]),   PrivatePointer!(__vector(float[4])));
pragma(mangle,"_Z6sincosDv8_fPS_")
__vector(float[8])   sincos(__vector(float[8]),   PrivatePointer!(__vector(float[8])));
pragma(mangle,"_Z6sincosDv16_fPS_")
__vector(float[16])  sincos(__vector(float[16]),  PrivatePointer!(__vector(float[16])));
pragma(mangle,"_Z6sincosdPd")
        double      sincos(          double,      PrivatePointer!(         double));
pragma(mangle,"_Z6sincosDv2_dPS_")
__vector(double[2])  sincos(__vector(double[2]),  PrivatePointer!(__vector(double[2])));
pragma(mangle,"_Z6sincosDv3_dPS_")
__vector(double[3])  sincos(__vector(double[3]),  PrivatePointer!(__vector(double[3])));
pragma(mangle,"_Z6sincosDv4_dPS_")
__vector(double[4])  sincos(__vector(double[4]),  PrivatePointer!(__vector(double[4])));
pragma(mangle,"_Z6sincosDv8_dPS_")
__vector(double[8])  sincos(__vector(double[8]),  PrivatePointer!(__vector(double[8])));
pragma(mangle,"_Z6sincosDv16_dPS_")
__vector(double[16]) sincos(__vector(double[16]), PrivatePointer!(__vector(double[16])));

// sinh
pragma(mangle,"_Z4sinhf")               float       sinh(         float);
pragma(mangle,"_Z4sinhDv2_f")  __vector(float[2])   sinh(__vector(float[2]));
pragma(mangle,"_Z4sinhDv3_f")  __vector(float[3])   sinh(__vector(float[3]));
pragma(mangle,"_Z4sinhDv4_f")  __vector(float[4])   sinh(__vector(float[4]));
pragma(mangle,"_Z4sinhDv8_f")  __vector(float[8])   sinh(__vector(float[8]));
pragma(mangle,"_Z4sinhDv16_f") __vector(float[16])  sinh(__vector(float[16]));
pragma(mangle,"_Z4sinhd")               double      sinh(         double);
pragma(mangle,"_Z4sinhDv2_d")  __vector(double[2])  sinh(__vector(double[2]));
pragma(mangle,"_Z4sinhDv3_d")  __vector(double[3])  sinh(__vector(double[3]));
pragma(mangle,"_Z4sinhDv4_d")  __vector(double[4])  sinh(__vector(double[4]));
pragma(mangle,"_Z4sinhDv8_d")  __vector(double[8])  sinh(__vector(double[8]));
pragma(mangle,"_Z4sinhDv16_d") __vector(double[16]) sinh(__vector(double[16]));

// sinpi
pragma(mangle,"_Z5sinpif")               float       sinpi(         float);
pragma(mangle,"_Z5sinpiDv2_f")  __vector(float[2])   sinpi(__vector(float[2]));
pragma(mangle,"_Z5sinpiDv3_f")  __vector(float[3])   sinpi(__vector(float[3]));
pragma(mangle,"_Z5sinpiDv4_f")  __vector(float[4])   sinpi(__vector(float[4]));
pragma(mangle,"_Z5sinpiDv8_f")  __vector(float[8])   sinpi(__vector(float[8]));
pragma(mangle,"_Z5sinpiDv16_f") __vector(float[16])  sinpi(__vector(float[16]));
pragma(mangle,"_Z5sinpid")               double      sinpi(         double);
pragma(mangle,"_Z5sinpiDv2_d")  __vector(double[2])  sinpi(__vector(double[2]));
pragma(mangle,"_Z5sinpiDv3_d")  __vector(double[3])  sinpi(__vector(double[3]));
pragma(mangle,"_Z5sinpiDv4_d")  __vector(double[4])  sinpi(__vector(double[4]));
pragma(mangle,"_Z5sinpiDv8_d")  __vector(double[8])  sinpi(__vector(double[8]));
pragma(mangle,"_Z5sinpiDv16_d") __vector(double[16]) sinpi(__vector(double[16]));

// sqrt
pragma(mangle,"_Z4sqrtf")               float       sqrt(         float);
pragma(mangle,"_Z4sqrtDv2_f")  __vector(float[2])   sqrt(__vector(float[2]));
pragma(mangle,"_Z4sqrtDv3_f")  __vector(float[3])   sqrt(__vector(float[3]));
pragma(mangle,"_Z4sqrtDv4_f")  __vector(float[4])   sqrt(__vector(float[4]));
pragma(mangle,"_Z4sqrtDv8_f")  __vector(float[8])   sqrt(__vector(float[8]));
pragma(mangle,"_Z4sqrtDv16_f") __vector(float[16])  sqrt(__vector(float[16]));
pragma(mangle,"_Z4sqrtd")               double      sqrt(         double);
pragma(mangle,"_Z4sqrtDv2_d")  __vector(double[2])  sqrt(__vector(double[2]));
pragma(mangle,"_Z4sqrtDv3_d")  __vector(double[3])  sqrt(__vector(double[3]));
pragma(mangle,"_Z4sqrtDv4_d")  __vector(double[4])  sqrt(__vector(double[4]));
pragma(mangle,"_Z4sqrtDv8_d")  __vector(double[8])  sqrt(__vector(double[8]));
pragma(mangle,"_Z4sqrtDv16_d") __vector(double[16]) sqrt(__vector(double[16]));

// tan
pragma(mangle,"_Z3tanf")               float       tan(         float);
pragma(mangle,"_Z3tanDv2_f")  __vector(float[2])   tan(__vector(float[2]));
pragma(mangle,"_Z3tanDv3_f")  __vector(float[3])   tan(__vector(float[3]));
pragma(mangle,"_Z3tanDv4_f")  __vector(float[4])   tan(__vector(float[4]));
pragma(mangle,"_Z3tanDv8_f")  __vector(float[8])   tan(__vector(float[8]));
pragma(mangle,"_Z3tanDv16_f") __vector(float[16])  tan(__vector(float[16]));
pragma(mangle,"_Z3tand")               double      tan(         double);
pragma(mangle,"_Z3tanDv2_d")  __vector(double[2])  tan(__vector(double[2]));
pragma(mangle,"_Z3tanDv3_d")  __vector(double[3])  tan(__vector(double[3]));
pragma(mangle,"_Z3tanDv4_d")  __vector(double[4])  tan(__vector(double[4]));
pragma(mangle,"_Z3tanDv8_d")  __vector(double[8])  tan(__vector(double[8]));
pragma(mangle,"_Z3tanDv16_d") __vector(double[16]) tan(__vector(double[16]));

// tanh
pragma(mangle,"_Z4tanhf")               float       tanh(         float);
pragma(mangle,"_Z4tanhDv2_f")  __vector(float[2])   tanh(__vector(float[2]));
pragma(mangle,"_Z4tanhDv3_f")  __vector(float[3])   tanh(__vector(float[3]));
pragma(mangle,"_Z4tanhDv4_f")  __vector(float[4])   tanh(__vector(float[4]));
pragma(mangle,"_Z4tanhDv8_f")  __vector(float[8])   tanh(__vector(float[8]));
pragma(mangle,"_Z4tanhDv16_f") __vector(float[16])  tanh(__vector(float[16]));
pragma(mangle,"_Z4tanhd")               double      tanh(         double);
pragma(mangle,"_Z4tanhDv2_d")  __vector(double[2])  tanh(__vector(double[2]));
pragma(mangle,"_Z4tanhDv3_d")  __vector(double[3])  tanh(__vector(double[3]));
pragma(mangle,"_Z4tanhDv4_d")  __vector(double[4])  tanh(__vector(double[4]));
pragma(mangle,"_Z4tanhDv8_d")  __vector(double[8])  tanh(__vector(double[8]));
pragma(mangle,"_Z4tanhDv16_d") __vector(double[16]) tanh(__vector(double[16]));

// tanpi
pragma(mangle,"_Z5tanpif")               float       tanpi(         float);
pragma(mangle,"_Z5tanpiDv2_f")  __vector(float[2])   tanpi(__vector(float[2]));
pragma(mangle,"_Z5tanpiDv3_f")  __vector(float[3])   tanpi(__vector(float[3]));
pragma(mangle,"_Z5tanpiDv4_f")  __vector(float[4])   tanpi(__vector(float[4]));
pragma(mangle,"_Z5tanpiDv8_f")  __vector(float[8])   tanpi(__vector(float[8]));
pragma(mangle,"_Z5tanpiDv16_f") __vector(float[16])  tanpi(__vector(float[16]));
pragma(mangle,"_Z5tanpid")               double      tanpi(         double);
pragma(mangle,"_Z5tanpiDv2_d")  __vector(double[2])  tanpi(__vector(double[2]));
pragma(mangle,"_Z5tanpiDv3_d")  __vector(double[3])  tanpi(__vector(double[3]));
pragma(mangle,"_Z5tanpiDv4_d")  __vector(double[4])  tanpi(__vector(double[4]));
pragma(mangle,"_Z5tanpiDv8_d")  __vector(double[8])  tanpi(__vector(double[8]));
pragma(mangle,"_Z5tanpiDv16_d") __vector(double[16]) tanpi(__vector(double[16]));

// tgamma
pragma(mangle,"_Z6tgammaf")               float       tgamma(         float);
pragma(mangle,"_Z6tgammaDv2_f")  __vector(float[2])   tgamma(__vector(float[2]));
pragma(mangle,"_Z6tgammaDv3_f")  __vector(float[3])   tgamma(__vector(float[3]));
pragma(mangle,"_Z6tgammaDv4_f")  __vector(float[4])   tgamma(__vector(float[4]));
pragma(mangle,"_Z6tgammaDv8_f")  __vector(float[8])   tgamma(__vector(float[8]));
pragma(mangle,"_Z6tgammaDv16_f") __vector(float[16])  tgamma(__vector(float[16]));
pragma(mangle,"_Z6tgammad")               double      tgamma(         double);
pragma(mangle,"_Z6tgammaDv2_d")  __vector(double[2])  tgamma(__vector(double[2]));
pragma(mangle,"_Z6tgammaDv3_d")  __vector(double[3])  tgamma(__vector(double[3]));
pragma(mangle,"_Z6tgammaDv4_d")  __vector(double[4])  tgamma(__vector(double[4]));
pragma(mangle,"_Z6tgammaDv8_d")  __vector(double[8])  tgamma(__vector(double[8]));
pragma(mangle,"_Z6tgammaDv16_d") __vector(double[16]) tgamma(__vector(double[16]));

// trunc
pragma(mangle,"_Z5truncf")               float       trunc(         float);
pragma(mangle,"_Z5truncDv2_f")  __vector(float[2])   trunc(__vector(float[2]));
pragma(mangle,"_Z5truncDv3_f")  __vector(float[3])   trunc(__vector(float[3]));
pragma(mangle,"_Z5truncDv4_f")  __vector(float[4])   trunc(__vector(float[4]));
pragma(mangle,"_Z5truncDv8_f")  __vector(float[8])   trunc(__vector(float[8]));
pragma(mangle,"_Z5truncDv16_f") __vector(float[16])  trunc(__vector(float[16]));
pragma(mangle,"_Z5truncd")               double      trunc(         double);
pragma(mangle,"_Z5truncDv2_d")  __vector(double[2])  trunc(__vector(double[2]));
pragma(mangle,"_Z5truncDv3_d")  __vector(double[3])  trunc(__vector(double[3]));
pragma(mangle,"_Z5truncDv4_d")  __vector(double[4])  trunc(__vector(double[4]));
pragma(mangle,"_Z5truncDv8_d")  __vector(double[8])  trunc(__vector(double[8]));
pragma(mangle,"_Z5truncDv16_d") __vector(double[16]) trunc(__vector(double[16]));

// half_cos
pragma(mangle,"_Z8half_cosf")               float      half_cos(         float);
pragma(mangle,"_Z8half_cosDv2_f")  __vector(float[2])  half_cos(__vector(float[2]));
pragma(mangle,"_Z8half_cosDv3_f")  __vector(float[3])  half_cos(__vector(float[3]));
pragma(mangle,"_Z8half_cosDv4_f")  __vector(float[4])  half_cos(__vector(float[4]));
pragma(mangle,"_Z8half_cosDv8_f")  __vector(float[8])  half_cos(__vector(float[8]));
pragma(mangle,"_Z8half_cosDv16_f") __vector(float[16]) half_cos(__vector(float[16]));

// half_divide
pragma(mangle,"_Z11half_divideff")                float      half_divide(         float,               float);
pragma(mangle,"_Z11half_divideDv2_fS_")  __vector(float[2])  half_divide(__vector(float[2]),  __vector(float[2]));
pragma(mangle,"_Z11half_divideDv3_fS_")  __vector(float[3])  half_divide(__vector(float[3]),  __vector(float[3]));
pragma(mangle,"_Z11half_divideDv4_fS_")  __vector(float[4])  half_divide(__vector(float[4]),  __vector(float[4]));
pragma(mangle,"_Z11half_divideDv8_fS_")  __vector(float[8])  half_divide(__vector(float[8]),  __vector(float[8]));
pragma(mangle,"_Z11half_divideDv16_fS_") __vector(float[16]) half_divide(__vector(float[16]), __vector(float[16]));

// half_exp
pragma(mangle,"_Z8half_expf")               float      half_exp(         float);
pragma(mangle,"_Z8half_expDv2_f")  __vector(float[2])  half_exp(__vector(float[2]));
pragma(mangle,"_Z8half_expDv3_f")  __vector(float[3])  half_exp(__vector(float[3]));
pragma(mangle,"_Z8half_expDv4_f")  __vector(float[4])  half_exp(__vector(float[4]));
pragma(mangle,"_Z8half_expDv8_f")  __vector(float[8])  half_exp(__vector(float[8]));
pragma(mangle,"_Z8half_expDv16_f") __vector(float[16]) half_exp(__vector(float[16]));

// half_exp2
pragma(mangle,"_Z9half_exp2f")               float      half_exp2(         float);
pragma(mangle,"_Z9half_exp2Dv2_f")  __vector(float[2])  half_exp2(__vector(float[2]));
pragma(mangle,"_Z9half_exp2Dv3_f")  __vector(float[3])  half_exp2(__vector(float[3]));
pragma(mangle,"_Z9half_exp2Dv4_f")  __vector(float[4])  half_exp2(__vector(float[4]));
pragma(mangle,"_Z9half_exp2Dv8_f")  __vector(float[8])  half_exp2(__vector(float[8]));
pragma(mangle,"_Z9half_exp2Dv16_f") __vector(float[16]) half_exp2(__vector(float[16]));

// half_exp10
pragma(mangle,"_Z10half_exp10f")               float      half_exp10(         float);
pragma(mangle,"_Z10half_exp10Dv2_f")  __vector(float[2])  half_exp10(__vector(float[2]));
pragma(mangle,"_Z10half_exp10Dv3_f")  __vector(float[3])  half_exp10(__vector(float[3]));
pragma(mangle,"_Z10half_exp10Dv4_f")  __vector(float[4])  half_exp10(__vector(float[4]));
pragma(mangle,"_Z10half_exp10Dv8_f")  __vector(float[8])  half_exp10(__vector(float[8]));
pragma(mangle,"_Z10half_exp10Dv16_f") __vector(float[16]) half_exp10(__vector(float[16]));

// half_log
pragma(mangle,"_Z8half_logf")               float      half_log(         float);
pragma(mangle,"_Z8half_logDv2_f")  __vector(float[2])  half_log(__vector(float[2]));
pragma(mangle,"_Z8half_logDv3_f")  __vector(float[3])  half_log(__vector(float[3]));
pragma(mangle,"_Z8half_logDv4_f")  __vector(float[4])  half_log(__vector(float[4]));
pragma(mangle,"_Z8half_logDv8_f")  __vector(float[8])  half_log(__vector(float[8]));
pragma(mangle,"_Z8half_logDv16_f") __vector(float[16]) half_log(__vector(float[16]));

// half_log2
pragma(mangle,"_Z9half_log2f")               float      half_log2(         float);
pragma(mangle,"_Z9half_log2Dv2_f")  __vector(float[2])  half_log2(__vector(float[2]));
pragma(mangle,"_Z9half_log2Dv3_f")  __vector(float[3])  half_log2(__vector(float[3]));
pragma(mangle,"_Z9half_log2Dv4_f")  __vector(float[4])  half_log2(__vector(float[4]));
pragma(mangle,"_Z9half_log2Dv8_f")  __vector(float[8])  half_log2(__vector(float[8]));
pragma(mangle,"_Z9half_log2Dv16_f") __vector(float[16]) half_log2(__vector(float[16]));

// half_log10
pragma(mangle,"_Z10half_log10f")               float      half_log10(         float);
pragma(mangle,"_Z10half_log10Dv2_f")  __vector(float[2])  half_log10(__vector(float[2]));
pragma(mangle,"_Z10half_log10Dv3_f")  __vector(float[3])  half_log10(__vector(float[3]));
pragma(mangle,"_Z10half_log10Dv4_f")  __vector(float[4])  half_log10(__vector(float[4]));
pragma(mangle,"_Z10half_log10Dv8_f")  __vector(float[8])  half_log10(__vector(float[8]));
pragma(mangle,"_Z10half_log10Dv16_f") __vector(float[16]) half_log10(__vector(float[16]));

// half_powr
pragma(mangle,"_Z9half_powrff")                float      half_powr(         float,               float);
pragma(mangle,"_Z9half_powrDv2_fS_")  __vector(float[2])  half_powr(__vector(float[2]),  __vector(float[2]));
pragma(mangle,"_Z9half_powrDv3_fS_")  __vector(float[3])  half_powr(__vector(float[3]),  __vector(float[3]));
pragma(mangle,"_Z9half_powrDv4_fS_")  __vector(float[4])  half_powr(__vector(float[4]),  __vector(float[4]));
pragma(mangle,"_Z9half_powrDv8_fS_")  __vector(float[8])  half_powr(__vector(float[8]),  __vector(float[8]));
pragma(mangle,"_Z9half_powrDv16_fS_") __vector(float[16]) half_powr(__vector(float[16]), __vector(float[16]));

// half_recip
pragma(mangle,"_Z10half_recipf")               float      half_recip(         float);
pragma(mangle,"_Z10half_recipDv2_f")  __vector(float[2])  half_recip(__vector(float[2]));
pragma(mangle,"_Z10half_recipDv3_f")  __vector(float[3])  half_recip(__vector(float[3]));
pragma(mangle,"_Z10half_recipDv4_f")  __vector(float[4])  half_recip(__vector(float[4]));
pragma(mangle,"_Z10half_recipDv8_f")  __vector(float[8])  half_recip(__vector(float[8]));
pragma(mangle,"_Z10half_recipDv16_f") __vector(float[16]) half_recip(__vector(float[16]));

// half_rsqrt
pragma(mangle,"_Z10half_rsqrtf")               float      half_rsqrt(         float);
pragma(mangle,"_Z10half_rsqrtDv2_f")  __vector(float[2])  half_rsqrt(__vector(float[2]));
pragma(mangle,"_Z10half_rsqrtDv3_f")  __vector(float[3])  half_rsqrt(__vector(float[3]));
pragma(mangle,"_Z10half_rsqrtDv4_f")  __vector(float[4])  half_rsqrt(__vector(float[4]));
pragma(mangle,"_Z10half_rsqrtDv8_f")  __vector(float[8])  half_rsqrt(__vector(float[8]));
pragma(mangle,"_Z10half_rsqrtDv16_f") __vector(float[16]) half_rsqrt(__vector(float[16]));

// half_sin
pragma(mangle,"_Z8half_sinf")               float      half_sin(         float);
pragma(mangle,"_Z8half_sinDv2_f")  __vector(float[2])  half_sin(__vector(float[2]));
pragma(mangle,"_Z8half_sinDv3_f")  __vector(float[3])  half_sin(__vector(float[3]));
pragma(mangle,"_Z8half_sinDv4_f")  __vector(float[4])  half_sin(__vector(float[4]));
pragma(mangle,"_Z8half_sinDv8_f")  __vector(float[8])  half_sin(__vector(float[8]));
pragma(mangle,"_Z8half_sinDv16_f") __vector(float[16]) half_sin(__vector(float[16]));

// half_sqrt
pragma(mangle,"_Z9half_sqrtf")               float      half_sqrt(         float);
pragma(mangle,"_Z9half_sqrtDv2_f")  __vector(float[2])  half_sqrt(__vector(float[2]));
pragma(mangle,"_Z9half_sqrtDv3_f")  __vector(float[3])  half_sqrt(__vector(float[3]));
pragma(mangle,"_Z9half_sqrtDv4_f")  __vector(float[4])  half_sqrt(__vector(float[4]));
pragma(mangle,"_Z9half_sqrtDv8_f")  __vector(float[8])  half_sqrt(__vector(float[8]));
pragma(mangle,"_Z9half_sqrtDv16_f") __vector(float[16]) half_sqrt(__vector(float[16]));

// half_tan
pragma(mangle,"_Z8half_tanf")               float      half_tan(         float);
pragma(mangle,"_Z8half_tanDv2_f")  __vector(float[2])  half_tan(__vector(float[2]));
pragma(mangle,"_Z8half_tanDv3_f")  __vector(float[3])  half_tan(__vector(float[3]));
pragma(mangle,"_Z8half_tanDv4_f")  __vector(float[4])  half_tan(__vector(float[4]));
pragma(mangle,"_Z8half_tanDv8_f")  __vector(float[8])  half_tan(__vector(float[8]));
pragma(mangle,"_Z8half_tanDv16_f") __vector(float[16]) half_tan(__vector(float[16]));

// native_cos
pragma(mangle,"_Z10native_cosf")               float      native_cos(         float);
pragma(mangle,"_Z10native_cosDv2_f")  __vector(float[2])  native_cos(__vector(float[2]));
pragma(mangle,"_Z10native_cosDv3_f")  __vector(float[3])  native_cos(__vector(float[3]));
pragma(mangle,"_Z10native_cosDv4_f")  __vector(float[4])  native_cos(__vector(float[4]));
pragma(mangle,"_Z10native_cosDv8_f")  __vector(float[8])  native_cos(__vector(float[8]));
pragma(mangle,"_Z10native_cosDv16_f") __vector(float[16]) native_cos(__vector(float[16]));

// native_divide
pragma(mangle,"_Z13native_divideff")                float      native_divide(         float,               float);
pragma(mangle,"_Z13native_divideDv2_fS_")  __vector(float[2])  native_divide(__vector(float[2]),  __vector(float[2]));
pragma(mangle,"_Z13native_divideDv3_fS_")  __vector(float[3])  native_divide(__vector(float[3]),  __vector(float[3]));
pragma(mangle,"_Z13native_divideDv4_fS_")  __vector(float[4])  native_divide(__vector(float[4]),  __vector(float[4]));
pragma(mangle,"_Z13native_divideDv8_fS_")  __vector(float[8])  native_divide(__vector(float[8]),  __vector(float[8]));
pragma(mangle,"_Z13native_divideDv16_fS_") __vector(float[16]) native_divide(__vector(float[16]), __vector(float[16]));

// native_exp
pragma(mangle,"_Z10native_expf")               float      native_exp(         float);
pragma(mangle,"_Z10native_expDv2_f")  __vector(float[2])  native_exp(__vector(float[2]));
pragma(mangle,"_Z10native_expDv3_f")  __vector(float[3])  native_exp(__vector(float[3]));
pragma(mangle,"_Z10native_expDv4_f")  __vector(float[4])  native_exp(__vector(float[4]));
pragma(mangle,"_Z10native_expDv8_f")  __vector(float[8])  native_exp(__vector(float[8]));
pragma(mangle,"_Z10native_expDv16_f") __vector(float[16]) native_exp(__vector(float[16]));

// native_exp2
pragma(mangle,"_Z11native_exp2f")               float      native_exp2(         float);
pragma(mangle,"_Z11native_exp2Dv2_f")  __vector(float[2])  native_exp2(__vector(float[2]));
pragma(mangle,"_Z11native_exp2Dv3_f")  __vector(float[3])  native_exp2(__vector(float[3]));
pragma(mangle,"_Z11native_exp2Dv4_f")  __vector(float[4])  native_exp2(__vector(float[4]));
pragma(mangle,"_Z11native_exp2Dv8_f")  __vector(float[8])  native_exp2(__vector(float[8]));
pragma(mangle,"_Z11native_exp2Dv16_f") __vector(float[16]) native_exp2(__vector(float[16]));

// native_exp10
pragma(mangle,"_Z12native_exp10f")               float      native_exp10(         float);
pragma(mangle,"_Z12native_exp10Dv2_f")  __vector(float[2])  native_exp10(__vector(float[2]));
pragma(mangle,"_Z12native_exp10Dv3_f")  __vector(float[3])  native_exp10(__vector(float[3]));
pragma(mangle,"_Z12native_exp10Dv4_f")  __vector(float[4])  native_exp10(__vector(float[4]));
pragma(mangle,"_Z12native_exp10Dv8_f")  __vector(float[8])  native_exp10(__vector(float[8]));
pragma(mangle,"_Z12native_exp10Dv16_f") __vector(float[16]) native_exp10(__vector(float[16]));

// native_log
pragma(mangle,"_Z10native_logf")               float      native_log(         float);
pragma(mangle,"_Z10native_logDv2_f")  __vector(float[2])  native_log(__vector(float[2]));
pragma(mangle,"_Z10native_logDv3_f")  __vector(float[3])  native_log(__vector(float[3]));
pragma(mangle,"_Z10native_logDv4_f")  __vector(float[4])  native_log(__vector(float[4]));
pragma(mangle,"_Z10native_logDv8_f")  __vector(float[8])  native_log(__vector(float[8]));
pragma(mangle,"_Z10native_logDv16_f") __vector(float[16]) native_log(__vector(float[16]));

// native_log2
pragma(mangle,"_Z11native_log2f")               float      native_log2(         float);
pragma(mangle,"_Z11native_log2Dv2_f")  __vector(float[2])  native_log2(__vector(float[2]));
pragma(mangle,"_Z11native_log2Dv3_f")  __vector(float[3])  native_log2(__vector(float[3]));
pragma(mangle,"_Z11native_log2Dv4_f")  __vector(float[4])  native_log2(__vector(float[4]));
pragma(mangle,"_Z11native_log2Dv8_f")  __vector(float[8])  native_log2(__vector(float[8]));
pragma(mangle,"_Z11native_log2Dv16_f") __vector(float[16]) native_log2(__vector(float[16]));

// native_log10
pragma(mangle,"_Z12native_log10f")               float      native_log10(         float);
pragma(mangle,"_Z12native_log10Dv2_f")  __vector(float[2])  native_log10(__vector(float[2]));
pragma(mangle,"_Z12native_log10Dv3_f")  __vector(float[3])  native_log10(__vector(float[3]));
pragma(mangle,"_Z12native_log10Dv4_f")  __vector(float[4])  native_log10(__vector(float[4]));
pragma(mangle,"_Z12native_log10Dv8_f")  __vector(float[8])  native_log10(__vector(float[8]));
pragma(mangle,"_Z12native_log10Dv16_f") __vector(float[16]) native_log10(__vector(float[16]));

// native_powr
pragma(mangle,"_Z11native_powrff")                float      native_powr(         float,               float);
pragma(mangle,"_Z11native_powrDv2_fS_")  __vector(float[2])  native_powr(__vector(float[2]),  __vector(float[2]));
pragma(mangle,"_Z11native_powrDv3_fS_")  __vector(float[3])  native_powr(__vector(float[3]),  __vector(float[3]));
pragma(mangle,"_Z11native_powrDv4_fS_")  __vector(float[4])  native_powr(__vector(float[4]),  __vector(float[4]));
pragma(mangle,"_Z11native_powrDv8_fS_")  __vector(float[8])  native_powr(__vector(float[8]),  __vector(float[8]));
pragma(mangle,"_Z11native_powrDv16_fS_") __vector(float[16]) native_powr(__vector(float[16]), __vector(float[16]));

// native_recip
pragma(mangle,"_Z12native_recipf")               float      native_recip(         float);
pragma(mangle,"_Z12native_recipDv2_f")  __vector(float[2])  native_recip(__vector(float[2]));
pragma(mangle,"_Z12native_recipDv3_f")  __vector(float[3])  native_recip(__vector(float[3]));
pragma(mangle,"_Z12native_recipDv4_f")  __vector(float[4])  native_recip(__vector(float[4]));
pragma(mangle,"_Z12native_recipDv8_f")  __vector(float[8])  native_recip(__vector(float[8]));
pragma(mangle,"_Z12native_recipDv16_f") __vector(float[16]) native_recip(__vector(float[16]));

// native_rsqrt
pragma(mangle,"_Z12native_rsqrtf")               float      native_rsqrt(         float);
pragma(mangle,"_Z12native_rsqrtDv2_f")  __vector(float[2])  native_rsqrt(__vector(float[2]));
pragma(mangle,"_Z12native_rsqrtDv3_f")  __vector(float[3])  native_rsqrt(__vector(float[3]));
pragma(mangle,"_Z12native_rsqrtDv4_f")  __vector(float[4])  native_rsqrt(__vector(float[4]));
pragma(mangle,"_Z12native_rsqrtDv8_f")  __vector(float[8])  native_rsqrt(__vector(float[8]));
pragma(mangle,"_Z12native_rsqrtDv16_f") __vector(float[16]) native_rsqrt(__vector(float[16]));

// native_sin
pragma(mangle,"_Z10native_sinf")               float      native_sin(         float);
pragma(mangle,"_Z10native_sinDv2_f")  __vector(float[2])  native_sin(__vector(float[2]));
pragma(mangle,"_Z10native_sinDv3_f")  __vector(float[3])  native_sin(__vector(float[3]));
pragma(mangle,"_Z10native_sinDv4_f")  __vector(float[4])  native_sin(__vector(float[4]));
pragma(mangle,"_Z10native_sinDv8_f")  __vector(float[8])  native_sin(__vector(float[8]));
pragma(mangle,"_Z10native_sinDv16_f") __vector(float[16]) native_sin(__vector(float[16]));

// native_sqrt
pragma(mangle,"_Z11native_sqrtf")               float      native_sqrt(         float);
pragma(mangle,"_Z11native_sqrtDv2_f")  __vector(float[2])  native_sqrt(__vector(float[2]));
pragma(mangle,"_Z11native_sqrtDv3_f")  __vector(float[3])  native_sqrt(__vector(float[3]));
pragma(mangle,"_Z11native_sqrtDv4_f")  __vector(float[4])  native_sqrt(__vector(float[4]));
pragma(mangle,"_Z11native_sqrtDv8_f")  __vector(float[8])  native_sqrt(__vector(float[8]));
pragma(mangle,"_Z11native_sqrtDv16_f") __vector(float[16]) native_sqrt(__vector(float[16]));

// native_tan
pragma(mangle,"_Z10native_tanf")               float      native_tan(         float);
pragma(mangle,"_Z10native_tanDv2_f")  __vector(float[2])  native_tan(__vector(float[2]));
pragma(mangle,"_Z10native_tanDv3_f")  __vector(float[3])  native_tan(__vector(float[3]));
pragma(mangle,"_Z10native_tanDv4_f")  __vector(float[4])  native_tan(__vector(float[4]));
pragma(mangle,"_Z10native_tanDv8_f")  __vector(float[8])  native_tan(__vector(float[8]));
pragma(mangle,"_Z10native_tanDv16_f") __vector(float[16]) native_tan(__vector(float[16]));
