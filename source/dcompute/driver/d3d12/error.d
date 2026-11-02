module dcompute.driver.d3d12.error;

import dcompute.driver.d3d12.bindings;
import dcompute.driver.error; // import core DriverStatus and Exception
import core.stdc.stdio : fprintf, stderr;

DriverStatus mapHRESULT(HRESULT hr)
{
    if (SUCCEEDED(hr)) return DriverStatus.success;

    // DXGI & D3D12 error codes
    switch (hr)
    {
        case E_OUTOFMEMORY:
            return DriverStatus.outOfMemory;
        case E_INVALIDARG:
            return DriverStatus.invalidValue;
        case DXGI_ERROR_DEVICE_REMOVED:
        case DXGI_ERROR_DEVICE_RESET:
        case DXGI_ERROR_DEVICE_HUNG:
            return DriverStatus.deviceLost;
        case DXGI_ERROR_UNSUPPORTED:
            return DriverStatus.notSupported;
        default:
            return DriverStatus.unknownError;
    }
}

version(DComputeIgnoreDriverErrors)
{
    void checkErrors(HRESULT hr, string file = __FILE__, size_t line = __LINE__) {}
}
else
{
    version (D_BetterC)
    {
        void checkErrors(HRESULT hr, string file = __FILE__, size_t line = __LINE__)
        {
            if (FAILED(hr))
            {
                fprintf(stderr,"*** DCompute D3D12 driver error: HRESULT 0x%X (Status: %d) at %s:%zu\n",
                       cast(uint)hr, mapHRESULT(hr), file.ptr, line);
            }
        }
    }
    else
    {
        void checkErrors(HRESULT hr, string file = __FILE__, size_t line = __LINE__)
        {
            if (FAILED(hr))
            {
                import std.format : format;
                throw new DComputeDriverException(mapHRESULT(hr), format("HRESULT 0x%X", cast(uint)hr), file, line);
            }
        }
    }
}
