
#include <abstractmetalang_typedefs.h>

extern "C"
{

    AbstractMetaFieldList* AbstractMetaFieldList__new();
    void AbstractMetaFieldList__adjust(AbstractMetaFieldList** self);
    void AbstractMetaFieldList__finalize(AbstractMetaFieldList** self);

    int AbstractMetaFieldList_size(AbstractMetaFieldList* self);
    AbstractMetaField* AbstractMetaFieldList_value(AbstractMetaFieldList* self, int index);

}
