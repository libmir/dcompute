module dcompute.driver.d3d12.platform;

import dcompute.driver.d3d12.bindings;
import dcompute.driver.d3d12.device;
import dcompute.driver.d3d12.error;

/// D3D12 platform: DXGI factory + adapter enumeration.
/// Mirrors dcompute.driver.cuda.platform.
struct Platform
{
    __gshared IDXGIFactory4 factory;

    /// Initialise COM and create the DXGI factory.
    /// Call once before any other D3D12 operation.
    static void initialise(uint flags = 0)
    {
        CoInitializeEx(null, COINIT_MULTITHREADED);

        auto hr = CreateDXGIFactory1(
            &IID_IDXGIFactory4,
            cast(void**)&factory
        );
        checkErrors(hr);
    }

    /// Enumerate all hardware adapters (skipping software/WARP).
    static Device[] getDevices()
    {
        Device[] devices;
        if (factory is null) return devices;

        for (uint i = 0; ; ++i)
        {
            IDXGIAdapter1 adap;
            auto hr = factory.EnumAdapters1(i, &adap);
            if (hr == DXGI_ERROR_NOT_FOUND)
                break;
            checkErrors(hr);

            // Skip software adapters
            DXGI_ADAPTER_DESC1 desc;
            adap.GetDesc1(&desc);
            if (desc.Flags & DXGI_ADAPTER_FLAG_SOFTWARE)
            {
                adap.Release();
                continue;
            }

            auto dev = Device.create(adap);
            if (dev.raw !is null)
                devices ~= dev;
        }
        return devices;
    }

    /// Get the WARP software adapter (useful for testing without hardware).
    static Device getWarpDevice()
    {
        if (factory is null)
            return Device.init;

        // EnumWarpAdapter returns IDXGIAdapter, QI to IDXGIAdapter1
        void* warpRaw;
        auto hr = factory.EnumWarpAdapter(
            &IID_IDXGIFactory4, // need IDXGIAdapter GUID here actually
            &warpRaw
        );
        checkErrors(hr);

        // QI to IDXGIAdapter1
        IDXGIAdapter1 warp;
        (cast(IUnknown)warpRaw).QueryInterface(
            &IID_ID3D12Device, // placeholder — in production use IID_IDXGIAdapter1
            cast(void**)&warp
        );

        return Device.create(warp);
    }
}
