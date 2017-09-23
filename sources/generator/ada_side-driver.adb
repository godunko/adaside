with Ada.Wide_Wide_Text_IO;
with Interfaces.C;

with League.Application;
with League.Strings;
with League.String_Vectors;

with Abstract_Meta_Class_Lists;
with Abstract_Meta_Classes;
with API_Extractors;
with Header_Paths;
with Q_Strings;

with Ada_Side.Setup;

procedure Ada_Side.Driver is
   Output_Directory_Switch : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("--output-directory");

   Output_Directory : League.Strings.Universal_String
     := League.Strings.To_Universal_String (".");

   Generators : constant Ada_Side.Setup.Generator_Array
     := Ada_Side.Setup.Generators;
   Arguments  : constant League.String_Vectors.Universal_String_Vector
     := League.Application.Arguments;
   Extractor  : API_Extractors.API_Extractor;
   Classes    : Abstract_Meta_Class_Lists.Abstract_Meta_Class_List;

begin
   Extractor.Set_Cpp_File_Name
     (Q_Strings.From_Universal_String (Arguments (1)));

   Extractor.Set_Type_System
     (Q_Strings.From_Universal_String (Arguments (2)));

   for J in 3 .. Arguments.Length loop
      if Arguments (J).Starts_With ("-I") then
         Extractor.Add_Include_Path
          (Header_Paths.Create
            (Q_Strings.From_Universal_String (Arguments (J).Tail_From (3))));

      elsif Arguments (J).Starts_With (Output_Directory_Switch) then
         Output_Directory :=
           Arguments (J).Tail_From (Output_Directory_Switch.Length + 1);

      else
         raise Program_Error;
      end if;
   end loop;

   Extractor.Set_Log_Directory
    (Q_Strings.From_Universal_String (Output_Directory));

   if Extractor.Run then
      null;
   end if;

   Classes := Extractor.Classes;

   Ada.Wide_Wide_Text_IO.Put_Line
    (Interfaces.C.int'Wide_Wide_Image (Classes.Size));

   for Class of Classes loop
      Ada.Wide_Wide_Text_IO.Put_Line
       (" " & Class.Full_Name.To_Universal_String.To_Wide_Wide_String
          & " "
          & Class.Type_Entry.Name.To_Universal_String.To_Wide_Wide_String);

      for Generator of Generators loop
         if Generator.Should_Generate (Class) then
            Ada.Wide_Wide_Text_IO.Put_Line ("   ...generating...");
            Generator.Generate (Class);
         end if;
      end loop;
   end loop;

end Ada_Side.Driver;
