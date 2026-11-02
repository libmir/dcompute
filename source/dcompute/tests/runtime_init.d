/**
 * dcompute.tests.runtime_init
 *
 * Verifies the soft-fail behaviour of the CUDA runtime module constructors
 * on machines without a usable CUDA driver/device.
 *
 * Opt-in via environment variable, with the devices masked so that
 * initialisation cannot succeed:
 *
 *     DCOMPUTE_TEST_NO_CUDA=1 CUDA_VISIBLE_DEVICES="" ./dcompute
 *
 * Merely reaching main() already proves half the fix: the module
 * constructors must not abort the program when CUDA is unavailable.  The
 * rest asserts that the first actual use of the runtime (ensureInit) reports
 * the condition with a clear, catchable exception instead.
 */
module dcompute.tests.runtime_init;

version (DComputeTesting) version = DComputeRuntimeInitTest;
version (DComputeTestCUDA) version = DComputeRuntimeInitTest;

version (DComputeRuntimeInitTest):

import std.stdio;

import dcompute.driver.cuda.runtime : ensureInit;
import dcompute.driver.error : DComputeDriverException;

/// Returns 0 on pass, 1 on failure (used as the process exit code).
int runNoCudaInitTest()
{
    // Reaching this function at all means the process survived the module
    // constructors with no usable CUDA — the primary claim under test.
    writeln("Module constructors survived without a usable CUDA device.");

    try
    {
        ensureInit();
    }
    catch (DComputeDriverException e)
    {
        writeln("ensureInit() threw as expected: ", e.msg);
        writeln("runtime_init no-CUDA test PASSED.");
        return 0;
    }

    stderr.writeln("FAIL: ensureInit() succeeded — CUDA appears to be usable. ",
                   "Run this test with the devices masked, e.g. CUDA_VISIBLE_DEVICES=\"\".");
    return 1;
}
