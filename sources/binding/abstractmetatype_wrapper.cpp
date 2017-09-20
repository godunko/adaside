
#include "abstractmetatype_wrapper.h"

extern "C"
{

    void AbstractMetaType_fullName(QString* _return, AbstractMetaType* self)
    {
        *_return = self->fullName();
    }

    void AbstractMetaType_name(QString* _return, AbstractMetaType* self)
    {
        *_return = self->name();
    }

}
