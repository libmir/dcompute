@compute module dcompute.std.index;

import dcompute.attributes;
import dcompute.reflect;

import ocl  = dcompute.std.opencl.index;
import cuda = dcompute.std.cuda.index;

/*
 Index Terminology
 
 DCompute               CUDA                        OpenCL
 GlobalDimension.xyz    gridDim*blockDim            get_global_size()
 GlobalIndex.xyz        blockDim*blockIdx+threadIdx get_global_id()
 
 
 GroupDimension.zyx     gridDim                     get_num_groups()
 GroupIndex.xyz         blockIdx                    get_group_id()
 
 SharedDimension.xyz    blockDim                    get_local_size()
 SharedIndex.xyz        threadIdx                   get_local_id()
 
 GlobalIndex.linear     A nasty calcualion          get_global_linear_id()
 SharedIndex.linear     Ditto                       get_local_linear_id()
 
 Notes:
    *Index.{x,y,z} are bounded by *Dimension.{x,y,z}
    Use SharedIndex's to index Shared Memory and GlobalIndex's to index Global Memory
 
    A Group is the ratio of Global to Shared. GroupDimension is NOT the size of a single
    group, (thats SharedDimension) rather it is the number of groups along e.g 
    the x dimension. Similarly GroupIndex is how many units of the SharedDimension along
    a given dimension is.
 */
pure: nothrow: @nogc:

struct GlobalDimension
{
    pragma(inline,true);
    @property static size_t x()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_global_size(0);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ntid_x()*cuda.nctaid_x();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t y()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_global_size(1);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ntid_y()*cuda.nctaid_y();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t z()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_global_size(2);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ntid_z()*cuda.nctaid_z();
        
        return 0;
    }
}

struct GlobalIndex
{
    pragma(inline,true);
    @property static size_t x()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_global_id(0);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ctaid_x()*cuda.ntid_x() + cuda.tid_x();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t y()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_global_id(1);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ctaid_y()*cuda.ntid_y() + cuda.tid_y();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t z()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_global_id(2);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ctaid_z()*cuda.ntid_z() + cuda.tid_z();
        
        return 0;
    }
    @property static size_t linear()()
    {
        if(__dcompute_reflect(target.OpenCL,200))
            return ocl.get_global_linear_id();
        if(__dcompute_reflect(target.OpenCL,210))
            return ocl.get_global_linear_id();
        if(__dcompute_reflect(target.OpenCL,220))
            return ocl.get_global_linear_id();
        if(__dcompute_reflect(target.OpenCL,120))
            return (ocl.get_global_id(2) * ocl.get_global_size(1) * ocl.get_global_size(0))+
                (ocl.get_global_id(1) * ocl.get_global_size(0)) + ocl.get_global_id(0);
        if(__dcompute_reflect(target.CUDA,0))
        {
            return (z * GlobalDimension.y * GlobalDimension.x)+
                (y * GlobalDimension.x) + x;
        }
        return 0;
    }
}

struct GroupDimension
{
    pragma(inline,true);
    @property static size_t x()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_num_groups(0);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.nctaid_x();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t y()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_num_groups(1);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.nctaid_y();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t z()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_num_groups(2);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.nctaid_z();
        
        return 0;
    }
}

struct GroupIndex
{
    pragma(inline,true);
    @property static size_t x()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_group_id(0);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ntid_x();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t y()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_group_id(1);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ntid_y();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t z()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_group_id(2);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ntid_z();
        
        return 0;
    }
}

struct SharedDimension
{
    pragma(inline,true);
    @property static size_t x()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
        return ocl.get_local_size(0);
        if(__dcompute_reflect(target.CUDA,0))
        return cuda.ntid_x();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t y()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
        return ocl.get_local_size(1);
        if(__dcompute_reflect(target.CUDA,0))
        return cuda.ntid_y();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t z()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
        return ocl.get_local_size(2);
        if(__dcompute_reflect(target.CUDA,0))
        return cuda.ntid_z();
        
        return 0;
    }
}

struct SharedIndex
{
    pragma(inline,true);
    @property static size_t x()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
        return ocl.get_local_id(0);
        if(__dcompute_reflect(target.CUDA,0))
        return cuda.tid_x();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t y()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
        return ocl.get_local_id(1);
        if(__dcompute_reflect(target.CUDA,0))
        return cuda.tid_y();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t z()()
    {
        if(__dcompute_reflect(target.OpenCL,0))
        return ocl.get_local_id(2);
        if(__dcompute_reflect(target.CUDA,0))
        return cuda.tid_z();
        
        return 0;
    }
    @property static size_t linear()()
    {
        if(__dcompute_reflect(target.OpenCL,200))
            return ocl.get_local_linear_id();
        if(__dcompute_reflect(target.OpenCL,210))
            return ocl.get_local_linear_id();
        if(__dcompute_reflect(target.OpenCL,220))
            return ocl.get_local_linear_id();
        if(__dcompute_reflect(target.OpenCL,120))
        return (z * SharedDimension.y * SharedDimension.x)+
                (y * SharedDimension.x) + x;
        if(__dcompute_reflect(target.CUDA,0))
        {
            return (z * SharedDimension.y * SharedDimension.x)+
            (y * SharedDimension.x) + x;
        }
        return 0;
        
    }
}

