private package Ada_Side.Outputs.Private_Records is

   type Private_Record is new Node with private;

   function New_Private_Record (Is_Tagged : Boolean) return Node'Class;

   overriding function Document
    (Self    : Private_Record;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Private_Record is new Node with record
      Is_Tagged : Boolean;
   end record;

end Ada_Side.Outputs.Private_Records;
