package body Ada_Side.Outputs.Packages is

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Package_Spec;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
      Content : League.Pretty_Printers.Document := Printer.New_Document;
      Name : constant League.Pretty_Printers.Document :=
        Self.Name.Document (Printer, Pad);
   begin
      Result.New_Line;
      Result.Put ("package ");
      Result.Append (Name);
      Result.Put (" is");

      if not Self.Comment.Is_Empty or Self.Public_Part /= null then
         Content := Printer.New_Document;
         Content.New_Line;

         if not Self.Comment.Is_Empty then
            Content.Put ("--  ");
            Content.Put (Self.Comment);
         end if;

         if Self.Public_Part /= null then
            Content.Append (Self.Public_Part.Document (Printer, Pad));
         end if;

         Content.Nest (3);

         Result.Append (Content);
      end if;

      if Self.Private_Part /= null then
         Content := Printer.New_Document;
         Content.Append (Self.Private_Part.Document (Printer, Pad));
         Content.Nest (3);

         Result.New_Line;
         Result.Put_Line ("private");
         Result.Append (Content);
      end if;

      Result.New_Line;
      Result.Put ("end ");
      Result.Append (Name);
      Result.Put (";");

      return Result;
   end Document;

   -----------------
   -- New_Package --
   -----------------

   function New_Package
     (Name         : not null Node_Access;
      Public_Part  : Node_Access;
      Private_Part : Node_Access;
      Comment      : League.Strings.Universal_String)
      return Node'Class is
   begin
      return Package_Spec'(Name, Public_Part, Private_Part, Comment);
   end New_Package;

end Ada_Side.Outputs.Packages;
