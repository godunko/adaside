
#include <abstractmetalang.h>

extern "C"
{

    AbstractMetaAttributes* dynamic_cast__AbstractMetaFunction__AbstractMetaAttributes(AbstractMetaFunction* self);
    void AbstractMetaFunction_name(QString* _return, AbstractMetaFunction* self);
    void AbstractMetaFunction_fullName(QString* _return, AbstractMetaFunction* self);

}

extern "C" void AbstractMetaFunction_arguments(AbstractMetaArgumentList* _return, AbstractMetaFunction* self);
extern "C" const AbstractMetaClass* AbstractMetaFunction_declaringClass(AbstractMetaFunction* self);
extern "C" const AbstractMetaClass* AbstractMetaFunction_implementingClass(AbstractMetaFunction* self);
extern "C" bool AbstractMetaFunction_isArithmeticOperator(AbstractMetaFunction* self);
extern "C" bool AbstractMetaFunction_isBitwiseOperator(AbstractMetaFunction* self);
extern "C" bool AbstractMetaFunction_isConstant(AbstractMetaFunction* self);
extern "C" bool AbstractMetaFunction_isConstructor(AbstractMetaFunction* self);
extern "C" bool AbstractMetaFunction_isInGlobalScope(AbstractMetaFunction* self);
extern "C" bool AbstractMetaFunction_isReverseOperator(AbstractMetaFunction* self);
extern "C" const AbstractMetaClass* AbstractMetaFunction_ownerClass(AbstractMetaFunction* self);
extern "C" AbstractMetaType* AbstractMetaFunction_type(AbstractMetaFunction* self);
