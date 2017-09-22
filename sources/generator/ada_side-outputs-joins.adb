package body Ada_Side.Outputs.Joins is

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self : Join;
      Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.Append (Self.Left.Document (Printer));
      Result.Append (Self.Right.Document (Printer));

      return Result;
   end Document;

   --------------
   -- New_Join --
   --------------

   function New_Join
     (Left  : not null Node_Access;
      Right : not null Node_Access) return Node'Class is
   begin
      return Join'(Left, Right);
   end New_Join;

end Ada_Side.Outputs.Joins;
