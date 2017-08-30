module dcompute.driver.cuda650.buffer;

struct Buffer(T)
{
    size_t raw;

    this(size_t elems)
    {
        status = cast(Status)cuMemAlloc(&raw,elems * T.sizeof);
        checkErrors();
    }
}
