package body Ada_Side.Outputs.Aspects is

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Aspect;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.Append (Self.Name.Document (Printer, Pad));

      if Self.Value /= null then
         Result.Put (" => ");
         Result.Append (Self.Value.Document (Printer, 0));
      end if;

      return Result;
   end Document;

   ----------
   -- Join --
   ----------

   overriding function Join
    (Self    : Aspect;
     List    : Node_Access_Array;
     Pad     : Natural;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.Append (Self.Document (Printer, Pad));

      for J in List'Range loop
         Result.Put (",");
         Result.New_Line;
         Result.Put ("     ");
         Result.Append (List (J).Document (Printer, Pad));
      end loop;

      return Result;
   end Join;

   ----------------
   -- New_Aspect --
   ----------------

   function New_Aspect
     (Name  : not null Node_Access;
      Value : Node_Access) return Node'Class is
   begin
      return Aspect'(Name, Value);
   end New_Aspect;

end Ada_Side.Outputs.Aspects;
