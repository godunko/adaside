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

   --------------
   -- New_Line --
   --------------

   procedure New_Line (Self : in out Ada_Spec_Unit) is
   begin
      Self.Text.Append (League.Strings.Empty_Universal_String);
      Self.Flushed := False;
   end New_Line;

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

   ----------
   -- Save --
   ----------

   procedure Save
    (Self      : in out Ada_Spec_Unit;
     Directory : League.Strings.Universal_String)
   is
      Name : constant String
        := Directory.To_UTF_8_String
             & '/'
             & Self.Name.To_Lowercase.Split ('.').Join ('-').To_UTF_8_String
             & (if Self.Is_Body then ".adb" else ".ads");
      File : Ada.Wide_Wide_Text_IO.File_Type;

   begin
      if Self.Name.Is_Empty then
         raise Program_Error;
      end if;

      Ada.Wide_Wide_Text_IO.Create
       (File, Ada.Wide_Wide_Text_IO.Out_File, Name, "wcem=8");

      for J in 1 .. Self.Text.Length loop
         if J /= Self.Text.Length
           or else not Self.Text (J).Is_Empty
         then
            Ada.Wide_Wide_Text_IO.Put_Line
             (File, Self.Text (J).To_Wide_Wide_String);
         end if;
      end loop;

      Ada.Wide_Wide_Text_IO.Close (File);

      Self.Flushed := True;
   end Save;

   ----------------------
   -- Set_Package_Name --
   ----------------------

   procedure Set_Package_Name
    (Self    : in out Ada_Spec_Unit;
     Name    : League.Strings.Universal_String;
     Is_Body : Boolean) is
   begin
      Self.Name    := Name;
      Self.Is_Body := Is_Body;
   end Set_Package_Name;

end Ada_Side.Units;
