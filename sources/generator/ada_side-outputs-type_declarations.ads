private package Ada_Side.Outputs.Type_Declarations is

   type Type_Declaration is new Node with private;

   function New_Type
     (Name          : not null Node_Access;
      Discriminants : Node_Access;
      Definition    : Node_Access;
      Aspects       : Node_Access;
      Comment       : League.Strings.Universal_String) return Node'Class;

   overriding function Document
    (Self : Type_Declaration;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document;

private

   type Type_Declaration is new Node with record
      Name          : not null Node_Access;
      Discriminants : Node_Access;
      Definition    : Node_Access;
      Aspects       : Node_Access;
      Comment       : League.Strings.Universal_String;
   end record;

end Ada_Side.Outputs.Type_Declarations;
