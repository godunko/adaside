with Abstract_Meta_Variables;

package Abstract_Meta_Arguments is

   type AbstractMetaArgument is null record with Convention => C;
   type AbstractMetaArgument_Access is access all AbstractMetaArgument;

   type Abstract_Meta_Argument is
     new Abstract_Meta_Variables.Abstract_Meta_Variable with private;

   package Internals is

      function Wrap
       (Object : AbstractMetaArgument_Access) return Abstract_Meta_Argument;

   end Internals;

private

   type Abstract_Meta_Argument is
     new Abstract_Meta_Variables.Abstract_Meta_Variable with
   record
      Object : AbstractMetaArgument_Access;
   end record;

   overriding function AbstractMetaVariable_View
    (Self : Abstract_Meta_Argument)
       return not null Abstract_Meta_Variables.AbstractMetaVariable_Access;

end Abstract_Meta_Arguments;
