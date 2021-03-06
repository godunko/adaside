
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

void AbstractMetaFunction_arguments(AbstractMetaArgumentList* _return, AbstractMetaFunction* self)
{
    *_return = self->arguments();
}

const AbstractMetaClass* AbstractMetaFunction_declaringClass(AbstractMetaFunction* self)
{
    return self->declaringClass();
}

const AbstractMetaFunction::FunctionType AbstractMetaFunction_functionType(AbstractMetaFunction* self)
{
    return self->functionType();
}

const AbstractMetaClass* AbstractMetaFunction_implementingClass(AbstractMetaFunction* self)
{
    return self->implementingClass();
}

bool AbstractMetaFunction_isArithmeticOperator(AbstractMetaFunction* self)
{
    return self->isArithmeticOperator();
}

bool AbstractMetaFunction_isBitwiseOperator(AbstractMetaFunction* self)
{
    return self->isBitwiseOperator();
}

bool AbstractMetaFunction_isComparisonOperator(AbstractMetaFunction* self)
{
    return self->isComparisonOperator();
}

bool AbstractMetaFunction_isConstant(AbstractMetaFunction* self)
{
    return self->isConstant();
}

bool AbstractMetaFunction_isConstructor(AbstractMetaFunction* self)
{
    return self->isConstructor();
}

bool AbstractMetaFunction_isInGlobalScope(AbstractMetaFunction* self)
{
    return self->isInGlobalScope();
}

bool AbstractMetaFunction_isReverseOperator(AbstractMetaFunction* self)
{
    return self->isReverseOperator();
}

void AbstractMetaFunction_minimalSignature(QString* _return, AbstractMetaFunction* self)
{
    *_return = self->minimalSignature();
}

const AbstractMetaClass* AbstractMetaFunction_ownerClass(AbstractMetaFunction* self)
{
    return self->ownerClass();
}

void AbstractMetaFunction_signature(QString* _return, AbstractMetaFunction* self)
{
    *_return = self->signature();
}

AbstractMetaType* AbstractMetaFunction_type(AbstractMetaFunction* self)
{
    return self->type();
}
