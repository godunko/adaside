package body Ada_Side.Outputs.Joins is

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
      Next  : Node_Access := Self.Right;
      Max   : Natural := Self.Left.Max_Pad;
   begin
      while Next.all in Join loop
         Count := Count + 1;
         Max := Natural'Max (Max, Join (Next.all).Left.Max_Pad);
         Next := Join (Next.all).Right;
      end loop;

      declare
         List : Node_Access_Array (1 .. Count) := (others => Self.Left);
      begin
         Next := Self.Right;
         for J in 1 .. Count - 1 loop
            List (J) := Join (Next.all).Left;
            Next := Join (Next.all).Right;
         end loop;

         List (Count) := Next;

         return Self.Left.Join (List, Max, Printer);
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

end Ada_Side.Outputs.Joins;
