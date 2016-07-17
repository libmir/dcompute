/*
 Variable declaration naming
 
 DCompute   OpenCL      Cuda            Metal
 Global     __global    __device__      device
 Shared     __local     __shared__      threadgroup
 Constant   __constant  __constant__    constant
 Private    __private   __local__       thread
 Generic
 
 */
module dcompute.types.pointer;


enum Private = 0;
enum Global = 1;
enum Shared = 2;
enum Constant = 3;
enum Generic = 4;

struct Pointer(uint p, T) if(p <= Generic)
{
    T* ptr;
    alias ptr this;
}

