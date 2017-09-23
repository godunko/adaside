private package Ada_Side.Outputs.Statements is

   type Statement is new Node with private;

   function New_Statement
     (Expression : Node_Access) return Node'Class;

   overriding function Document
    (Self    : Statement;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Statement is new Node with record
      Expression      : Node_Access;
   end record;

end Ada_Side.Outputs.Statements;
