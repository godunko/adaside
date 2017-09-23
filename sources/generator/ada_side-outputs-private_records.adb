package body Ada_Side.Outputs.Private_Records is

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self    : Private_Record;
      Printer : not null access League.Pretty_Printers.Printer'Class;
      Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      pragma Unreferenced (Pad);
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      if Self.Is_Tagged then
         Result.Put ("tagged ");
      end if;

      Result.Put ("private");
      return Result;
   end Document;

   ------------------------
   -- New_Private_Record --
   ------------------------

   function New_Private_Record (Is_Tagged : Boolean) return Node'Class is
   begin
      return Private_Record'(Is_Tagged => Is_Tagged);
   end New_Private_Record;

end Ada_Side.Outputs.Private_Records;
