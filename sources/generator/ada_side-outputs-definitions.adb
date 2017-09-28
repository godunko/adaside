package body Ada_Side.Outputs.Definitions is

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

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Derived;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.Put ("new ");
      Result.Append (Self.Parent.Document (Printer, Pad));

      return Result;
   end Document;

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Null_Exclusion;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      if Self.Exclude then
         Result.Put ("not ");
      end if;

      Result.Put ("null ");
      Result.Append (Self.Definition.Document (Printer, Pad));
      return Result;
   end Document;

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

   --------------
   -- Document --
   --------------

   overriding function Document
     (Self    : Subprogram;
      Printer : not null access League.Pretty_Printers.Printer'Class;
      Pad     : Natural)
       return League.Pretty_Printers.Document
   is
      Result  : League.Pretty_Printers.Document := Printer.New_Document;
      Profile : League.Pretty_Printers.Document := Printer.New_Document;
      Returns : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      if Self.Is_Overriding then
         Result.Put ("overriding ");
      end if;

      if Self.Result = null then
         Result.Put ("procedure ");
      else
         Result.Put ("function ");

         Returns.New_Line;
         Returns.Put ("return ");
         Returns.Append (Self.Result.Document (Printer, Pad).Nest (2));
         Returns.Nest (2);
      end if;

      if Self.Name /= null then
         Result.Append (Self.Name.Document (Printer, Pad));
      end if;

      if Self.Parameters /= null then
         Profile.New_Line;
         Profile.Put ("(");
         Profile.Append (Self.Parameters.Document (Printer, Pad).Nest (1));
         Profile.Put (")");

         if Self.Result /= null then
            Profile.Append (Returns);
         end if;

         Profile.Nest (1);
         Profile.Group;
         Result.Append (Profile);
      else
         Result.Append (Returns.Group);
      end if;

      return Result;
   end Document;

   ----------
   -- Name --
   ----------

   function Name (Self : Subprogram) return Node_Access is
   begin
      return Self.Name;
   end Name;

   ----------------
   -- New_Access --
   ----------------

   function New_Access
     (Is_All : Boolean;
      Target : not null Node_Access) return Node'Class is
   begin
      return Access_Definition'(Is_All, Target);
   end New_Access;

   -----------------
   -- New_Derived --
   -----------------

   function New_Derived (Parent : not null Node_Access) return Node'Class is
   begin
      return Derived'(Parent => Parent);
   end New_Derived;

   ------------------------
   -- New_Null_Exclusion --
   ------------------------

   function New_Null_Exclusion
     (Definition : not null Node_Access;
      Exclude    : Boolean) return Node'Class is
   begin
      return Null_Exclusion'(Definition, Exclude);
   end New_Null_Exclusion;

   ------------------------
   -- New_Private_Record --
   ------------------------

   function New_Private_Record (Is_Tagged : Boolean) return Node'Class is
   begin
      return Private_Record'(Is_Tagged => Is_Tagged);
   end New_Private_Record;

   ----------------
   -- New_Record --
   ----------------

   function New_Record
     (Parent       : Node_Access := null;
      Components   : Node_Access) return Node'Class is
   begin
      return Record_Definition'(Parent, Components);
   end New_Record;

   --------------------
   -- New_Subprogram --
   --------------------

   function New_Subprogram
     (Is_Overriding : Boolean;
      Name          : Node_Access;
      Parameters    : Node_Access;
      Result        : Node_Access) return Node'Class is
   begin
      return Subprogram'(Is_Overriding, Name, Parameters, Result);
   end New_Subprogram;

end Ada_Side.Outputs.Definitions;
