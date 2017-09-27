
#include "abstractmetavariable_wrapper.h"

void AbstractMetaVariable_name(QString* _return, AbstractMetaVariable* self)
{
    *_return = self->name();
}
