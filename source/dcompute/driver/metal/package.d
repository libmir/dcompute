/**
 * Metal compute driver for DCompute.
 *
 * Provides access to Apple Metal GPU compute on macOS via
 * LDC's extern(Objective-C) support and the Inochi2D/metal-d bindings.
 *
 * This mirrors the structure of dcompute.driver.cuda and dcompute.driver.ocl.
 * Only available on macOS (version(OSX)).
 */
module dcompute.driver.metal;

version (OSX):

public import dcompute.driver.metal.queue;
public import dcompute.driver.metal.buffer;
public import dcompute.driver.metal.program;
public import dcompute.driver.metal.device;
