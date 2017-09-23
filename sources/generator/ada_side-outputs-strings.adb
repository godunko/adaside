package body Ada_Side.Outputs.Strings is

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self    : String;
      Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.Put ("""");
      Result.Put (Self.Text);
      Result.Put ("""");
      return Result;
   end Document;

   ----------------
   -- New_String --
   ----------------

   function New_String (Text : League.Strings.Universal_String)
      return Node'Class is
   begin
      return String'(Text => Text);
   end New_String;

end Ada_Side.Outputs.Strings;
