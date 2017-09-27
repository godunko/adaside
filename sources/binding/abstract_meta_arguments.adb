

package body Abstract_Meta_Arguments is

   function cast_AbstractMetaArgument_AbstractMetaVariable
    (This : AbstractMetaArgument_Access)
       return Abstract_Meta_Variables.AbstractMetaVariable_Access
         with Import     => True,
              Convention => C,
              Link_Name  =>
               "dynamic_cast__AbstractMetaArgument__AbstractMetaVariable";

   -------------------------------
   -- AbstractMetaVariable_View --
   -------------------------------

   overriding function AbstractMetaVariable_View
    (Self : Abstract_Meta_Argument)
       return not null Abstract_Meta_Variables.AbstractMetaVariable_Access is
   begin
      return cast_AbstractMetaArgument_AbstractMetaVariable (Self.Object);
   end AbstractMetaVariable_View;

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

end Abstract_Meta_Arguments;
