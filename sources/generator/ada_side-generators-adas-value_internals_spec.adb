with Ada_Side.Units;
with Ada_Side.Outputs;

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
      F    : aliased Ada_Side.Outputs.Factory;

      Package_Name : constant League.Strings.Universal_String :=
        User_Package_Full_Name (Class) & ".Internals";

      With_Clause : constant Ada_Side.Outputs.Node_Access :=
        F.New_With (F.New_Selected_Name (API_Package_Full_Name (Class)));

      Preelaborate : constant Ada_Side.Outputs.Node_Access :=
        F.New_Pragma (F.New_Name (+"Preelaborate"));

      Self_Arg : constant Ada_Side.Outputs.Node_Access :=
        F.New_Parameter
          (Name            => F.New_Name (+"Self"),
           Type_Definition => F.New_Selected_Name
             (User_Tagged_Type_Full_Name (Class) & "'Class"));

      View : constant Ada_Side.Outputs.Node_Access :=
        F.New_Subprogram_Specification
          (Name       => F.New_Name (Class.Name.To_Universal_String & "_View"),
           Parameters => Self_Arg,
           Result     => F.New_Null_Exclusion
             (F.New_Selected_Name
                (API_Access_Type_Full_Name (Class))));

      View_Decl : constant Ada_Side.Outputs.Node_Access :=
        F.New_Subprogram_Declaration (View);

      Package_Spec : constant Ada_Side.Outputs.Node_Access :=
        F.New_Package
          (Name         => F.New_Selected_Name (Package_Name),
           Public_Part  => F.New_List (Preelaborate, View_Decl));

      Spec_Unit : constant Ada_Side.Outputs.Node_Access :=
        F.New_Compilation_Unit (Package_Spec, With_Clause);
   begin
      Unit.Set_Package_Name (Package_Name);
      Unit.Put_Lines (F.To_Text (Spec_Unit));
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
