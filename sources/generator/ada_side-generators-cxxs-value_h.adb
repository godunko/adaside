with Ada.Wide_Wide_Text_IO;

with Abstract_Meta_Function_Lists;

with Ada_Side.Units;

package body Ada_Side.Generators.CXXs.Value_H is

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_H_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      use type League.Strings.Universal_String;

      Unit      : Ada_Side.Units.CXX_H_Unit;
      Functions : Abstract_Meta_Function_Lists.Abstract_Meta_Function_List
        := Class.Functions;
      Generated : Universal_String_Sets.Set;

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

      for Method of Functions loop
         if not Self.Can_Be_Generated (Class, Method) then
            null;

         elsif Generated.Contains (Method.Minimal_Signature) then
            Ada.Wide_Wide_Text_IO.Put_Line
             (" Skip '" & Method.Name.To_Wide_Wide_String
                & " - already generated");

         else
            Generated.Include (Method.Minimal_Signature);
            --  Protect from generation of duplicate for operators.

            Generated.Include (Method.Minimal_Signature);
            --  Protect from generation of duplicate for operators.

            Unit.Put (+"extern ""C"" ");
            Generate_Declaration (Self, Unit, Class, Method);
            Unit.Put_Line (+";");
         end if;
      end loop;

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
