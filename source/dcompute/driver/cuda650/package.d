module dcopute.driver.cuda650;

public import derelict.cuda.driverapi;

public import dcompute.driver.cuda650.buffer;
public import dcompute.driver.cuda650.context;
public import dcompute.driver.cuda650.device;
public import dcompute.driver.cuda650.event;
public import dcompute.driver.cuda650.kernel;
public import dcompute.driver.cuda650.memory;
public import dcompute.driver.cuda650.platform;
public import dcompute.driver.cuda650.program;
public import dcompute.driver.cuda650.queue;

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
