with Ada_Side.Units;

package body Ada_Side.Generators.CXXs.Value_Cpp is

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_Cpp_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      use type League.Strings.Universal_String;

      Unit : Ada_Side.Units.CXX_Cpp_Unit;

   begin
      Unit.Set_Class_Name (Class.Name.To_Universal_String);

      Unit.Put_Line
       ("#include """
          & Class.Name.To_Universal_String.To_Lowercase & "_wrapper.h""");

      Unit.New_Line;
      Unit.Put_Line
       ("const size_t "
          & API_Size_Of_Link_Name (Class)
          & " = sizeof(" & Class.Name.To_Universal_String & ");");

      Unit.New_Line;
      Unit.Put_Line
       ("void "
          & API_Subprogram_Link_Name (Class, Adjust)
          & "(" & Class.Name.To_Universal_String
          & "** ___view, void* ___storage)");
      Unit.Put_Line (+"{");
      Unit.Put_Line
       (+"    *___view = new (___storage) "
           & Class.Name.To_Universal_String & "(**___view);");
      Unit.Put_Line (+"}");

      Unit.New_Line;
      Unit.Put_Line
       ("void "
          & API_Subprogram_Link_Name (Class, Finalize)
          & "(" & Class.Name.To_Universal_String & "** ___view)");
      Unit.Put_Line (+"{");
      Unit.Put_Line
       ("    (*___view)->~" & Class.Name.To_Universal_String & "();");
      Unit.Put_Line (+"    *___view = 0;");
      Unit.Put_Line (+"}");

      Unit.New_Line;
      Unit.Put_Line
       ("void "
          & API_Subprogram_Link_Name (Class, Initialize)
          & "(" & Class.Name.To_Universal_String
          & "** ___view, void* ___storage)");
      Unit.Put_Line (+"{");
      Unit.Put_Line
       (+"    *___view = new (___storage) "
           & Class.Name.To_Universal_String & "();");
      Unit.Put_Line (+"}");

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
