
package Abstract_Meta_Attributes is

   type AbstractMetaAttributes is null record with Convention => C;
   type AbstractMetaAttributes_Access is access all AbstractMetaAttributes;

   type Abstract_Meta_Attributes is limited interface;

   pragma Style_Checks (Off);
   --    Attributes attributes() const
   --    {
   --        return m_attributes;
   --    }
   --
   --    void setAttributes(Attributes attributes)
   --    {
   --        m_attributes = attributes;
   --    }
   --
   --    Attributes originalAttributes() const
   --    {
   --        return m_originalAttributes;
   --    }
   --
   --    void setOriginalAttributes(Attributes attributes)
   --    {
   --        m_originalAttributes = attributes;
   --    }
   --
   --    Attributes visibility() const
   --    {
   --        return m_attributes & Visibility;
   --    }
   --
   --    void setVisibility(Attributes visi)
   --    {
   --        m_attributes = (m_attributes & ~Visibility) | visi;
   --    }
   --
   --    void operator+=(Attribute attribute)
   --    {
   --        m_attributes |= attribute;
   --    }
   --
   --    void operator-=(Attribute attribute)
   --    {
   --        m_attributes &= ~attribute;
   --    }
   --
   --    bool isNative() const
   --    {
   --        return m_attributes & Native;
   --    }
   --
   --    bool isFinal() const
   --    {
   --        return (m_attributes & Final) == Final;
   --    }
   --
   --    bool isFinalInTargetLang() const
   --    {
   --        return m_attributes & FinalInTargetLang;
   --    }
   --
   --    bool isFinalInCpp() const
   --    {
   --        return m_attributes & FinalInCpp;
   --    }
   --
   --    bool isAbstract() const
   --    {
   --        return m_attributes & Abstract;
   --    }
   --
   --    bool isForcedShellImplementation() const
   --    {
   --        return m_attributes & ForceShellImplementation;
   --    }
   --
   --    bool isInterfaceFunction() const
   --    {
   --        return m_attributes & InterfaceFunction;
   --    }
   --
   --    bool isFinalOverload() const
   --    {
   --        return m_attributes & FinalOverload;
   --    }
   --
   --    bool isInvokable() const
   --    {
   --        return m_attributes & Invokable;
   --    }
   --
   --    bool isPropertyReader() const
   --    {
   --        return m_attributes & PropertyReader;
   --    }
   --
   --    bool isPropertyWriter() const
   --    {
   --        return m_attributes & PropertyWriter;
   --    }
   --
   --    bool isPropertyResetter() const
   --    {
   --        return m_attributes & PropertyResetter;
   --    }
   --
   --    bool isPrivate() const
   --    {
   --        return m_attributes & Private;
   --    }
   --
   --    bool isProtected() const
   --    {
   --        return m_attributes & Protected;
   --    }
   --
   --    bool isPublic() const
   --    {
   --        return m_attributes & Public;
   --    }
   --
   --    bool wasPrivate() const
   --    {
   --        return m_originalAttributes & Private;
   --    }
   --
   --    bool wasProtected() const
   --    {
   --        return m_originalAttributes & Protected;
   --    }
   --
   --    bool wasPublic() const
   --    {
   --        return m_originalAttributes & Public;
   --    }
   --
   --    bool wasFriendly() const
   --    {
   --        return m_originalAttributes & Friendly;
   --    }
   --
   --    void setDocumentation(const Documentation& doc)
   --    {
   --        m_doc = doc;
   --    }
   --
   --    Documentation documentation() const
   --    {
   --        return m_doc;
   --    }
   pragma Style_Checks (On);

   function Is_Friendly (Self : Abstract_Meta_Attributes'Class) return Boolean;
   --  bool isFriendly() const

   function Is_Static (Self : Abstract_Meta_Attributes'Class) return Boolean;
   --  bool isStatic() const

   not overriding function Internal
    (Self : Abstract_Meta_Attributes)
       return AbstractMetaAttributes_Access is abstract;

end Abstract_Meta_Attributes;
