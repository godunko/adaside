
#include <abstractmetalang.h>

extern "C"
{

    void AbstractMetaType_name(QString* _return, AbstractMetaType* self);
    void AbstractMetaType_fullName(QString* _return, AbstractMetaType* self);

}

extern "C" bool AbstractMetaType_isConstant(AbstractMetaType* self);
extern "C" bool AbstractMetaType_isPrimitive(AbstractMetaType* self);
extern "C" bool AbstractMetaType_isValue(AbstractMetaType* self);
extern "C" ReferenceType AbstractMetaType_referenceType(AbstractMetaType* self);
extern "C" const TypeEntry* AbstractMetaType_typeEntry(AbstractMetaType* self);
