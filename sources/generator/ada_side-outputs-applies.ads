private package Ada_Side.Outputs.Applies is

   type Apply is new Node with private;

   function New_Apply
     (Prefix    : not null Node_Access;
      Arguments : not null Node_Access) return Node'Class;

   overriding function Document
    (Self    : Apply;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Apply is new Node with record
      Prefix    : not null Node_Access;
      Arguments : not null Node_Access;
   end record;

end Ada_Side.Outputs.Applies;
