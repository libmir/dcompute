module dcompute.driver.d3d12.runtime;

import dcompute.driver.d3d12.device;
import dcompute.driver.d3d12.platform;
import dcompute.driver.d3d12.queue;
import dcompute.driver.d3d12.program;
import dcompute.driver.d3d12.context;

// Global state
struct Config
{
    /// If true, the driver will use SM 6.6 Bindless architecture.
    /// WARNING: Do NOT enable this until LDC supports lowering GlobalPointer to a 32-bit index!
    __gshared static bool enableBindlessABI = false;
}

private __gshared Device  _defaultDevice;
private __gshared Context _defaultContext;
private __gshared bool    _platformReady = false;

// Thread-local state
private static Queue _threadQueue;
private static Queue _threadCopyQueue;
private static bool  _threadReady = false;

// Init hooks (mirroring CUDA driver)
shared static this()
{
    version(LDC_DCompute_DirectX) {
        _initPlatform();
    }
}

static this()
{
    version(LDC_DCompute_DirectX) {
        _initThread();
    }
}

void ensureInit()
{
    if (!_platformReady) _initPlatform();
    if (!_threadReady)   _initThread();
}

Device defaultDevice()
{
    return _defaultDevice;
}

Queue* defaultQueue()
{
    return &_threadQueue;
}

Queue* defaultCopyQueue()
{
    return &_threadCopyQueue;
}

private void _initPlatform()
{
    if (_platformReady) return;

    synchronized
    {
        if (_platformReady) return;

        Platform.initialise();
        
        auto devices = Platform.getDevices();
        if (devices.length > 0) {
            _defaultDevice = devices[0];
        } else {
            // Fallback to WARP if no hardware adapters found
            _defaultDevice = Platform.getWarpDevice();
        }
        
        _defaultContext = Context(_defaultDevice);

        _platformReady = true;
    }
}

private void _initThread()
{
    if (_threadReady) return;

    import dcompute.driver.d3d12.bindings : D3D12_COMMAND_LIST_TYPE;
    
    // Automatically push the default context for the calling thread
    // This perfectly matches cuCtxCreate/cuCtxPushCurrent semantics
    if (Context.current.device.raw != _defaultContext.device.raw)
        Context.push(_defaultContext);
        
    _threadQueue = Queue(D3D12_COMMAND_LIST_TYPE.DIRECT);
    _threadCopyQueue = Queue(D3D12_COMMAND_LIST_TYPE.COPY);
    _threadReady = true;
}

/// D3D12 equivalent of CUDA launch!
/// Dynamically extracts LDC embedded DXIL or requires manual load.
auto launch(alias k)(uint[3] grid, uint[3] block,
                     HostArgsOf!(typeof(k)) args)
{
    if (Program.globalProgram.dxilBlob is null)
    {
        import std.traits : moduleName;
        ensureInit();
        Program.globalProgram = Program.fromModule!(moduleName!(__traits(parent, k)))();
    }
    defaultQueue().enqueue!k(grid, block)(args);
}

import dcompute.driver.d3d12.traits : HostArgsOf;
