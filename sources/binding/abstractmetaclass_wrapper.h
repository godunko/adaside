
#include <abstractmetalang.h>

extern "C"
{

    AbstractMetaAttributes* dynamic_cast__AbstractMetaClass__AbstractMetaAttributes(AbstractMetaClass* self);
    void AbstractMetaClass_name(QString* _return, AbstractMetaClass* self);
    void AbstractMetaClass_fullName(QString* _return, AbstractMetaClass* self);
    ComplexTypeEntry* AbstractMetaClass_typeEntry (AbstractMetaClass* self);

}

extern "C" void AbstractMetaClass_functions(AbstractMetaFunctionList* _return, AbstractMetaClass* self);
extern "C" AbstractMetaClass* AbstractMetaClass_findClass(const AbstractMetaClassList* classes, const TypeEntry* typeEntry);

