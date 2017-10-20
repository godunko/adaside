with Code_Model.Files;

package body Code_Model.Models is

   ----------------------
   -- Lookup_Or_Create --
   ----------------------

   function Lookup_Or_Create
    (Self      : in out Model'Class;
     File_Name : League.Strings.Universal_String)
       return not null File_Access
   is
      Position : constant File_Maps.Cursor := Self.Files.Find (File_Name);

   begin
      if File_Maps.Has_Element (Position) then
         return File_Maps.Element (Position);

      else
         return Result : constant not null File_Access
           := new Code_Model.Files.File'(Name => File_Name, Classes => <>)
         do
            Self.Files.Insert (File_Name, Result);
         end return;
      end if;
   end Lookup_Or_Create;

end Code_Model.Models;
