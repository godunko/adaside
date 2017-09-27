with Interfaces.C.Extensions;

package body Abstract_Meta_Types is

   use type Interfaces.C.Extensions.bool;

   procedure AbstractMetaType_fullName
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaType_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaType_fullName";

   function AbstractMetaType_isConstant
    (Self : not null AbstractMetaType_Access)
       return Interfaces.C.Extensions.bool
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaType_isConstant";

   function AbstractMetaType_isValue
    (Self : not null AbstractMetaType_Access)
       return Interfaces.C.Extensions.bool
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaType_isValue";

   procedure AbstractMetaType_name
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaType_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaType_name";

   function AbstractMetaType_referenceType
    (Self : not null AbstractMetaType_Access) return Reference_Types
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaType_referenceType";

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

   -----------------
   -- Is_Constant --
   -----------------

   function Is_Constant (Self : Abstract_Meta_Type'Class) return Boolean is
   begin
      return AbstractMetaType_isConstant (Self.Object) /= 0;
   end Is_Constant;

   --------------------------
   -- Is_L_Value_Reference --
   --------------------------

   function Is_L_Value_Reference
    (Self : Abstract_Meta_Type'Class) return Boolean is
   begin
      return Self.Reference_Type = L_Value_Reference;
   end Is_L_Value_Reference;

   -------------
   -- Is_Null --
   -------------

   function Is_Null (Self : Abstract_Meta_Type'Class) return Boolean is
   begin
      return Self.Object = null;
   end Is_Null;

   --------------------------
   -- Is_R_Value_Reference --
   --------------------------

   function Is_R_Value_Reference
    (Self : Abstract_Meta_Type'Class) return Boolean is
   begin
      return Self.Reference_Type = R_Value_Reference;
   end Is_R_Value_Reference;

   ------------------
   -- Is_Reference --
   ------------------

   function Is_Reference (Self : Abstract_Meta_Type'Class) return Boolean is
   begin
      return Self.Reference_Type /= No_Reference;
   end Is_Reference;

   --------------
   -- Is_Value --
   --------------

   function Is_Value (Self : Abstract_Meta_Type'Class) return Boolean is
   begin
      return AbstractMetaType_isValue (Self.Object) /= 0;
   end Is_Value;

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

   --------------------
   -- Reference_Type --
   --------------------

   function Reference_Type
    (Self : Abstract_Meta_Type'Class) return Reference_Types is
   begin
      return AbstractMetaType_referenceType (Self.Object);
   end Reference_Type;

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
