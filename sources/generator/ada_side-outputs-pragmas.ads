private package Ada_Side.Outputs.Pragmas is

   type Pragma_Node is new Node with private;

   function New_Pragma
     (Name      : not null Node_Access;
      Arguments : Node_Access) return Node'Class;

   overriding function Document
    (Self    : Pragma_Node;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Pragma_Node is new Node with record
      Name      : not null Node_Access;
      Arguments : Node_Access;
   end record;

end Ada_Side.Outputs.Pragmas;
