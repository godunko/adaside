with Ada.Command_Line;
with Ada.Text_IO;
with Interfaces.C;

with Abstract_Meta_Class_Lists;
with Abstract_Meta_Classes;
with API_Extractors;
with Header_Paths;
with Q_Strings;

with Ada_Side.Setup;

procedure Ada_Side.Driver is
   Extractor  : API_Extractors.API_Extractor;
   Classes    : Abstract_Meta_Class_Lists.Abstract_Meta_Class_List;
   Generators : constant Ada_Side.Setup.Generator_Array
     := Ada_Side.Setup.Generators;

begin
   Extractor.Set_Cpp_File_Name
     (Q_Strings.From_UTF8 (Ada.Command_Line.Argument (1)));

   Extractor.Set_Type_System
     (Q_Strings.From_UTF8 (Ada.Command_Line.Argument (2)));

   for J in 3 .. Ada.Command_Line.Argument_Count loop
      Extractor.Add_Include_Path
        (Header_Paths.Create
           (Q_Strings.From_UTF8 (Ada.Command_Line.Argument (J))));
   end loop;

   if Extractor.Run then
      null;
   end if;

   Classes := Extractor.Classes;

   Ada.Text_IO.Put_Line (Interfaces.C.int'Image (Classes.Size));

   for Class of Classes loop
      Ada.Text_IO.Put_Line (" " & Class.Full_Name.To_UTF8);

      for Generator of Generators loop
         if Generator.Should_Generate (Class) then
            null;
         end if;
      end loop;
   end loop;

end Ada_Side.Driver;
