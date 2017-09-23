package body Ada_Side.Outputs.Records is

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Record_Definition;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      if Self.Parent /= null then
         Result.Put ("new ");
         Result.Append (Self.Parent.Document (Printer, 0));
         Result.Put (" with ");
      end if;

      if Self.Components = null then
         Result.Put ("null record");
      else
         Result.Put ("record");
         Result.Append (Self.Components.Document (Printer, Pad).Nest (3));
         Result.New_Line;
         Result.Put ("end record");
      end if;

      return Result;
   end Document;

   ----------------
   -- New_Record --
   ----------------

   function New_Record
     (Parent       : Node_Access := null;
      Components   : Node_Access) return Node'Class is
   begin
      return Record_Definition'(Parent, Components);
   end New_Record;

end Ada_Side.Outputs.Records;
