private package Ada_Side.Outputs.Parameters is

   type Parameter is new Node with private;

   function New_Parameter
     (Name            : not null Node_Access;
      Type_Definition : Node_Access;
      Initialization  : Node_Access;
      Is_In           : Boolean;
      Is_Out          : Boolean;
      Is_Aliased      : Boolean;
      Comment         : League.Strings.Universal_String) return Node'Class;

   overriding function Document
    (Self    : Parameter;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

private

   type Parameter is new Node with record
      Name            : not null Node_Access;
      Type_Definition : not null Node_Access;
      Initialization  : Node_Access;
      Is_In           : Boolean;
      Is_Out          : Boolean;
      Is_Aliased      : Boolean;
      Comment         : League.Strings.Universal_String;
   end record;

   overriding function Max_Pad (Self : Parameter) return Natural is
     (Self.Name.Max_Pad);

end Ada_Side.Outputs.Parameters;
