with Q_Strings;

package Abstract_Meta_Variables is

   type AbstractMetaVariable is null record with Convention => C;
   type AbstractMetaVariable_Access is access all AbstractMetaVariable;

   type Abstract_Meta_Variable is interface;

   pragma Style_Checks (Off);
   --    AbstractMetaType *type() const
   --    {
   --        return m_type;
   --    }
   --    void setType(AbstractMetaType *type)
   --    {
   --        Q_ASSERT(m_type == 0);
   --        m_type = type;
   --    }
   --    void replaceType(AbstractMetaType *type)
   --    {
   --        if (m_type)
   --            delete m_type;
   --        m_type = type;
   --    }
   --
   --    void setName(const QString &name, bool realName = true)
   --    {
   --        m_name = name;
   --        m_hasName = realName;
   --    }
   --    bool hasName() const
   --    {
   --        return m_hasName;
   --    }
   --    QString originalName() const
   --    {
   --        return m_originalName;
   --    }
   --    void setOriginalName(const QString& name)
   --    {
   --        m_originalName = name;
   --    }
   --    void setDocumentation(const Documentation& doc)
   --    {
   --        m_doc = doc;
   --    }
   --    Documentation documentation() const
   --    {
   --        return m_doc;
   --    }
   pragma Style_Checks (On);

   function Name
    (Self : Abstract_Meta_Variable'Class) return Q_Strings.Q_String;
   --  QString name() const

   not overriding function AbstractMetaVariable_View
    (Self : Abstract_Meta_Variable)
       return not null AbstractMetaVariable_Access is abstract;

end Abstract_Meta_Variables;
