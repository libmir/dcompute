@compute(CompileFor.deviceOnly) module dcompute.std.directx.image;

import ldc.dcompute;
pure: nothrow: @nogc:

// DXIL resource handle
// LDC uses `target("dxil")` or similar opaque handle for DXIL resources
// For now, we will represent it as an opaque void* or uint index depending on the ABI.
// Since we are using the Bindless ABI, the resource is actually a 32-bit index into the descriptor heap!
alias DXILHandle = uint;

// DXIL intrinsic for loading a texture.
// Note: IntrinsicsDirectX.td does not have a direct llvm.dx.textureLoad, 
// typically it is dx.op.textureLoad accessed via a generic resource op.
// We will stub this to a generic intrinsic that LDC could lower.
pragma(LDC_intrinsic, "llvm.dx.texture.load.1d")
T dx_texture_load_1d(T)(DXILHandle handle, uint x);

pragma(LDC_intrinsic, "llvm.dx.texture.load.2d")
T dx_texture_load_2d(T)(DXILHandle handle, uint x, uint y);

pragma(LDC_intrinsic, "llvm.dx.texture.load.3d")
T dx_texture_load_3d(T)(DXILHandle handle, uint x, uint y, uint z);
