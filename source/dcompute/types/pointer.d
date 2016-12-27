/*
 Variable declaration naming
 
 DCompute   OpenCL      Cuda            Metal
 Global     __global    __device__      device
 Shared     __local     __shared__      threadgroup
 Constant   __constant  __constant__    constant
 Private    __private   __local__       thread
 Generic
 
 DCompute avoids the use of 'local' as it means completely different
 things in OpenCL and CUDA.
 */
module dcompute.types.pointer;


enum Private = 0;
enum Global = 1;
enum Shared = 2;
enum Constant = 3;
enum Generic = 4;

alias PrivatePointer(T)     = Pointer!(Private,T);
alias GlobalPointer(T)      = Pointer!(Global,T);
alias SharedPointer(T)      = Pointer!(Shared,T);
alias ConstantPointer(T)    = Pointer!(Constant,T);
alias GenericPointer(T)     = Pointer!(Generic,T);

//This is a Magic compiler type. DO NOT CHANGE
struct Pointer(uint p, T) if(p <= Generic)
{
    T* ptr;
    alias ptr this;
}

