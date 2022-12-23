module dcompute.std.cuda.texture;

// CUDA texture sampling return types
struct int4
{
    int x, y, z, w;
}

struct float4
{
    float x, y, z, w;

    float4 opBinary(string op)(float s) if (op == "+"){
        return float4(x+s, y+s, z+s, w+s);
    }
    float4 opBinary(string op)(float s) if (op == "-"){
        return float4(x-s, y-s, z-s, w-s);
    }
    float4 opBinary(string op)(float s) if (op == "*") {
        return float4(x*s, y*s, z*s, w*s);
    }
    float4 opBinary(string op)(float s) if (op == "/") {
        return float4(x/s, y/s, z/s, w/s);
    }

    float4 opBinary(string op)(float4 other){
        static if (op == "+"){
            return float4(x+other.x, y+other.y, z+other.z, w+other.w);
        }else
        static if (op == "-"){
            return float4(x-other.x, y-other.y, z-other.z, w-other.w);
        }else
        static if (op == "*"){
            return float4(x*other.x, y*other.y, z*other.z, w*other.w);
        }else
        static if (op == "/"){
            return float4(x/other.x, y/other.y, z/other.z, w/other.w);
        }
        else
            static assert(0, "op is not implemented");
    }
}

// Sampling a 1D texture:

//%float4 @llvm.nvvm.tex.unified.1d.v4f32.s32(i64 %tex, i32 %x)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.v4f32.s32")
float4 tex_unified_1d_v4f32_s32(long tex, int x);

//%float4 @llvm.nvvm.tex.unified.1d.v4f32.f32(i64 %tex, float %x)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.v4f32.f32")
float4 tex_unified_1d_v4f32_f32(long tex, float x);

//%float4 @llvm.nvvm.tex.unified.1d.level.v4f32.f32(i64 %tex, float %x, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.level.v4f32.f32")
float4 tex_unified_1d_level_v4f32_f32(long tex, float x, float level);

//%float4 @llvm.nvvm.tex.unified.1d.grad.v4f32.f32(i64 %tex, float %x, float %dPdx, float %dPdy)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.grad.v4f32.f32")
float4 tex_unified_1d_grad_v4f32_f32(long tex, float x, float dPdx, float dPdy);

//%int4 @llvm.nvvm.tex.unified.1d.v4s32.s32(i64 %tex, i32 %x)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.v4s32.s32")
int4 tex_unified_1d_v4s32_s32(long tex, int x);

//%int4 @llvm.nvvm.tex.unified.1d.v4s32.f32(i64 %tex, float %x)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.v4s32.f32")
int4 tex_unified_1d_v4s32_f32(long tex, float x);

//%int4 @llvm.nvvm.tex.unified.1d.level.v4s32.f32(i64 %tex, float %x, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.level.v4s32.f32")
int4 tex_unified_1d_level_v4s32_f32(long tex, float x, float level);

//%int4 @llvm.nvvm.tex.unified.1d.grad.v4s32.f32(i64 %tex, float %x, float %dPdx, float %dPdy)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.grad.v4s32.f32")
int4 tex_unified_1d_grad_v4s32_f32(long tex, float x, float dPdx, float dPdy);

//%int4 @llvm.nvvm.tex.unified.1d.v4u32.s32(i64 %tex, i32 %x)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.v4u32.s32")
int4 tex_unified_1d_v4u32_s32(long tex, int x);

//%int4 @llvm.nvvm.tex.unified.1d.v4u32.f32(i64 %tex, float %x)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.v4u32.f32")
int4 tex_unified_1d_v4u32_f32(long tex, float x);

//%int4 @llvm.nvvm.tex.unified.1d.level.v4u32.f32(i64 %tex, float %x, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.level.v4u32.f32")
int4 tex_unified_1d_level_v4u32_f32(long tex, float x, float level);

//%int4 @llvm.nvvm.tex.unified.1d.grad.v4u32.f32(i64 %tex, float %x, float %dPdx, float %dPdy)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.grad.v4u32.f32")
int4 tex_unified_1d_grad_v4u32_f32(long tex, float x, float dPdx, float dPdy);


// Sampling a 1D texture array:

//%float4 @llvm.nvvm.tex.unified.1d.array.v4f32.s32(i64 %tex, i32 %idx, i32 %x)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.array.v4f32.s32")
float4 tex_unified_1d_array_v4f32_s32(long tex, int idx, int x);

//%float4 @llvm.nvvm.tex.unified.1d.array.v4f32.f32(i64 %tex, i32 %idx, float %x)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.array.v4f32.f32")
float4 tex_unified_1d_array_v4f32_f32(long tex, int idx, float x);

//%float4 @llvm.nvvm.tex.unified.1d.array.level.v4f32.f32(i64 %tex, i32 %idx, float %x, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.array.level.v4f32.f32")
float4 tex_unified_1d_array_level_v4f32_f32(long tex, int idx, float x, float level);

//%float4 @llvm.nvvm.tex.unified.1d.array.grad.v4f32.f32(i64 %tex, i32 %idx, float %x, float %dPdx, float %dPdy)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.array.grad.v4f32.f32")
float4 tex_unified_1d_array_grad_v4f32_f32(long tex, int idx, float x, float dPdx, float dPdy);

//%int4 @llvm.nvvm.tex.unified.1d.array.v4s32.s32(i64 %tex, i32 %idx, i32 %x)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.array.v4s32.s32")
int4 tex_unified_1d_array_v4s32_s32(long tex, int idx, int x);

//%int4 @llvm.nvvm.tex.unified.1d.array.v4s32.f32(i64 %tex, i32 %idx, float %x)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.array.v4s32.f32")
int4 tex_unified_1d_array_v4s32_f32(long tex, int idx, float x);

//%int4 @llvm.nvvm.tex.unified.1d.array.level.v4s32.f32(i64 %tex, i32 %idx, float %x, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.array.level.v4s32.f32")
int4 tex_unified_1d_array_level_v4s32_f32(long tex, int idx, float x, float level);

//%int4 @llvm.nvvm.tex.unified.1d.array.grad.v4s32.f32(i64 %tex, i32 %idx, float %x, float %dPdx, float %dPdy)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.array.grad.v4s32.f32")
int4 tex_unified_1d_array_grad_v4s32_f32(long tex, int idx, float x, float dPdx, float dPdy);

//%int4 @llvm.nvvm.tex.unified.1d.array.v4u32.s32(i64 %tex, i32 %idx, i32 %x)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.array.v4u32.s32")
int4 tex_unified_1d_array_v4u32_s32(long tex, int idx, int x);

//%int4 @llvm.nvvm.tex.unified.1d.array.v4u32.f32(i64 %tex, i32 %idx, float %x)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.array.v4u32.f32")
int4 tex_unified_1d_array_v4u32_f32(long tex, int idx, float x);

//%int4 @llvm.nvvm.tex.unified.1d.array.level.v4u32.f32(i64 %tex, i32 %idx, float %x, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.array.level.v4u32.f32")
int4 tex_unified_1d_array_level_v4u32_f32(long tex, int idx, float x, float level);

//%int4 @llvm.nvvm.tex.unified.1d.array.grad.v4u32.f32(i64 %tex, i32 %idx, float %x, float %dPdx, float %dPdy)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.1d.array.grad.v4u32.f32")
int4 tex_unified_1d_array_grad_v4u32_f32(long tex, int idx, float x, float dPdx, float dPdy);


// Sampling a 2D texture:


//%float4 @llvm.nvvm.tex.unified.2d.v4f32.s32(i64 %tex, i32 %x, i32 %y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.v4f32.s32")
float4 tex_unified_2d_v4f32_s32(long tex, int x, int y);

//%float4 @llvm.nvvm.tex.unified.2d.v4f32.f32(i64 %tex, float %x, float %y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.v4f32.f32")
float4 tex_unified_2d_v4f32_f32(long tex, float x, float y);

//%float4 @llvm.nvvm.tex.unified.2d.level.v4f32.f32(i64 %tex, float %x, float %y, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.level.v4f32.f32")
float4 tex_unified_2d_level_v4f32_f32(long tex, float x, float y, float level);

//%float4 @llvm.nvvm.tex.unified.2d.grad.v4f32.f32(i64 %tex, float %x, float %y, float %dPdx_x, float %dPdx_y, float %dPdy_x, float %dPdy_y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.grad.v4f32.f32")
float4 tex_unified_2d_grad_v4f32_f32(long tex, float x, float y, float dPdx_x, float dPdx_y, float dPdy_x, float dPdy_y);

//%int4 @llvm.nvvm.tex.unified.2d.v4s32.s32(i64 %tex, i32 %x, i32 %y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.v4s32.s32")
int4 tex_unified_2d_v4s32_s32(long tex, int x, int y);

//%int4 @llvm.nvvm.tex.unified.2d.v4s32.f32(i64 %tex, float %x, float %y,)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.v4s32.f32")
int4 tex_unified_2d_v4s32_f32(long tex, float x, float y,);

//%int4 @llvm.nvvm.tex.unified.2d.level.v4s32.f32(i64 %tex, float %x, float %y, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.level.v4s32.f32")
int4 tex_unified_2d_level_v4s32_f32(long tex, float x, float y, float level);

//%int4 @llvm.nvvm.tex.unified.2d.grad.v4s32.f32(i64 %tex, float %x, float %y, float %dPdx_x, float %dPdx_y, float %dPdy_x, float %dPdy_y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.grad.v4s32.f32")
int4 tex_unified_2d_grad_v4s32_f32(long tex, float x, float y, float dPdx_x, float dPdx_y, float dPdy_x, float dPdy_y);

//%int4 @llvm.nvvm.tex.unified.2d.v4u32.s32(i64 %tex, i32 %x i32 %y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.v4u32.s32")
int4 tex_unified_2d_v4u32_s32(long tex, int x, int y);

//%int4 @llvm.nvvm.tex.unified.2d.v4u32.f32(i64 %tex, float %x float %y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.v4u32.f32")
int4 tex_unified_2d_v4u32_f32(long tex, float x, float y);

//%int4 @llvm.nvvm.tex.unified.2d.level.v4u32.f32(i64 %tex, float %x, float %y, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.level.v4u32.f32")
int4 tex_unified_2d_level_v4u32_f32(long tex, float x, float y, float level);

//%int4 @llvm.nvvm.tex.unified.2d.grad.v4u32.f32(i64 %tex, float %x, float %y, float %dPdx_x, float %dPdx_y, float %dPdy_x, float %dPdy_y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.grad.v4u32.f32")
int4 tex_unified_2d_grad_v4u32_f32(long tex, float x, float y, float dPdx_x, float dPdx_y, float dPdy_x, float dPdy_y);

// Sampling a 2D texture array:


//%float4 @llvm.nvvm.tex.unified.2d.array.v4f32.s32(i64 %tex, i32 %idx, i32 %x, i32 %y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.array.v4f32.s32")
float4 tex_unified_2d_array_v4f32_s32(long tex, int idx, int x, int y);

//%float4 @llvm.nvvm.tex.unified.2d.array.v4f32.f32(i64 %tex, i32 %idx, float %x, float %y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.array.v4f32.f32")
float4 tex_unified_2d_array_v4f32_f32(long tex, int idx, float x, float y);

//%float4 @llvm.nvvm.tex.unified.2d.array.level.v4f32.f32(i64 %tex, i32 %idx, float %x, float %y, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.array.level.v4f32.f32")
float4 tex_unified_2d_array_level_v4f32_f32(long tex, int idx, float x, float y, float level);

//%float4 @llvm.nvvm.tex.unified.2d.array.grad.v4f32.f32(i64 %tex, i32 %idx, float %x, float %y, float %dPdx_x, float %dPdx_y, float %dPdy_x, float %dPdy_y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.array.grad.v4f32.f32")
float4 tex_unified_2d_array_grad_v4f32_f32(long tex, int idx, float x, float y, float dPdx_x, float dPdx_y, float dPdy_x, float dPdy_y);

//%int4 @llvm.nvvm.tex.unified.2d.array.v4s32.s32(i64 %tex, i32 %idx, i32 %x, i32 %y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.array.v4s32.s32")
int4 tex_unified_2d_array_v4s32_s32(long tex, int idx, int x, int y);

//%int4 @llvm.nvvm.tex.unified.2d.array.v4s32.f32(i64 %tex, i32 %idx, float %x, float %y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.array.v4s32.f32")
int4 tex_unified_2d_array_v4s32_f32(long tex, int idx, float x, float y);

//%int4 @llvm.nvvm.tex.unified.2d.array.level.v4s32.f32(i64 %tex, i32 %idx, float %x, float %y, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.array.level.v4s32.f32")
int4 tex_unified_2d_array_level_v4s32_f32(long tex, int idx, float x, float y, float level);

//%int4 @llvm.nvvm.tex.unified.2d.array.grad.v4s32.f32(i64 %tex, i32 %idx, float %x, float %y, float %dPdx_x, float %dPdx_y, float %dPdy_x, float %dPdy_y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.array.grad.v4s32.f32")
int4 tex_unified_2d_array_grad_v4s32_f32(long tex, int idx, float x, float y, float dPdx_x, float dPdx_y, float dPdy_x, float dPdy_y);

//%int4 @llvm.nvvm.tex.unified.2d.array.v4u32.s32(i64 %tex, i32 %idx, i32 %x i32 %y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.array.v4u32.s32")
int4 tex_unified_2d_array_v4u32_s32(long tex, int idx, int x, int y);

//%int4 @llvm.nvvm.tex.unified.2d.array.v4u32.f32(i64 %tex, i32 %idx, float %x float %y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.array.v4u32.f32")
int4 tex_unified_2d_array_v4u32_f32(long tex, int idx, float x, float y);

//%int4 @llvm.nvvm.tex.unified.2d.array.level.v4u32.f32(i64 %tex, i32 %idx, float %x, float %y, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.array.level.v4u32.f32")
int4 tex_unified_2d_array_level_v4u32_f32(long tex, int idx, float x, float y, float level);

//%int4 @llvm.nvvm.tex.unified.2d.array.grad.v4u32.f32(i64 %tex, i32 %idx, float %x, float %y, float %dPdx_x, float %dPdx_y, float %dPdy_x, float %dPdy_y)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.2d.array.grad.v4u32.f32")
int4 tex_unified_2d_array_grad_v4u32_f32(long tex, int idx, float x, float y, float dPdx_x, float dPdx_y, float dPdy_x, float dPdy_y);

// Sampling a 3D texture:

//%float4 @llvm.nvvm.tex.unified.3d.v4f32.s32(i64 %tex, i32 %x, i32 %y, i32 %z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.3d.v4f32.s32")
float4 tex_unified_3d_v4f32_s32(long tex, int x, int y, int z);

//%float4 @llvm.nvvm.tex.unified.3d.v4f32.f32(i64 %tex, float %x, float %y, float %z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.3d.v4f32.f32")
float4 tex_unified_3d_v4f32_f32(long tex, float x, float y, float z);

//%float4 @llvm.nvvm.tex.unified.3d.level.v4f32.f32(i64 %tex,float %x, float %y, float %z, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.3d.level.v4f32.f32")
float4 tex_unified_3d_level_v4f32_f32(long tex,float x, float y, float z, float level);

//%float4 @llvm.nvvm.tex.unified.3d.grad.v4f32.f32(i64 %tex, float %x, float %y, float %z, float %dPdx_x, float %dPdx_y, float %dPdx_z, float %dPdy_x, float %dPdy_y, float %dPdy_z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.3d.grad.v4f32.f32")
float4 tex_unified_3d_grad_v4f32_f32(long tex, float x, float y, float z, float dPdx_x, float dPdx_y, float dPdx_z, float dPdy_x, float dPdy_y, float dPdy_z);

//%int4 @llvm.nvvm.tex.unified.3d.v4s32.s32(i64 %tex, i32 %x, i32 %y, i32 %z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.3d.v4s32.s32")
int4 tex_unified_3d_v4s32_s32(long tex, int x, int y, int z);

//%int4 @llvm.nvvm.tex.unified.3d.v4s32.f32(i64 %tex, float %x, float %y, float %z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.3d.v4s32.f32")
int4 tex_unified_3d_v4s32_f32(long tex, float x, float y, float z);

//%int4 @llvm.nvvm.tex.unified.3d.level.v4s32.f32(i64 %tex, float %x, float %y, float %z, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.3d.level.v4s32.f32")
int4 tex_unified_3d_level_v4s32_f32(long tex, float x, float y, float z, float level);

//%int4 @llvm.nvvm.tex.unified.3d.grad.v4s32.f32(i64 %tex, float %x, float %y, float %z, float %dPdx_x, float %dPdx_y, float %dPdx_z, float %dPdy_x, float %dPdy_y, float %dPdy_z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.3d.grad.v4s32.f32")
int4 tex_unified_3d_grad_v4s32_f32(long tex, float x, float y, float z, float dPdx_x, float dPdx_y, float dPdx_z, float dPdy_x, float dPdy_y, float dPdy_z);

//%int4 @llvm.nvvm.tex.unified.3d.v4u32.s32(i64 %tex, i32 %x i32 %y, i32 %z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.3d.v4u32.s32")
int4 tex_unified_3d_v4u32_s32(long tex, int x, int y, int z);

//%int4 @llvm.nvvm.tex.unified.3d.v4u32.f32(i64 %tex, float %x, float %y, float %z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.3d.v4u32.f32")
int4 tex_unified_3d_v4u32_f32(long tex, float x, float y, float z);

//%int4 @llvm.nvvm.tex.unified.3d.level.v4u32.f32(i64 %tex, float %x, float %y, float %z, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.3d.level.v4u32.f32")
int4 tex_unified_3d_level_v4u32_f32(long tex, float x, float y, float z, float level);

//%int4 @llvm.nvvm.tex.unified.3d.grad.v4u32.f32(i64 %tex, float %x, float %y, float %z, float %dPdx_x, float %dPdx_y, float %dPdx_z, float %dPdy_x, float %dPdy_y, float %dPdy_z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.3d.grad.v4u32.f32")
int4 tex_unified_3d_grad_v4u32_f32(long tex, float x, float y, float z, float dPdx_x, float dPdx_y, float dPdx_z, float dPdy_x, float dPdy_y, float dPdy_z);

// Sampling a cube texture:

//%float4 @llvm.nvvm.tex.unified.cube.v4f32.f32(i64 %tex, float %x, float %y, float %z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.cube.v4f32.f32")
float4 tex_unified_cube_v4f32_f32(long tex, float x, float y, float z);

//%float4 @llvm.nvvm.tex.unified.cube.level.v4f32.f32(i64 %tex,float %x, float %y, float %z, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.cube.level.v4f32.f32")
float4 tex_unified_cube_level_v4f32_f32(long tex,float x, float y, float z, float level);

//%int4 @llvm.nvvm.tex.unified.cube.v4s32.f32(i64 %tex, float %x, float %y, float %z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.cube.v4s32.f32")
int4 tex_unified_cube_v4s32_f32(long tex, float x, float y, float z);

//%int4 @llvm.nvvm.tex.unified.cube.level.v4s32.f32(i64 %tex, float %x, float %y, float %z, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.cube.level.v4s32.f32")
int4 tex_unified_cube_level_v4s32_f32(long tex, float x, float y, float z, float level);

//%int4 @llvm.nvvm.tex.unified.cube.v4u32.f32(i64 %tex, float %x, float %y, float %z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.cube.v4u32.f32")
int4 tex_unified_cube_v4u32_f32(long tex, float x, float y, float z);

//%int4 @llvm.nvvm.tex.unified.cube.level.v4u32.f32(i64 %tex, float %x, float %y, float %z, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.cube.level.v4u32.f32")
int4 tex_unified_cube_level_v4u32_f32(long tex, float x, float y, float z, float level);

// Sampling a cube texture array:

//%float4 @llvm.nvvm.tex.unified.cube.array.v4f32.f32(i64 %tex, i32 %idx, float %x, float %y, float %z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.cube.array.v4f32.f32")
float4 tex_unified_cube_array_v4f32_f32(long tex, int idx, float x, float y, float z);

//%float4 @llvm.nvvm.tex.unified.cube.array.level.v4f32.f32(i64 %tex, i32 %idx, float %x, float %y, float %z, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.cube.array.level.v4f32.f32")
float4 tex_unified_cube_array_level_v4f32_f32(long tex, int idx, float x, float y, float z, float level);

//%int4 @llvm.nvvm.tex.unified.cube.array.v4s32.f32(i64 %tex, i32 %idx, float %x, float %y, float %z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.cube.array.v4s32.f32")
int4 tex_unified_cube_array_v4s32_f32(long tex, int idx, float x, float y, float z);

//%int4 @llvm.nvvm.tex.unified.cube.array.level.v4s32.f32(i64 %tex, i32 %idx, float %x, float %y, float %z, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.cube.array.level.v4s32.f32")
int4 tex_unified_cube_array_level_v4s32_f32(long tex, int idx, float x, float y, float z, float level);

//%int4 @llvm.nvvm.tex.unified.cube.array.v4u32.f32(i64 %tex, i32 %idx, float %x, float %y, float %z)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.cube.array.v4u32.f32")
int4 tex_unified_cube_array_v4u32_f32(long tex, int idx, float x, float y, float z);

//%int4 @llvm.nvvm.tex.unified.cube.array.level.v4u32.f32(i64 %tex, i32 %idx, float %x, float %y, float %z, float %level)
pragma(LDC_intrinsic, "llvm.nvvm.tex.unified.cube.array.level.v4u32.f32")
int4 tex_unified_cube_array_level_v4u32_f32(long tex, int idx, float x, float y, float z, float level);
