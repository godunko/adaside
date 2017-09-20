with Ada_Side.Generators.Value_Ada_Body;
with Ada_Side.Generators.Value_Ada_Spec;

package body Ada_Side.Setup is

   Configured_Generators : constant Generator_Array
     := (new Ada_Side.Generators.Value_Ada_Spec.Value_Ada_Spec_Generator,
         new Ada_Side.Generators.Value_Ada_Body.Value_Ada_Body_Generator);

   ----------------
   -- Generators --
   ----------------

   function Generators return Generator_Array is
   begin
      return Configured_Generators;
   end Generators;

end Ada_Side.Setup;
