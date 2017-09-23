package body Ada_Side.Outputs.Infixes is

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self    : Infix;
      Printer : not null access League.Pretty_Printers.Printer'Class;
      Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;
      Result.Put (Self.Operator);
      Result.Put (" ");
      Result.Append (Self.Left.Document (Printer, Pad));
      Result.Nest (2);
      Result.Group;

      return Result;
   end Document;

   ---------------
   -- New_Infix --
   ---------------

   function New_Infix
     (Operator : League.Strings.Universal_String;
      Left     : not null Node_Access)
      return Node'Class is
   begin
      return Infix'(Operator, Left);
   end New_Infix;

end Ada_Side.Outputs.Infixes;
