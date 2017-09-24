package body Ada_Side.Outputs.Statements is

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self    : Statement;
      Printer : not null access League.Pretty_Printers.Printer'Class;
      Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;

      if Self.Expression /= null then
         Result.Append (Self.Expression.Document (Printer, Pad));
      end if;

      Result.Put (";");
      return Result;
   end Document;

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Assignment;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;
      Result.Append (Self.Left.Document (Printer, Pad));
      Result.Put (" := ");
      Result.Append (Self.Right.Document (Printer, Pad));

      Result.Put (";");
      return Result;
   end Document;

   --------------------
   -- New_Assignment --
   --------------------

   function New_Assignment
     (Left  : not null Node_Access;
      Right : not null Node_Access) return Node'Class is
   begin
      return Assignment'(Left, Right);
   end New_Assignment;

   -------------------
   -- New_Statement --
   -------------------

   function New_Statement (Expression : Node_Access) return Node'Class is
   begin
      return Statement'(Expression => Expression);
   end New_Statement;

end Ada_Side.Outputs.Statements;
