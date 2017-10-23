private package Ada_Outputs.Expressions is

   type Apply is new Node with private;

   function New_Apply
     (Prefix    : not null Node_Access;
      Arguments : not null Node_Access) return Node'Class;

   type Infix is new Node with private;

   function New_Infix
     (Operator : League.Strings.Universal_String;
      Left     : not null Node_Access) return Node'Class;

   type Integer_Literal is new Node with private;

   function New_Literal
     (Value : Natural;
      Base  : Positive) return Node'Class;

   type Name is new Node with private;

   function New_Name
     (Name : League.Strings.Universal_String) return Node'Class;

   type Selected_Name is new Node with private;

   function New_Selected_Name
     (Prefix   : not null Node_Access;
      Selector : not null Node_Access) return Node'Class;

   type String is new Node with private;

   function New_String
     (Text : League.Strings.Universal_String) return Node'Class;

   type Parentheses is new Node with private;

   function New_Parentheses
     (Child : not null Node_Access) return Node'Class;

private

   type Apply is new Node with record
      Prefix    : not null Node_Access;
      Arguments : not null Node_Access;
   end record;

   overriding function Document
    (Self    : Apply;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Infix is new Node with record
      Operator : League.Strings.Universal_String;
      Left     : not null Node_Access;
   end record;

   overriding function Document
    (Self    : Infix;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Integer_Literal is new Node with record
      Value : Natural;
      Base  : Positive;
   end record;

   overriding function Document
    (Self    : Integer_Literal;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Name is new Expression with record
      Name : League.Strings.Universal_String;
   end record;

   overriding function Max_Pad (Self : Name) return Natural is
     (Self.Name.Length);

   overriding function Document
    (Self    : Name;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Selected_Name is new Expression with record
      Prefix   : not null Node_Access;
      Selector : not null Node_Access;
   end record;

   overriding function Document
    (Self    : Selected_Name;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type String is new Node with record
      Text : League.Strings.Universal_String;
   end record;

   overriding function Document
    (Self    : String;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Parentheses is new Node with record
      Child : not null Node_Access;
   end record;

   overriding function Document
    (Self    : Parentheses;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

end Ada_Outputs.Expressions;
