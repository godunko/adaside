
#include "abstractmetatype_wrapper.h"

extern "C"
{

    void AbstractMetaType_fullName(QString* _return, AbstractMetaType* self)
    {
        *_return = self->fullName();
    }

    void AbstractMetaType_name(QString* _return, AbstractMetaType* self)
    {
        *_return = self->name();
    }

}

bool AbstractMetaType_isConstant(AbstractMetaType* self)
{
    return self->isConstant();
}

bool AbstractMetaType_isValue(AbstractMetaType* self)
{
    return self->isValue();
}

ReferenceType AbstractMetaType_referenceType(AbstractMetaType* self)
{
    return self->referenceType();
}

const TypeEntry* AbstractMetaType_typeEntry(AbstractMetaType* self)
{
    return self->typeEntry();
}
