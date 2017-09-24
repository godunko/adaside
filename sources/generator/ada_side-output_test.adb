with Ada.Wide_Wide_Text_IO;
with League.Strings;
with Ada_Side.Outputs;

procedure Ada_Side.Output_Test is
   function "+" (Text : Wide_Wide_String)
                 return League.Strings.Universal_String
                 renames League.Strings.To_Universal_String;

   procedure Print_API;
   procedure Print_Core_Spec_And_Body;

   F : aliased Ada_Side.Outputs.Factory;

   Convention : constant Ada_Side.Outputs.Node_Access := F.New_Aspect
     (F.New_Name (+"Convention"),
      F.New_Name (+"C"));

   Import : constant Ada_Side.Outputs.Node_Access := F.New_Aspect
     (F.New_Name (+"Import"),
      F.New_Name (+"True"));

   ---------------
   -- Print_API --
   ---------------

   procedure Print_API is

      Name : constant Ada_Side.Outputs.Node_Access :=
        F.New_Selected_Name (+"Qt_Ada.API.Strings");

      Clause : constant Ada_Side.Outputs.Node_Access := F.New_With
        (F.New_Selected_Name (+"System.Storage_Elements"));

      Preelaborate : constant Ada_Side.Outputs.Node_Access := F.New_Pragma
        (F.New_Name (+"Preelaborate"));

      QString : constant Ada_Side.Outputs.Node_Access :=
        F.New_Name (+"QString");

      QString_Type : constant Ada_Side.Outputs.Node_Access := F.New_Type
        (Name       => QString,
         Definition => F.New_Record,
         Aspects    => Convention);

      QString_Access : constant Ada_Side.Outputs.Node_Access := F.New_Type
        (Name       => F.New_Name (+"QString_Access"),
         Definition => F.New_Access (True, QString),
         Aspects    => Convention);

      Link_Name : constant Ada_Side.Outputs.Node_Access := F.New_Aspect
        (F.New_Name (+"Link_Name"),
         F.New_String_Literal (+"__qtada__QString__storage_size"));

      Aspect_List : constant Ada_Side.Outputs.Node_Access :=
        F.New_List (Import,
          F.New_List (Convention, Link_Name));

      QString_Storage_Size : constant Ada_Side.Outputs.Node_Access :=
        F.New_Variable
          (Name            => F.New_Name (+"QString_Storage_Size"),
           Type_Definition => F.New_Selected_Name
             (+"System.Storage_Elements.Storage_Offset"),
           Is_Constant     => True,
           Aspects         => Aspect_List);

      Public : constant Ada_Side.Outputs.Node_Access := F.New_List
        ((Preelaborate, QString_Type, QString_Access, QString_Storage_Size));

      Root : constant Ada_Side.Outputs.Node_Access :=
        F.New_Package (Name, Public);

      Unit : constant Ada_Side.Outputs.Node_Access :=
        F.New_Compilation_Unit (Root, Clause);
   begin
      Ada.Wide_Wide_Text_IO.Put_Line (F.To_Text (Unit).To_Wide_Wide_String);
   end Print_API;

   ------------------------------
   -- Print_Core_Spec_And_Body --
   ------------------------------

   procedure Print_Core_Spec_And_Body is
      Name : constant Ada_Side.Outputs.Node_Access :=
        F.New_Selected_Name (+"Qt5.Qt_Core.Strings");

      With_1 : constant Ada_Side.Outputs.Node_Access := F.New_With
        (F.New_Selected_Name (+"Ada.Finalization"), Is_Private => True);

      With_2 : constant Ada_Side.Outputs.Node_Access := F.New_With
        (F.New_Selected_Name (+"System.Storage_Elements"), Is_Private => True);

      With_3 : constant Ada_Side.Outputs.Node_Access := F.New_With
        (F.New_Selected_Name (+"Qt_Ada.API.Strings"), Is_Private => True);

      Clause : constant Ada_Side.Outputs.Node_Access :=
        F.New_List ((With_1, With_2, With_3));

      Q_String : constant Ada_Side.Outputs.Node_Access :=
        F.New_Name (+"Q_String");

      Q_String_Type : constant Ada_Side.Outputs.Node_Access := F.New_Type
        (Name       => Q_String,
         Definition => F.New_Private_Record (Is_Tagged => True));

      QString_View : constant Ada_Side.Outputs.Node_Access := F.New_Variable
        (Name            => F.New_Name (+"QString_View"),
         Type_Definition => F.New_Selected_Name
           (+"Qt_Ada.API.Strings.QString_Access"));

      Is_Wrapper : constant Ada_Side.Outputs.Node_Access := F.New_Variable
        (Name            => F.New_Name (+"Is_Wrapper"),
         Type_Definition => F.New_Name (+"Boolean"));

      Storage : constant Ada_Side.Outputs.Node_Access := F.New_Variable
        (Name            => F.New_Name (+"Storage"),
         Type_Definition => F.New_Apply
           (F.New_Selected_Name (+"System.Storage_Elements.Storage_Array"),
            F.New_List
              (F.New_Literal (1),
               F.New_Infix
                 (+"..",
                  F.New_Selected_Name
                   (+"Qt_Ada.API.Strings.QString_Storage_Size")))));

      Q_String_Type_Full : constant Ada_Side.Outputs.Node_Access := F.New_Type
        (Name       => Q_String,
         Definition => F.New_Record
           (Parent     => F.New_Selected_Name (+"Ada.Finalization.Controlled"),
            Components => F.New_List ((QString_View, Is_Wrapper, Storage))));

      Self_Q_String : constant Ada_Side.Outputs.Node_Access := F.New_Parameter
        (Name            => F.New_Name (+"Self"),
         Is_In           => True,
         Is_Out          => True,
         Type_Definition => Q_String);

      Initialize : constant Ada_Side.Outputs.Node_Access :=
        F.New_Subprogram_Specification
          (Is_Overriding => True,
           Name          => F.New_Name (+"Initialize"),
           Parameters    => Self_Q_String);

      Adjust : constant Ada_Side.Outputs.Node_Access :=
        F.New_Subprogram_Specification
          (Is_Overriding => True,
           Name          => F.New_Name (+"Adjust"),
           Parameters    => Self_Q_String);

      Finalize : constant Ada_Side.Outputs.Node_Access :=
        F.New_Subprogram_Specification
          (Is_Overriding => True,
           Name          => F.New_Name (+"Finalize"),
           Parameters    => Self_Q_String);

      Private_Part : constant Ada_Side.Outputs.Node_Access :=
        F.New_List ((Q_String_Type_Full,
                     F.New_Subprogram_Declaration (Initialize),
                     F.New_Subprogram_Declaration (Adjust),
                     F.New_Subprogram_Declaration (Finalize)));

      Spec_Root : constant Ada_Side.Outputs.Node_Access :=
        F.New_Package (Name, Q_String_Type, Private_Part);

      Spec_Unit : constant Ada_Side.Outputs.Node_Access :=
        F.New_Compilation_Unit (Spec_Root, Clause);

      QString_Access : constant Ada_Side.Outputs.Node_Access :=
        F.New_Selected_Name (+"Qt_Ada.API.Strings.QString_Access");

      Self_QString_Access : constant Ada_Side.Outputs.Node_Access :=
        F.New_Parameter
          (Name            => F.New_Name (+"Self"),
           Is_In           => True,
           Is_Out          => True,
           Type_Definition => QString_Access);

      Address : constant Ada_Side.Outputs.Node_Access :=
        F.New_Selected_Name (+"System.Address");

      Storage_Param : constant Ada_Side.Outputs.Node_Access :=
        F.New_Parameter
          (Name            => F.New_Name (+"Storage"),
           Type_Definition => Address);

      QString_initialize : constant Ada_Side.Outputs.Node_Access :=
        F.New_Subprogram_Declaration
          (F.New_Subprogram_Specification
             (Name          => F.New_Name (+"QString_initialize"),
              Parameters    =>
                F.New_List (Self_QString_Access, Storage_Param)),
           Aspects => F.New_List
             ((Import,
               Convention,
               F.New_Aspect
                (F.New_Name (+"Link_Name"),
                 F.New_String_Literal (+"QString___initialize")))));

      QString_finalize : constant Ada_Side.Outputs.Node_Access :=
        F.New_Subprogram_Declaration
          (F.New_Subprogram_Specification
             (Name          => F.New_Name (+"QString_finalize"),
              Parameters    => Self_QString_Access),
           Aspects => F.New_List
             ((Import,
               Convention,
               F.New_Aspect
                (F.New_Name (+"Link_Name"),
                 F.New_String_Literal (+"QString__finalize")))));

      QString_adjust : constant Ada_Side.Outputs.Node_Access :=
        F.New_Subprogram_Declaration
          (F.New_Subprogram_Specification
             (Name          => F.New_Name (+"QString_adjust"),
              Parameters    =>
                F.New_List (Self_QString_Access, Storage_Param)),
           Aspects => F.New_List
             ((Import,
               Convention,
               F.New_Aspect
                (F.New_Name (+"Link_Name"),
                 F.New_String_Literal (+"QString__adjust")))));

      Adjust_Stmt_1 : constant Ada_Side.Outputs.Node_Access :=
        F.New_Statement
          (F.New_Apply
             (F.New_Name (+"QString_adjust"),
              F.New_List
                (F.New_Selected_Name (+"Self.QString_View"),
                 F.New_Selected_Name (+"Self.Storage'Address"))));

      Adjust_Stmt_2 : constant Ada_Side.Outputs.Node_Access :=
        F.New_Assignment
          (F.New_Selected_Name (+"Self.Is_Wrapper"),
           F.New_Name (+"False"));

      Adjust_Body : constant Ada_Side.Outputs.Node_Access :=
        F.New_Subprogram_Body
          (Adjust,
           Statements =>
             F.New_List (Adjust_Stmt_1, Adjust_Stmt_2));

      Finalize_Body : constant Ada_Side.Outputs.Node_Access :=
        F.New_Subprogram_Body
          (Finalize,
           Declarations => F.New_Use
             (F.New_Selected_Name (+"Qt_Ada.API.Strings.QString_Access"),
              Use_Type => True),
           Statements =>
             F.New_List (Adjust_Stmt_1, Adjust_Stmt_2));

      Body_Root : constant Ada_Side.Outputs.Node_Access :=
        F.New_Package_Body
          (Name,
           F.New_List
             ((QString_initialize,
               QString_finalize,
               QString_adjust,
               Adjust_Body,
               Finalize_Body)));

      Body_Unit : constant Ada_Side.Outputs.Node_Access :=
        F.New_Compilation_Unit (Body_Root);
   begin
      Ada.Wide_Wide_Text_IO.Put_Line
        (F.To_Text (Spec_Unit).To_Wide_Wide_String);

      Ada.Wide_Wide_Text_IO.Put_Line
        (F.To_Text (Body_Unit).To_Wide_Wide_String);
   end Print_Core_Spec_And_Body;

begin
   Print_API;
   Print_Core_Spec_And_Body;
end Ada_Side.Output_Test;
