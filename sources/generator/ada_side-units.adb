with Ada.Wide_Wide_Text_IO;

package body Ada_Side.Units is

   use type League.Strings.Universal_String;

   -----------------------------
   -- Add_Limited_With_Clause --
   -----------------------------

   procedure Add_Limited_With_Clause
    (Self : in out Abstract_Ada_Unit'Class;
     Name : League.Strings.Universal_String)
   is
      Position : constant Context_Maps.Cursor
        := Self.Context.Records.Find (Name);

   begin
      if not Context_Maps.Has_Element (Position) then
         Self.Context.Records.Insert
          (Name,
           new Context_Record'
                (Name => Name, Is_Private => False, Is_Limited => True));
      end if;
   end Add_Limited_With_Clause;

   -----------------------------
   -- Add_Private_With_Clause --
   -----------------------------

   procedure Add_Private_With_Clause
    (Self : in out Abstract_Ada_Unit'Class;
     Name : League.Strings.Universal_String)
   is
      Position : constant Context_Maps.Cursor
        := Self.Context.Records.Find (Name);

   begin
      if not Context_Maps.Has_Element (Position) then
         Self.Context.Records.Insert
          (Name,
           new Context_Record'
                (Name => Name, Is_Private => True, Is_Limited => False));
      end if;
   end Add_Private_With_Clause;

   ---------------------
   -- Add_With_Clause --
   ---------------------

   procedure Add_With_Clause
    (Self : in out Abstract_Ada_Unit'Class;
     Name : League.Strings.Universal_String)
   is
      Position : constant Context_Maps.Cursor
        := Self.Context.Records.Find (Name);

   begin
      if not Context_Maps.Has_Element (Position) then
         Self.Context.Records.Insert
          (Name,
           new Context_Record'
                (Name => Name, Is_Private => False, Is_Limited => False));

      else
         Context_Maps.Element (Position).Is_Private := False;
      end if;
   end Add_With_Clause;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Abstract_Unit) is
   begin
      if not Self.Flushed then
         for J in 1 .. Self.Text.Length loop
            Ada.Wide_Wide_Text_IO.Put_Line (Self.Text (J).To_Wide_Wide_String);
         end loop;
      end if;

      Self.Text.Clear;
   end Finalize;

   -----------------------------------
   -- Generate_Unit_Context_Clauses --
   -----------------------------------

   function Generate_Unit_Context_Clauses
    (Self : Ada_Context) return League.String_Vectors.Universal_String_Vector
   is
      Position : Context_Maps.Cursor := Self.Records.First;
      Result   : League.String_Vectors.Universal_String_Vector;

   begin
      while Context_Maps.Has_Element (Position) loop
         declare
            Name : constant League.Strings.Universal_String
              := Context_Maps.Key (Position);
            Info : constant Context_Record_Access
              := Context_Maps.Element (Position);

         begin
            if Info.Is_Private then
               Result.Append ("private with " & Name & ";");

            elsif Info.Is_Limited then
               Result.Append ("limited with " & Name & ";");

            else
               Result.Append ("with " & Name & ";");
            end if;

            Context_Maps.Next (Position);
         end;
      end loop;

      return Result;
   end Generate_Unit_Context_Clauses;

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

   -------------------------
   -- Generated_File_Name --
   -------------------------

   overriding function Generated_File_Name
    (Self : CXX_Cpp_Unit) return League.Strings.Universal_String is
   begin
      return Self.Name.To_Lowercase & "_wrapper.cpp";
   end Generated_File_Name;

   -------------------------
   -- Generated_File_Name --
   -------------------------

   overriding function Generated_File_Name
    (Self : CXX_H_Unit) return League.Strings.Universal_String is
   begin
      return Self.Name.To_Lowercase & "_wrapper.h";
   end Generated_File_Name;

   -----------------
   -- Get_Context --
   -----------------

   not overriding function Get_Context
    (Self : Abstract_Unit)
       return League.String_Vectors.Universal_String_Vector
   is
      pragma Unreferenced (Self);

   begin
      return League.String_Vectors.Empty_Universal_String_Vector;
   end Get_Context;

   -----------------
   -- Get_Context --
   -----------------

   overriding function Get_Context
    (Self : Abstract_Ada_Unit)
       return League.String_Vectors.Universal_String_Vector is
   begin
      return Self.Context.Generate_Unit_Context_Clauses;
   end Get_Context;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out Abstract_Unit) is
   begin
      Self.Text.Append (League.Strings.Empty_Universal_String);
      Self.Flushed := True;
   end Initialize;

   --------------
   -- New_Line --
   --------------

   procedure New_Line (Self : in out Abstract_Unit'Class) is
   begin
      Self.Text.Append (League.Strings.Empty_Universal_String);
      Self.Flushed := False;
   end New_Line;

   ---------
   -- Put --
   ---------

   procedure Put
    (Self : in out Abstract_Unit'Class;
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
    (Self : in out Abstract_Unit'Class;
     Item : League.Strings.Universal_String)
   is
      Last : constant Natural := Self.Text.Length;

   begin
      Self.Text.Replace (Last, Self.Text (Last) & Item);
      Self.Text.Append (League.Strings.Empty_Universal_String);
      Self.Flushed := False;
   end Put_Line;

   ---------------
   -- Put_Lines --
   ---------------

   procedure Put_Lines
    (Self  : in out Abstract_Unit'Class;
     Lines : League.String_Vectors.Universal_String_Vector) is
   begin
      for J in 1 .. Lines.Length loop
         Self.Put_Line (Lines (J));
      end loop;
   end Put_Lines;

   ----------
   -- Save --
   ----------

   procedure Save
    (Self      : in out Abstract_Unit'Class;
     Directory : League.Strings.Universal_String)
   is
      Name : constant String
        := Directory.To_UTF_8_String
             & '/'
             & Self.Generated_File_Name.To_UTF_8_String;
      File : Ada.Wide_Wide_Text_IO.File_Type;

   begin
      Ada.Wide_Wide_Text_IO.Create
       (File, Ada.Wide_Wide_Text_IO.Out_File, Name, "wcem=8");

      declare
         Context : constant League.String_Vectors.Universal_String_Vector
           := Self.Get_Context;

      begin
         for J in 1 .. Context.Length loop
            Ada.Wide_Wide_Text_IO.Put_Line
             (File, Context (J).To_Wide_Wide_String);
         end loop;
      end;

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

   --------------------
   -- Set_Class_Name --
   --------------------

   procedure Set_Class_Name
    (Self : in out Abstract_CXX_Unit'Class;
     Name : League.Strings.Universal_String) is
   begin
      Self.Name := Name;
   end Set_Class_Name;

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
