package body Ada_Side.Outputs.Units is

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self : Compilation_Unit;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      if not Self.License.Is_Empty then
         Result.New_Line;
         Result.Put (Self.License);
      end if;

      if Self.Clauses /= null then
         Result.Append (Self.Clauses.Document (Printer));
      end if;

      Result.Append (Self.Root.Document (Printer));

      return Result;
   end Document;

   --------------------------
   -- New_Compilation_Unit --
   --------------------------

   function New_Compilation_Unit
     (Root    : not null Node_Access;
      Clauses : Node_Access := null;
      License : League.Strings.Universal_String)
      return Node'Class
   is
   begin
      return Compilation_Unit'(Root, Clauses, License);
   end New_Compilation_Unit;

end Ada_Side.Outputs.Units;
