package body Ada_Side.Outputs.Variables is

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Variable;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;
      Result.Append (Self.Name.Document (Printer, Pad));
      Result.Put (" :");

      if Self.Is_Constant then
         Result.Put (" constant");
      end if;

      if Self.Is_Aliased then
         Result.Put (" aliased");
      end if;

      if Self.Type_Definition /= null then
         Result.Put (" ");
         Result.Append (Self.Type_Definition.Document (Printer, 0));
      end if;

      if Self.Initialization /= null then
         Result.Put (" := ");
         Result.Append (Self.Initialization.Document (Printer, 0));
      end if;

      Result.Append (Print_Aspect (Self.Aspects, Printer));
      Result.Put (";");

      return Result;
   end Document;

   ------------------
   -- New_Variable --
   ------------------

   function New_Variable
     (Name            : not null Node_Access;
      Type_Definition : Node_Access;
      Initialization  : Node_Access;
      Is_Constant     : Boolean;
      Is_Aliased      : Boolean;
      Aspects         : Node_Access;
      Comment         : League.Strings.Universal_String) return Node'Class is
   begin
      return Variable'
        (Name,
         Type_Definition,
         Initialization,
         Is_Constant,
         Is_Aliased,
         Aspects,
         Comment);
   end New_Variable;

end Ada_Side.Outputs.Variables;
