

#include <abstractmetafunclist_wrapper.h>

extern "C"
{

    AbstractMetaFunctionList* AbstractMetaFunctionList__new()
    {
        return new AbstractMetaFunctionList();
    }

    void AbstractMetaFunctionList__adjust(AbstractMetaFunctionList **self)
    {
        *self = new AbstractMetaFunctionList(**self);
    }

    void AbstractMetaFunctionList__finalize(AbstractMetaFunctionList **self)
    {
        delete *self;
        *self = 0;
    }

    int AbstractMetaFunctionList_size(AbstractMetaFunctionList* self)
    {
        return self->size();
    }

    AbstractMetaFunction* AbstractMetaFunctionList_value(AbstractMetaFunctionList* self, int index)
    {
        return self->value(index);
    }

}
