private package Ada_Side.Outputs.Variables is

   type Variable is new Node with private;

   function New_Variable
     (Name            : not null Node_Access;
      Type_Definition : Node_Access;
      Initialization  : Node_Access;
      Is_Constant     : Boolean;
      Is_Aliased      : Boolean;
      Aspects         : Node_Access;
      Comment         : League.Strings.Universal_String) return Node'Class;

   overriding function Document
    (Self    : Variable;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Variable is new Node with record
      Name            : not null Node_Access;
      Type_Definition : Node_Access;
      Initialization  : Node_Access;
      Is_Constant     : Boolean;
      Is_Aliased      : Boolean;
      Aspects         : Node_Access;
      Comment         : League.Strings.Universal_String;
   end record;

end Ada_Side.Outputs.Variables;
