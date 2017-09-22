package body Ada_Side.Outputs.With_Clauses is

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self : With_Clause;
      Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;
      Result.Put ("with ");
      Result.Append (Self.Name.Document (Printer));
      Result.Put (";");
      return Result;
   end Document;

   --------------
   -- New_With --
   --------------

   function New_With (Name : not null Node_Access) return Node'Class is
   begin
      return With_Clause'(Name => Name);
   end New_With;

end Ada_Side.Outputs.With_Clauses;
