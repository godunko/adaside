with Abstract_Meta_Class_Lists;

package body Abstract_Meta_Classes is

   function cast_AbstractMetaClass_AbstractMetaAttributes
    (This : AbstractMetaClass_Access)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access
         with Import     => True,
              Convention => C,
              Link_Name  =>
               "dynamic_cast__AbstractMetaClass__AbstractMetaAttributes";

   function AbstractMetaClass_findClass
    (Classes    : not null
       Abstract_Meta_Class_Lists.Internals.AbstractMetaClassList_Access;
     Type_Entry : not null Type_Entries.TypeEntry_Access)
       return AbstractMetaClass_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaClass_findClass";

   procedure AbstractMetaClass_fullName
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaClass_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaClass_fullName";

   procedure AbstractMetaClass_functions
    (Result : not null
       Abstract_Meta_Function_Lists.Internals.AbstractMetaFunctionList_Access;
     Self   : not null AbstractMetaClass_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaClass_functions";

   procedure AbstractMetaClass_name
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaClass_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaClass_name";

   function AbstractMetaClass_typeEntry
    (Self : not null AbstractMetaClass_Access)
       return Complex_Type_Entries.ComplexTypeEntry_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaClass_typeEntry";

   ----------------
   -- Find_Class --
   ----------------

   function Find_Class
    (Classes    : Abstract_Meta_Class_Lists.Abstract_Meta_Class_List'Class;
     Type_Entry : Type_Entries.Type_Entry'Class)
       return Abstract_Meta_Class is
   begin
      return
       (Object =>
          AbstractMetaClass_findClass
           (Abstract_Meta_Class_Lists.Internals.Internal (Classes),
            Type_Entries.Internals.Internal (Type_Entry)));
   end Find_Class;

   ---------------
   -- Full_Name --
   ---------------

   function Full_Name
    (Self : Abstract_Meta_Class'Class) return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         AbstractMetaClass_fullName
          (Q_Strings.Internals.Internal (Result), Self.Object);
      end return;
   end Full_Name;

   ---------------
   -- Functions --
   ---------------

   function Functions
    (Self : Abstract_Meta_Class'Class)
       return Abstract_Meta_Function_Lists.Abstract_Meta_Function_List is
   begin
      return Result :
               Abstract_Meta_Function_Lists.Abstract_Meta_Function_List
      do
         AbstractMetaClass_functions
          (Abstract_Meta_Function_Lists.Internals.Internal (Result),
           Self.Object);
      end return;
   end Functions;

   --------------
   -- Internal --
   --------------

   overriding function Internal
    (Self : Abstract_Meta_Class)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access is
   begin
      return cast_AbstractMetaClass_AbstractMetaAttributes (Self.Object);
   end Internal;

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      ----------
      -- Wrap --
      ----------

      function Wrap
       (Object : AbstractMetaClass_Access) return Abstract_Meta_Class is
      begin
         return (Object => Object);
      end Wrap;

   end Internals;

   -------------
   -- Is_Null --
   -------------

   function Is_Null (Self : Abstract_Meta_Class'Class) return Boolean is
   begin
      return Self.Object = null;
   end Is_Null;

   ----------
   -- Name --
   ----------

   function Name (Self : Abstract_Meta_Class'Class)
     return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         AbstractMetaClass_name
          (Q_Strings.Internals.Internal (Result), Self.Object);
      end return;
   end Name;

   ----------------
   -- Type_Entry --
   ----------------

   function Type_Entry
    (Self : Abstract_Meta_Class'Class)
       return Complex_Type_Entries.Complex_Type_Entry is
   begin
      return
        Complex_Type_Entries.Internals.Wrap
         (AbstractMetaClass_typeEntry (Self.Object));
   end Type_Entry;

end Abstract_Meta_Classes;
