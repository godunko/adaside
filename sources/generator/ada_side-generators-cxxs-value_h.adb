with Ada_Side.Units;

package body Ada_Side.Generators.CXXs.Value_H is

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_H_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      use type League.Strings.Universal_String;

      Unit : Ada_Side.Units.CXX_H_Unit;

   begin
      Unit.Set_Class_Name (Class.Name.To_Universal_String);

      Unit.Put_Line ("#include <" & Class.Name.To_Universal_String & ">");

      Unit.New_Line;
      Unit.Put_Line
       ("extern ""C"" const size_t " & API_Size_Of_Link_Name (Class) & ";");

      Unit.New_Line;
      Unit.Put_Line
       ("extern ""C"" void "
          & API_Subprogram_Link_Name (Class, Adjust)
          & "(" & Class.Name.To_Universal_String
          & "** ___view, void* ___storage);");
      Unit.Put_Line
       ("extern ""C"" void "
          & API_Subprogram_Link_Name (Class, Finalize)
          & "(" & Class.Name.To_Universal_String & "** ___view);");
      Unit.Put_Line
       ("extern ""C"" void "
          & API_Subprogram_Link_Name (Class, Initialize)
          & "(" & Class.Name.To_Universal_String
          & "** ___view, void* ___storage);");

      Unit.Save (Self.Output_Directory);
   end Generate;

   ---------------------
   -- Should_Generate --
   ---------------------

   overriding function Should_Generate
    (Self  : in out Value_H_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean
   is
      pragma Unreferenced (Self);

   begin
      return Class.Type_Entry.Is_Value;
   end Should_Generate;

end Ada_Side.Generators.CXXs.Value_H;
