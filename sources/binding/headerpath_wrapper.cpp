
#include "headerpath_wrapper.h"

extern "C"
{

    HeaderPath* HeaderPath__new()
    {
        return new HeaderPath(QByteArray());
    }

    HeaderPath* HeaderPath__new_2(QString *path)
    {
        return new HeaderPath(*path);
    }

    void HeaderPath__adjust(HeaderPath **self)
    {
        *self = new HeaderPath(**self);
    }

    void HeaderPath__delete(HeaderPath **self)
    {
        delete *self;
        *self = 0;
    }

}
