
#include "abstractmetaclass_wrapper.h"

extern "C"
{

    AbstractMetaAttributes* dynamic_cast__AbstractMetaEnum__AbstractMetaAttributes(AbstractMetaEnum* self)
    {
        return dynamic_cast<AbstractMetaAttributes*>(self);
    }

    void AbstractMetaEnum_fullName(QString* _return, AbstractMetaEnum* self)
    {
        *_return = self->fullName();
    }

    void AbstractMetaEnum_name(QString* _return, AbstractMetaEnum* self)
    {
        *_return = self->name();
    }

}
