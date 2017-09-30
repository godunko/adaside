private package Ada_Side.Outputs.Statements is

   type Assignment is new Node with private;

   function New_Assignment
     (Left  : not null Node_Access;
      Right : not null Node_Access) return Node'Class;

   type Elsif_Statement is new Node with private;

   function New_Elsif
     (Condition  : not null Node_Access;
      List       : not null Node_Access) return Node'Class;

   type If_Statement is new Node with private;

   function New_If
     (Condition  : not null Node_Access;
      Then_Path  : not null Node_Access;
      Elsif_List : Node_Access;
      Else_Path  : Node_Access) return Node'Class;

   type Return_Statement is new Node with private;

   function New_Return
     (Expression : not null Node_Access) return Node'Class;

   type Statement is new Node with private;

   function New_Statement
     (Expression : Node_Access) return Node'Class;

private

   type Assignment is new Node with record
      Left  : not null Node_Access;
      Right : not null Node_Access;
   end record;

   overriding function Document
    (Self    : Assignment;
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

   type If_Statement is new Node with record
      Condition  : not null Node_Access;
      Then_Path  : not null Node_Access;
      Elsif_List : Node_Access;
      Else_Path  : Node_Access;
   end record;

   overriding function Document
    (Self    : If_Statement;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Return_Statement is new Node with record
      Expression : Node_Access;
   end record;

   overriding function Document
    (Self    : Return_Statement;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Statement is new Node with record
      Expression : Node_Access;
   end record;

   overriding function Document
    (Self    : Statement;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

end Ada_Side.Outputs.Statements;
