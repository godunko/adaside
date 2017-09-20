
#include <abstractmetalang_typedefs.h>

extern "C"
{

    AbstractMetaFunctionList* AbstractMetaFunctionList__new();
    void AbstractMetaFunctionList__adjust(AbstractMetaFunctionList** self);
    void AbstractMetaFunctionList__finalize(AbstractMetaFunctionList** self);

    int AbstractMetaFunctionList_size(AbstractMetaFunctionList* self);
    AbstractMetaFunction* AbstractMetaFunctionList_value(AbstractMetaFunctionList* self, int index);

}
