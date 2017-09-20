
package body Ada_Side.Generators.Value_Ada_Body is

   ---------------------
   -- Should_Generate --
   ---------------------

   overriding function Should_Generate
    (Self  : in out Value_Ada_Body_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean
   is
      pragma Unreferenced (Self, Class);

   begin
      return True;
   end Should_Generate;

end Ada_Side.Generators.Value_Ada_Body;
