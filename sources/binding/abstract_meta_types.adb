

package body Abstract_Meta_Types is

   procedure AbstractMetaType_fullName
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaType_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaType_fullName";

   procedure AbstractMetaType_name
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaType_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaType_name";

   function AbstractMetaType_typeEntry
    (Self : not null AbstractMetaType_Access)
       return Type_Entries.TypeEntry_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaType_typeEntry";

   ---------------
   -- Full_Name --
   ---------------

   function Full_Name
    (Self : Abstract_Meta_Type'Class) return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         AbstractMetaType_fullName
          (Q_Strings.Internals.Internal (Result), Self.Object);
      end return;
   end Full_Name;

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      ----------
      -- Wrap --
      ----------

      function Wrap
       (Object : AbstractMetaType_Access) return Abstract_Meta_Type is
      begin
         return (Object => Object);
      end Wrap;

   end Internals;

   ----------
   -- Name --
   ----------

   function Name (Self : Abstract_Meta_Type'Class)
     return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         AbstractMetaType_name
          (Q_Strings.Internals.Internal (Result), Self.Object);
      end return;
   end Name;

   ----------------
   -- Type_Entry --
   ----------------

   function Type_Entry
    (Self : Abstract_Meta_Type'Class) return Type_Entries.Type_Entry is
   begin
      return
        Type_Entries.Internals.Wrap (AbstractMetaType_typeEntry (Self.Object));
   end Type_Entry;

end Abstract_Meta_Types;
