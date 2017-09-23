private package Ada_Side.Outputs.Subprograms is

   type Subprogram is new Node with private;

   function New_Subprogram
     (Is_Overriding : Boolean;
      Name          : Node_Access;
      Parameters    : Node_Access;
      Result        : Node_Access) return Node'Class;

   overriding function Document
    (Self    : Subprogram;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Declaration is new Node with private;

   function New_Declaration
     (Specification : not null Node_Access;
      Aspects       : Node_Access := null;
      Comment       : League.Strings.Universal_String) return Node'Class;

   overriding function Document
    (Self    : Declaration;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Implementation is new Node with private;

   function New_Body
     (Specification : not null Node_Access;
      Declarations  : Node_Access;
      Statements    : Node_Access;
      Exceptions    : Node_Access) return Node'Class;

   overriding function Document
    (Self    : Implementation;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Subprogram is new Node with record
      Is_Overriding : Boolean;
      Name          : Node_Access;
      Parameters    : Node_Access;
      Result        : Node_Access;
   end record;

   type Declaration is new Node with record
      Specification : not null Node_Access;
      Aspects       : Node_Access;
      Comment       : League.Strings.Universal_String;
   end record;

   type Implementation is new Node with record
      Specification : not null Node_Access;
      Declarations  : Node_Access;
      Statements    : Node_Access;
      Exceptions    : Node_Access;
   end record;

end Ada_Side.Outputs.Subprograms;
