

#include <abstractmetatypelist_wrapper.h>

extern "C"
{

    AbstractMetaTypeList* AbstractMetaTypeList__new()
    {
        return new AbstractMetaTypeList();
    }

    void AbstractMetaTypeList__adjust(AbstractMetaTypeList **self)
    {
        *self = new AbstractMetaTypeList(**self);
    }

    void AbstractMetaTypeList__finalize(AbstractMetaTypeList **self)
    {
        delete *self;
        *self = 0;
    }

    int AbstractMetaTypeList_size(AbstractMetaTypeList* self)
    {
        return self->size();
    }

    AbstractMetaType* AbstractMetaTypeList_value(AbstractMetaTypeList* self, int index)
    {
        return self->value(index);
    }

}
