
#include "typeentry_wrapper.h"

extern "C"
{

    void TypeEntry_name(QString* _return, TypeEntry* self)
    {
        *_return = self->name();
    }

    bool TypeEntry_isValue(TypeEntry* self)
    {
        return self->isValue();
    }

}