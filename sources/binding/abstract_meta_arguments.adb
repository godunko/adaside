

package body Abstract_Meta_Arguments is

   function cast_AbstractMetaArgument_AbstractMetaVariable
    (This : AbstractMetaArgument_Access)
       return Abstract_Meta_Variables.AbstractMetaVariable_Access
         with Import     => True,
              Convention => C,
              Link_Name  =>
               "dynamic_cast__AbstractMetaArgument__AbstractMetaVariable";

   procedure AbstractMetaArgument_name
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaArgument_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaArgument_name";

   --------------
   -- Internal --
   --------------

   overriding function Internal
    (Self : Abstract_Meta_Argument)
       return Abstract_Meta_Variables.AbstractMetaVariable_Access is
   begin
      return cast_AbstractMetaArgument_AbstractMetaVariable (Self.Object);
   end Internal;

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      ----------
      -- Wrap --
      ----------

      function Wrap
       (Object : AbstractMetaArgument_Access) return Abstract_Meta_Argument is
      begin
         return (Object => Object);
      end Wrap;

   end Internals;

   ----------
   -- Name --
   ----------

   overriding function Name (Self : Abstract_Meta_Argument)
     return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         AbstractMetaArgument_name
          (Q_Strings.Internals.Internal (Result), Self.Object);
      end return;
   end Name;

end Abstract_Meta_Arguments;
