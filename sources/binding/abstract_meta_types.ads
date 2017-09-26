
with Type_Entries;
with Q_Strings;

package Abstract_Meta_Types is

   type Reference_Types is (No_Reference, L_Value_Reference, R_Value_Reference)
     with Convention => C;

   type AbstractMetaType is null record with Convention => C;
   type AbstractMetaType_Access is access all AbstractMetaType;

   type Abstract_Meta_Type is tagged private;

   function Is_Null (Self : Abstract_Meta_Type'Class) return Boolean;

   --    QString package() const;
   --
   --    void setTypeUsagePattern(TypeUsagePattern pattern)
   --    {
   --        m_pattern = pattern;
   --    }
   --    TypeUsagePattern typeUsagePattern() const
   --    {
   --        return m_pattern;
   --    }
   --
   --    // true when use pattern is container
   --    bool hasInstantiations() const
   --    {
   --        return !m_instantiations.isEmpty();
   --    }
   --
   --    void addInstantiation(AbstractMetaType* inst, bool owner = false)
   --    {
   --        if (owner)
   --            m_children << inst;
   --        m_instantiations << inst;
   --    }
   --
   --    void setInstantiations(
   --      const AbstractMetaTypeList  &insts, bool owner = false)
   --    {
   --        m_instantiations = insts;
   --        if (owner) {
   --            m_children.clear();
   --            m_children = insts;
   --        }
   --    }
   --
   --    AbstractMetaTypeList instantiations() const
   --    {
   --        return m_instantiations;
   --    }
   --
   --    void setInstantiationInCpp(bool incpp)
   --    {
   --        m_cppInstantiation = incpp;
   --    }
   --    bool hasInstantiationInCpp() const
   --    {
   --        return hasInstantiations() && m_cppInstantiation;
   --    }
   --
   --    QString minimalSignature() const { return formatSignature(true); }
   --
   --    // true when the type is a QtJambiObject subclass
   --    bool hasNativeId() const;
   --
   --    // returns true if the typs is used as a non complex primitive, no
   --    //  & or *'s
   --    bool isPrimitive() const
   --    {
   --        return m_pattern == PrimitivePattern;
   --    }
   --
   --    bool isCppPrimitive() const;
   --
   --    // returns true if the type is used as an enum
   --    bool isEnum() const
   --    {
   --        return m_pattern == EnumPattern;
   --    }
   --
   --    // returns true if the type is used as a QObject *
   --    bool isQObject() const
   --    {
   --        return m_pattern == QObjectPattern;
   --    }
   --
   --    // returns true if the type is used as an object, e.g. Xxx *
   --    bool isObject() const
   --    {
   --        return m_pattern == ObjectPattern;
   --    }
   --
   --    // returns true if the type is used as an array, e.g. Xxx[42]
   --    bool isArray() const
   --    {
   --        return m_pattern == ArrayPattern;
   --    }
   --
   --    bool isValuePointer() const
   --    {
   --        return m_pattern == ValuePointerPattern;
   --    }
   --
   --    // returns true for more complex types...
   --    bool isNativePointer() const
   --    {
   --        return m_pattern == NativePointerPattern;
   --    }
   --
   --    // returns true if the type was originally a QString or const
   --    // QString & or equivalent for QLatin1String
   --    bool isTargetLangString() const
   --    {
   --        return m_pattern == StringPattern;
   --    }
   --
   --    // returns true if the type was originally a QChar or const QChar &
   --    bool isTargetLangChar() const
   --    {
   --        return m_pattern == CharPattern;
   --    }
   --
   --    // return true if the type was originally a QVariant or const
   --    // QVariant &
   --    bool isVariant() const
   --    {
   --        return m_pattern == VariantPattern;
   --    }
   --
   --    // return true if the type was originally a varargs
   --    bool isVarargs() const
   --    {
   --        return m_pattern == VarargsPattern;
   --    }
   --
   --    // return true if the type was originally a JObjectWrapper or const
   --    //  JObjectWrapper &
   --    bool isJObjectWrapper() const
   --    {
   --        return m_pattern == JObjectWrapperPattern;
   --    }
   --
   --    // returns true if the type was used as a container
   --    bool isContainer() const
   --    {
   --        return m_pattern == ContainerPattern;
   --    }
   --
   --    // returns true if the type was used as a smart pointer
   --    bool isSmartPointer() const
   --     { return m_pattern == SmartPointerPattern; }
   --
   --    // returns true if the type was used as a flag
   --    bool isFlags() const
   --    {
   --        return m_pattern == FlagsPattern;
   --    }
   --
   --    // returns true if the type was used as a thread
   --    bool isThread() const
   --    {
   --        return m_pattern == ThreadPattern;
   --    }
   --
   --    bool isConstant() const
   --    {
   --        return m_constant;
   --    }
   --    void setConstant(bool constant)
   --    {
   --        m_constant = constant;
   --    }
   --
   --    void setReferenceType(ReferenceType ref) { m_referenceType = ref; }
   --
   --    /**
   --     *   Says if the type is to be implemented using target language
   --     *   equivalent of C++ enums, i.e. not plain ints.
   --     *   /return true if the type is to be implemented using target
   --     *   language enums
   --     */
   --    bool isTargetLangEnum() const;
   --    bool isIntegerEnum() const
   --    {
   --        return isEnum() && !isTargetLangEnum();
   --    }
   --
   --    /**
   --     *   Says if the type is to be implemented using target language
   --     *   equivalent of Qt's QFlags, i.e. not plain ints.
   --     *   /return true if the type is to be implemented using target
   --     *   language QFlags
   --     */
   --    bool isTargetLangFlags() const;
   --    bool isIntegerFlags() const
   --    {
   --        return isFlags() && !isTargetLangFlags();
   --    }
   --
   --    int actualIndirections() const
   --    {
   --        return
   --          m_indirections + (m_referenceType == LValueReference ? 1 : 0);
   --    }
   --    int indirections() const
   --    {
   --        return m_indirections;
   --    }
   --    void setIndirections(int indirections)
   --    {
   --        m_indirections = indirections;
   --    }
   --
   --    void setArrayElementCount(int n)
   --    {
   --        m_arrayElementCount = n;
   --    }
   --    int arrayElementCount() const
   --    {
   --        return m_arrayElementCount;
   --    }
   --
   --    const AbstractMetaType *arrayElementType() const
   --    {
   --        return m_arrayElementType;
   --    }
   --    void setArrayElementType(const AbstractMetaType *t)
   --    {
   --        m_arrayElementType = t;
   --    }
   --
   --    AbstractMetaTypeCList nestedArrayTypes() const;
   --
   --    QString cppSignature() const;
   --
   --    AbstractMetaType *copy() const;
   --    void setTypeEntry(const TypeEntry *type)
   --    {
   --        m_typeEntry = type;
   --    }
   --
   --    void setOriginalTypeDescription(const QString &otd)
   --    {
   --        m_originalTypeDescription = otd;
   --    }
   --    QString originalTypeDescription() const
   --    {
   --        return m_originalTypeDescription;
   --    }
   --
   --    void setOriginalTemplateType(const AbstractMetaType *type)
   --    {
   --        m_originalTemplateType = type;
   --    }
   --    const AbstractMetaType *originalTemplateType() const
   --    {
   --        return m_originalTemplateType;
   --    }
   --
   --    AbstractMetaType *getSmartPointerInnerType() const
   --    {
   --        Q_ASSERT(isSmartPointer());
   --        AbstractMetaTypeList instantiations = this->instantiations();
   --        Q_ASSERT(!instantiations.isEmpty());
   --        AbstractMetaType *innerType = instantiations.at(0);
   --        return innerType;
   --    }
   --
   --    QString getSmartPointerInnerTypeName() const
   --    {
   --        Q_ASSERT(isSmartPointer());
   --        AbstractMetaType *innerType = getSmartPointerInnerType();
   --        Q_ASSERT(innerType);
   --        return innerType->name();
   --    }
   --
   --    /// Decides and sets the proper usage patter for the current meta
   --    //  type.
   --    void decideUsagePattern();
   --
   --    bool hasTemplateChildren() const;

   function Full_Name
    (Self : Abstract_Meta_Type'Class) return Q_Strings.Q_String;
   --  QString fullName() const

   function Is_Value (Self : Abstract_Meta_Type'Class) return Boolean;
   --  bool isValue() const
   --  Returns true if the type is used as a value type (X or const X &)

   function Name (Self : Abstract_Meta_Type'Class) return Q_Strings.Q_String;
   --  QString name() const;

   function Reference_Type
    (Self : Abstract_Meta_Type'Class) return Reference_Types;
   --  ReferenceType referenceType() const

   function Is_Reference (Self : Abstract_Meta_Type'Class) return Boolean;
   function Is_L_Value_Reference
    (Self : Abstract_Meta_Type'Class) return Boolean;
   function Is_R_Value_Reference
    (Self : Abstract_Meta_Type'Class) return Boolean;

   function Type_Entry
    (Self : Abstract_Meta_Type'Class) return Type_Entries.Type_Entry;
   --  const TypeEntry *typeEntry() const

   package Internals is

      function Wrap
       (Object : AbstractMetaType_Access) return Abstract_Meta_Type;

   end Internals;

private

   type Abstract_Meta_Type is tagged record
      Object : AbstractMetaType_Access;
   end record;

end Abstract_Meta_Types;
