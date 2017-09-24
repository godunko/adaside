with Ada_Side.Units;

package body Ada_Side.Generators.CXXs.Value_Cpp is

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_Cpp_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      Unit : Ada_Side.Units.CXX_Cpp_Unit;

   begin
      Unit.Set_Class_Name (Class.Name.To_Universal_String);

      Unit.Save (Self.Output_Directory);
   end Generate;

   ---------------------
   -- Should_Generate --
   ---------------------

   overriding function Should_Generate
    (Self  : in out Value_Cpp_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean
   is
      pragma Unreferenced (Self);

   begin
      return Class.Type_Entry.Is_Value;
   end Should_Generate;

end Ada_Side.Generators.CXXs.Value_Cpp;
