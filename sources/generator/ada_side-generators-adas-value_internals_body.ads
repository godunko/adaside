
package Ada_Side.Generators.Adas.Value_Internals_Body is

   type Value_Ada_Internals_Body_Generator is
     new Abstract_Generator with private;

private

   type Value_Ada_Internals_Body_Generator is
     new Abstract_Generator with
   record
      null;
   end record;

   overriding function Should_Generate
    (Self  : in out Value_Ada_Internals_Body_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean;

   overriding procedure Generate
    (Self  : in out Value_Ada_Internals_Body_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class);

end Ada_Side.Generators.Adas.Value_Internals_Body;
