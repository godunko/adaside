#include <header_paths.h>

extern "C"
{

    HeaderPath* HeaderPath__new();
    HeaderPath* HeaderPath__new_2(QString *path);
    void HeaderPath__delete(HeaderPath **self);
    void HeaderPath__adjust(HeaderPath **self);

}
