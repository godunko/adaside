
#include "abstractmetaclass_wrapper.h"

extern "C"
{

    AbstractMetaAttributes* dynamic_cast__AbstractMetaClass__AbstractMetaAttributes(AbstractMetaClass* self)
    {
        return dynamic_cast<AbstractMetaAttributes*>(self);
    }

    void AbstractMetaClass_name(QString* _return, AbstractMetaClass* self)
    {
        *_return = self->name();
    }

}
