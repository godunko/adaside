private package Ada_Side.Outputs.Names is

   type Name is new Node with private;

   function New_Name
     (Name : League.Strings.Universal_String) return Node'Class;

   overriding function Document
    (Self : Name;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document;

private

   type Name is new Node with record
      Name : League.Strings.Universal_String;
   end record;

end Ada_Side.Outputs.Names;
