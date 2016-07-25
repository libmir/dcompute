@compute
module dcompute.tests.test;

import dcompute.attributes;
import dcompute.types.pointer;
import dcompute.std.index;
import std.traits;

@kernel
void map(alias F)(GlobalPointer!(ReturnType!(F)) r, Parameters!F args)
{
    r[GlobalIndex.x] = F(args);
}

