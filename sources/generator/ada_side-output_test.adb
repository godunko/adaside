with Ada.Wide_Wide_Text_IO;
with League.Strings;
with Ada_Side.Outputs;

procedure Ada_Side.Output_Test is
   function "+" (Text : Wide_Wide_String)
                 return League.Strings.Universal_String
                 renames League.Strings.To_Universal_String;
   F : aliased Ada_Side.Outputs.Factory;
   Aaa  : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Aaa");
   Name : constant Ada_Side.Outputs.Node_Access :=
     F.New_Selected_Name (+"Qt_Ada.API.Strings");

   Clause : constant Ada_Side.Outputs.Node_Access := F.New_With
     (F.New_Selected_Name (+"System.Storage_Elements"));
   Preelaborate : constant Ada_Side.Outputs.Node_Access := F.New_Pragma
     (F.New_Name (+"Preelaborate"));
   Root : constant Ada_Side.Outputs.Node_Access := F.New_Package
     (Name, Preelaborate, Comment => Aaa);
   Unit : constant Ada_Side.Outputs.Node_Access :=
     F.New_Compilation_Unit (Root, Clause, License => Aaa);
begin
   Ada.Wide_Wide_Text_IO.Put_Line (F.To_Text (Unit).To_Wide_Wide_String);

end Ada_Side.Output_Test;
