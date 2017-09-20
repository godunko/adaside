

#include <abstractmetaclasslist_wrapper.h>

extern "C"
{

    AbstractMetaClassList* AbstractMetaClassList__new()
    {
        return new AbstractMetaClassList();
    }

    void AbstractMetaClassList__adjust(AbstractMetaClassList **self)
    {
        *self = new AbstractMetaClassList(**self);
    }

    void AbstractMetaClassList__finalize(AbstractMetaClassList **self)
    {
        delete *self;
        *self = 0;
    }

    int AbstractMetaClassList_size(AbstractMetaClassList* self)
    {
        return self->size();
    }

}
