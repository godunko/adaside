with Ada.Wide_Wide_Text_IO;
with League.Strings;
with Ada_Side.Outputs;

procedure Ada_Side.Output_Test is
   function "+" (Text : Wide_Wide_String)
                 return League.Strings.Universal_String
                 renames League.Strings.To_Universal_String;

   procedure Print_API;
   procedure Print_Core_Spec;

   F : aliased Ada_Side.Outputs.Factory;

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

      Convention : constant Ada_Side.Outputs.Node_Access := F.New_Aspect
        (F.New_Name (+"Convention"),
         F.New_Name (+"C"));

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

      Import : constant Ada_Side.Outputs.Node_Access := F.New_Aspect
        (F.New_Name (+"Import"),
         F.New_Name (+"True"));

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

   ---------------------
   -- Print_Core_Spec --
   ---------------------

   procedure Print_Core_Spec is
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

      QString : constant Ada_Side.Outputs.Node_Access :=
        F.New_Name (+"QString");

      QString_Type : constant Ada_Side.Outputs.Node_Access := F.New_Type
        (Name       => QString,
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
            F.New_Selected_Name (+"Qt_Ada.API.Strings.QString_Storage_Size")));

      QString_Type_Full : constant Ada_Side.Outputs.Node_Access := F.New_Type
        (Name       => QString,
         Definition => F.New_Record
           (F.New_List ((QString_View, Is_Wrapper, Storage))));

      Root : constant Ada_Side.Outputs.Node_Access :=
        F.New_Package (Name, QString_Type, QString_Type_Full);

      Unit : constant Ada_Side.Outputs.Node_Access :=
        F.New_Compilation_Unit (Root, Clause);
   begin
      Ada.Wide_Wide_Text_IO.Put_Line (F.To_Text (Unit).To_Wide_Wide_String);
   end Print_Core_Spec;

begin
   Print_API;
   Print_Core_Spec;
end Ada_Side.Output_Test;
