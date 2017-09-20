

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

   procedure AbstractMetaField_name
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaField_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaField_name";

   --------------
   -- Internal --
   --------------

   overriding function Internal
    (Self : Abstract_Meta_Field)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access is
   begin
      return cast_AbstractMetaField_AbstractMetaAttributes (Self.Object);
   end Internal;

   --------------
   -- Internal --
   --------------

   overriding function Internal
    (Self : Abstract_Meta_Field)
       return Abstract_Meta_Variables.AbstractMetaVariable_Access is
   begin
      return cast_AbstractMetaField_AbstractMetaVariable (Self.Object);
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

   ----------
   -- Name --
   ----------

   overriding function Name (Self : Abstract_Meta_Field)
     return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         AbstractMetaField_name
          (Q_Strings.Internals.Internal (Result), Self.Object);
      end return;
   end Name;

end Abstract_Meta_Fields;
