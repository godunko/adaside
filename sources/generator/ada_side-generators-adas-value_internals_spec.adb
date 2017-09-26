with Ada_Side.Units;

package body Ada_Side.Generators.Adas.Value_Internals_Spec is

   use type League.Strings.Universal_String;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_Ada_Internals_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      Unit : Ada_Side.Units.Ada_Spec_Unit;

   begin
      Unit.Set_Package_Name (User_Package_Full_Name (Class) & ".Internals");

      Unit.Add_With_Clause (API_Package_Full_Name (Class));

      Unit.New_Line;
      Unit.Put_Line
       ("package " & User_Package_Full_Name (Class) & ".Internals is");
      Unit.New_Line;
      Unit.Put_Line (+"   pragma Preelaborate;");
      Unit.New_Line;
      Unit.Put_Line
       ("   function " & Class.Name.To_Universal_String & "_View");
      Unit.Put_Line
       ("    (Self : " & User_Tagged_Type_Full_Name (Class) & "'Class)");
      Unit.Put_Line
       ("       return not null " & API_Access_Type_Full_Name (Class) & ";");
      Unit.New_Line;
      Unit.Put_Line ("end " & User_Package_Full_Name (Class) & ".Internals;");

      Unit.Save (Self.Output_Directory);
   end Generate;

   ---------------------
   -- Should_Generate --
   ---------------------

   overriding function Should_Generate
    (Self  : in out Value_Ada_Internals_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean
   is
      pragma Unreferenced (Self);

   begin
      return Class.Type_Entry.Is_Value;
   end Should_Generate;

end Ada_Side.Generators.Adas.Value_Internals_Spec;
