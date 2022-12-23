@compute(CompileFor.hostAndDevice) module dcompute.std.cuda.math;

import ldc.dcompute;

/++ auto-generated intrinsics definitions from CUDA 10.2 - libdevice.10.bc
    the generator python script is available at the end of this file
+/

//declare float @llvm.nvvm.floor.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.floor.ftz.f")
float floor_ftz_f(float);

//declare float @llvm.nvvm.floor.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.floor.f")
float floor_f(float);

//declare double @llvm.nvvm.floor.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.floor.d")
double floor_d(double);

//declare float @llvm.nvvm.fabs.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.fabs.ftz.f")
float fabs_ftz_f(float);

//declare float @llvm.nvvm.fabs.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.fabs.f")
float fabs_f(float);

//declare double @llvm.nvvm.fabs.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.fabs.d")
double fabs_d(double);

//declare double @llvm.nvvm.rcp.approx.ftz.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.approx.ftz.d")
double rcp_approx_ftz_d(double);

//declare float @llvm.nvvm.fmin.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.fmin.ftz.f")
float fmin_ftz_f(float, float);

//declare float @llvm.nvvm.fmin.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.fmin.f")
float fmin_f(float, float);

//declare float @llvm.nvvm.fmax.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.fmax.ftz.f")
float fmax_ftz_f(float, float);

//declare float @llvm.nvvm.fmax.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.fmax.f")
float fmax_f(float, float);

//declare float @llvm.nvvm.rsqrt.approx.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.rsqrt.approx.ftz.f")
float rsqrt_approx_ftz_f(float);

//declare float @llvm.nvvm.rsqrt.approx.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.rsqrt.approx.f")
float rsqrt_approx_f(float);

//declare double @llvm.nvvm.fmin.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.fmin.d")
double fmin_d(double, double);

//declare double @llvm.nvvm.fmax.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.fmax.d")
double fmax_d(double, double);

//declare double @llvm.nvvm.rsqrt.approx.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.rsqrt.approx.d")
double rsqrt_approx_d(double);

//declare double @llvm.nvvm.ceil.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.ceil.d")
double ceil_d(double);

//declare double @llvm.nvvm.trunc.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.trunc.d")
double trunc_d(double);

//declare float @llvm.nvvm.ex2.approx.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.ex2.approx.ftz.f")
float ex2_approx_ftz_f(float);

//declare float @llvm.nvvm.ex2.approx.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.ex2.approx.f")
float ex2_approx_f(float);

//declare float @llvm.nvvm.lg2.approx.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.lg2.approx.ftz.f")
float lg2_approx_ftz_f(float);

//declare float @llvm.nvvm.lg2.approx.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.lg2.approx.f")
float lg2_approx_f(float);

//declare float @llvm.nvvm.sin.approx.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.sin.approx.ftz.f")
float sin_approx_ftz_f(float);

//declare float @llvm.nvvm.sin.approx.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.sin.approx.f")
float sin_approx_f(float);

//declare float @llvm.nvvm.cos.approx.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.cos.approx.ftz.f")
float cos_approx_ftz_f(float);

//declare float @llvm.nvvm.cos.approx.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.cos.approx.f")
float cos_approx_f(float);

//declare float @llvm.nvvm.round.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.round.ftz.f")
float round_ftz_f(float);

//declare float @llvm.nvvm.round.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.round.f")
float round_f(float);

//declare double @llvm.nvvm.round.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.round.d")
double round_d(double);

//declare float @llvm.nvvm.trunc.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.trunc.ftz.f")
float trunc_ftz_f(float);

//declare float @llvm.nvvm.trunc.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.trunc.f")
float trunc_f(float);

//declare float @llvm.nvvm.ceil.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.ceil.ftz.f")
float ceil_ftz_f(float);

//declare float @llvm.nvvm.ceil.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.ceil.f")
float ceil_f(float);

//declare float @llvm.nvvm.saturate.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.saturate.ftz.f")
float saturate_ftz_f(float);

//declare float @llvm.nvvm.saturate.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.saturate.f")
float saturate_f(float);

//declare float @llvm.nvvm.fma.rn.ftz.f(float, float, float)
pragma(LDC_intrinsic, "llvm.nvvm.fma.rn.ftz.f")
float fma_rn_ftz_f(float, float, float);

//declare float @llvm.nvvm.fma.rn.f(float, float, float)
pragma(LDC_intrinsic, "llvm.nvvm.fma.rn.f")
float fma_rn_f(float, float, float);

//declare float @llvm.nvvm.fma.rz.ftz.f(float, float, float)
pragma(LDC_intrinsic, "llvm.nvvm.fma.rz.ftz.f")
float fma_rz_ftz_f(float, float, float);

//declare float @llvm.nvvm.fma.rz.f(float, float, float)
pragma(LDC_intrinsic, "llvm.nvvm.fma.rz.f")
float fma_rz_f(float, float, float);

//declare float @llvm.nvvm.fma.rm.ftz.f(float, float, float)
pragma(LDC_intrinsic, "llvm.nvvm.fma.rm.ftz.f")
float fma_rm_ftz_f(float, float, float);

//declare float @llvm.nvvm.fma.rm.f(float, float, float)
pragma(LDC_intrinsic, "llvm.nvvm.fma.rm.f")
float fma_rm_f(float, float, float);

//declare float @llvm.nvvm.fma.rp.ftz.f(float, float, float)
pragma(LDC_intrinsic, "llvm.nvvm.fma.rp.ftz.f")
float fma_rp_ftz_f(float, float, float);

//declare float @llvm.nvvm.fma.rp.f(float, float, float)
pragma(LDC_intrinsic, "llvm.nvvm.fma.rp.f")
float fma_rp_f(float, float, float);

//declare double @llvm.nvvm.fma.rn.d(double, double, double)
pragma(LDC_intrinsic, "llvm.nvvm.fma.rn.d")
double fma_rn_d(double, double, double);

//declare double @llvm.nvvm.fma.rz.d(double, double, double)
pragma(LDC_intrinsic, "llvm.nvvm.fma.rz.d")
double fma_rz_d(double, double, double);

//declare double @llvm.nvvm.fma.rm.d(double, double, double)
pragma(LDC_intrinsic, "llvm.nvvm.fma.rm.d")
double fma_rm_d(double, double, double);

//declare double @llvm.nvvm.fma.rp.d(double, double, double)
pragma(LDC_intrinsic, "llvm.nvvm.fma.rp.d")
double fma_rp_d(double, double, double);

//declare float @llvm.nvvm.div.approx.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.div.approx.ftz.f")
float div_approx_ftz_f(float, float);

//declare float @llvm.nvvm.div.approx.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.div.approx.f")
float div_approx_f(float, float);

//declare float @llvm.nvvm.div.rn.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.div.rn.ftz.f")
float div_rn_ftz_f(float, float);

//declare float @llvm.nvvm.div.rn.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.div.rn.f")
float div_rn_f(float, float);

//declare float @llvm.nvvm.div.rz.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.div.rz.ftz.f")
float div_rz_ftz_f(float, float);

//declare float @llvm.nvvm.div.rz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.div.rz.f")
float div_rz_f(float, float);

//declare float @llvm.nvvm.div.rm.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.div.rm.ftz.f")
float div_rm_ftz_f(float, float);

//declare float @llvm.nvvm.div.rm.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.div.rm.f")
float div_rm_f(float, float);

//declare float @llvm.nvvm.div.rp.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.div.rp.ftz.f")
float div_rp_ftz_f(float, float);

//declare float @llvm.nvvm.div.rp.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.div.rp.f")
float div_rp_f(float, float);

//declare float @llvm.nvvm.rcp.rn.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.rn.ftz.f")
float rcp_rn_ftz_f(float);

//declare float @llvm.nvvm.rcp.rn.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.rn.f")
float rcp_rn_f(float);

//declare float @llvm.nvvm.rcp.rz.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.rz.ftz.f")
float rcp_rz_ftz_f(float);

//declare float @llvm.nvvm.rcp.rz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.rz.f")
float rcp_rz_f(float);

//declare float @llvm.nvvm.rcp.rm.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.rm.ftz.f")
float rcp_rm_ftz_f(float);

//declare float @llvm.nvvm.rcp.rm.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.rm.f")
float rcp_rm_f(float);

//declare float @llvm.nvvm.rcp.rp.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.rp.ftz.f")
float rcp_rp_ftz_f(float);

//declare float @llvm.nvvm.rcp.rp.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.rp.f")
float rcp_rp_f(float);

//declare float @llvm.nvvm.sqrt.rn.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.rn.ftz.f")
float sqrt_rn_ftz_f(float);

//declare float @llvm.nvvm.sqrt.rn.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.rn.f")
float sqrt_rn_f(float);

//declare float @llvm.nvvm.sqrt.rz.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.rz.ftz.f")
float sqrt_rz_ftz_f(float);

//declare float @llvm.nvvm.sqrt.rz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.rz.f")
float sqrt_rz_f(float);

//declare float @llvm.nvvm.sqrt.rm.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.rm.ftz.f")
float sqrt_rm_ftz_f(float);

//declare float @llvm.nvvm.sqrt.rm.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.rm.f")
float sqrt_rm_f(float);

//declare float @llvm.nvvm.sqrt.rp.ftz.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.rp.ftz.f")
float sqrt_rp_ftz_f(float);

//declare float @llvm.nvvm.sqrt.rp.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.rp.f")
float sqrt_rp_f(float);

//declare double @llvm.nvvm.div.rn.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.div.rn.d")
double div_rn_d(double, double);

//declare double @llvm.nvvm.div.rz.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.div.rz.d")
double div_rz_d(double, double);

//declare double @llvm.nvvm.div.rm.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.div.rm.d")
double div_rm_d(double, double);

//declare double @llvm.nvvm.div.rp.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.div.rp.d")
double div_rp_d(double, double);

//declare double @llvm.nvvm.rcp.rn.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.rn.d")
double rcp_rn_d(double);

//declare double @llvm.nvvm.rcp.rz.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.rz.d")
double rcp_rz_d(double);

//declare double @llvm.nvvm.rcp.rm.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.rm.d")
double rcp_rm_d(double);

//declare double @llvm.nvvm.rcp.rp.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.rcp.rp.d")
double rcp_rp_d(double);

//declare double @llvm.nvvm.sqrt.rn.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.rn.d")
double sqrt_rn_d(double);

//declare double @llvm.nvvm.sqrt.rz.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.rz.d")
double sqrt_rz_d(double);

//declare double @llvm.nvvm.sqrt.rm.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.rm.d")
double sqrt_rm_d(double);

//declare double @llvm.nvvm.sqrt.rp.d(double)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.rp.d")
double sqrt_rp_d(double);

//declare float @llvm.nvvm.sqrt.f(float)
pragma(LDC_intrinsic, "llvm.nvvm.sqrt.f")
float sqrt_f(float);

//declare double @llvm.nvvm.add.rn.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.add.rn.d")
double add_rn_d(double, double);

//declare double @llvm.nvvm.add.rz.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.add.rz.d")
double add_rz_d(double, double);

//declare double @llvm.nvvm.add.rm.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.add.rm.d")
double add_rm_d(double, double);

//declare double @llvm.nvvm.add.rp.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.add.rp.d")
double add_rp_d(double, double);

//declare double @llvm.nvvm.mul.rn.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.mul.rn.d")
double mul_rn_d(double, double);

//declare double @llvm.nvvm.mul.rz.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.mul.rz.d")
double mul_rz_d(double, double);

//declare double @llvm.nvvm.mul.rm.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.mul.rm.d")
double mul_rm_d(double, double);

//declare double @llvm.nvvm.mul.rp.d(double, double)
pragma(LDC_intrinsic, "llvm.nvvm.mul.rp.d")
double mul_rp_d(double, double);

//declare float @llvm.nvvm.add.rm.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.add.rm.ftz.f")
float add_rm_ftz_f(float, float);

//declare float @llvm.nvvm.add.rm.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.add.rm.f")
float add_rm_f(float, float);

//declare float @llvm.nvvm.add.rp.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.add.rp.ftz.f")
float add_rp_ftz_f(float, float);

//declare float @llvm.nvvm.add.rp.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.add.rp.f")
float add_rp_f(float, float);

//declare float @llvm.nvvm.mul.rm.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.mul.rm.ftz.f")
float mul_rm_ftz_f(float, float);

//declare float @llvm.nvvm.mul.rm.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.mul.rm.f")
float mul_rm_f(float, float);

//declare float @llvm.nvvm.mul.rp.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.mul.rp.ftz.f")
float mul_rp_ftz_f(float, float);

//declare float @llvm.nvvm.mul.rp.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.mul.rp.f")
float mul_rp_f(float, float);

//declare float @llvm.nvvm.add.rn.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.add.rn.ftz.f")
float add_rn_ftz_f(float, float);

//declare float @llvm.nvvm.add.rn.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.add.rn.f")
float add_rn_f(float, float);

//declare float @llvm.nvvm.add.rz.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.add.rz.ftz.f")
float add_rz_ftz_f(float, float);

//declare float @llvm.nvvm.add.rz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.add.rz.f")
float add_rz_f(float, float);

//declare float @llvm.nvvm.mul.rn.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.mul.rn.ftz.f")
float mul_rn_ftz_f(float, float);

//declare float @llvm.nvvm.mul.rn.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.mul.rn.f")
float mul_rn_f(float, float);

//declare float @llvm.nvvm.mul.rz.ftz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.mul.rz.ftz.f")
float mul_rz_ftz_f(float, float);

//declare float @llvm.nvvm.mul.rz.f(float, float)
pragma(LDC_intrinsic, "llvm.nvvm.mul.rz.f")
float mul_rz_f(float, float);

//declare float @llvm.nvvm.d2f.rn.ftz(double)
pragma(LDC_intrinsic, "llvm.nvvm.d2f.rn.ftz")
float d2f_rn_ftz(double);

//declare float @llvm.nvvm.d2f.rn(double)
pragma(LDC_intrinsic, "llvm.nvvm.d2f.rn")
float d2f_rn(double);

//declare float @llvm.nvvm.d2f.rz.ftz(double)
pragma(LDC_intrinsic, "llvm.nvvm.d2f.rz.ftz")
float d2f_rz_ftz(double);

//declare float @llvm.nvvm.d2f.rz(double)
pragma(LDC_intrinsic, "llvm.nvvm.d2f.rz")
float d2f_rz(double);

//declare float @llvm.nvvm.d2f.rm.ftz(double)
pragma(LDC_intrinsic, "llvm.nvvm.d2f.rm.ftz")
float d2f_rm_ftz(double);

//declare float @llvm.nvvm.d2f.rm(double)
pragma(LDC_intrinsic, "llvm.nvvm.d2f.rm")
float d2f_rm(double);

//declare float @llvm.nvvm.d2f.rp.ftz(double)
pragma(LDC_intrinsic, "llvm.nvvm.d2f.rp.ftz")
float d2f_rp_ftz(double);

//declare float @llvm.nvvm.d2f.rp(double)
pragma(LDC_intrinsic, "llvm.nvvm.d2f.rp")
float d2f_rp(double);

//declare double @llvm.nvvm.i2d.rn(i32)
pragma(LDC_intrinsic, "llvm.nvvm.i2d.rn")
double i2d_rn(int);

//declare double @llvm.nvvm.ui2d.rn(i32)
pragma(LDC_intrinsic, "llvm.nvvm.ui2d.rn")
double ui2d_rn(int);

//declare float @llvm.nvvm.i2f.rn(i32)
pragma(LDC_intrinsic, "llvm.nvvm.i2f.rn")
float i2f_rn(int);

//declare float @llvm.nvvm.i2f.rz(i32)
pragma(LDC_intrinsic, "llvm.nvvm.i2f.rz")
float i2f_rz(int);

//declare float @llvm.nvvm.i2f.rm(i32)
pragma(LDC_intrinsic, "llvm.nvvm.i2f.rm")
float i2f_rm(int);

//declare float @llvm.nvvm.i2f.rp(i32)
pragma(LDC_intrinsic, "llvm.nvvm.i2f.rp")
float i2f_rp(int);

//declare float @llvm.nvvm.ui2f.rn(i32)
pragma(LDC_intrinsic, "llvm.nvvm.ui2f.rn")
float ui2f_rn(int);

//declare float @llvm.nvvm.ui2f.rz(i32)
pragma(LDC_intrinsic, "llvm.nvvm.ui2f.rz")
float ui2f_rz(int);

//declare float @llvm.nvvm.ui2f.rm(i32)
pragma(LDC_intrinsic, "llvm.nvvm.ui2f.rm")
float ui2f_rm(int);

//declare float @llvm.nvvm.ui2f.rp(i32)
pragma(LDC_intrinsic, "llvm.nvvm.ui2f.rp")
float ui2f_rp(int);

//declare double @llvm.nvvm.lohi.i2d(i32, i32)
pragma(LDC_intrinsic, "llvm.nvvm.lohi.i2d")
double lohi_i2d(int, int);

//declare float @llvm.nvvm.ll2f.rn(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ll2f.rn")
float ll2f_rn(long);

//declare float @llvm.nvvm.ll2f.rz(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ll2f.rz")
float ll2f_rz(long);

//declare float @llvm.nvvm.ll2f.rm(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ll2f.rm")
float ll2f_rm(long);

//declare float @llvm.nvvm.ll2f.rp(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ll2f.rp")
float ll2f_rp(long);

//declare float @llvm.nvvm.ull2f.rn(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ull2f.rn")
float ull2f_rn(long);

//declare float @llvm.nvvm.ull2f.rz(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ull2f.rz")
float ull2f_rz(long);

//declare float @llvm.nvvm.ull2f.rm(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ull2f.rm")
float ull2f_rm(long);

//declare float @llvm.nvvm.ull2f.rp(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ull2f.rp")
float ull2f_rp(long);

//declare double @llvm.nvvm.ll2d.rn(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ll2d.rn")
double ll2d_rn(long);

//declare double @llvm.nvvm.ll2d.rz(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ll2d.rz")
double ll2d_rz(long);

//declare double @llvm.nvvm.ll2d.rm(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ll2d.rm")
double ll2d_rm(long);

//declare double @llvm.nvvm.ll2d.rp(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ll2d.rp")
double ll2d_rp(long);

//declare double @llvm.nvvm.ull2d.rn(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ull2d.rn")
double ull2d_rn(long);

//declare double @llvm.nvvm.ull2d.rz(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ull2d.rz")
double ull2d_rz(long);

//declare double @llvm.nvvm.ull2d.rm(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ull2d.rm")
double ull2d_rm(long);

//declare double @llvm.nvvm.ull2d.rp(i64)
pragma(LDC_intrinsic, "llvm.nvvm.ull2d.rp")
double ull2d_rp(long);

/+ python codegen from libdevice.10.ll

# use `llvm-dis libdevice.10.bc` to obtain libdevice.10.ll then run this script

import re

def use_regex(input_text):
	pattern = re.compile(r"[a-zA-Z]+ [a-zA-Z]+ @([A-Za-z0-9]+(\.[A-Za-z0-9]+)+)\([^)]*\)", re.IGNORECASE)
	return pattern.match(input_text)

def unique(list1):
	# initialize a null list
	unique_list = []
	# traverse for all elements
	for x in list1:
		# check if exists in unique_list or not
		if x not in unique_list:
			unique_list.append(x)
	return unique_list

def getReturnType(s):
	rt = ""
	i = 0
	while s[i] != " ":
		rt += s[i]
		i += 1
	return rt

def getFunNameandArgInd(s):
	index = -1;
	try:
		index = s.index('@llvm.nvvm.')
	except ValueError:
		return None
	fnstartind = index + 11
	i = fnstartind
	name = ""
	while s[i] != "(":
		name += s[i]
		i += 1
	name = name.replace(".", "_")
	return (name, i)

def getNVVMname(s):
	i = -1;
	try:
		i = s.index('llvm.nvvm.')
	except ValueError:
		return None
	name = ""
	while s[i] != "(":
		name += s[i]
		i += 1
	return name

def getParams(s, i):
	params = ""
	while s[i] != ")":
		params += s[i]
		i += 1
	return params + ")"

file1 = open('libdevice.10.ll', 'r')
Lines = file1.readlines()

mlist = []

for line in Lines:
	some = use_regex(line)
	if some is not None:
		mlist.append(some.group(0))

ftemplate = "//%s\npragma(LDC_intrinsic, \"%s\")\n%s %s%s;\n"


for d in unique(mlist):
	raw = d[8:]
	rtype = getReturnType(raw)
	
	rtype = rtype.replace("i64", "long")
	rtype = rtype.replace("i32", "int")
	
	tup = getFunNameandArgInd(raw)
	if tup is None:
		continue
	
	lfn = getNVVMname(raw)
	if lfn is None:
		continue
	
	name, i = tup
	params = getParams(raw, i)
	params = params.replace("i64", "long")
	params = params.replace("i32", "int")
	
	print(ftemplate % (d, lfn, rtype, name, params))
+/
