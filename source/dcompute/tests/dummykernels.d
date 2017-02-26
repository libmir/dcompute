@compute(CompileFor.deviceOnly) module dcompute.dummykernels;
pragma(LDC_no_moduleinfo);
import ldc.attributes;
import dcompute.types.pointer;
import dcompute.reflect;
import dcompute.std.index;

@kernel void lfgsf( Pointer!(2,float) a,  Pointer!(2,float) b, float c )
{
    auto i = GlobalIndex.x;
    a[i] = b[i] +c;
}
