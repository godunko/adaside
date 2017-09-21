with League.Strings;

with Ada_Side.Units;

package body Ada_Side.Generators.Value_API_Ada_Spec is

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_API_Ada_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      pragma Unreferenced (Self, Class);

      Unit : Ada_Side.Units.Ada_Spec_Unit;

   begin
      Unit.Put_Line (+"package XXX is");
      Unit.Put_Line (+"end XXX;");
   end Generate;

   ---------------------
   -- Should_Generate --
   ---------------------

   overriding function Should_Generate
    (Self  : in out Value_API_Ada_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean
   is
      pragma Unreferenced (Self);

   begin
      return Class.Type_Entry.Is_Value;
   end Should_Generate;

end Ada_Side.Generators.Value_API_Ada_Spec;
