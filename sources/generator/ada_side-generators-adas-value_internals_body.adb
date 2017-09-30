with Ada_Side.Outputs;
with Ada_Side.Units;

package body Ada_Side.Generators.Adas.Value_Internals_Body is

   use type League.Strings.Universal_String;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_Ada_Internals_Body_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      Unit : Ada_Side.Units.Ada_Body_Unit;
      F    : aliased Ada_Side.Outputs.Factory;

      Package_Name : constant League.Strings.Universal_String :=
        User_Package_Full_Name (Class) & ".Internals";

      Self_Name : constant Ada_Side.Outputs.Node_Access :=
        F.New_Name (+"Self");

      Self_Arg : constant Ada_Side.Outputs.Node_Access :=
        F.New_Parameter
          (Name            => Self_Name,
           Type_Definition => F.New_Selected_Name
             (User_Tagged_Type_Full_Name (Class) & "'Class"));

      View_Name : constant Ada_Side.Outputs.Node_Access :=
        F.New_Name (Class.Name.To_Universal_String & "_View");

      View : constant Ada_Side.Outputs.Node_Access :=
        F.New_Subprogram_Specification
          (Name       => View_Name,
           Parameters => Self_Arg,
           Result     => F.New_Null_Exclusion
             (F.New_Selected_Name
                (API_Access_Type_Full_Name (Class))));

      Return_Stmt : constant Ada_Side.Outputs.Node_Access := F.New_Return
        (F.New_Selected_Name (Self_Name, View_Name));

      View_Body : constant Ada_Side.Outputs.Node_Access :=
        F.New_Subprogram_Body
          (Specification => View,
           Statements    => Return_Stmt);

      Package_Body : constant Ada_Side.Outputs.Node_Access :=
        F.New_Package_Body
          (Name => F.New_Selected_Name (Package_Name),
           List => View_Body);

      Body_Unit : constant Ada_Side.Outputs.Node_Access :=
        F.New_Compilation_Unit (Package_Body);
   begin
      Unit.Set_Package_Name (Package_Name);
      Unit.Put_Lines (F.To_Text (Body_Unit));
      Unit.Save (Self.Output_Directory);
   end Generate;

   ---------------------
   -- Should_Generate --
   ---------------------

   overriding function Should_Generate
    (Self  : in out Value_Ada_Internals_Body_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean
   is
      pragma Unreferenced (Self);

   begin
      return Class.Type_Entry.Is_Value;
   end Should_Generate;

end Ada_Side.Generators.Adas.Value_Internals_Body;
