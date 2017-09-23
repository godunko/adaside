private package Ada_Side.Outputs.Packages is

   type Package_Spec is new Node with private;

   function New_Package
     (Name         : not null Node_Access;
      Public_Part  : Node_Access;
      Private_Part : Node_Access;
      Comment      : League.Strings.Universal_String) return Node'Class;

   overriding function Document
    (Self    : Package_Spec;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Package_Spec is new Node with record
      Name         : not null Node_Access;
      Public_Part  : Node_Access;
      Private_Part : Node_Access;
      Comment      : League.Strings.Universal_String;
   end record;

end Ada_Side.Outputs.Packages;
