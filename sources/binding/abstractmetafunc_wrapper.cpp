
#include "abstractmetafunc_wrapper.h"

extern "C"
{

    AbstractMetaAttributes* dynamic_cast__AbstractMetaFunction__AbstractMetaAttributes(AbstractMetaFunction* self)
    {
        return dynamic_cast<AbstractMetaAttributes*>(self);
    }

    void AbstractMetaFunction_name(QString* _return, AbstractMetaFunction* self)
    {
        *_return = self->name();
    }

}

bool AbstractMetaFunction_isConstant(AbstractMetaFunction* self)
{
    return self->isConstant();
}

bool AbstractMetaFunction_isConstructor(AbstractMetaFunction* self)
{
    return self->isConstructor();
}
