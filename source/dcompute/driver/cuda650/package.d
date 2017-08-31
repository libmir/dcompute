module dcopute.driver.cuda650;

public import derelict.cuda.driverapi;

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
