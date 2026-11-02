module dcompute.driver.d3d12.context;

import dcompute.driver.d3d12.device;

/// D3D12 equivalent of CUDA's CUcontext.
/// In D3D12, the ID3D12Device IS the context, but this struct provides
/// API parity with DCompute's CUDA backend, enabling seamless thread-local
/// context switching (e.g. `Context.push(ctx)`).
struct Context
{
    Device device;
    
    // In D3D12 we don't have separate contexts per device like CUDA, 
    // the device acts as the context.
    this(Device dev, uint flags = 0)
    {
        this.device = dev;
    }

    /// Push this context onto the calling thread's context stack.
    /// All subsequent queue/memory operations on this thread will use this device.
    static void push(Context ctx)
    {
        _stack ~= ctx;
    }
    
    /// Pop the current context from the calling thread's stack.
    static Context pop()
    {
        if (_stack.length == 0)
            return Context(Device.init); // Handle empty stack gracefully
        
        Context ret = _stack[$ - 1];
        _stack.length--;
        return ret;
    }
    
    /// Get the current context for the calling thread.
    static @property Context current()
    {
        if (_stack.length == 0)
            return Context(Device.init);
            
        return _stack[$ - 1];
    }
    
    /// Set the current context for the calling thread, replacing the top of the stack.
    static @property void current(Context ctx)
    {
        if (_stack.length == 0)
            _stack ~= ctx;
        else
            _stack[$ - 1] = ctx;
    }

    private static Context[] _stack;
}
