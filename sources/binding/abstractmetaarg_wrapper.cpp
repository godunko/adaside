
#include "abstractmetaclass_wrapper.h"

extern "C"
{

    AbstractMetaVariable* dynamic_cast__AbstractMetaArgument__AbstractMetaVariable(AbstractMetaArgument* self)
    {
        return dynamic_cast<AbstractMetaVariable*>(self);
    }

    void AbstractMetaArgument_name(QString* _return, AbstractMetaArgument* self)
    {
        *_return = self->name();
    }

}
