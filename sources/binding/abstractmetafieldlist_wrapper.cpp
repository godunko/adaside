

#include <abstractmetafieldlist_wrapper.h>

extern "C"
{

    AbstractMetaFieldList* AbstractMetaFieldList__new()
    {
        return new AbstractMetaFieldList();
    }

    void AbstractMetaFieldList__adjust(AbstractMetaFieldList **self)
    {
        *self = new AbstractMetaFieldList(**self);
    }

    void AbstractMetaFieldList__finalize(AbstractMetaFieldList **self)
    {
        delete *self;
        *self = 0;
    }

    int AbstractMetaFieldList_size(AbstractMetaFieldList* self)
    {
        return self->size();
    }

    AbstractMetaField* AbstractMetaFieldList_value(AbstractMetaFieldList* self, int index)
    {
        return self->value(index);
    }

}
