private with Ada.Finalization;

with Q_Strings;

package API_Extractors is

   --    QString typeSystem() const { return m_typeSystemFileName; }
   --    QString cppFileName() const { return m_cppFileName; }
   --    void setDebugLevel(ReportHandler::DebugLevel debugLevel);
   --    void setSuppressWarnings(bool value);
   --    void setSilent(bool value);
   --    void addTypesystemSearchPath(const QString& path);
   --    void addTypesystemSearchPath(const QStringList& paths);
   --    void addIncludePath(const HeaderPath& path);
   --    void addIncludePath(const HeaderPaths& paths);
   --    HeaderPaths includePaths() const { return m_includePaths; }
   --    void setLogDirectory(const QString& logDir);
   --    bool setApiVersion(const QString& package, const QString& version);
   --    void setDropTypeEntries(QString dropEntries);
   --
   --    AbstractMetaEnumList globalEnums() const;
   --    AbstractMetaFunctionList globalFunctions() const;
   --    AbstractMetaClassList classes() const;
   --    AbstractMetaClassList smartPointers() const;
   --    AbstractMetaClassList classesTopologicalSorted(const Dependencies &additionalDependencies = Dependencies()) const;
   --    PrimitiveTypeEntryList primitiveTypes() const;
   --    ContainerTypeEntryList containerTypes() const;
   --    QSet<QString> qtMetaTypeDeclaredTypeNames() const;
   --
   --    const AbstractMetaEnum* findAbstractMetaEnum(const EnumTypeEntry* typeEntry) const;
   --    const AbstractMetaEnum* findAbstractMetaEnum(const TypeEntry* typeEntry) const;
   --    const AbstractMetaEnum* findAbstractMetaEnum(const FlagsTypeEntry* typeEntry) const;
   --    const AbstractMetaEnum* findAbstractMetaEnum(const AbstractMetaType* metaType) const;
   --
   --    int classCount() const;


   type API_Extractor is tagged limited private;

   function Run (Self : in out API_Extractor'Class) return Boolean;
   --    bool run();

   procedure Set_Cpp_File_Name
    (Self      : in out API_Extractor'Class;
     File_Name : Q_Strings.Q_String'Class);
   --    void setCppFileName(const QString& cppFileName);

   procedure Set_Type_System
    (Self      : in out API_Extractor'Class;
     File_Name : Q_Strings.Q_String'Class);
   --    void setTypeSystem(const QString& typeSystemFileName);

private

   type ApiExtractor is null record with Convention => C;
   type ApiExtractor_Access is access all ApiExtractor with Convention => C;

   function ApiExtractor_new return ApiExtractor_Access
      with Import     => True,
           Convention => C,
           Link_Name  => "ApiExtractor__new";

   type API_Extractor is new Ada.Finalization.Limited_Controlled with record
      Object : ApiExtractor_Access := ApiExtractor_new;
   end record;

   overriding procedure Finalize (Self : in out API_Extractor);

end API_Extractors;
