@compute(CompileFor.deviceOnly)
module dcompute.dummykernels;
pragma(LDC_no_moduleinfo);

import ldc.dcompute;
import dcompute.std.index;

@kernel void saxpy(GlobalPointer!(float) a, GlobalPointer!(float) b, float c )
{
    auto i = GlobalIndex.x;
    a[i] = b[i] +c;
}
