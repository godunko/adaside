
with Q_Strings;

package Abstract_Meta_Types is

   type AbstractMetaType is null record with Convention => C;
   type AbstractMetaType_Access is access all AbstractMetaType;

   type Abstract_Meta_Type is tagged private;

   function Full_Name
    (Self : Abstract_Meta_Type'Class) return Q_Strings.Q_String;
   --    QString fullName() const

   function Name (Self : Abstract_Meta_Type'Class) return Q_Strings.Q_String;
   --    QString name() const;

   package Internals is

      function Wrap
       (Object : AbstractMetaType_Access) return Abstract_Meta_Type;

   end Internals;

private

   type Abstract_Meta_Type is tagged record
      Object : AbstractMetaType_Access;
   end record;

end Abstract_Meta_Types;
