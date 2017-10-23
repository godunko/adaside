private package Ada_Outputs.Clauses is

   type Aspect is new Node with private;

   function New_Aspect
     (Name  : not null Node_Access;
      Value : Node_Access) return Node'Class;

   type Pragma_Node is new Node with private;

   function New_Pragma
     (Name      : not null Node_Access;
      Arguments : Node_Access) return Node'Class;

   type With_Clause is new Node with private;

   function New_With
     (Name : not null Node_Access;
      Is_Limited : Boolean;
      Is_Private : Boolean) return Node'Class;

   type Use_Clause is new Node with private;

   function New_Use
     (Name     : not null Node_Access;
      Use_Type : Boolean) return Node'Class;

private

   type Aspect is new Node with record
      Name  : not null Node_Access;
      Value : Node_Access;
   end record;

   overriding function Document
    (Self    : Aspect;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   overriding function Join
    (Self    : Aspect;
     List    : Node_Access_Array;
     Pad     : Natural;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document;

   overriding function Max_Pad (Self : Aspect) return Natural is
     (Self.Name.Max_Pad);

   type Pragma_Node is new Declaration with record
      Name      : not null Node_Access;
      Arguments : Node_Access;
   end record;

   overriding function Document
    (Self    : Pragma_Node;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type With_Clause is new Node with record
      Name       : not null Node_Access;
      Is_Limited : Boolean;
      Is_Private : Boolean;
   end record;

   overriding function Document
    (Self    : With_Clause;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Use_Clause is new Node with record
      Name     : not null Node_Access;
      Use_Type : Boolean;
   end record;

   overriding function Document
    (Self    : Use_Clause;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

end Ada_Outputs.Clauses;
