
#include "abstractmetaattributes_wrapper.h"

bool AbstractMetaAttributes_isFriendly(AbstractMetaAttributes* self)
{
    return self->isFriendly();
}

bool AbstractMetaAttributes_isStatic(AbstractMetaAttributes* self)
{
    return self->isStatic();
}
