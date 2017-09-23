package body Ada_Side.Outputs.Names is

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Name;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural) return League.Pretty_Printers.Document
   is
      Result  : League.Pretty_Printers.Document := Printer.New_Document;
      Padding : constant Wide_Wide_String
        (Self.Name.Length + 1 .. Pad) := (others => ' ');
   begin
      Result.Put (Self.Name);

      if Padding'Length > 0 then
         Result.Put (Padding);
      end if;

      return Result;
   end Document;

   --------------
   -- New_Name --
   --------------

   function New_Name (Name : League.Strings.Universal_String)
     return Node'Class is
   begin
      return Names.Name'(Name => Name);
   end New_Name;

end Ada_Side.Outputs.Names;
