package body Ada_Side.Outputs.Applies is

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self    : Apply;
      Printer : not null access League.Pretty_Printers.Printer'Class;
      Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      --  Format thi as
      --  Prefix
      --    (Arguments)
      pragma Unreferenced (Pad);
      Prefix : League.Pretty_Printers.Document :=
        Self.Prefix.Document (Printer, 0);
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;
      Result.Put ("(");
      Result.Append (Self.Arguments.Document (Printer, 0));
      Result.Put (")");
      Result.Nest (2);
      Prefix.Append (Result);
      Prefix.Group;

      return Prefix;
   end Document;

   ---------------
   -- New_Apply --
   ---------------

   function New_Apply
     (Prefix    : not null Node_Access;
      Arguments : not null Node_Access) return Node'Class is
   begin
      return Apply'(Prefix, Arguments);
   end New_Apply;

end Ada_Side.Outputs.Applies;
