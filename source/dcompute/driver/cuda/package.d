module dcopute.driver.cuda;

public import derelict.cuda.driverapi;

public import dcompute.driver.cuda.buffer;
public import dcompute.driver.cuda.context;
public import dcompute.driver.cuda.device;
public import dcompute.driver.cuda.event;
public import dcompute.driver.cuda.kernel;
public import dcompute.driver.cuda.memory;
public import dcompute.driver.cuda.platform;
public import dcompute.driver.cuda.program;
public import dcompute.driver.cuda.queue;

enum CopySource
{
    host,
    device,
    array,
}

enum MemoryBankConfig : int
{
    default_,
    fourBytes,
    eightBytes,
}
