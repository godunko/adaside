package body Ada_Outputs.Joins is

   --------------
   -- Document --
   --------------

   overriding function Document
    (Self    : Join;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document
   is
      pragma Unreferenced (Pad);
      Count : Positive := 1;
      Next  : Node_Access := Self.Left;
      Max   : Natural := Self.Right.Max_Pad;
   begin
      while Next.all in Join loop
         Count := Count + 1;
         Max := Natural'Max (Max, Join (Next.all).Right.Max_Pad);
         Next := Join (Next.all).Left;
      end loop;

      Max := Natural'Max (Max, Next.Max_Pad);

      declare
         List : Node_Access_Array (1 .. Count) := (others => Self.Right);
      begin
         List (Count) := Self.Right;
         Next := Self.Left;
         for J in reverse 1 .. Count - 1 loop
            List (J) := Join (Next.all).Right;
            Next := Join (Next.all).Left;
         end loop;

         return Next.Join (List, Max, Printer);
      end;
   end Document;

   --------------
   -- New_Join --
   --------------

   function New_Join
     (Left  : not null Node_Access;
      Right : not null Node_Access) return Node'Class is
   begin
      return Join'(Left, Right);
   end New_Join;

end Ada_Outputs.Joins;
