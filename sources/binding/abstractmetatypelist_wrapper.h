
#include <abstractmetalang_typedefs.h>

extern "C"
{

    AbstractMetaTypeList* AbstractMetaTypeList__new();
    void AbstractMetaTypeList__adjust(AbstractMetaTypeList** self);
    void AbstractMetaTypeList__finalize(AbstractMetaTypeList** self);

    int AbstractMetaTypeList_size(AbstractMetaTypeList* self);
    AbstractMetaType* AbstractMetaTypeList_value(AbstractMetaTypeList* self, int index);

}
