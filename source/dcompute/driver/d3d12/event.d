module dcompute.driver.d3d12.event;

import dcompute.driver.d3d12.queue;
import dcompute.driver.d3d12.bindings;

/// D3D12 Event: wraps a target fence value on a specific Queue.
/// Allows for asynchronous waiting.
/// Mirrors dcompute.driver.cuda.event.
struct Event
{
    Queue* q;
    ulong  targetValue;

    void wait()
    {
        if (q is null || q.fence is null) return;
        
        if (q.fence.GetCompletedValue() < targetValue)
        {
            q.fence.SetEventOnCompletion(targetValue, q.fenceEvent);
            WaitForSingleObject(q.fenceEvent, INFINITE);
        }
    }
}
