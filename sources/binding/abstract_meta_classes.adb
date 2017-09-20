

package body Abstract_Meta_Classes is

   function cast_AbstractMetaClass_AbstractMetaAttributes
    (This : AbstractMetaClass_Access)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "dynamic_cast__AbstractMetaClass__AbstractMetaAttributes";

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

end Abstract_Meta_Classes;
