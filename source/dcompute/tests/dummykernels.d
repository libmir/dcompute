@compute(CompileFor.deviceOnly)
module dcompute.tests.dummykernels;
pragma(LDC_no_moduleinfo);

import ldc.dcompute;
import ldc.intrinsics;
import dcompute.std.index;

mixin template _saxpy() {
    void saxpy(GlobalPointer!(float) res,
                    float alpha,GlobalPointer!(float) x,
                    GlobalPointer!(float) y, 
                    size_t N)
    {
        auto i = GlobalIndex.x;
        if (i >= N) return;
        res[i] = alpha*x[i] + y[i];
    }    
}

alias aagf = AutoIndexed!(GlobalPointer!(float));

mixin template _auto_index_test() {
    void auto_index_test(aagf a,
                            aagf b,
                            aagf c)
    {
        a = b + c;
    }
}

static if (LLVM_atleast!21) { // >= LDC 1.42.0(LLVM 21)
    pragma(msg, "using LDC version >= 1.42.0(LLVM 21)");
    @kernel() mixin _saxpy;
    @kernel() mixin _auto_index_test;
} else {
    pragma(msg, "using LDC version < 1.42.0(LLVM 21)");
    @kernel mixin _saxpy;
    @kernel mixin _auto_index_test;
}
