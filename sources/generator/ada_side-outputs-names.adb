package body Ada_Side.Outputs.Names is

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self    : Name;
      Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document is
   begin
      return Printer.New_Document.Put (Self.Name);
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
