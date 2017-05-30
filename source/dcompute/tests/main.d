import dcompute.tests.test;

import std.stdio;
import std.traits;
import std.meta;

struct Buffer {}
struct Queue {}
void computeMap(alias F)(Queue q,Buffer b,  Parameters!F _args){
    alias kfunc = map!F;
    alias args = AliasSeq!(b,_args);
    // int err;
    // auto k = Kernel(globalProgram,(kfunc).mangleof,&err);
    //enforce(err == Error.Success);
    //setKernelParameters!(kfunc)(k, args);
    //q.enqueueKernel(k,1,/*Offset*/[0],/GlobalSize**/[linearShapeOf(b)]
    //                  ,/*SharedSize*/[someSensibleDefault(linearShapeOf(b))]
    //                  ,/*events*/[],null);
    string s = (kfunc).mangleof;
    writeln(s);
}

int main(string[] args)
{
    int a = 3;
    auto q = Queue();
    auto b = Buffer();
    q.computeMap!((int x) => x*x)(b, a);
    return 0;
}


