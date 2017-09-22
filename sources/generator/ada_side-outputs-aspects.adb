package body Ada_Side.Outputs.Aspects is

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self : Aspect;
      Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.Append (Self.Name.Document (Printer));

      if Self.Value /= null then
         Result.Put (" => ");
         Result.Append (Self.Value.Document (Printer));
      end if;

      return Result;
   end Document;

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
