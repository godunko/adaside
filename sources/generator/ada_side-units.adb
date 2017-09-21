with Ada.Wide_Wide_Text_IO;

package body Ada_Side.Units is

   use type League.Strings.Universal_String;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Ada_Spec_Unit) is
   begin
      if not Self.Flushed then
         for J in 1 .. Self.Text.Length loop
            Ada.Wide_Wide_Text_IO.Put_Line (Self.Text (J).To_Wide_Wide_String);
         end loop;
      end if;

      Self.Text.Clear;
   end Finalize;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out Ada_Spec_Unit) is
   begin
      Self.Text.Append (League.Strings.Empty_Universal_String);
      Self.Flushed := True;
   end Initialize;

   ---------
   -- Put --
   ---------

   procedure Put
    (Self : in out Ada_Spec_Unit; Item : League.Strings.Universal_String)
   is
      Last : constant Natural := Self.Text.Length;

   begin
      Self.Text.Replace (Last, Self.Text (Last) & Item);
      Self.Flushed := False;
   end Put;

   --------------
   -- Put_Line --
   --------------

   procedure Put_Line
    (Self : in out Ada_Spec_Unit; Item : League.Strings.Universal_String)
   is
      Last : constant Natural := Self.Text.Length;

   begin
      Self.Text.Replace (Last, Self.Text (Last) & Item);
      Self.Text.Append (League.Strings.Empty_Universal_String);
      Self.Flushed := False;
   end Put_Line;

end Ada_Side.Units;
