
package Ada_Side.Generators.Value_Ada_Spec is

   type Value_Ada_Spec_Generator is new Abstract_Generator with private;

private

   type Value_Ada_Spec_Generator is new Abstract_Generator with record
      null;
   end record;

   overriding function Should_Generate
    (Self  : in out Value_Ada_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean;

end Ada_Side.Generators.Value_Ada_Spec;