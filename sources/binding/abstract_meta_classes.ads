
with Abstract_Meta_Attributes;
limited with Abstract_Meta_Class_Lists;
with Abstract_Meta_Function_Lists;
with Complex_Type_Entries;
with Q_Strings;
with Type_Entries;

package Abstract_Meta_Classes is

   type AbstractMetaClass is null record with Convention => C;
   type AbstractMetaClass_Access is access all AbstractMetaClass;

   type Abstract_Meta_Class is
     new Abstract_Meta_Attributes.Abstract_Meta_Attributes with private;

   Null_Abstract_Meta_Class : constant Abstract_Meta_Class;

   pragma Style_Checks (Off);
   --    AbstractMetaClass *extractInterface();
   --    void fixFunctions();
   --
   --    void setFunctions(const AbstractMetaFunctionList &functions);
   --    void addFunction(AbstractMetaFunction *function);
   --    bool hasFunction(const AbstractMetaFunction *f) const;
   --    bool hasFunction(const QString &str) const;
   --    const AbstractMetaFunction* findFunction(const QString& functionName) const;
   --    bool hasSignal(const AbstractMetaFunction *f) const;
   --
   --    bool hasConstructors() const;
   --    bool hasCopyConstructor() const;
   --    bool hasPrivateCopyConstructor() const;
   --
   --    void addDefaultConstructor();
   --    void addDefaultCopyConstructor(bool isPrivate = false);
   --
   --    bool hasNonPrivateConstructor() const
   --    {
   --        return m_hasNonPrivateConstructor;
   --    }
   --
   --    void setHasNonPrivateConstructor(bool value)
   --    {
   --        m_hasNonPrivateConstructor = value;
   --    }
   --
   --    bool hasPrivateDestructor() const
   --    {
   --        return m_hasPrivateDestructor;
   --    }
   --
   --    void setHasPrivateDestructor(bool value)
   --    {
   --        m_hasPrivateDestructor = value;
   --    }
   --
   --    bool hasProtectedDestructor() const
   --    {
   --        return m_hasProtectedDestructor;
   --    }
   --
   --    void setHasProtectedDestructor(bool value)
   --    {
   --        m_hasProtectedDestructor = value;
   --    }
   --
   --    bool hasVirtualDestructor() const
   --    {
   --        return m_hasVirtualDestructor;
   --    }
   --
   --    void setHasVirtualDestructor(bool value)
   --    {
   --        m_hasVirtualDestructor = value;
   --    }
   --
   --    AbstractMetaFunctionList queryFunctionsByName(const QString &name) const;
   --    AbstractMetaFunctionList queryFunctions(FunctionQueryOptions query) const;
   --    AbstractMetaFunctionList functionsInTargetLang() const;
   --    AbstractMetaFunctionList functionsInShellClass() const;
   --    inline AbstractMetaFunctionList cppSignalFunctions() const;
   --    AbstractMetaFunctionList publicOverrideFunctions() const;
   --    AbstractMetaFunctionList virtualOverrideFunctions() const;
   --    AbstractMetaFunctionList virtualFunctions() const;
   --    AbstractMetaFunctionList implicitConversions() const;
   --
   --    AbstractMetaFunctionList operatorOverloads(OperatorQueryOptions query = AllOperators) const;
   --
   --    bool hasOperatorOverload() const;
   --    bool hasArithmeticOperatorOverload() const;
   --    bool hasBitwiseOperatorOverload() const;
   --    bool hasComparisonOperatorOverload() const;
   --    bool hasLogicalOperatorOverload() const;
   --    bool hasSubscriptOperatorOverload() const;
   --    bool hasAssignmentOperatorOverload() const;
   --    bool hasConversionOperatorOverload() const;
   --
   --    AbstractMetaFieldList fields() const
   --    {
   --        return m_fields;
   --    }
   --
   --    void setFields(const AbstractMetaFieldList &fields)
   --    {
   --        m_fields = fields;
   --    }
   --
   --    void addField(AbstractMetaField *field)
   --    {
   --        m_fields << field;
   --    }
   --
   --    AbstractMetaEnumList enums() const
   --    {
   --        return m_enums;
   --    }
   --    void setEnums(const AbstractMetaEnumList &enums)
   --    {
   --        m_enums = enums;
   --    }
   --
   --    void addEnum(AbstractMetaEnum *e)
   --    {
   --        m_enums << e;
   --    }
   --
   --    AbstractMetaEnum *findEnum(const QString &enumName);
   --    AbstractMetaEnum *findEnumForValue(const QString &enumName);
   --    AbstractMetaEnumValue *findEnumValue(const QString &enumName, AbstractMetaEnum *meta_enum);
   --
   --    AbstractMetaClassList interfaces() const
   --    {
   --        return m_interfaces;
   --    }
   --    void addInterface(AbstractMetaClass *interface);
   --    void setInterfaces(const AbstractMetaClassList &interface);
   --
   --    QString baseClassName() const
   --    {
   --        return m_baseClass ? m_baseClass->name() : QString();
   --    }
   --    AbstractMetaClass *baseClass() const
   --    {
   --        return m_baseClass;
   --    }
   --
   --    void setBaseClass(AbstractMetaClass *base_class);
   --
   --    const AbstractMetaClass *enclosingClass() const
   --    {
   --        return m_enclosingClass;
   --    }
   --
   --    void setEnclosingClass(AbstractMetaClass *cl)
   --    {
   --        m_enclosingClass = cl;
   --    }
   --
   --    const AbstractMetaClassList& innerClasses() const
   --    {
   --        return m_innerClasses;
   --    }
   --
   --    void addInnerClass(AbstractMetaClass* cl)
   --    {
   --        m_innerClasses << cl;
   --    }
   --
   --    void setInnerClasses(AbstractMetaClassList innerClasses)
   --    {
   --        m_innerClasses = innerClasses;
   --    }
   --
   --    QString package() const;
   --
   --    bool isInterface() const;
   --
   --    bool isNamespace() const;
   --
   --    bool isQObject() const;
   --
   --    bool isQtNamespace() const
   --    {
   --        return isNamespace() && name() == QLatin1String("Qt");
   --    }
   --
   --    QString qualifiedCppName() const;
   --
   --    bool hasSignals() const;
   --    bool inheritsFrom(const AbstractMetaClass *other) const;
   --
   --    void setForceShellClass(bool on)
   --    {
   --        m_forceShellClass = on;
   --    }
   --
   --    bool generateShellClass() const;
   --
   --    bool hasVirtualSlots() const
   --    {
   --        return m_hasVirtualSlots;
   --    }
   --
   --    /**
   --    *   Says if a class has any virtual functions of its own.
   --    *   \return true if the class implements any virtual methods
   --    */
   --    bool hasVirtualFunctions() const
   --    {
   --        return !isFinal() && m_hasVirtuals;
   --    }
   --    /**
   --    *   Says if the class that declares or inherits a virtual function.
   --    *   \return true if the class implements or inherits any virtual methods
   --    */
   --    bool isPolymorphic() const
   --    {
   --        return m_isPolymorphic;
   --    }
   --
   --    /**
   --     * Tells if this class has one or more functions that are protected.
   --     * \return true if the class has protected functions.
   --     */
   --    bool hasProtectedFunctions() const;
   --
   --    /**
   --     * Tells if this class has one or more fields (member variables) that are protected.
   --     * \return true if the class has protected fields.
   --     */
   --    bool hasProtectedFields() const;
   --
   --    /**
   --     * Tells if this class has one or more members (functions or fields) that are protected.
   --     * \return true if the class has protected members.
   --     */
   --    bool hasProtectedMembers() const;
   --
   --
   --    QVector<TypeEntry *> templateArguments() const
   --    {
   --        return m_templateArgs;
   --    }
   --
   --    void setTemplateArguments(const QVector<TypeEntry *> &args)
   --    {
   --        m_templateArgs = args;
   --    }
   --
   --    bool hasFieldAccessors() const;
   --
   --    // only valid during metabuilder's run
   --    QStringList baseClassNames() const
   --    {
   --        return m_baseClassNames;
   --    }
   --
   --    void setBaseClassNames(const QStringList &names)
   --    {
   --        m_baseClassNames = names;
   --    }
   --
   --    const ComplexTypeEntry *typeEntry() const
   --    {
   --        return m_typeEntry;
   --    }
   --
   --    void setTypeEntry(ComplexTypeEntry *type)
   --    {
   --        m_typeEntry = type;
   --    }
   --
   --    void setHasHashFunction(bool on)
   --    {
   --        m_hasHashFunction = on;
   --    }
   --
   --    bool hasHashFunction() const
   --    {
   --        return m_hasHashFunction;
   --    }
   --    virtual bool hasDefaultToStringFunction() const;
   --
   --    void setHasEqualsOperator(bool on)
   --    {
   --        m_hasEqualsOperator = on;
   --    }
   --
   --    bool hasEqualsOperator() const
   --    {
   --        return m_hasEqualsOperator;
   --    }
   --
   --    void setHasCloneOperator(bool on)
   --    {
   --        m_hasCloneOperator = on;
   --    }
   --
   --    bool hasCloneOperator() const
   --    {
   --        return m_hasCloneOperator;
   --    }
   --
   --    void addPropertySpec(QPropertySpec *spec)
   --    {
   --        m_propertySpecs << spec;
   --    }
   --
   --    QVector<QPropertySpec *> propertySpecs() const
   --    {
   --        return m_propertySpecs;
   --    }
   --
   --    QPropertySpec *propertySpecForRead(const QString &name) const;
   --    QPropertySpec *propertySpecForWrite(const QString &name) const;
   --    QPropertySpec *propertySpecForReset(const QString &name) const;
   --
   --    /// Returns a list of conversion operators for this class. The conversion operators are defined in other classes of the same module.
   --    AbstractMetaFunctionList externalConversionOperators() const
   --    {
   --        return m_externalConversionOperators;
   --    }
   --    /// Adds a converter operator for this class.
   --    void addExternalConversionOperator(AbstractMetaFunction* conversionOp)
   --    {
   --        if (!m_externalConversionOperators.contains(conversionOp))
   --            m_externalConversionOperators.append(conversionOp);
   --    }
   --    /// Returns true if this class has any converter operators defined elsewhere.
   --    bool hasExternalConversionOperators() const
   --    {
   --        return !m_externalConversionOperators.isEmpty();
   --    }
   --
   --    void sortFunctions();
   --
   --    const AbstractMetaClass *templateBaseClass() const
   --    {
   --        return m_templateBaseClass;
   --    }
   --
   --    void setTemplateBaseClass(const AbstractMetaClass *cls)
   --    {
   --        m_templateBaseClass = cls;
   --    }
   --
   --    bool hasTemplateBaseClassInstantiations() const;
   --    AbstractMetaTypeList templateBaseClassInstantiations() const;
   --    void setTemplateBaseClassInstantiations(AbstractMetaTypeList& instantiations);
   --
   --    void setTypeDef(bool typeDef) { m_isTypeDef = typeDef; }
   --    bool isTypeDef() const { return m_isTypeDef; }
   --
   --    void setStream(bool stream)
   --    {
   --        m_stream = stream;
   --    }
   --
   --    bool isStream() const
   --    {
   --        return m_stream;
   --    }
   --
   --    void setToStringCapability(bool value)
   --    {
   --        m_hasToStringCapability = value;
   --    }
   --
   --    bool hasToStringCapability() const
   --    {
   --        return m_hasToStringCapability;
   --    }
   --
   --    static AbstractMetaClass *findClass(const AbstractMetaClassList &classes,
   --                                        const QString &name);
   --    static AbstractMetaEnumValue *findEnumValue(const AbstractMetaClassList &classes,
   --                                                const QString &string);
   --    static AbstractMetaEnum *findEnum(const AbstractMetaClassList &classes,
   --                                      const EnumTypeEntry *entry);
   pragma Style_Checks (On);

   function Full_Name
    (Self : Abstract_Meta_Class'Class) return Q_Strings.Q_String;
   --    QString fullName() const

   function Functions
    (Self : Abstract_Meta_Class'Class)
       return Abstract_Meta_Function_Lists.Abstract_Meta_Function_List;
   --    AbstractMetaFunctionList functions() const

   function Name (Self : Abstract_Meta_Class'Class) return Q_Strings.Q_String;
   --  Retrieves the class name without any namespace/scope information.
   --  /return the class name without scope information
   --    QString name() const;

   function Type_Entry
    (Self : Abstract_Meta_Class'Class)
       return Complex_Type_Entries.Complex_Type_Entry;
   --    ComplexTypeEntry *typeEntry()

   function Find_Class
    (Classes    : Abstract_Meta_Class_Lists.Abstract_Meta_Class_List'Class;
     Type_Entry : Type_Entries.Type_Entry'Class)
       return Abstract_Meta_Class;
   --  static AbstractMetaClass *findClass(
   --    const AbstractMetaClassList &classes,
   --    const TypeEntry* typeEntry);

   package Internals is

      function Wrap
       (Object : AbstractMetaClass_Access) return Abstract_Meta_Class;

   end Internals;

private

   type Abstract_Meta_Class is
     new Abstract_Meta_Attributes.Abstract_Meta_Attributes with
   record
      Object : AbstractMetaClass_Access;
   end record;

   overriding function Internal
    (Self : Abstract_Meta_Class)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access;

   Null_Abstract_Meta_Class : constant Abstract_Meta_Class := (Object => null);

end Abstract_Meta_Classes;
