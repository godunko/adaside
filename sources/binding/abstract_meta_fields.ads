
with Abstract_Meta_Attributes;
with Abstract_Meta_Variables;
with Q_Strings;

package Abstract_Meta_Fields is

   type AbstractMetaField is null record with Convention => C;
   type AbstractMetaField_Access is access all AbstractMetaField;

   type Abstract_Meta_Field is
     new Abstract_Meta_Attributes.Abstract_Meta_Attributes
       and Abstract_Meta_Variables.Abstract_Meta_Variable with private;

   overriding function Name (Self : Abstract_Meta_Field)
     return Q_Strings.Q_String;
   --    QString name() const;

   package Internals is

      function Wrap
       (Object : AbstractMetaField_Access) return Abstract_Meta_Field;

   end Internals;

private

   type Abstract_Meta_Field is
     new Abstract_Meta_Attributes.Abstract_Meta_Attributes
       and Abstract_Meta_Variables.Abstract_Meta_Variable with
   record
      Object : AbstractMetaField_Access;
   end record;

   overriding function Internal
    (Self : Abstract_Meta_Field)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access;

   overriding function Internal
    (Self : Abstract_Meta_Field)
       return Abstract_Meta_Variables.AbstractMetaVariable_Access;

end Abstract_Meta_Fields;
