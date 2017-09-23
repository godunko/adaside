private package Ada_Side.Outputs.Records is

   type Record_Definition is new Node with private;

   function New_Record
     (Parent       : Node_Access := null;
      Components   : Node_Access) return Node'Class;

   overriding function Document
    (Self    : Record_Definition;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Record_Definition is new Node with record
      Parent     : Node_Access;
      Components : Node_Access;
   end record;

end Ada_Side.Outputs.Records;
