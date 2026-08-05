/**
 * Metal program/library abstraction.
 *
 * Wraps MTLLibrary to load precompiled .metallib files
 * (produced by ldc2 -mdcompute-targets=metal-300 + metallib tool).
 * Mirrors dcompute.driver.cuda.program.
 */
module dcompute.driver.metal.program;

version (OSX):

/// A compiled Metal library loaded from a .metallib file.
/// Contains one or more compute kernel functions.
struct MetalProgram
{
    // Opaque handle to MTLLibrary
    private void* _library;

    /// Whether this program has been loaded successfully
    @property bool isLoaded() const
    {
        return _library !is null;
    }

    /// Get a kernel function by name from this library.
    /// Returns an opaque handle to MTLFunction.
    void* getFunction(string name)
    {
        // TODO: _library.newFunctionWithName(name.toNSString)
        return null;
    }

    /// List all function names in this library.
    /// Useful for debugging which kernels were compiled.
    string[] functionNames()
    {
        // TODO: _library.functionNames
        return [];
    }
}

/// Load a compiled .metallib file from disk.
///
/// The .metallib file is produced by the pipeline:
///   ldc2 -mdcompute-targets=metal-300 kernel.d  →  kernel.air
///   metallib kernel.air -o kernel.metallib
///
/// Params:
///   path = path to the .metallib file
/// Returns:
///   a MetalProgram ready for kernel dispatch
MetalProgram loadLibrary(string path)
{
    // TODO: Implementation outline:
    // 1. auto device = MTLCreateSystemDefaultDevice();
    // 2. auto url = NSURL.fileURLWithPath(path.toNSString);
    // 3. NSError* err;
    // 4. auto lib = device.newLibraryWithURL(url, &err);
    // 5. enforce(lib !is null, err.localizedDescription);
    MetalProgram prog;
    return prog;
}
