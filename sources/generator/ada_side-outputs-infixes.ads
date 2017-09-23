private package Ada_Side.Outputs.Infixes is

   type Infix is new Node with private;

   function New_Infix
     (Operator : League.Strings.Universal_String;
      Left     : not null Node_Access) return Node'Class;

   overriding function Document
    (Self    : Infix;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Infix is new Node with record
      Operator : League.Strings.Universal_String;
      Left     : not null Node_Access;
   end record;

end Ada_Side.Outputs.Infixes;
