/// Metal simdgroup (warp) primitives for DCompute.
@compute(CompileFor.deviceOnly) module dcompute.std.metal.warp;

import ldc.dcompute;

/// Metal `simd_shuffle_xor(val, mask)`.
/// Exchanges `val` with the lane `lane_id ^ mask` within the SIMD group.
pragma(LDC_intrinsic, "air.simd_shuffle_xor.s.i32")
    int simdShuffleXor(int val, short mask);

/// ditto — float version.
pragma(LDC_intrinsic, "air.simd_shuffle_xor.s.f32")
    float simdShuffleXor(float val, short mask);
