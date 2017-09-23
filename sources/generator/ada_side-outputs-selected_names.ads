private package Ada_Side.Outputs.Selected_Names is

   type Selected_Name is new Node with private;

   function New_Selected_Name
     (Prefix   : not null Node_Access;
      Selector : not null Node_Access) return Node'Class;

   overriding function Document
    (Self    : Selected_Name;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Selected_Name is new Expression with record
      Prefix   : not null Node_Access;
      Selector : not null Node_Access;
   end record;

end Ada_Side.Outputs.Selected_Names;
