private package Ada_Side.Outputs.Statements is

   type Statement is new Node with private;

   function New_Statement
     (Expression : Node_Access) return Node'Class;

   overriding function Document
    (Self    : Statement;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Assignment is new Node with private;

   function New_Assignment
     (Left  : not null Node_Access;
      Right : not null Node_Access) return Node'Class;

   overriding function Document
    (Self    : Assignment;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   function New_If
     (Condition  : not null Node_Access;
      Then_Path  : not null Node_Access;
      Elsif_List : Node_Access;
      Else_Path  : Node_Access) return Node'Class;

   function New_Elsif
     (Condition  : not null Node_Access;
      List       : not null Node_Access) return Node'Class;

private

   type Statement is new Node with record
      Expression : Node_Access;
   end record;

   type Assignment is new Node with record
      Left  : not null Node_Access;
      Right : not null Node_Access;
   end record;

   type IF_Statement is new Node with record
      Condition  : not null Node_Access;
      Then_Path  : not null Node_Access;
      Elsif_List : Node_Access;
      Else_Path  : Node_Access;
   end record;

   overriding function Document
    (Self    : IF_Statement;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Elsif_Statement is new Node with record
      Condition : not null Node_Access;
      List      : not null Node_Access;
   end record;

   overriding function Document
    (Self    : Elsif_Statement;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

end Ada_Side.Outputs.Statements;
