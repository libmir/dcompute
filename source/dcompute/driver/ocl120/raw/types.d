module dcompute.driver.ocl120.raw.types;

import dcompute.driver.ocl120;

alias bool_ = cl_bool;
alias char_   = cl_char;
alias uchar  = cl_uchar;
alias short_  = cl_short;
alias ushort_ = cl_ushort;
alias int_    = cl_int;
alias uint_   = cl_uint;
alias long_   = cl_long;
alias ulong_  = cl_ulong;

alias half   = cl_half;
alias float_  = cl_float;
alias double_ = cl_double;

alias GLuint = cl_GLuint;
alias GLint  = cl_GLint;
alias GLenum = cl_GLenum;


struct   platform_id
{
    cl_platform_id raw;
    auto opCast(T : void*)() { return cast(T)raw; }
}

struct     device_id
{
    cl_device_id raw;
    auto opCast(T : void*)() { return cast(T)raw; }
}

struct       context
{
    cl_context raw;
    auto opCast(T : void*)() { return cast(T)raw; }
}

struct command_queue
{
    cl_command_queue raw;
    auto opCast(T : void*)() { return cast(T)raw; }
}

struct           mem
{
    cl_mem raw;
    auto opCast(T : void*)() { return cast(T)raw; }
}

struct       program
{
    cl_program raw;
    auto opCast(T : void*)() { return cast(T)raw; }
}

struct        kernel
{
    cl_kernel raw;
    auto opCast(T : void*)() { return cast(T)raw; }
}

struct         event
{
    cl_event raw;
    auto opCast(T : void*)() { return cast(T)raw; }
}

struct       sampler
{
    cl_sampler raw;
    auto opCast(T : void*)() { return cast(T)raw; }
}

alias device_type                  = EnumTypedef!(cl_device_type, cl_device_type.init, "device_type");
alias platform_info                = EnumTypedef!(cl_platform_info, cl_platform_info.init, "platform_info");
alias device_info                  = EnumTypedef!(cl_device_info, cl_device_info.init, "device_info");
alias device_fp_config             = EnumTypedef!(cl_device_fp_config, cl_device_fp_config.init, "device_fp_config");
alias device_mem_cache_type        = EnumTypedef!(cl_device_mem_cache_type, cl_device_mem_cache_type.init, "device_mem_cache_type");
alias device_local_mem_type        = EnumTypedef!(cl_device_local_mem_type, cl_device_local_mem_type.init, "device_local_mem_type");
alias device_exec_capabilities     = EnumTypedef!(cl_device_exec_capabilities, cl_device_exec_capabilities.init, "device_exec_capabilities");
alias command_queue_properties     = EnumTypedef!(cl_command_queue_properties, cl_command_queue_properties.init, "command_queue_properties");
alias device_partition_property    = EnumTypedef!(cl_device_partition_property, cl_device_partition_property.init, "device_partition_property");
alias device_affinity_domain       = EnumTypedef!(cl_device_affinity_domain, cl_device_affinity_domain.init, "device_affinity_domain");

alias context_properties           = EnumTypedef!(cl_context_properties, cl_context_properties.init, "context_properties");
alias context_info                 = EnumTypedef!(cl_context_info, cl_context_info.init, "context_info");
alias command_queue_info           = EnumTypedef!(cl_command_queue_info, cl_command_queue_info.init, "command_queue_info");
alias channel_order                = EnumTypedef!(cl_channel_order, cl_channel_order.init, "channel_order");
alias channel_type                 = EnumTypedef!(cl_channel_type, cl_channel_type.init, "channel_type");
alias mem_flags                    = EnumTypedef!(cl_mem_flags, cl_mem_flags.init, "mem_flags");
alias mem_object_type              = EnumTypedef!(cl_mem_object_type, cl_mem_object_type.init, "mem_object_type");
alias mem_info                     = EnumTypedef!(cl_mem_info, cl_mem_info.init, "mem_info");
alias mem_migration_flags          = EnumTypedef!(cl_mem_migration_flags, cl_mem_migration_flags.init, "mem_migration_flags");
alias image_info                   = EnumTypedef!(cl_image_info, cl_image_info.init, "image_info");
alias buffer_create_type           = EnumTypedef!(cl_buffer_create_type, cl_buffer_create_type.init, "buffer_create_type");
alias addressing_mode              = EnumTypedef!(cl_addressing_mode, cl_addressing_mode.init, "addressing_mode");
alias filter_mode                  = EnumTypedef!(cl_filter_mode, cl_filter_mode.init, "filter_mode");
alias sampler_info                 = EnumTypedef!(cl_sampler_info, cl_sampler_info.init, "sampler_info");
alias map_flags                    = EnumTypedef!(cl_map_flags, cl_map_flags.init, "map_flags");
alias program_info                 = EnumTypedef!(cl_program_info, cl_program_info.init, "program_info");
alias program_build_info           = EnumTypedef!(cl_program_build_info, cl_program_build_info.init, "program_build_info");
alias program_binary_type          = EnumTypedef!(cl_program_binary_type, cl_program_binary_type.init, "program_binary_type");
alias build_status                 = EnumTypedef!(cl_build_status, cl_build_status.init, "build_status");
alias kernel_info                  = EnumTypedef!(cl_kernel_info, cl_kernel_info.init, "kernel_info");
alias kernel_arg_info              = EnumTypedef!(cl_kernel_arg_info, cl_kernel_arg_info.init, "kernel_arg_info");
alias kernel_arg_address_qualifier = EnumTypedef!(cl_kernel_arg_address_qualifier, cl_kernel_arg_address_qualifier.init, "kernel_arg_address_qualifier");
alias kernel_arg_access_qualifier  = EnumTypedef!(cl_kernel_arg_access_qualifier, cl_kernel_arg_access_qualifier.init, "kernel_arg_access_qualifier");
alias kernel_arg_type_qualifier    = EnumTypedef!(cl_kernel_arg_type_qualifier, cl_kernel_arg_type_qualifier.init, "kernel_arg_type_qualifier");
alias kernel_work_group_info       = EnumTypedef!(cl_kernel_work_group_info, cl_kernel_work_group_info.init, "kernel_work_group_info");
alias event_info                   = EnumTypedef!(cl_event_info, cl_event_info.init, "event_info");
alias command_type                 = EnumTypedef!(cl_command_type, cl_command_type.init, "command_type");
alias profiling_info               = EnumTypedef!(cl_profiling_info, cl_profiling_info.init, "profiling_info");

alias image_format  = cl_image_format;
alias image_desc    = cl_image_desc;
alias buffer_region = cl_buffer_region;

alias device_partition_property_ext = EnumTypedef!(cl_device_partition_property_ext, cl_device_partition_property_ext.init, "device_partition_property_ext");

public import derelict.opencl.cl : CLeglImageKHR, CLeglDisplayKHR;
alias egl_image_properties_khr = EnumTypedef!(cl_egl_image_properties_khr, cl_egl_image_properties_khr.init, "egl_image_properties_khr");

alias gl_object_type = EnumTypedef!(cl_gl_object_type, cl_gl_object_type.init, "gl_object_type");
alias gl_texture_info = EnumTypedef!(cl_gl_texture_info, cl_gl_texture_info.init, "gl_texture_info");
alias gl_platform_info = EnumTypedef!(cl_gl_platform_info, cl_gl_platform_info.init, "gl_platform_info");

alias GLsync = cl_GLsync;

alias gl_context_info = EnumTypedef!(cl_gl_context_info, cl_gl_context_info.init, "gl_context_info");

public import derelict.opencl.cl : ID3D10Buffer, ID3D10Texture2D, ID3D10Texture3D;

alias d3d10_device_source_khr = EnumTypedef!(cl_d3d10_device_source_khr, cl_d3d10_device_source_khr.init, "d3d10_device_source_khr");
alias d3d10_device_set_khr = EnumTypedef!(cl_d3d10_device_set_khr, cl_d3d10_device_set_khr.init, "d3d10_device_set_khr");

public import derelict.opencl.cl : ID3D11Buffer, ID3D11Texture2D, ID3D11Texture3D;

alias d3d11_device_source_khr = EnumTypedef!(cl_d3d11_device_source_khr, cl_d3d11_device_source_khr.init, "d3d11_device_source_khr");
alias d3d11_device_set_khr = EnumTypedef!(cl_d3d11_device_set_khr, cl_d3d11_device_set_khr.init, "d3d11_device_set_khr");

alias dx9_media_adapter_type_khr = EnumTypedef!(cl_dx9_media_adapter_type_khr, cl_dx9_media_adapter_type_khr.init, "dx9_media_adapter_type_khr");
alias dx9_media_adapter_set_khr = EnumTypedef!(cl_dx9_media_adapter_set_khr, cl_dx9_media_adapter_set_khr.init, "dx9_media_adapter_set_khr");

version(Windows)
{
    public import derelict.opencl.cl : IDirect3DSurface9, HANDLE;

    alias dx9_surface_info_khr = cl_dx9_surface_info_khr;
}

/+
private template RawType(T)
{
    import std.traits : hasMember;
    pragma(msg, T);
    static if (is(T : U*, U))
        alias RawType = RawType!(U)*;
    else static if (is(T : const(U*), U))
        alias RawType = const(RawType!(U)*);
    else static if (hasMember!(T, "raw"))
        alias RawType = typeof(T.raw);
    else static if (is(T : Typedef!Args, Args...))
        alias RawType = Args[0];
    else static if (is(T : const(Typedef!Args), Args...))
        alias RawType = const(Args[0]);
    else
        alias RawType = T;
}

private auto toRawType(T)(T v)
{
    pragma(msg, "from toRawType: " ~ T.stringof);
    return cast(RawType!T)v;
}+/

struct EnumTypedef(T, T init = T.init, string cookie=null)
{
    private T Typedef_payload = init;
    
    this(T init)
    {
        Typedef_payload = init;
    }
    
    this(EnumTypedef tdef)
    {
        this(tdef.Typedef_payload);
    }
    
    // We need to add special overload for cast(Typedef!X)exp,
    // thus we can't simply inherit Proxy!Typedef_payload
    T2 opCast(T2 : EnumTypedef!(T, Unused), this X, T, Unused...)()
    {
        return T2(cast(T)Typedef_payload);
    }
    
    auto ref opCast(T2, this X)()
    {
        return cast(T2)Typedef_payload;
    }

    auto opBinary(string op, T)(T a)
    {
        mixin("return cast(typeof(this))(Typedef_payload " ~ op ~ " a);");
    }

    auto opUnary(string op)()
    {
        mixin("return cast(typeof(this))(" ~ op ~ "Typedef_payload);");
    }
    
    import std.typecons : Proxy;
    mixin Proxy!Typedef_payload;
}
