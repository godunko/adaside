private package Ada_Side.Outputs.Strings is

   type String is new Node with private;

   function New_String
     (Text : League.Strings.Universal_String) return Node'Class;

   overriding function Document
    (Self    : String;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document;

private

   type String is new Node with record
      Text : League.Strings.Universal_String;
   end record;

end Ada_Side.Outputs.Strings;
