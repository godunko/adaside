
#include "abstractmetaclass_wrapper.h"

extern "C"
{

    AbstractMetaAttributes* dynamic_cast__AbstractMetaClass__AbstractMetaAttributes(AbstractMetaClass* self)
    {
        return dynamic_cast<AbstractMetaAttributes*>(self);
    }

    void AbstractMetaClass_fullName(QString* _return, AbstractMetaClass* self)
    {
        *_return = self->fullName();
    }

    void AbstractMetaClass_name(QString* _return, AbstractMetaClass* self)
    {
        *_return = self->name();
    }

    ComplexTypeEntry* AbstractMetaClass_typeEntry (AbstractMetaClass* self)
    {
        return self->typeEntry();
    }

}

void AbstractMetaClass_functions(AbstractMetaFunctionList* _return, AbstractMetaClass* self)
{
    *_return = self->functions();
}

AbstractMetaClass* AbstractMetaClass_findClass(const AbstractMetaClassList* classes, const TypeEntry* typeEntry)
{
    return AbstractMetaClass::findClass(*classes, typeEntry);
}
