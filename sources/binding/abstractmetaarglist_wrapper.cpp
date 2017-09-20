

#include <abstractmetaarglist_wrapper.h>

extern "C"
{

    AbstractMetaArgumentList* AbstractMetaArgumentList__new()
    {
        return new AbstractMetaArgumentList();
    }

    void AbstractMetaArgumentList__adjust(AbstractMetaArgumentList **self)
    {
        *self = new AbstractMetaArgumentList(**self);
    }

    void AbstractMetaArgumentList__finalize(AbstractMetaArgumentList **self)
    {
        delete *self;
        *self = 0;
    }

    int AbstractMetaArgumentList_size(AbstractMetaArgumentList* self)
    {
        return self->size();
    }

    AbstractMetaArgument* AbstractMetaArgumentList_value(AbstractMetaArgumentList* self, int index)
    {
        return self->value(index);
    }

}
