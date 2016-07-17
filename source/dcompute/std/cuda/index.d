@compute module dcompute.std.cuda.index;

import dcompute.attributes;
//tid = threadId
pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.tid.x")
int tid_x();

pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.tid.y")
int tid_y();

pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.tid.z")
int tid_z();

//ntid = blockDim
pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.ntid.x")
int ntid_x();

pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.ntid.y")
int ntid_y();

pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.ntid.z")
int ntid_z();

//ctaid = blockIdx
pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.ctaid.x")
int ctaid_x();

pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.ctaid.y")
int ctaid_y();

pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.ctaid.z")
int ctaid_z();

//nctaid = gridDim
pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.nctaid.x")
int nctaid_x();

pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.nctaid.y")
int nctaid_y();

pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.nctaid.z")
int nctaid_z();

//warpsize
pragma(LDC_intrinsic, "llvm.nvvm.read.ptx.sreg.warpsize")
int warpsize();


