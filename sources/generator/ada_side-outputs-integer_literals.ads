private package Ada_Side.Outputs.Integer_Literals is

   type Integer_Literal is new Node with private;

   function New_Literal
     (Value : Natural;
      Base  : Positive) return Node'Class;

   overriding function Document
    (Self    : Integer_Literal;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Integer_Literal is new Node with record
      Value : Natural;
      Base  : Positive;
   end record;

end Ada_Side.Outputs.Integer_Literals;
