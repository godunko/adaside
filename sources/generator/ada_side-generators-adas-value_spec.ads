
package Ada_Side.Generators.Adas.Value_Spec is

   type Value_Ada_Spec_Generator is new Abstract_Generator with private;

   function User_Package_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

private

   type Value_Ada_Spec_Generator is new Abstract_Generator with record
      null;
   end record;

   overriding function Should_Generate
    (Self  : in out Value_Ada_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean;

   overriding procedure Generate
    (Self  : in out Value_Ada_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class);

end Ada_Side.Generators.Adas.Value_Spec;
