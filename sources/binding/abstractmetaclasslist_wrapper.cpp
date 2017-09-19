

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

}
