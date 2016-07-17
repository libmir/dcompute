@compute module dcompute.std.index;

import dcompute.attributes;
import dcompute.reflect;

import ocl  = dcompute.std.opencl.index;
import cuda = dcompute.std.cuda.index;

struct GroupDimension
{
    pragma(inline,true);
    @property static size_t x()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_sub_group_id(0);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.nctaid_x();
            
        return 0;
    }
    pragma(inline,true);
    @property static size_t y()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_num_groups(1);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.nctaid_y();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t z()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_num_groups(2);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.nctaid_z();
        
        return 0;
    }
}

struct LocalDimension
{
    pragma(inline,true);
    @property static size_t x()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_local_size(0);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ntid_x();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t y()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_local_size(1);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ntid_y();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t z()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_local_size(2);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ntid_y();
        
        return 0;
    }
}

struct GroupIndex
{
    pragma(inline,true);
    @property static size_t x()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_group_id(0);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ctaid_x();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t y()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_group_id(1);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ctaid_y();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t z()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_group_id(2);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ctaid_z();
        
        return 0;
    }
}

struct LocalIndex
{
    pragma(inline,true);
    @property static size_t x()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_local_id(0);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.tid_x();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t y()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_local_id(1);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.tid_y();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t z()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_local_id(2);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.tid_y();
        
        return 0;
    }
}

struct GlobalDimension
{
    pragma(inline,true);
    @property static size_t x()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_global_size(0);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ntid_x()*cuda.nctaid_x();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t y()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_global_size(1);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ntid_y()*cuda.nctaid_y();
        
        return 0;
    }
    pragma(inline,true);
    @property static size_t z()
    {
        if(__dcompute_reflect(target.OpenCL,0))
            return ocl.get_global_size(2);
        if(__dcompute_reflect(target.CUDA,0))
            return cuda.ntid_z()*cuda.nctaid_z();
        
        return 0;
    }
}
