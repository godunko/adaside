
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

extern "C" bool TypeEntry_isPrimitive(TypeEntry* self)
{
    return self->isPrimitive();
}

void TypeEntry_targetLangAPIName(QString* _return, TypeEntry* self)
{
    *_return = self->targetLangApiName();
}

void TypeEntry_targetLangName(QString* _return, TypeEntry* self)
{
    *_return = self->targetLangName();
}
