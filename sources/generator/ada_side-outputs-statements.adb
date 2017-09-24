package body Ada_Side.Outputs.Statements is

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Elsif_Statement;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;
      Result.New_Line;
      Result.Put ("elsif ");
      Result.Append (Self.Condition.Document (Printer, Pad));
      Result.Put (" then");

      Result.Append (Self.List.Document (Printer, Pad).Nest (3));

      return Result;
   end Document;

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : IF_Statement;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;
      Result.Put ("if ");
      Result.Append (Self.Condition.Document (Printer, Pad));
      Result.Put (" then");

      Result.Append (Self.Then_Path.Document (Printer, Pad).Nest (3));

      if Self.Elsif_List /= null then
         Result.Append (Self.Elsif_List.Document (Printer, Pad));
      end if;

      if Self.Else_Path /= null then
         Result.Append (Self.Else_Path.Document (Printer, Pad).Nest (3));
      end if;

      Result.New_Line;
      Result.Put ("end if;");
      return Result;
   end Document;

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

   ---------------
   -- New_Elsif --
   ---------------

   function New_Elsif
     (Condition  : not null Node_Access;
      List       : not null Node_Access) return Node'Class is
   begin
      return Elsif_Statement'(Condition, List);
   end New_Elsif;

   ------------
   -- New_If --
   ------------

   function New_If
     (Condition  : not null Node_Access;
      Then_Path  : not null Node_Access;
      Elsif_List : Node_Access;
      Else_Path  : Node_Access) return Node'Class is
   begin
      return IF_Statement'(Condition, Then_Path, Elsif_List, Else_Path);
   end New_If;

   -------------------
   -- New_Statement --
   -------------------

   function New_Statement (Expression : Node_Access) return Node'Class is
   begin
      return Statement'(Expression => Expression);
   end New_Statement;

end Ada_Side.Outputs.Statements;
