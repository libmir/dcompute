#include <metal_stdlib>
using namespace metal;

kernel void vec_add(
    device const float* a [[buffer(0)]],
    device const float* b [[buffer(1)]],
    device float* out [[buffer(2)]],
    uint id [[thread_position_in_grid]])
{
    out[id] = a[id] + b[id];
}
