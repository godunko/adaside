

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

    char* QString_toUtf8(QString* self)
    {
        QByteArray aux = self->toUtf8();
        int length = aux.size();
        char* _return = (char*)malloc(length + 1);
        strncpy(_return, aux.data(), length);
        _return[length] = 0;

        return _return;
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

QString* QString__fromUtf16(const ushort* data, int size)
{
    return new QString(QString::fromUtf16(data, size));
}

const ushort* QString__utf16(const QString* self)
{
    return self->utf16();
}

int QString__size(const QString* self)
{
    return self->size();
}
