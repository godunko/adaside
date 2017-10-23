private package Ada_Outputs.Joins is

   type Join is new Node with private;

   function New_Join
     (Left  : not null Node_Access;
      Right : not null Node_Access) return Node'Class;

private

   type Join is new Node with record
      Left  : not null Node_Access;
      Right : not null Node_Access;
   end record;

   overriding function Document
    (Self    : Join;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

end Ada_Outputs.Joins;
