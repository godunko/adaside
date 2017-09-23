package body Ada_Side.Outputs.Integer_Literals is

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self    : Integer_Literal;
      Printer : not null access League.Pretty_Printers.Printer'Class;
      Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      pragma Unreferenced (Pad);

      Image : constant Wide_Wide_String :=
        Natural'Wide_Wide_Image (Self.Value);
   begin
      return Printer.New_Document.Put (Image (2 .. Image'Last));
   end Document;

   -----------------
   -- New_Literal --
   -----------------

   function New_Literal
     (Value : Natural; Base  : Positive) return Node'Class is
   begin
      return Integer_Literal'(Value, Base);
   end New_Literal;

end Ada_Side.Outputs.Integer_Literals;
