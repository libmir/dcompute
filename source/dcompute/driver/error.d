/**/

module dcompute.driver.error;

// Helpfully OpenCL errors are negative and CUDAs are positive
enum Status : int {
    Success = 0,
    // CUDA Errors.
    missingConfiguration    = 1,
    memoryAllocationFailure = 2,
    initialisationError     = 3,
    launchFailure           = 4,
    priorLaunchFailure      = 5,
    launchTimeout           = 6,
    launchOutOfResources    = 7,
    invalidDeviceFunction   = 8,
    invalidConfiguration    = 9,
    invalidDeviceCU         = 10,
    invalidValueCU          = 11,
    invalidPitchValue       = 12,
    invalidSymbol           = 13,
    mapBufferObjectFailed   = 14,
    unmapBufferObjectFailed = 15,
    invalidHostPointerCU    = 16,
    invalidDevicePointer    = 17,
    invalidTexture          = 18,
    invalidTextureBinding   = 19,
    invalidChannelDescriptor= 20,
    invalidMemcpyDirection  = 21,
    addressOfConstantError  = 22,
    textureFetchFailed      = 23,
    textureNotBound         = 24,
    synchronisationError    = 25,
    invalidFilterSetting    = 26,
    invalidNormSetting      = 27,
    mixedDeviceExecutionError = 28,
    cudartUnloadingFailure  = 29,
    unknownError            = 30,
    notYetImplementedError  = 31,
    memoryValueTooLargeError= 32,
    invalidResourceHandle   = 33,
    notReadyError           = 34,
    driverMismatchError     = 35,
    setOnActiveProcessError = 36,
    noDeviceError           = 37,
    startupFailure          = 0x7f,
    apiFailureBase          = 10000,
    // OpenCL Errors.
    deviceNotFound                 = -1,
    deviceNotAvailable             = -2,
    compilerNotAvailable           = -3,
    memoryObjectAloocationFailure  = -4,
    outOfResources                 = -5,
    outOfHostMemory                = -6,
    profilingInfomationAvailable   = -7,
    memoryCopyOverlap              = -8,
    imageFormatMismatch            = -9,
    imageFormatNotSupported        = -10,
    buildProgramFailed             = -11,
    mapFailure                     = -12,
    misalignedSubBufferOffset      = -13,
    errorsInWaitList               = -14,
    compileProgramFailure          = -15,
    linkerNotAvailable             = -16,
    linkerFailure                  = -17,
    devicePartitionFailure         = -18,
    kernelArgInfoNotAvailable      = -19,
    
    invalidValueCL                 = -30,
    invalidDeviceType              = -31,
    invalidPlatform                = -32,
    invalidDeviceCL                = -33,
    invalidContext                 = -34,
    invalidQueueProperties         = -35,
    invalidQueue                   = -36,
    invalidHostPointerCL           = -37,
    invalidMemoryObject            = -38,
    invalidImageFormatDesctiptor   = -39,
    invalidImageSize               = -40,
    invalidSampler                 = -41,
    invalidBinary                  = -42,
    invalidBuildOptions            = -43,
    invalidProgram                 = -44,
    invalidExecutable              = -45,
    invalidKernelName              = -46,
    invalidKernelDefinition        = -47,
    invalidKernel                  = -48,
    invalidArgumentIndex           = -49,
    invalidArgumentValue           = -50,
    invalidArgumentSize            = -51,
    invalidKernelArguments         = -52,
    invalidWorkDimensions          = -53,
    invaildWorkGroupSize           = -54,
    invaildWorkItemSize            = -55,
    invalidGlobalOffest            = -56,
    invalidEventWaitList           = -57,
    invalidEvent                   = -58,
    invalidOperation               = -59,
    invalidGLObject                = -60,
    invalidBufferSize              = -61,
    invalidMipLevel                = -62,
    invalidGlobalWorkSize          = -63,
    invalidProperty                = -64,
    invalidImageDescriptor         = -65,
    invalidCompilerOptions         = -66,
    invalidLinkerOptions           = -67,
    invalidDevicePartitionCount    = -68,
    
    invalidGLSharegroupReference   = -1000,
    platformNotFound               = -1001,
    invalidD3D10Device             = -1002,
    invalidD3D10Resource           = -1003,
    D3D10ResouceAlreadyAcquired    = -1004,
    D3D10ResourceNotAcquires       = -1005,
    invalidD3D11Device             = -1006,
    invalidD3D11Resource           = -1007,
    D3D11ResourceAlredyAcquired    = -1008,
    D3D11ResourceNotAcquired       = -1009,
    invalidDX9MediaAdapter         = -1010,
    invalidDX9MediaSurface         = -1011,
    DX9MediaSurfaceAlreadyAcquired = -1012,
    DX9MediaSurfaceNotAcquired     = -1013,
    
    devicePartitionFailed          = -1057,
    invalidPartitionCount          = -1058,
    invalidPartitionName           = -1059,
    
    invalidEGLObject               = -1093,
    EGLResourceNotAcquired         = -1092,
}

//@BUG@ The static this does not appear to work!
version (D_BetterC)
{
    void delegate (Status) nothrow @nogc onDriverError;
    immutable void delegate (Status) nothrow @nogc defaultOnDriverError;
    static this()
    {
        defaultOnDriverError = (Status _status)
        {
            import core.stdc.stdio : stderr;
            import std.conv : to;
            fprintf(stderr,"*** DCompute driver error:%s\n",
                   _status.to!(string).toStringz);
        };
    }
}
else
{
    class DComputeDriverException : Exception
    {
        this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable next = null)
        {
            super(msg, file, line, next);
        }
        
        this(Status err, string file = __FILE__, size_t line = __LINE__, Throwable next = null)
        {
            import std.conv : to;
            super(err.to!string, file, line, next);
        }
    }
    void delegate(Status) onDriverError;
    immutable void delegate(Status) defaultOnDriverError;
    static this()
    {
        defaultOnDriverError = (Status _status)
        {
            throw new DComputeDriverException(_status);
        };
    }
}
 static this() { 
    onDriverError = (Status _status) { defaultOnDriverError(_status);};
}
// Thread local status
Status status;

version(DComputeIgnoreDriverErrors)
{
    void checkErrors() {}
}
else
{
    void checkErrors()
    {
        if (status) onDriverError(status);
    }

}





