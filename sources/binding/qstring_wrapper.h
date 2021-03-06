
#include <QString>

extern "C"
{

    void QString__adjust(QString **self);
    void QString__delete(QString **self);
    QString *QString__new();

    QString *QString__fromUtf8(const char *str, int size);
    char* QString_toUtf8(QString* self);

}

extern "C" int QString__size(const QString* self);
extern "C" const ushort* QString__utf16(const QString* self);
extern "C" QString* QString__fromUtf16(const ushort* data, int size);
