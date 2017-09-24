
package Ada_Side.Generators.CXXs.Value_Cpp is

   type Value_Cpp_Generator is new Abstract_Generator with private;

private

   type Value_Cpp_Generator is new Abstract_Generator with record
      null;
   end record;

   overriding function Should_Generate
    (Self  : in out Value_Cpp_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean;

   overriding procedure Generate
    (Self  : in out Value_Cpp_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class);

end Ada_Side.Generators.CXXs.Value_Cpp;
