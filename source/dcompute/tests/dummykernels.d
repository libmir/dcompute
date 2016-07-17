@compute module dcompute.dummykernels;
import dcompute.attributes;
import dcompute.types.pointer;
import dcompute.reflect;
import dcompute.std.index;
@kernel void lfgsf( Pointer!(1,float) a,  Pointer!(1,float) b, float c )
{
    auto i = LocalIndex.x;
    a[i] = b[i] +c;
}