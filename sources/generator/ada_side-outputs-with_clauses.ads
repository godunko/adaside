private package Ada_Side.Outputs.With_Clauses is

   type With_Clause is new Node with private;

   function New_With
     (Name : not null Node_Access;
      Is_Limited : Boolean;
      Is_Private : Boolean) return Node'Class;

   overriding function Document
    (Self    : With_Clause;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type With_Clause is new Node with record
      Name       : not null Node_Access;
      Is_Limited : Boolean;
      Is_Private : Boolean;
   end record;

end Ada_Side.Outputs.With_Clauses;