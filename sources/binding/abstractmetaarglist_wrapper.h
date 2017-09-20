
#include <abstractmetalang_typedefs.h>

extern "C"
{

    AbstractMetaArgumentList* AbstractMetaArgumentList__new();
    void AbstractMetaArgumentList__adjust(AbstractMetaArgumentList** self);
    void AbstractMetaArgumentList__finalize(AbstractMetaArgumentList** self);

    int AbstractMetaArgumentList_size(AbstractMetaArgumentList* self);
    AbstractMetaArgument* AbstractMetaArgumentList_value(AbstractMetaArgumentList* self, int index);

}
