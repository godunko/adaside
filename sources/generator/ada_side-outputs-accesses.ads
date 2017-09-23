private package Ada_Side.Outputs.Accesses is

   type Access_Definition is new Node with private;

   function New_Access
     (Is_All : Boolean;
      Target : not null Node_Access) return Node'Class;

   overriding function Document
    (Self    : Access_Definition;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Access_Definition is new Node with record
      Is_All : Boolean;
      Target : not null Node_Access;
   end record;

end Ada_Side.Outputs.Accesses;
