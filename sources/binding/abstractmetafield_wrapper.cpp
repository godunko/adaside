
#include "abstractmetafield_wrapper.h"

extern "C"
{

    AbstractMetaAttributes* dynamic_cast__AbstractMetaField__AbstractMetaAttributes(AbstractMetaField* self)
    {
        return dynamic_cast<AbstractMetaAttributes*>(self);
    }

    AbstractMetaVariable* dynamic_cast__AbstractMetaField__AbstractMetaVariable(AbstractMetaField* self)
    {
        return dynamic_cast<AbstractMetaVariable*>(self);
    }

}
