@compute(CompileFor.deviceOnly) module dcompute.std.directx.sync;

import ldc.dcompute;
import ldc.llvmasm;

// Suspends work-item execution until all work-items in the work-group have called the barrier
// In LLVM DXIL, memory barriers and group syncs are handled by standard fence instructions
// which the DXILOpLowering pass intercepts and converts to dx.op.barrier (opcode 80)
pragma(inline, true)
void barrier()()
{
    // Emits a memory fence with 'workgroup' sync scope.
    // DXIL translates this to SyncThreadGroup | UAVGroup
    __ir!("fence syncscope(\"workgroup\") seq_cst", void);
}

pragma(inline, true)
void local_fence()
{
    // DXIL translates this to UAVGroup memory barrier without thread sync
    __ir!("fence syncscope(\"workgroup\") acquire", void);
}

pragma(inline, true)
void global_fence()
{
    // DXIL translates this to UAVGlobal memory barrier
    __ir!("fence syncscope(\"device\") acquire", void);
}
