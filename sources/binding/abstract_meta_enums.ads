
with Abstract_Meta_Attributes;
with Q_Strings;

package Abstract_Meta_Enums is

   type AbstractMetaEnum is null record with Convention => C;
   type AbstractMetaEnum_Access is access all AbstractMetaEnum;

   type Abstract_Meta_Enum is
     new Abstract_Meta_Attributes.Abstract_Meta_Attributes with private;


   function Full_Name
    (Self : Abstract_Meta_Enum'Class) return Q_Strings.Q_String;
   --    QString fullName() const

   function Name (Self : Abstract_Meta_Enum'Class) return Q_Strings.Q_String;
   --    QString name() const;

   package Internals is

      function Wrap
       (Object : AbstractMetaEnum_Access) return Abstract_Meta_Enum;

   end Internals;

private

   type Abstract_Meta_Enum is
     new Abstract_Meta_Attributes.Abstract_Meta_Attributes with
   record
      Object : AbstractMetaEnum_Access;
   end record;

   overriding function Internal
    (Self : Abstract_Meta_Enum)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access;

end Abstract_Meta_Enums;
