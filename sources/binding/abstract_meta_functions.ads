
with Abstract_Meta_Attributes;
with Q_Strings;

package Abstract_Meta_Functions is

   type AbstractMetaFunction is null record with Convention => C;
   type AbstractMetaFunction_Access is access all AbstractMetaFunction;

   type Abstract_Meta_Function is
     new Abstract_Meta_Attributes.Abstract_Meta_Attributes with private;


   function Name (Self : Abstract_Meta_Function'Class)
     return Q_Strings.Q_String;
   --    QString name() const;

   package Internals is

      function Wrap
       (Object : AbstractMetaFunction_Access) return Abstract_Meta_Function;

   end Internals;

private

   type Abstract_Meta_Function is
     new Abstract_Meta_Attributes.Abstract_Meta_Attributes with
   record
      Object : AbstractMetaFunction_Access;
   end record;

   overriding function Internal
    (Self : Abstract_Meta_Function)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access;

end Abstract_Meta_Functions;
