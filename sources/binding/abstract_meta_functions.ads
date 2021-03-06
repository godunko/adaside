with League.Strings;

with Abstract_Meta_Argument_Lists;
with Abstract_Meta_Attributes;
limited with Abstract_Meta_Classes;
with Abstract_Meta_Types;
with Q_Strings;

package Abstract_Meta_Functions is

   type Function_Types is
    (Constructor_Function,
     Copy_Constructor_Function,
     Move_Constructor_Function,
     Assignment_OperatorFunction,
     Move_Assignment_Operator_Function,
     Destructor_Function,
     Normal_Function,
     Signal_Function,
     Empty_Function,
     Slot_Function,
     Global_Scope_Function) with Convention => C;

   type AbstractMetaFunction is null record with Convention => C;
   type AbstractMetaFunction_Access is access all AbstractMetaFunction;

   type Abstract_Meta_Function is
     new Abstract_Meta_Attributes.Abstract_Meta_Attributes with private;

   --    void setName(const QString &name)
   --
   --    QString originalName() const
   --    {
   --        return m_originalName.isEmpty() ? name() : m_originalName;
   --    }
   --
   --    void setOriginalName(const QString &name)
   --    {
   --        m_originalName = name;
   --    }
   --
   --    void setReverseOperator(bool reverse)
   --
   --    /**
   --     *  Returns true if this is a operator and the "self" operand is a
   --     *  pointer. e.g. class Foo {}; operator+(SomeEnum, Foo*);
   --     */
   --    bool isPointerOperator() const
   --    {
   --        return m_pointerOperator;
   --    }
   --
   --    void setPointerOperator(bool value)
   --    {
   --        m_pointerOperator = value;
   --    }
   --
   --    void setExplicit(bool isExplicit)
   --    {
   --        m_explicit = isExplicit;
   --    }
   --    /**
   --    *   Says if the function (a constructor) was declared as explicit in
   --    *   C++.
   --    *   \return true if the function was declared as explicit in C++
   --    */
   --    bool isExplicit() const
   --    {
   --        return m_explicit;
   --    }
   --
   --    static bool isConversionOperator(QString funcName);
   --    bool isConversionOperator() const
   --    {
   --        return isConversionOperator(originalName());
   --    }
   --
   --    static bool isOperatorOverload(QString funcName);
   --    bool isOperatorOverload() const
   --    {
   --        return isOperatorOverload(originalName());
   --    }
   --    bool isCastOperator() const;
   --
   --    bool isLogicalOperator() const;
   --    bool isSubscriptOperator() const;
   --    bool isAssignmentOperator() const; // Assignment or move assignment
   --    bool isOtherOperator() const;
   --
   --    /**
   --     * Informs the arity of the operator or -1 if the function is not
   --     * an operator overload.
   --     * /return the arity of the operator or -1
   --     */
   --    int arityOfOperator() const;
   --    bool isUnaryOperator() const { return arityOfOperator() == 1; }
   --    bool isBinaryOperator() const { return arityOfOperator() == 2; }
   --    bool isInplaceOperator() const;
   --
   --    // TODO: ths function *should* know if it is virtual
   --    // instead of asking to your implementing class.
   --    bool isVirtual() const;
   --    bool isThread() const;
   --    bool allowThread() const;
   --    QString modifiedName() const;
   --
   --    QStringList possibleIntrospectionCompatibleSignatures() const;
   --
   --    QString marshalledName() const;
   --
   --    // true if one or more of the arguments are of QtJambiObject
   --    // subclasses
   --    bool argumentsHaveNativeId() const
   --    {
   --        for (const AbstractMetaArgument *arg : m_arguments) {
   --            if (arg->type()->hasNativeId())
   --                return true;
   --        }
   --
   --        return false;
   --    }
   --
   --    bool isModifiedRemoved(int types = TypeSystem::All) const;
   --
   --    void setType(AbstractMetaType *type)
   --    {
   --        Q_ASSERT(m_type == 0);
   --        m_type = type;
   --    }
   --
   --    void replaceType(AbstractMetaType *type)
   --    {
   --        if (m_type)
   --            delete m_type;
   --        m_type = type;
   --    }
   --
   --    void setOwnerClass(const AbstractMetaClass *cls)
   --    void setDeclaringClass(const AbstractMetaClass *cls)
   --    void setImplementingClass(const AbstractMetaClass *cls)
   --
   --    bool needsCallThrough() const;
   --
   --    void setArguments(const AbstractMetaArgumentList &arguments)
   --    {
   --        m_arguments = arguments;
   --    }
   --    void addArgument(AbstractMetaArgument *argument)
   --    {
   --        m_arguments << argument;
   --    }
   --    int actualMinimumArgumentCount() const;
   --
   --    bool isDeprecated() const;
   --    bool isDestructor() const
   --    {
   --        return functionType() == DestructorFunction;
   --    }
   --    bool isNormal() const
   --    {
   --        return functionType() == NormalFunction || isSlot() ||
   --                                   isInGlobalScope();
   --    }
   --    bool isSignal() const
   --    {
   --        return functionType() == SignalFunction;
   --    }
   --    bool isSlot() const
   --    {
   --        return functionType() == SlotFunction;
   --    }
   --    bool isEmptyFunction() const
   --    {
   --        return functionType() == EmptyFunction;
   --    }
   --    void setFunctionType(FunctionType type)
   --
   --    bool usesRValueReferences() const;
   --    QStringList introspectionCompatibleSignatures(
   --      const QStringList &resolvedArguments = QStringList()) const;
   --    QString targetLangSignature(bool minimal = false) const;
   --    bool shouldReturnThisObject() const
   --    {
   --        return QLatin1String("this") == argumentReplaced(0);
   --    }
   --    bool shouldIgnoreReturnValue() const
   --    {
   --        return QLatin1String("void") == argumentReplaced(0);
   --    }
   --
   --    void setConstant(bool constant)
   --    {
   --        m_constant = constant;
   --    }
   --
   --    // Returns true if the AbstractMetaFunction was added by the user
   --    // via the type system description.
   --    bool isUserAdded() const
   --    {
   --        return m_userAdded;
   --    }
   --    void setUserAdded(bool userAdded)
   --    {
   --        m_userAdded = userAdded;
   --    }
   --
   --    QString toString() const
   --    {
   --        return m_name;
   --    }
   --
   --    CompareResult compareTo(const AbstractMetaFunction *other) const;
   --
   --    bool operator <(const AbstractMetaFunction &a) const;
   --
   --    AbstractMetaFunction *copy() const;
   --
   --    QString replacedDefaultExpression(
   --      const AbstractMetaClass *cls, int idx) const;
   --    bool removedDefaultExpression(
   --      const AbstractMetaClass *cls, int idx) const;
   --    QString conversionRule(TypeSystem::Language language, int idx) const;
   --    QVector<ReferenceCount> referenceCounts(
   --      const AbstractMetaClass *cls, int idx = -2) const;
   --    ArgumentOwner argumentOwner(
   --      const AbstractMetaClass *cls, int idx) const;
   --
   --    bool nullPointersDisabled(
   --      const AbstractMetaClass *cls = 0, int argument_idx = 0) const;
   --    QString nullPointerDefaultValue(
   --      const AbstractMetaClass *cls = 0, int argument_idx = 0) const;
   --
   --    bool resetObjectAfterUse(int argument_idx) const;
   --
   --    // Returns whether garbage collection is disabled for the argument in
   --    // any context
   --    bool disabledGarbageCollection(
   --      const AbstractMetaClass *cls, int key) const;
   --
   --    // Returns the ownership rules for the given argument in the given
   --    // context
   --    TypeSystem::Ownership ownership(
   --      const AbstractMetaClass *cls,
   --      TypeSystem::Language language, int idx) const;
   --
   --    bool isVirtualSlot() const;
   --
   --    QString typeReplaced(int argument_index) const;
   --    bool isRemovedFromAllLanguages(const AbstractMetaClass *) const;
   --    bool isRemovedFrom(
   --      const AbstractMetaClass *, TypeSystem::Language language) const;
   --    bool argumentRemoved(int) const;
   --
   --    QString argumentReplaced(int key) const;
   --    bool needsSuppressUncheckedWarning() const;
   --
   --    bool hasModifications(const AbstractMetaClass *implementor) const;
   --    /**
   --    *   Verifies if any modification to the function is an inject code.
   --    *   \return true if there is inject code modifications to the
   --    *   function.
   --    */
   --    bool hasInjectedCode() const;
   --    /**
   --    *   Returns a list of code snips for this function.
   --    *   The code snips can be filtered by position and language.
   --    *   \return list of code snips
   --    */
   --    CodeSnipList injectedCodeSnips(
   --      TypeSystem::CodeSnipPosition position =
   --        TypeSystem::CodeSnipPositionAny,
   --      TypeSystem::Language language = TypeSystem::All) const;
   --
   --    /**
   --    *   Verifies if any modification to the function alters/removes its
   --    *   arguments types or default values.
   --    *   \return true if there is some modification to function signature
   --    */
   --    bool hasSignatureModifications() const;
   --    FunctionModificationList modifications(
   --      const AbstractMetaClass* implementor = 0) const;
   --
   --    /**
   --     * Return the argument name if there is a modification the renamed
   --     * value will be returned
   --     */
   --    QString argumentName(int index,
   --                         bool create = true,
   --                         const AbstractMetaClass *cl = 0) const;
   --
   --    void setPropertySpec(QPropertySpec *spec)
   --    {
   --        m_propertySpec = spec;
   --    }
   --
   --    QPropertySpec *propertySpec() const
   --    {
   --        return m_propertySpec;
   --    }
   --
   --    FunctionTypeEntry* typeEntry() const
   --    {
   --        return m_typeEntry;
   --    }
   --
   --    void setTypeEntry(FunctionTypeEntry* typeEntry)
   --    {
   --        m_typeEntry = typeEntry;
   --    }
   --
   --    bool isCallOperator() const;

   function Arguments
    (Self : Abstract_Meta_Function'Class)
       return Abstract_Meta_Argument_Lists.Abstract_Meta_Argument_List;
   --  AbstractMetaArgumentList arguments() const

   function Declaring_Class
    (Self : Abstract_Meta_Function'Class)
       return Abstract_Meta_Classes.Abstract_Meta_Class;
   --  The first class in a hierarchy that declares the function
   --  const AbstractMetaClass *declaringClass() const

   function Function_Type
    (Self : Abstract_Meta_Function'Class) return Function_Types;
   --  FunctionType functionType() const

   function Implementing_Class
    (Self : Abstract_Meta_Function'Class)
       return Abstract_Meta_Classes.Abstract_Meta_Class;
   --  The class that actually implements this function
   --  const AbstractMetaClass *implementingClass() const

   function Is_Arithmetic_Operator
    (Self : Abstract_Meta_Function'Class) return Boolean;
   --  bool isArithmeticOperator() const

   function Is_Bitwise_Operator
    (Self : Abstract_Meta_Function'Class) return Boolean;
   --  bool isBitwiseOperator() const

   function Is_Comparison_Operator
    (Self : Abstract_Meta_Function'Class) return Boolean;
   --  bool isComparisonOperator() const

   function Is_Constant
    (Self : Abstract_Meta_Function'Class) return Boolean;
   --  bool isConstant() const

   function Is_Constructor
    (Self : Abstract_Meta_Function'Class) return Boolean;
   --  bool isConstructor() const

   function Is_Copy_Constructor
    (Self : Abstract_Meta_Function'Class) return Boolean;

   function Is_In_Global_Scope
    (Self : Abstract_Meta_Function'Class) return Boolean;
   --  bool isInGlobalScope() const

   function Is_Reverse_Operator
    (Self : Abstract_Meta_Function'Class) return Boolean;
   --  bool isReverseOperator() const

   function Minimal_Signature
    (Self : Abstract_Meta_Function'Class) return Q_Strings.Q_String;
   function Minimal_Signature
    (Self : Abstract_Meta_Function'Class)
       return League.Strings.Universal_String;
   --  QString minimalSignature() const

   function Name
    (Self : Abstract_Meta_Function'Class) return Q_Strings.Q_String;
   function Name
    (Self : Abstract_Meta_Function'Class)
       return League.Strings.Universal_String;
   --  QString name() const;

   function Owner_Class
    (Self : Abstract_Meta_Function'Class)
       return Abstract_Meta_Classes.Abstract_Meta_Class;
   --  The class that has this function as a member.
   --  const AbstractMetaClass *ownerClass() const

   function Signature
    (Self : Abstract_Meta_Function'Class) return Q_Strings.Q_String;
   function Signature
    (Self : Abstract_Meta_Function'Class)
       return League.Strings.Universal_String;
   --  QString signature() const

   function Get_Type (Self : Abstract_Meta_Function'Class)
     return Abstract_Meta_Types.Abstract_Meta_Type;
   --  AbstractMetaType *type() const

   package Internals is

      function Wrap
       (Object : AbstractMetaFunction_Access) return Abstract_Meta_Function;

   end Internals;

private

   type Abstract_Meta_Function is
     new Abstract_Meta_Attributes.Abstract_Meta_Attributes with
   record
      Object : AbstractMetaFunction_Access;
   end record;

   overriding function Internal
    (Self : Abstract_Meta_Function)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access;

end Abstract_Meta_Functions;
