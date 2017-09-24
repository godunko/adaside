package body Ada_Side.Outputs.With_Clauses is

   overriding function Document
    (Self    : Use_Clause;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;

      Result.Put ("use ");

      if Self.Use_Type then
         Result.Put ("type ");
      end if;

      Result.Append (Self.Name.Document (Printer, Pad));
      Result.Put (";");
      return Result;
   end Document;

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : With_Clause;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;

      if Self.Is_Limited then
         Result.Put ("limited ");
      end if;

      if Self.Is_Private then
         Result.Put ("private ");
      end if;

      Result.Put ("with ");
      Result.Append (Self.Name.Document (Printer, Pad));
      Result.Put (";");
      return Result;
   end Document;

   -------------
   -- New_Use --
   -------------

   function New_Use
     (Name     : not null Node_Access;
      Use_Type : Boolean) return Node'Class is
   begin
      return Use_Clause'(Name, Use_Type);
   end New_Use;

   --------------
   -- New_With --
   --------------

   function New_With
     (Name : not null Node_Access;
      Is_Limited : Boolean;
      Is_Private : Boolean) return Node'Class is
   begin
      return With_Clause'(Name, Is_Limited, Is_Private);
   end New_With;

end Ada_Side.Outputs.With_Clauses;
