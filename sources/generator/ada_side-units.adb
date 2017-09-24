with Ada.Wide_Wide_Text_IO;

package body Ada_Side.Units is

   use type League.Strings.Universal_String;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Abstract_Ada_Unit) is
   begin
      if not Self.Flushed then
         for J in 1 .. Self.Text.Length loop
            Ada.Wide_Wide_Text_IO.Put_Line (Self.Text (J).To_Wide_Wide_String);
         end loop;
      end if;

      Self.Text.Clear;
   end Finalize;

   -------------------------
   -- Generated_File_Name --
   -------------------------

   overriding function Generated_File_Name
    (Self : Ada_Body_Unit) return League.Strings.Universal_String is
   begin
      return Self.Name.To_Lowercase.Split ('.').Join ('-') & ".adb";
   end Generated_File_Name;

   -------------------------
   -- Generated_File_Name --
   -------------------------

   overriding function Generated_File_Name
    (Self : Ada_Spec_Unit) return League.Strings.Universal_String is
   begin
      return Self.Name.To_Lowercase.Split ('.').Join ('-') & ".ads";
   end Generated_File_Name;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out Abstract_Ada_Unit) is
   begin
      Self.Text.Append (League.Strings.Empty_Universal_String);
      Self.Flushed := True;
   end Initialize;

   --------------
   -- New_Line --
   --------------

   procedure New_Line (Self : in out Abstract_Ada_Unit'Class) is
   begin
      Self.Text.Append (League.Strings.Empty_Universal_String);
      Self.Flushed := False;
   end New_Line;

   ---------
   -- Put --
   ---------

   procedure Put
    (Self : in out Abstract_Ada_Unit'Class;
     Item : League.Strings.Universal_String)
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
    (Self : in out Abstract_Ada_Unit'Class;
     Item : League.Strings.Universal_String)
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
    (Self      : in out Abstract_Ada_Unit'Class;
     Directory : League.Strings.Universal_String)
   is
      Name : constant String
        := Directory.To_UTF_8_String
             & '/'
             & Self.Generated_File_Name.To_UTF_8_String;
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
    (Self : in out Abstract_Ada_Unit'Class;
     Name : League.Strings.Universal_String) is
   begin
      Self.Name := Name;
   end Set_Package_Name;

end Ada_Side.Units;
