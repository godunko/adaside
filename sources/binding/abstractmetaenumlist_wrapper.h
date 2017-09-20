
#include <abstractmetalang_typedefs.h>

extern "C"
{

    AbstractMetaEnumList* AbstractMetaEnumList__new();
    void AbstractMetaEnumList__adjust(AbstractMetaEnumList** self);
    void AbstractMetaEnumList__finalize(AbstractMetaEnumList** self);

    int AbstractMetaEnumList_size(AbstractMetaEnumList* self);
    AbstractMetaEnum* AbstractMetaEnumList_value(AbstractMetaEnumList* self, int index);

}
