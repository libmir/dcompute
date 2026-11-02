module dcompute.driver.d3d12.bindings;

// Minimal, dependency-free D3D12/DXGI COM bindings for dcompute.
// Uses C-style vtable structs to avoid massive COM inheritance chains.
// Each struct wraps a raw COM pointer; helper methods forward through lpVtbl.

// ── Fundamental Windows types ──────────────────────────────────────────────
alias HRESULT = int;
alias UINT   = uint;
alias UINT64 = ulong;
alias BOOL   = int;
alias HANDLE = void*;
alias LPCWSTR = const(wchar)*;
alias SIZE_T = size_t;

struct GUID {
    uint   Data1;
    ushort Data2;
    ushort Data3;
    ubyte[8] Data4;
}

enum S_OK = 0;
bool SUCCEEDED(HRESULT hr) { return hr >= 0; }
bool FAILED(HRESULT hr)    { return hr < 0; }

enum INFINITE = 0xFFFFFFFF;

// ── DXGI enums ─────────────────────────────────────────────────────────────
enum DXGI_ERROR_NOT_FOUND    = cast(HRESULT)0x887A0002;
enum DXGI_ADAPTER_FLAG_SOFTWARE = 2;

// ── D3D12 enums ────────────────────────────────────────────────────────────
enum D3D_FEATURE_LEVEL : int {
    _11_0 = 0xb000,
    _12_0 = 0xc000,
    _12_1 = 0xc100,
}

enum D3D12_COMMAND_LIST_TYPE : int {
    DIRECT  = 0,
    BUNDLE  = 1,
    COMPUTE = 2,
    COPY    = 3,
}

enum D3D12_DESCRIPTOR_HEAP_TYPE : int {
    CBV_SRV_UAV = 0,
    SAMPLER     = 1,
    RTV         = 2,
    DSV         = 3,
}

enum D3D12_DESCRIPTOR_HEAP_FLAGS : int {
    NONE           = 0,
    SHADER_VISIBLE = 1,
}

enum D3D12_HEAP_TYPE : int {
    DEFAULT  = 1,
    UPLOAD   = 2,
    READBACK = 3,
    CUSTOM   = 4,
}

enum D3D12_HEAP_FLAGS : int {
    NONE = 0,
}

enum D3D12_RESOURCE_DIMENSION : int {
    UNKNOWN   = 0,
    BUFFER    = 1,
    TEXTURE1D = 2,
    TEXTURE2D = 3,
    TEXTURE3D = 4,
}

enum D3D12_TEXTURE_LAYOUT : int {
    UNKNOWN            = 0,
    ROW_MAJOR          = 1,
    _64KB_UNDEFINED_SWIZZLE = 2,
    _64KB_STANDARD_SWIZZLE  = 3,
}

enum D3D12_RESOURCE_FLAGS : int {
    NONE                          = 0,
    ALLOW_RENDER_TARGET           = 1,
    ALLOW_DEPTH_STENCIL           = 2,
    ALLOW_UNORDERED_ACCESS        = 4,
    DENY_SHADER_RESOURCE          = 8,
    ALLOW_CROSS_ADAPTER            = 16,
    ALLOW_SIMULTANEOUS_ACCESS      = 32,
}

enum D3D12_RESOURCE_STATES : int {
    COMMON                       = 0,
    VERTEX_AND_CONSTANT_BUFFER   = 1,
    INDEX_BUFFER                 = 2,
    RENDER_TARGET                = 4,
    UNORDERED_ACCESS             = 8,
    DEPTH_WRITE                  = 16,
    DEPTH_READ                   = 32,
    NON_PIXEL_SHADER_RESOURCE    = 64,
    PIXEL_SHADER_RESOURCE        = 128,
    STREAM_OUT                   = 256,
    INDIRECT_ARGUMENT            = 512,
    COPY_DEST                    = 1024,
    COPY_SOURCE                  = 2048,
    RESOLVE_DEST                 = 4096,
    RESOLVE_SOURCE               = 8192,
    GENERIC_READ                 = 0xAC3, // combination of read states
}

enum D3D12_RESOURCE_BARRIER_TYPE : int {
    TRANSITION = 0,
    ALIASING   = 1,
    UAV        = 2,
}

enum D3D12_RESOURCE_BARRIER_FLAGS : int {
    NONE       = 0,
    BEGIN_ONLY = 1,
    END_ONLY   = 2,
}

enum D3D12_RESOURCE_BARRIER_ALL_SUBRESOURCES = 0xffffffff;

enum D3D12_FENCE_FLAGS : int {
    NONE   = 0,
    SHARED = 1,
}

enum D3D_ROOT_SIGNATURE_VERSION : int {
    _1_0 = 1,
    _1_1 = 2,
}

enum D3D12_DESCRIPTOR_RANGE_TYPE : int {
    SRV     = 0,
    UAV     = 1,
    CBV     = 2,
    SAMPLER = 3,
}

enum D3D12_DESCRIPTOR_RANGE_FLAGS : int {
    NONE                          = 0,
    DESCRIPTORS_VOLATILE          = 1,
    DATA_VOLATILE                 = 2,
    DATA_STATIC_WHILE_SET_AT_EXECUTE = 4,
    DATA_STATIC                   = 8,
    DESCRIPTORS_STATIC_KEEPING_BUFFER_BOUNDS_CHECKS = 0x10000,
}

enum D3D12_ROOT_PARAMETER_TYPE : int {
    DESCRIPTOR_TABLE = 0,
    _32BIT_CONSTANTS = 1,
    CBV              = 2,
    SRV              = 3,
    UAV              = 4,
}

enum D3D12_SHADER_VISIBILITY : int {
    ALL      = 0,
    VERTEX   = 1,
    HULL     = 2,
    DOMAIN   = 3,
    GEOMETRY = 4,
    PIXEL    = 5,
    AMPLIFICATION = 6,
    MESH     = 7,
}

enum D3D12_ROOT_SIGNATURE_FLAGS : int {
    NONE = 0,
    ALLOW_INPUT_ASSEMBLER_INPUT_LAYOUT = 1,
    DENY_VERTEX_SHADER_ROOT_ACCESS     = 2,
    DENY_HULL_SHADER_ROOT_ACCESS       = 4,
    DENY_DOMAIN_SHADER_ROOT_ACCESS     = 8,
    DENY_GEOMETRY_SHADER_ROOT_ACCESS   = 16,
    DENY_PIXEL_SHADER_ROOT_ACCESS      = 32,
    ALLOW_STREAM_OUTPUT                = 64,
    LOCAL_ROOT_SIGNATURE               = 128,
    DENY_AMPLIFICATION_SHADER_ROOT_ACCESS = 256,
    DENY_MESH_SHADER_ROOT_ACCESS       = 512,
    CBV_SRV_UAV_HEAP_DIRECTLY_INDEXED  = 1024, // 0x400 - SM 6.6 Bindless Heap
    SAMPLER_HEAP_DIRECTLY_INDEXED      = 2048, // 0x800
}

enum DXGI_FORMAT : int {
    UNKNOWN            = 0,
    R32G32B32A32_FLOAT = 2,
    R32G32B32A32_UINT  = 3,
    R32G32B32_FLOAT    = 6,
    R32G32_FLOAT       = 16,
    R8G8B8A8_UNORM     = 28,
    R8G8B8A8_UINT      = 30,
    B8G8R8A8_UNORM     = 87,
    R32_TYPELESS       = 39,
    R32_FLOAT          = 41,
    R32_UINT           = 42,
    R16_FLOAT          = 54,
    R16_UINT           = 57,
    R8_UNORM           = 61,
    R8_UINT            = 62,
}

enum D3D12_UAV_DIMENSION : int {
    UNKNOWN = 0,
    BUFFER  = 1,
    TEXTURE1D = 2,
    TEXTURE2D = 4,
    TEXTURE3D = 8,
}

enum D3D12_BUFFER_UAV_FLAGS : int {
    NONE = 0,
    RAW  = 1,
}

enum D3D12_FEATURE : int {
    OPTIONS               = 0,
    ARCHITECTURE          = 1,
    FEATURE_LEVELS        = 2,
    FORMAT_SUPPORT        = 3,
    MULTISAMPLE_QUALITY_LEVELS = 4,
    FORMAT_INFO           = 5,
    GPU_VIRTUAL_ADDRESS_SUPPORT = 6,
    SHADER_MODEL          = 7,
    D3D12_OPTIONS1        = 8,
    ARCHITECTURE1         = 16,
}

/// Shader model versions (hex encoding: major << 4 | minor).
/// SM 6.6 is the minimum for Dynamic Resources (Bindless).
enum D3D_SHADER_MODEL : int {
    _5_1 = 0x51,
    _6_0 = 0x60,
    _6_1 = 0x61,
    _6_2 = 0x62,
    _6_3 = 0x63,
    _6_4 = 0x64,
    _6_5 = 0x65,
    _6_6 = 0x66,  // Dynamic Resources (Bindless)
    _6_7 = 0x67,
    _6_8 = 0x68,
}

/// Resource Binding Tier. Tier 3 = full bindless heap access.
enum D3D12_RESOURCE_BINDING_TIER : int {
    TIER_1 = 1,
    TIER_2 = 2,
    TIER_3 = 3,
}

// ── D3D12 structs ──────────────────────────────────────────────────────────

struct DXGI_ADAPTER_DESC1 {
    wchar[128] Description;
    uint VendorId;
    uint DeviceId;
    uint SubSysId;
    uint Revision;
    size_t DedicatedVideoMemory;
    size_t DedicatedSystemMemory;
    size_t SharedSystemMemory;
    long AdapterLuid;
    uint Flags;
}

struct DXGI_SAMPLE_DESC {
    uint Count  = 1;
    uint Quality = 0;
}

struct D3D12_COMMAND_QUEUE_DESC {
    D3D12_COMMAND_LIST_TYPE Type;
    int Priority;
    int Flags;
    uint NodeMask;
}

struct D3D12_HEAP_PROPERTIES {
    D3D12_HEAP_TYPE Type;
    int CPUPageProperty;
    int MemoryPoolPreference;
    uint CreationNodeMask;
    uint VisibleNodeMask;
}

struct D3D12_RESOURCE_DESC {
    D3D12_RESOURCE_DIMENSION Dimension;
    ulong Alignment;
    ulong Width;
    uint Height          = 1;
    ushort DepthOrArraySize = 1;
    ushort MipLevels      = 1;
    DXGI_FORMAT Format    = DXGI_FORMAT.UNKNOWN;
    DXGI_SAMPLE_DESC SampleDesc;
    D3D12_TEXTURE_LAYOUT Layout;
    D3D12_RESOURCE_FLAGS Flags;
}

struct D3D12_DESCRIPTOR_HEAP_DESC {
    D3D12_DESCRIPTOR_HEAP_TYPE Type;
    uint NumDescriptors;
    D3D12_DESCRIPTOR_HEAP_FLAGS Flags;
    uint NodeMask;
}

struct D3D12_CPU_DESCRIPTOR_HANDLE {
    size_t ptr;
}

struct D3D12_GPU_DESCRIPTOR_HANDLE {
    ulong ptr;
}

struct D3D12_RESOURCE_TRANSITION_BARRIER {
    void* pResource;        // ID3D12Resource*
    uint Subresource;
    D3D12_RESOURCE_STATES StateBefore;
    D3D12_RESOURCE_STATES StateAfter;
}

struct D3D12_RESOURCE_BARRIER {
    D3D12_RESOURCE_BARRIER_TYPE Type;
    D3D12_RESOURCE_BARRIER_FLAGS Flags;
    D3D12_RESOURCE_TRANSITION_BARRIER Transition;
}

struct D3D12_RANGE {
    size_t Begin;
    size_t End;
}

struct D3D12_SHADER_BYTECODE {
    const(void)* pShaderBytecode;
    size_t BytecodeLength;
}

struct D3D12_DESCRIPTOR_RANGE1 {
    D3D12_DESCRIPTOR_RANGE_TYPE RangeType;
    uint NumDescriptors;
    uint BaseShaderRegister;
    uint RegisterSpace;
    D3D12_DESCRIPTOR_RANGE_FLAGS Flags;
    uint OffsetInDescriptorsFromTableStart = 0xffffffff; // D3D12_DESCRIPTOR_RANGE_OFFSET_APPEND
}

struct D3D12_ROOT_DESCRIPTOR_TABLE1 {
    uint NumDescriptorRanges;
    const(D3D12_DESCRIPTOR_RANGE1)* pDescriptorRanges;
}

struct D3D12_ROOT_PARAMETER1 {
    D3D12_ROOT_PARAMETER_TYPE ParameterType;
    D3D12_ROOT_DESCRIPTOR_TABLE1 DescriptorTable;
    D3D12_SHADER_VISIBILITY ShaderVisibility;
}

struct D3D12_ROOT_SIGNATURE_DESC1 {
    uint NumParameters;
    const(D3D12_ROOT_PARAMETER1)* pParameters;
    uint NumStaticSamplers;
    const(void)* pStaticSamplers;
    D3D12_ROOT_SIGNATURE_FLAGS Flags;
}

struct D3D12_VERSIONED_ROOT_SIGNATURE_DESC {
    D3D_ROOT_SIGNATURE_VERSION Version;
    D3D12_ROOT_SIGNATURE_DESC1 Desc_1_1;
}

struct D3D12_COMPUTE_PIPELINE_STATE_DESC {
    void* pRootSignature;   // ID3D12RootSignature*
    D3D12_SHADER_BYTECODE CS;
    uint NodeMask;
    D3D12_SHADER_BYTECODE CachedPSO;
    int Flags;
}

struct D3D12_BUFFER_UAV {
    ulong FirstElement;
    uint  NumElements;
    uint  StructureByteStride;
    ulong CounterOffsetInBytes;
    D3D12_BUFFER_UAV_FLAGS Flags;
}

struct D3D12_CONSTANT_BUFFER_VIEW_DESC {
    ulong BufferLocation;
    uint SizeInBytes;
}

struct D3D12_UNORDERED_ACCESS_VIEW_DESC {
    DXGI_FORMAT Format;
    D3D12_UAV_DIMENSION ViewDimension;
    D3D12_BUFFER_UAV Buffer;
}

enum D3D12_TEXTURE_COPY_TYPE : int {
    SUBRESOURCE_INDEX = 0,
    PLACED_FOOTPRINT  = 1,
}

struct D3D12_SUBRESOURCE_FOOTPRINT {
    DXGI_FORMAT Format;
    uint Width;
    uint Height;
    uint Depth;
    uint RowPitch;
}

struct D3D12_PLACED_SUBRESOURCE_FOOTPRINT {
    ulong Offset;
    D3D12_SUBRESOURCE_FOOTPRINT Footprint;
}

struct D3D12_TEXTURE_COPY_LOCATION {
    ID3D12Resource pResource;
    D3D12_TEXTURE_COPY_TYPE Type;
    union {
        D3D12_PLACED_SUBRESOURCE_FOOTPRINT PlacedFootprint;
        uint SubresourceIndex;
    }
}

struct D3D12_BOX {
    uint left;
    uint top;
    uint front;
    uint right;
    uint bottom;
    uint back;
}

struct D3D12_FEATURE_DATA_ARCHITECTURE {
    uint NodeIndex;
    BOOL TileBasedRenderer;
    BOOL UMA;
    BOOL CacheCoherentUMA;
}

struct D3D12_FEATURE_DATA_ARCHITECTURE1 {
    uint NodeIndex;
    BOOL TileBasedRenderer;
    BOOL UMA;
    BOOL CacheCoherentUMA;
    BOOL IsolatedMMU;
}

/// Used with CheckFeatureSupport(D3D12_FEATURE.SHADER_MODEL).
/// Set HighestShaderModel to the max you want to query; the driver
/// will clamp it down to whatever the hardware actually supports.
struct D3D12_FEATURE_DATA_SHADER_MODEL {
    D3D_SHADER_MODEL HighestShaderModel;
}

/// Used with CheckFeatureSupport(D3D12_FEATURE.OPTIONS).
/// We only care about ResourceBindingTier (offset 16 = 5th DWORD),
/// but the struct layout must be exact for the driver to write into it.
struct D3D12_FEATURE_DATA_D3D12_OPTIONS {
    BOOL DoublePrecisionFloatShaderOps;
    BOOL OutputMergerLogicOp;
    int  MinPrecisionSupport;            // D3D12_SHADER_MIN_PRECISION_SUPPORT
    int  TiledResourcesTier;             // D3D12_TILED_RESOURCES_TIER
    D3D12_RESOURCE_BINDING_TIER ResourceBindingTier;
    BOOL PSSpecifiedStencilRefSupported;
    BOOL TypedUAVLoadAdditionalFormats;
    BOOL ROVsSupported;
    int  ConservativeRasterizationTier;  // D3D12_CONSERVATIVE_RASTERIZATION_TIER
    uint MaxGPUVirtualAddressBitsPerResource;
    BOOL StandardSwizzle64KBSupported;
    int  CrossNodeSharingTier;           // D3D12_CROSS_NODE_SHARING_TIER
    BOOL CrossAdapterRowMajorTextureSupported;
    BOOL VPAndRTArrayIndexFromAnyShaderFeedingRasterizerSupportedWithoutGSEmulation;
    int  ResourceHeapTier;               // D3D12_RESOURCE_HEAP_TIER
}

// ── GUIDs ──────────────────────────────────────────────────────────────────

immutable GUID IID_IDXGIFactory4 = {
    0x1bc6ea02, 0xef36, 0x464f, [0xbf, 0x0c, 0x21, 0xca, 0x39, 0xe5, 0x16, 0x8a]
};
immutable GUID IID_ID3D12Device = {
    0x189819f1, 0x1db6, 0x4b57, [0xbe, 0x54, 0x18, 0x21, 0x33, 0x9b, 0x85, 0xf7]
};
immutable GUID IID_ID3D12CommandQueue = {
    0x0ec870a6, 0x5d7e, 0x4c22, [0x8c, 0xfc, 0x5b, 0xaa, 0xe0, 0x76, 0x16, 0xed]
};
immutable GUID IID_ID3D12CommandAllocator = {
    0x6102dee4, 0xaf59, 0x4b09, [0xb9, 0x99, 0xb4, 0x4d, 0x73, 0xf0, 0x9b, 0x24]
};
immutable GUID IID_ID3D12GraphicsCommandList = {
    0x5b160d0f, 0xac1b, 0x4185, [0x8b, 0xa8, 0xb3, 0xae, 0x42, 0xa5, 0xa4, 0x55]
};
immutable GUID IID_ID3D12Fence = {
    0x0a753dcf, 0xc4d8, 0x4b91, [0xad, 0xf6, 0xbe, 0x5a, 0x60, 0xd9, 0x5a, 0x76]
};
immutable GUID IID_ID3D12PipelineState = {
    0x765a30f3, 0xf624, 0x4c6f, [0xa8, 0x28, 0xac, 0xe9, 0x48, 0x62, 0x24, 0x45]
};
immutable GUID IID_ID3D12RootSignature = {
    0xc54a6b66, 0x72df, 0x4ee8, [0x8b, 0xe5, 0xa9, 0x46, 0xa1, 0x42, 0x92, 0x14]
};
immutable GUID IID_ID3D12DescriptorHeap = {
    0x8efb471d, 0x616c, 0x4f49, [0x90, 0xf7, 0x12, 0x7b, 0xb7, 0x63, 0xfa, 0x51]
};
immutable GUID IID_ID3D12Resource = {
    0x696442be, 0xa72e, 0x4059, [0xbc, 0x79, 0x5b, 0x5c, 0x98, 0x04, 0x0f, 0xad]
};

// ── COM Interfaces ─────────────────────────────────────────────────────────

extern(Windows) interface IUnknown {
    HRESULT QueryInterface(const(GUID)* riid, void** ppvObject);
    uint AddRef();
    uint Release();
}
extern(Windows) interface IDXGIObject : IUnknown {
    void _pad3(); void _pad4(); void _pad5(); void _pad6();
}
extern(Windows) interface ID3D12Object : IUnknown {
    void _pad3(); void _pad4(); void _pad5(); void _pad6();
}

extern(Windows) interface IDXGIFactory4 : IDXGIObject {
    void _pad7(); void _pad8(); void _pad9(); void _pad10(); void _pad11();
    HRESULT EnumAdapters1(uint Adapter, IDXGIAdapter1* ppAdapter);
    void _pad13(); void _pad14(); void _pad15(); void _pad16(); void _pad17(); void _pad18(); void _pad19(); void _pad20();
    HRESULT EnumWarpAdapter(const(GUID)* riid, void** ppvAdapter);
}

extern(Windows) interface IDXGIAdapter1 : IDXGIObject {
    void _pad7();
    HRESULT GetDesc1(DXGI_ADAPTER_DESC1* pDesc);
}

extern(Windows) interface ID3DBlob : IUnknown {
    void* GetBufferPointer();
    size_t GetBufferSize();
}

extern(Windows) interface ID3D12Device : ID3D12Object {
    void _pad7();
    HRESULT CreateCommandQueue(const(D3D12_COMMAND_QUEUE_DESC)* pDesc, const(GUID)* riid, void** ppCommandQueue);
    HRESULT CreateCommandAllocator(D3D12_COMMAND_LIST_TYPE type, const(GUID)* riid, void** ppCommandAllocator);
    void _pad10();
    HRESULT CreateComputePipelineState(const(D3D12_COMPUTE_PIPELINE_STATE_DESC)* pDesc, const(GUID)* riid, void** ppPipelineState);
    HRESULT CreateCommandList(uint nodeMask, D3D12_COMMAND_LIST_TYPE type, ID3D12CommandAllocator pCommandAllocator, ID3D12PipelineState pInitialState, const(GUID)* riid, void** ppCommandList);
    HRESULT CheckFeatureSupport(D3D12_FEATURE Feature, void* pFeatureSupportData, uint FeatureSupportDataSize);
    HRESULT CreateDescriptorHeap(const(D3D12_DESCRIPTOR_HEAP_DESC)* pDescriptorHeapDesc, const(GUID)* riid, void** ppvHeap);
    uint GetDescriptorHandleIncrementSize(D3D12_DESCRIPTOR_HEAP_TYPE DescriptorHeapType);
    HRESULT CreateRootSignature(uint nodeMask, const(void)* pBlobWithRootSignature, size_t blobLengthInBytes, const(GUID)* riid, void** ppvRootSignature);
    void CreateConstantBufferView(const(D3D12_CONSTANT_BUFFER_VIEW_DESC)* pDesc, D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    void _pad18();
    void CreateUnorderedAccessView(ID3D12Resource pResource, ID3D12Resource pCounterResource, const(D3D12_UNORDERED_ACCESS_VIEW_DESC)* pDesc, D3D12_CPU_DESCRIPTOR_HANDLE DestDescriptor);
    void _pad20(); void _pad21(); void _pad22(); void _pad23();
    void _pad24(); void _pad25();
    void _pad26(); void _pad27();
    HRESULT CreateCommittedResource(const(D3D12_HEAP_PROPERTIES)* pHeapProperties, D3D12_HEAP_FLAGS HeapFlags, const(D3D12_RESOURCE_DESC)* pDesc, D3D12_RESOURCE_STATES InitialResourceState, const(void)* pOptimizedClearValue, const(GUID)* riid, void** ppvResource);
    void _pad29(); void _pad30(); void _pad31(); void _pad32();
    void _pad33(); void _pad34(); void _pad35();
    void _pad36(); void _pad37();
    HRESULT CreateFence(ulong InitialValue, D3D12_FENCE_FLAGS Flags, const(GUID)* riid, void** ppFence);
    HRESULT GetDeviceRemovedReason();
    void GetCopyableFootprints(const(D3D12_RESOURCE_DESC)* pResourceDesc, uint FirstSubresource, uint NumSubresources, ulong BaseOffset, D3D12_PLACED_SUBRESOURCE_FOOTPRINT* pLayouts, uint* pNumRows, ulong* pRowSizeInBytes, ulong* pTotalBytes);
    void _pad39(); void _pad40(); void _pad41(); void _pad42(); void _pad43(); void _pad44(); void _pad45();
}

extern(Windows) interface ID3D12CommandQueue : ID3D12Object {
    void _pad7(); void _pad8();
    void ExecuteCommandLists(uint NumCommandLists, ID3D12CommandList* ppCommandLists);
    void _pad10(); void _pad11(); void _pad12();
    HRESULT Signal(ID3D12Fence pFence, ulong Value);
    HRESULT Wait(ID3D12Fence pFence, ulong Value);
    HRESULT GetTimestampFrequency(ulong* pFrequency);
    void _pad16(); void _pad17();
}

extern(Windows) interface ID3D12CommandList : ID3D12Object {
    void _pad7();
}

extern(Windows) interface ID3D12CommandAllocator : ID3D12Object {
    HRESULT Reset();
}

extern(Windows) interface ID3D12GraphicsCommandList : ID3D12CommandList {
    HRESULT Close();
    HRESULT Reset(ID3D12CommandAllocator pAllocator, ID3D12PipelineState pInitialState);
    void _pad10(); void _pad11(); void _pad12();
    void Dispatch(uint ThreadGroupCountX, uint ThreadGroupCountY, uint ThreadGroupCountZ);
    void _pad14();
    void CopyTextureRegion(const(D3D12_TEXTURE_COPY_LOCATION)* pDst, uint DstX, uint DstY, uint DstZ, const(D3D12_TEXTURE_COPY_LOCATION)* pSrc, const(D3D12_BOX)* pSrcBox);
    void CopyResource(ID3D12Resource pDstResource, ID3D12Resource pSrcResource);
    void _pad17(); void _pad18(); void _pad19(); void _pad20(); void _pad21();
    void SetPipelineState(ID3D12PipelineState pPipelineState);
    void ResourceBarrier(uint NumBarriers, const(D3D12_RESOURCE_BARRIER)* pBarriers);
    void _pad24();
    void SetDescriptorHeaps(uint NumDescriptorHeaps, ID3D12DescriptorHeap* ppDescriptorHeaps);
    void SetComputeRootSignature(ID3D12RootSignature pRootSignature);
    void _pad27();
    void SetComputeRootDescriptorTable(uint RootParameterIndex, D3D12_GPU_DESCRIPTOR_HANDLE BaseDescriptor);
}

extern(Windows) interface ID3D12PipelineState : ID3D12Object {
    void _pad7();
}

extern(Windows) interface ID3D12RootSignature : ID3D12Object {
}

extern(Windows) interface ID3D12DescriptorHeap : ID3D12Object {
    void _pad7();
    D3D12_CPU_DESCRIPTOR_HANDLE GetCPUDescriptorHandleForHeapStart();
    D3D12_GPU_DESCRIPTOR_HANDLE GetGPUDescriptorHandleForHeapStart();
}

extern(Windows) interface ID3D12Resource : ID3D12Object {
    HRESULT Map(uint Subresource, const(D3D12_RANGE)* pReadRange, void** ppData);
    void Unmap(uint Subresource, const(D3D12_RANGE)* pWrittenRange);
    void _pad9();
    ulong GetGPUVirtualAddress();
    void _pad11(); void _pad12(); void _pad13();
}

extern(Windows) interface ID3D12Fence : ID3D12Object {
    ulong GetCompletedValue();
    HRESULT SetEventOnCompletion(ulong Value, HANDLE hEvent);
    HRESULT Signal(ulong Value);
}

// ── Win32 / D3D12 functions (loaded at link time via .lib) ─────────────────

extern(Windows):

HRESULT CreateDXGIFactory1(const(GUID)* riid, void** ppFactory);
HRESULT CreateDXGIFactory2(uint Flags, const(GUID)* riid, void** ppFactory);
HRESULT D3D12CreateDevice(void* pAdapter, D3D_FEATURE_LEVEL MinimumFeatureLevel, const(GUID)* riid, void** ppDevice);
HRESULT D3D12SerializeVersionedRootSignature(const(D3D12_VERSIONED_ROOT_SIGNATURE_DESC)* pRootSignature, ID3DBlob** ppBlob, ID3DBlob** ppErrorBlob);
HANDLE  CreateEventW(void* lpEventAttributes, BOOL bManualReset, BOOL bInitialState, LPCWSTR lpName);
BOOL    CloseHandle(HANDLE hObject);
uint    WaitForSingleObject(HANDLE hHandle, uint dwMilliseconds);
HRESULT CoInitializeEx(void* pvReserved, uint dwCoInit);

enum COINIT_MULTITHREADED = 0;
