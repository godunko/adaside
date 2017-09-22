package body Ada_Side.Outputs.Selected_Names is

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self : Selected_Name;
      Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document
   is
      --  Format this as
      --  Prefix
      --    .Selector
      Result : League.Pretty_Printers.Document := Printer.New_Document;
      Prefix : League.Pretty_Printers.Document :=
        Self.Prefix.Document (Printer);
      Selector : constant League.Pretty_Printers.Document :=
        Self.Selector.Document (Printer);
   begin
      Result.New_Line (Gap => "");
      Result.Put (".");
      Result.Append (Selector);
      Result.Nest (2);
      Result.Group;
      Prefix.Append (Result);
      return Prefix;
   end Document;

   -----------------------
   -- New_Selected_Name --
   -----------------------

   function New_Selected_Name
     (Prefix   : not null Node_Access;
      Selector : not null Node_Access) return Node'Class is
   begin
      return Selected_Name'(Prefix, Selector);
   end New_Selected_Name;

end Ada_Side.Outputs.Selected_Names;
