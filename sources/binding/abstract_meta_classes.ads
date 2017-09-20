
with Abstract_Meta_Attributes;

package Abstract_Meta_Classes is

   type AbstractMetaClass is null record with Convention => C;
   type AbstractMetaClass_Access is access all AbstractMetaClass;

   type Abstract_Meta_Class is
     new Abstract_Meta_Attributes.Abstract_Meta_Attributes with private;

   package Internals is

      function Wrap
       (Object : AbstractMetaClass_Access) return Abstract_Meta_Class;

   end Internals;

private

   type Abstract_Meta_Class is
     new Abstract_Meta_Attributes.Abstract_Meta_Attributes with
   record
      Object : AbstractMetaClass_Access;
   end record;

   overriding function Internal
    (Self : Abstract_Meta_Class)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access;

end Abstract_Meta_Classes;
