@compute module dcompute.std.index;

import dcompute.attributes;
import dcompute.reflect;

import ocl  = dcompute.std.opencl.index;
import cuda = dcompute.std.cuda.index;

struct GroupDimension
{
    @property static int x()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_num_groups(0);
        if(__dcompute_reflect(target.CUDA))
            return cuda.nctaid_x();
            
        return 0;
    }
    
    @property static int y()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_num_groups(1);
        if(__dcompute_reflect(target.CUDA))
            return cuda.nctaid_y();
        
        return 0;
    }
    
    @property static int z()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_num_groups(2);
        if(__dcompute_reflect(target.CUDA))
            return cuda.nctaid_z();
        
        return 0;
    }
}

struct LocalDimension
{
    @property static int x()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_local_size(0);
        if(__dcompute_reflect(target.CUDA))
            return cuda.ntid_x();
        
        return 0;
    }
    
    @property static int y()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_local_size(1);
        if(__dcompute_reflect(target.CUDA))
            return cuda.ntid_y();
        
        return 0;
    }
    
    @property static int z()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_local_size(2);
        if(__dcompute_reflect(target.CUDA))
            return cuda.ntid_y();
        
        return 0;
    }
}

struct GroupIndex
{
    @property static int x()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_group_id(0);
        if(__dcompute_reflect(target.CUDA))
            return cuda.ctaid_x();
        
        return 0;
    }
    
    @property static int y()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_group_id(1);
        if(__dcompute_reflect(target.CUDA))
            return cuda.ctaid_y();
        
        return 0;
    }
    
    @property static int z()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_group_id(2);
        if(dcompute_reflect(target.CUDA))
            return cuda.ctaid_z();
        
        return 0;
    }
}

struct LocalIndex
{
    @property static int x()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_local_id(0);
        if(__dcompute_reflect(target.CUDA))
            return cuda.tid_x();
        
        return 0;
    }
    
    @property static int y()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_local_id(1);
        if(__dcompute_reflect(target.CUDA))
            return cuda.tid_y();
        
        return 0;
    }
    
    @property static int z()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_local_id(2);
        if(__dcompute_reflect(target.CUDA))
            return cuda.tid_y();
        
        return 0;
    }
}

struct GlobalDimension
{
    @property static int x()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_global_size(0);
        if(__dcompute_reflect(target.CUDA))
            return cuda.ntid_x()*cuda.nctaid_x();
        
        return 0;
    }
    
    @property static int y()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_global_size(1);
        if(__dcompute_reflect(target.CUDA))
            return cuda.ntid_y()*cuda.nctaid_y();
        
        return 0;
    }
    
    @property static int z()
    {
        if(__dcompute_reflect(target.OpenCL))
            return ocl.get_global_size(2);
        if(__dcompute_reflect(target.CUDA))
            return cuda.ntid_z()*cuda.nctaid_z();
        
        return 0;
    }
}
