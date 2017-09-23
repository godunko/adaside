private package Ada_Side.Outputs.Units is

   type Compilation_Unit is new Node with private;

   function New_Compilation_Unit
     (Root    : not null Node_Access;
      Clauses : Node_Access := null;
      License : League.Strings.Universal_String) return Node'Class;

   overriding function Document
    (Self    : Compilation_Unit;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Compilation_Unit is new Node with record
      Root    : not null Node_Access;
      Clauses : Node_Access;
      License : League.Strings.Universal_String;
   end record;

end Ada_Side.Outputs.Units;
