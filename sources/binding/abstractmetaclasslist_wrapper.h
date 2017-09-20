
#include <abstractmetalang_typedefs.h>

extern "C"
{

    AbstractMetaClassList* AbstractMetaClassList__new();
    void AbstractMetaClassList__adjust(AbstractMetaClassList** self);
    void AbstractMetaClassList__finalize(AbstractMetaClassList** self);

    int AbstractMetaClassList_size(AbstractMetaClassList* self);

}
