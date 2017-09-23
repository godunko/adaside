package body Ada_Side.Outputs.Parameters is

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self    : Parameter;
      Printer : not null access League.Pretty_Printers.Printer'Class;
      Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.Append (Self.Name.Document (Printer, Pad));
      Result.Put (" :");

      if Self.Is_In then
         Result.Put (" in");
      end if;

      if Self.Is_Out then
         Result.Put (" out");
      end if;

      if Self.Is_Aliased then
         Result.Put (" aliased");
      end if;

      Result.Put (" ");
      Result.Append (Self.Type_Definition.Document (Printer, 0).Nest (2));

      if Self.Initialization /= null then
         Result.Put (" := ");
         Result.Append (Self.Initialization.Document (Printer, 0));
      end if;

      return Result;
   end Document;

   -------------------
   -- New_Parameter --
   -------------------

   function New_Parameter
     (Name            : not null Node_Access;
      Type_Definition : Node_Access;
      Initialization  : Node_Access;
      Is_In           : Boolean;
      Is_Out          : Boolean;
      Is_Aliased      : Boolean;
      Comment         : League.Strings.Universal_String) return Node'Class is
   begin
      return Parameter'(Name,
                        Type_Definition,
                        Initialization,
                        Is_In,
                        Is_Out,
                        Is_Aliased,
                        Comment);
   end New_Parameter;

end Ada_Side.Outputs.Parameters;
