package body Ada_Side.Outputs.Pragmas is

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Pragma_Node;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;
      Result.Put ("pragma ");
      Result.Append (Self.Name.Document (Printer, Pad));

      if Self.Arguments /= null then
         Result.Put (" (");
         Result.Append (Self.Arguments.Document (Printer, Pad));
         Result.Put (")");
      end if;

      Result.Put (";");

      return Result;
   end Document;

   ----------------
   -- New_Pragma --
   ----------------

   function New_Pragma
     (Name      : not null Node_Access;
      Arguments : Node_Access) return Node'Class is
   begin
      return Pragma_Node'(Name, Arguments);
   end New_Pragma;

end Ada_Side.Outputs.Pragmas;
