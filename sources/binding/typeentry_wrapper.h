
#include <typesystem.h>

extern "C"
{

    void TypeEntry_name(QString* _return, TypeEntry* self);
    bool TypeEntry_isValue(TypeEntry* self);

}

extern "C" bool TypeEntry_isPrimitive(TypeEntry* self);
extern "C" void TypeEntry_targetLangName(QString* _return, TypeEntry* self);
