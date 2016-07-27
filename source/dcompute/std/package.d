module dcompute.std;

version(D_DCompute) {}
else
{
    static assert(false, "Need to use a DCompute enabled compiler\n" ~
                         "See https://github.com/thewilsonator/ldc/tree/dcompute");
}


public import dcompute.std.index;