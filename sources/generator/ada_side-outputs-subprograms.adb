package body Ada_Side.Outputs.Subprograms is

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

         Profile.Group;
         Result.Append (Profile);
      else
         Result.Append (Returns.Group);
      end if;

      return Result;
   end Document;

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Declaration;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
     return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.New_Line;
      Result.Append (Self.Specification.Document (Printer, Pad));
      Result.Put (";");
      Result.Append (Print_Aspect (Self.Aspects, Printer));

      return Result;
   end Document;

   ---------------------
   -- New_Declaration --
   ---------------------

   function New_Declaration
     (Specification : not null Node_Access;
      Aspects       : Node_Access := null;
      Comment       : League.Strings.Universal_String) return Node'Class is
   begin
      return Declaration'(Specification, Aspects, Comment);
   end New_Declaration;

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

end Ada_Side.Outputs.Subprograms;
