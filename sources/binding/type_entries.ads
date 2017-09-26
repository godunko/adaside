with Q_Strings;

package Type_Entries is

   type TypeEntry is null record with Convention => C;
   type TypeEntry_Access is access all TypeEntry with Convention => C;

   type Type_Entry is tagged private;

   pragma Style_Checks (Off);

   --    Type type() const
   --    {
   --        return m_type;
   --    }
   --    bool isEnum() const
   --    {
   --        return m_type == EnumType;
   --    }
   --    bool isFlags() const
   --    {
   --        return m_type == FlagsType;
   --    }
   --    bool isInterface() const
   --    {
   --        return m_type == InterfaceType;
   --    }
   --    bool isObject() const
   --    {
   --        return m_type == ObjectType;
   --    }
   --    bool isString() const
   --    {
   --        return m_type == StringType;
   --    }
   --    bool isChar() const
   --    {
   --        return m_type == CharType;
   --    }
   --    bool isNamespace() const
   --    {
   --        return m_type == NamespaceType;
   --    }
   --    bool isContainer() const
   --    {
   --        return m_type == ContainerType;
   --    }
   --    bool isSmartPointer() const
   --    {
   --        return m_type == SmartPointerType;
   --    }
   --    bool isVariant() const
   --    {
   --        return m_type == VariantType;
   --    }
   --    bool isJObjectWrapper() const
   --    {
   --        return m_type == JObjectWrapperType;
   --    }
   --    bool isArray() const
   --    {
   --        return m_type == ArrayType;
   --    }
   --    bool isTemplateArgument() const
   --    {
   --        return m_type == TemplateArgumentType;
   --    }
   --    bool isVoid() const
   --    {
   --        return m_type == VoidType;
   --    }
   --    bool isVarargs() const
   --    {
   --        return m_type == VarargsType;
   --    }
   --    bool isThread() const
   --    {
   --        return m_type == ThreadType;
   --    }
   --    bool isCustom() const
   --    {
   --        return m_type == CustomType;
   --    }
   --    bool isBasicValue() const
   --    {
   --        return m_type == BasicValueType;
   --    }
   --    bool isTypeSystem() const
   --    {
   --        return m_type == TypeSystemType;
   --    }
   --    bool isFunction() const
   --    {
   --        return m_type == FunctionType;
   --    }
   --    bool isEnumValue() const
   --    {
   --        return m_type == EnumValue;
   --    }
   --
   --    virtual bool preferredConversion() const
   --    {
   --        return m_preferredConversion;
   --    }
   --    virtual void setPreferredConversion(bool b)
   --    {
   --        m_preferredConversion = b;
   --    }
   --
   --    bool stream() const
   --    {
   --        return m_stream;
   --    }
   --
   --    void setStream(bool b)
   --    {
   --        m_stream = b;
   --    }
   --
   --    uint codeGeneration() const
   --    {
   --        return m_codeGeneration;
   --    }
   --    void setCodeGeneration(uint cg)
   --    {
   --        m_codeGeneration = cg;
   --    }
   --
   --    // Returns true if code must be generated for this entry,
   --    // it will return false in case of types coming from typesystems
   --    // included for reference only.
   --    // NOTE: 'GenerateForSubclass' means 'generate="no"'
   --    //       on 'load-typesystem' tag
   --    inline bool generateCode() const
   --    {
   --        return m_codeGeneration != TypeEntry::GenerateForSubclass
   --               && m_codeGeneration != TypeEntry::GenerateNothing;
   --    }
   --
   --    virtual QString qualifiedCppName() const
   --    {
   --        return m_name;
   --    }
   --
   --    /**
   --     *   Its type's name in target language API
   --     *   The target language API name represents how this type is
   --     *   referred on low level code for the target language.
   --     *   Examples: for Java this would be a JNI name, for Python
   --     *   it should represent the CPython type name.
   --     *   /return string representing the target language API name
   --     *   for this type entry
   --     */
   --    virtual QString targetLangApiName() const
   --    {
   --        return m_name;
   --    }
   --
   --    // The type's name in TargetLang
   --    virtual QString targetLangName() const
   --    {
   --        return m_name;
   --    }
   --
   --    // The type to lookup when converting to TargetLang
   --    virtual QString lookupName() const
   --    {
   --        return targetLangName();
   --    }
   --
   --    // The package
   --    virtual QString targetLangPackage() const
   --    {
   --        return QString();
   --    }
   --
   --    virtual QString qualifiedTargetLangName() const
   --    {
   --        QString pkg = targetLangPackage();
   --        if (pkg.isEmpty())
   --            return targetLangName();
   --        return pkg + QLatin1Char('.') + targetLangName();
   --    }
   --
   --    virtual InterfaceTypeEntry *designatedInterface() const
   --    {
   --        return 0;
   --    }
   --
   --    void setCustomConstructor(const CustomFunction &func)
   --    {
   --        m_customConstructor = func;
   --    }
   --    CustomFunction customConstructor() const
   --    {
   --        return m_customConstructor;
   --    }
   --
   --    void setCustomDestructor(const CustomFunction &func)
   --    {
   --        m_customDestructor = func;
   --    }
   --    CustomFunction customDestructor() const
   --    {
   --        return m_customDestructor;
   --    }
   --
   --    virtual bool isComplex() const
   --    {
   --        return false;
   --    }
   --
   --    virtual bool isNativeIdBased() const
   --    {
   --        return false;
   --    }
   --
   --    CodeSnipList codeSnips() const;
   --    void setCodeSnips(const CodeSnipList &codeSnips)
   --    {
   --        m_codeSnips = codeSnips;
   --    }
   --    void addCodeSnip(const CodeSnip &codeSnip)
   --    {
   --        m_codeSnips << codeSnip;
   --    }
   --
   --    void setDocModification(const DocModificationList& docMods)
   --    {
   --        m_docModifications << docMods;
   --    }
   --    DocModificationList docModifications() const
   --    {
   --        return m_docModifications;
   --    }
   --
   --    IncludeList extraIncludes() const
   --    {
   --        return m_extraIncludes;
   --    }
   --    void setExtraIncludes(const IncludeList &includes)
   --    {
   --        m_extraIncludes = includes;
   --    }
   --    void addExtraInclude(const Include &include)
   --    {
   --        if (!m_includesUsed.value(include.name(), false)) {
   --            m_extraIncludes << include;
   --            m_includesUsed[include.name()] = true;
   --        }
   --    }
   --
   --    Include include() const
   --    {
   --        return m_include;
   --    }
   --    void setInclude(const Include &inc)
   --    {
   --        // This is a workaround for preventing double inclusion of the QSharedPointer implementation
   --        // header, which does not use header guards. In the previous parser this was not a problem
   --        // because the Q_QDOC define was set, and the implementation header was never included.
   --        if (inc.name() == QLatin1String("qsharedpointer_impl.h"))
   --            m_include = Include(inc.type(), QLatin1String("qsharedpointer.h"));
   --        else
   --            m_include = inc;
   --    }
   --
   --    // Replace conversionRule arg to CodeSnip in future version
   --    /// Set the type convertion rule
   --    void setConversionRule(const QString& conversionRule)
   --    {
   --        m_conversionRule = conversionRule;
   --    }
   --
   --    /// Returns the type convertion rule
   --    QString conversionRule() const
   --    {
   --        //skip conversions flag
   --        return m_conversionRule.mid(1);
   --    }
   --
   --    /// Returns true if there are any conversiton rule for this type, false otherwise.
   --    bool hasConversionRule() const
   --    {
   --        return !m_conversionRule.isEmpty();
   --    }
   --
   --    double version() const
   --    {
   --        return m_version;
   --    }
   --
   --    /// TODO-CONVERTER: mark as deprecated
   --    bool hasNativeConversionRule() const
   --    {
   --        return m_conversionRule.startsWith(QLatin1String(NATIVE_CONVERSION_RULE_FLAG));
   --    }
   --
   --    /// TODO-CONVERTER: mark as deprecated
   --    bool hasTargetConversionRule() const
   --    {
   --        return m_conversionRule.startsWith(QLatin1String(TARGET_CONVERSION_RULE_FLAG));
   --    }
   --
   --    bool isCppPrimitive() const;
   --
   --    bool hasCustomConversion() const;
   --    void setCustomConversion(CustomConversion* customConversion);
   --    CustomConversion* customConversion() const;
   pragma Style_Checks (On);

   function Is_Primitive (Self : Type_Entry'Class) return Boolean;
   --  bool isPrimitive() const

   function Is_Value (Self : Type_Entry'Class) return Boolean;
   --  virtual bool isValue() const

   function Name (Self : Type_Entry'Class) return Q_Strings.Q_String;
   --  The type's name in C++, fully qualified
   --  QString name() const

   package Internals is

      procedure Initialize
       (Self : in out Type_Entry'Class;
        View : TypeEntry_Access);

      function Internal (Self : Type_Entry'Class) return TypeEntry_Access;

      function Wrap (View : TypeEntry_Access) return Type_Entry;

   end Internals;

private

   type Type_Entry is tagged record
      TypeEntry_View : TypeEntry_Access;
   end record;

end Type_Entries;
