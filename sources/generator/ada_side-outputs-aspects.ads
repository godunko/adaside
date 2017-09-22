private package Ada_Side.Outputs.Aspects is

   type Aspect is new Node with private;

   function New_Aspect
     (Name  : not null Node_Access;
      Value : Node_Access) return Node'Class;

   overriding function Document
    (Self : Aspect;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document;

private

   type Aspect is new Node with record
      Name  : not null Node_Access;
      Value : Node_Access;
   end record;

end Ada_Side.Outputs.Aspects;
