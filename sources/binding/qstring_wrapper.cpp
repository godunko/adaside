

#include "qstring_wrapper.h"

extern "C"
{

    void QString__adjust(QString **self)
    {
        *self = new QString(**self);
    }

    void QString__delete(QString **self)
    {
        delete (*self);
        *self = 0;
    }

    QString *QString__new()
    {
        return new QString();
    }

    QString *QString__fromUtf8(const char *str, int size)
    {
        return new QString(QString::fromUtf8(str, size));
    }

}
