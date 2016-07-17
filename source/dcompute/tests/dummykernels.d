@compute module dcompute.dummykernels;
import dcompute.attributes;
import dcompute.types.pointer;
import dcompute.reflect;
import dcompute.std.index;
@kernel void lfgsf( Pointer!(1,float) a,  Pointer!(1,float) b, float c )
{
    if(__dcompute_reflect(target.CUDA, 0))
    *a = *b - c;
    else
    *a = *b + c;
}