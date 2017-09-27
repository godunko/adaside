package body Ada_Side.Outputs.Clauses is

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

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Pragma_Node;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;
      Result.Put ("pragma ");
      Result.Append (Self.Name.Document (Printer, 0));

      if Self.Arguments /= null then
         Result.Put (" (");
         Result.Append (Self.Arguments.Document (Printer, Pad));
         Result.Put (")");
      end if;

      Result.Put (";");

      return Result;
   end Document;

   --------------
   -- Document --
   --------------

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

   ----------------
   -- New_Pragma --
   ----------------

   function New_Pragma
     (Name      : not null Node_Access;
      Arguments : Node_Access) return Node'Class is
   begin
      return Pragma_Node'(Name, Arguments);
   end New_Pragma;

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

end Ada_Side.Outputs.Clauses;
