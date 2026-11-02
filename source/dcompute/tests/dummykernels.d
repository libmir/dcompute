@compute(CompileFor.deviceOnly)
module dcompute.tests.dummykernels;
pragma(LDC_no_moduleinfo);

import ldc.dcompute;
import dcompute.std.index;

@kernel() void saxpy(GlobalPointer!(float) res,
                   float alpha,GlobalPointer!(float) x,
                   GlobalPointer!(float) y, 
                   size_t N)
{
    auto i = GlobalIndex.x;
    if (i >= N) return;
    res[i] = alpha*x[i] + y[i];
}

alias aagf = AutoIndexed!(GlobalPointer!(float));

@kernel() void auto_index_test(aagf a,
                             aagf b,
                             aagf c)
{
    a = b + c;
}

struct ComplexScalar {
    float x;
    float y;
    int z;
}

@kernel() void abi_test(
    int scalar1,                     // Scalar at start
    GlobalPointer!(float) buf0,      // u0
    ComplexScalar scalar2,           // Struct scalar
    GlobalPointer!(int) buf1,        // u1
    float scalar3,                   // Trailing scalar
    GlobalPointer!(float) buf2,      // u2
    size_t N                         // Scalar size_t
)
{
    auto i = GlobalIndex.x;
    if (i >= N) return;
    
    // Write out the scalars to the buffers to prove they were passed correctly
    buf0[i] = scalar2.x + scalar2.y + scalar3;
    buf1[i] = scalar1 + scalar2.z;
    buf2[i] = buf0[i] * cast(float)buf1[i];
}

// Dummy opaque type for DXIL texture resource binding testing
struct Texture2D(T) {
    // In a real DXIL module, this would be an opaque handle to a resource.
    // For ABI validation, we just need it to exist in the signature.
    uint dummy;
}

@kernel() void image_test(
    Texture2D!float inputImage,
    GlobalPointer!(float) outputBuf,
    size_t width,
    size_t height
)
{
    // Real LDC image intrinsics are WIP. We just validate the ABI unpacking logic here.
    auto idx = GlobalIndex.x;
    if (idx < width * height)
    {
        outputBuf[idx] = 1.0f; // Write something to prove execution didn't crash
    }
}
