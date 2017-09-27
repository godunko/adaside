

package body Abstract_Meta_Fields is

   function cast_AbstractMetaField_AbstractMetaAttributes
    (This : AbstractMetaField_Access)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access
         with Import     => True,
              Convention => C,
              Link_Name  =>
               "dynamic_cast__AbstractMetaField__AbstractMetaAttributes";

   function cast_AbstractMetaField_AbstractMetaVariable
    (This : AbstractMetaField_Access)
       return Abstract_Meta_Variables.AbstractMetaVariable_Access
         with Import     => True,
              Convention => C,
              Link_Name  =>
               "dynamic_cast__AbstractMetaField__AbstractMetaVariable";

   -------------------------------
   -- AbstractMetaVariable_View --
   -------------------------------

   overriding function AbstractMetaVariable_View
    (Self : Abstract_Meta_Field)
       return not null Abstract_Meta_Variables.AbstractMetaVariable_Access is
   begin
      return cast_AbstractMetaField_AbstractMetaVariable (Self.Object);
   end AbstractMetaVariable_View;

   --------------
   -- Internal --
   --------------

   overriding function Internal
    (Self : Abstract_Meta_Field)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access is
   begin
      return cast_AbstractMetaField_AbstractMetaAttributes (Self.Object);
   end Internal;

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      ----------
      -- Wrap --
      ----------

      function Wrap
       (Object : AbstractMetaField_Access) return Abstract_Meta_Field is
      begin
         return (Object => Object);
      end Wrap;

   end Internals;

end Abstract_Meta_Fields;
