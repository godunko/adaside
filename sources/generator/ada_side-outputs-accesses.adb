package body Ada_Side.Outputs.Accesses is

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Access_Definition;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.Put ("access ");
      if Self.Is_All then
         Result.Put ("all ");
      end if;

      Result.Append (Self.Target.Document (Printer, Pad));

      return Result;
   end Document;

   ----------------
   -- New_Access --
   ----------------

   function New_Access
     (Is_All : Boolean;
      Target : not null Node_Access) return Node'Class is
   begin
      return Access_Definition'(Is_All, Target);
   end New_Access;

end Ada_Side.Outputs.Accesses;
