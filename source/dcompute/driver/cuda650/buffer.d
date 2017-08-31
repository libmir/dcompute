module dcompute.driver.cuda650.buffer;

import dcompute.driver.cuda650;

struct Buffer(T)
{
    size_t raw;

    this(size_t elems)
    {
        status = cast(Status)cuMemAlloc(&raw,elems * T.sizeof);
        checkErrors();
    }
}
