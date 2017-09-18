with Ada.Command_Line;

with API_Extractors;
with Header_Paths;
with Q_Strings;

procedure Generator.Driver is
   Extractor : API_Extractors.API_Extractor;

begin
   Extractor.Set_Cpp_File_Name (Q_Strings.From_UTF8 (Ada.Command_Line.Argument (1)));
   Extractor.Set_Type_System (Q_Strings.From_UTF8 (Ada.Command_Line.Argument (2)));

   for J in 3 .. Ada.Command_Line.Argument_Count loop
      Extractor.Add_Include_Path (Header_Paths.Create (Q_Strings.From_UTF8 (Ada.Command_Line.Argument (J))));
   end loop;

   if Extractor.Run then
      null;
   end if;
end Generator.Driver;
