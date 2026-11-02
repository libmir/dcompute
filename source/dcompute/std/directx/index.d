@compute(CompileFor.deviceOnly) module dcompute.std.directx.index;

import ldc.dcompute;
pure: nothrow: @nogc:

// LLVM DXIL thread intrinsics take a single i32 dimension argument:
//   llvm.dx.thread.id(0) = x, (1) = y, (2) = z

// SV_DispatchThreadID (Global Thread ID)
pragma(LDC_intrinsic, "llvm.dx.thread.id")
uint thread_id(uint dim);

// SV_GroupThreadID (Local Thread ID within a group)
pragma(LDC_intrinsic, "llvm.dx.thread.id.in.group")
uint thread_id_in_group(uint dim);

// SV_GroupID (Group/Block ID)
pragma(LDC_intrinsic, "llvm.dx.group.id")
uint group_id(uint dim);

// SV_GroupIndex (Flattened local thread ID)
pragma(LDC_intrinsic, "llvm.dx.flattened.thread.id.in.group")
uint flattened_thread_id_in_group();
