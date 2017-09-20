

#include <abstractmetaenumlist_wrapper.h>

extern "C"
{

    AbstractMetaEnumList* AbstractMetaEnumList__new()
    {
        return new AbstractMetaEnumList();
    }

    void AbstractMetaEnumList__adjust(AbstractMetaEnumList **self)
    {
        *self = new AbstractMetaEnumList(**self);
    }

    void AbstractMetaEnumList__finalize(AbstractMetaEnumList **self)
    {
        delete *self;
        *self = 0;
    }

    int AbstractMetaEnumList_size(AbstractMetaEnumList* self)
    {
        return self->size();
    }

    AbstractMetaEnum* AbstractMetaEnumList_value(AbstractMetaEnumList* self, int index)
    {
        return self->value(index);
    }

}
