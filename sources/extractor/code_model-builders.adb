with League.Strings;

with Clang.Cursors;

with Code_Model.Classes;
with Code_Model.Namespaces;

package body Code_Model.Builders is

   use type Ada.Text_IO.Count;

   procedure Enter_Class_Declaration
    (Self    : in out Code_Model_Builder'Class;
     Cursor  : clang_c_Index_h.CXCursor;
     Control : in out Base_Visitors.Traverse_Control);

   procedure Enter_Namespace
    (Self    : in out Code_Model_Builder'Class;
     Cursor  : clang_c_Index_h.CXCursor;
     Control : in out Base_Visitors.Traverse_Control);

   procedure Push_Namespace
    (Self  : in out Code_Model_Builder'Class;
     Scope : not null Code_Model.Namespace_Access);

   procedure Push_Class
    (Self  : in out Code_Model_Builder'Class;
     Scope : not null Code_Model.Class_Access);

   procedure Pop (Self : in out Code_Model_Builder'Class);

   -----------------------------
   -- Enter_Class_Declaration --
   -----------------------------

   procedure Enter_Class_Declaration
    (Self    : in out Code_Model_Builder'Class;
     Cursor  : clang_c_Index_h.CXCursor;
     Control : in out Base_Visitors.Traverse_Control)
   is
      Name  : constant League.Strings.Universal_String
        := Clang.Cursors.Get_Spelling (Cursor);
      Class : Code_Model.Class_Access := Self.State.Scope.Lookup_Class (Name);

   begin
      if Class = null then
         Ada.Text_IO.Put_Line ("New class!!!!");

         Class :=
           new Code_Model.Classes.Class'
                (Name       => Name,
                 Classes    => <>);
         Self.State.Scope.Classes.Append (Class);

      else
         Ada.Text_IO.Put_Line ("Reuse class!!!!");
      end if;

      Control := Base_Visitors.Continue;
      Ada.Text_IO.Put_Line
       (Clang.Cursors.Get_Spelling (Cursor.kind).To_UTF_8_String
          & " '"
          & Clang.Cursors.Get_Spelling (Cursor).To_UTF_8_String
          & ''');
      Self.Push_Class (Class);
   end Enter_Class_Declaration;

   ---------------------
   -- Enter_Namespace --
   ---------------------

   procedure Enter_Namespace
    (Self    : in out Code_Model_Builder'Class;
     Cursor  : clang_c_Index_h.CXCursor;
     Control : in out Base_Visitors.Traverse_Control)
   is
      Name  : constant League.Strings.Universal_String
        := Clang.Cursors.Get_Spelling (Cursor);
      Namespace : Code_Model.Namespace_Access
        := Code_Model.Namespace_Access
            (Self.State.Scope).Lookup_Namespace (Name);

   begin
      if Namespace = null then
         Ada.Text_IO.Put_Line ("New namespace!!!!");

         Namespace :=
           new Code_Model.Namespaces.Namespace'
                (Name       => Name,
                 Classes    => <>,
                 Namespaces => <>);
         Code_Model.Namespace_Access
          (Self.State.Scope).Namespaces.Append (Namespace);

      else
         Ada.Text_IO.Put_Line ("Reuse namespace!!!!");
      end if;

      Control := Base_Visitors.Continue;
      Ada.Text_IO.Put_Line
       (Clang.Cursors.Get_Spelling (Cursor.kind).To_UTF_8_String
          & " '"
          & Clang.Cursors.Get_Spelling (Cursor).To_UTF_8_String
          & ''');
      Self.Push_Namespace (Namespace);
   end Enter_Namespace;

   -----------------
   -- Enter_Token --
   -----------------

   overriding procedure Enter_Token
    (Self    : in out Code_Model_Builder;
     Cursor  : clang_c_Index_h.CXCursor;
     Control : in out Base_Visitors.Traverse_Control)
   is
--      use all type clang_c_Index_h.CXCursorKind;
--      pragma Unreferenced (Cursor, Control);
--      pragma Unreferenced (Control);

   begin
      Control := Base_Visitors.Abandon_Children;

      Ada.Text_IO.Set_Col (Self.Indent);
      Self.Indent := Self.Indent + 1;

      case Cursor.kind is
         when clang_c_Index_h.CXCursor_Namespace =>
            Self.Enter_Namespace (Cursor, Control);

         when clang_c_Index_h.CXCursor_ClassDecl =>
            Self.Enter_Class_Declaration (Cursor, Control);
--            Control := Base_Visitors.Continue;
--            Ada.Text_IO.Put_Line
--             (Clang.Cursors.Get_Spelling (Cursor.kind).To_UTF_8_String
--                & " '"
--                & Clang.Cursors.Get_Spelling (Cursor).To_UTF_8_String
--                & ''');

         when others =>
--            Ada.Text_IO.Put_Line
--             (clang_c_Index_h.CXCursorKind'Image (Cursor.kind));
--            Ada.Text_IO.Put_Line
--             (Clang.Cursors.Get_Spelling (Cursor.kind).To_UTF_8_String);
            Ada.Text_IO.Put_Line
             (Clang.Cursors.Get_Spelling (Cursor.kind).To_UTF_8_String
                & " '"
                & Clang.Cursors.Get_Spelling (Cursor).To_UTF_8_String
                & ''');
      end case;
   end Enter_Token;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out Code_Model_Builder'Class) is
   begin
      Self.State.Scope :=
        new Code_Model.Namespaces.Namespace'
             (Name       => <>,
              Classes    => <>,
              Namespaces => <>);
   end Initialize;

   -----------------
   -- Leave_Token --
   -----------------

   overriding procedure Leave_Token
    (Self    : in out Code_Model_Builder;
     Cursor  : clang_c_Index_h.CXCursor;
     Control : in out Base_Visitors.Traverse_Control)
   is
      pragma Unreferenced (Control);

   begin
      Self.Indent := Self.Indent - 1;

      case Cursor.kind is
         when clang_c_Index_h.CXCursor_Namespace =>
            Self.Pop;
--            Self.Enter_Namespace (Cursor, Control);

         when clang_c_Index_h.CXCursor_ClassDecl =>
            Self.Pop;
--            Control := Base_Visitors.Continue;
--            Ada.Text_IO.Put_Line
--             (Clang.Cursors.Get_Spelling (Cursor.kind).To_UTF_8_String
--                & " '"
--                & Clang.Cursors.Get_Spelling (Cursor).To_UTF_8_String
--                & ''');

         when others =>
            null;
--            Ada.Text_IO.Put_Line
--             (clang_c_Index_h.CXCursorKind'Image (Cursor.kind));
--            Ada.Text_IO.Put_Line
--             (Clang.Cursors.Get_Spelling (Cursor.kind).To_UTF_8_String);
--            Ada.Text_IO.Put_Line
--             (Clang.Cursors.Get_Spelling (Cursor.kind).To_UTF_8_String
--                & " '"
--                & Clang.Cursors.Get_Spelling (Cursor).To_UTF_8_String
--                & ''');
      end case;
   end Leave_Token;

   ---------
   -- Pop --
   ---------

   procedure Pop (Self : in out Code_Model_Builder'Class) is
   begin
      Self.State := Self.Stack.Last_Element;
      Self.Stack.Delete_Last;
   end Pop;

   ----------------
   -- Push_Class --
   ----------------

   procedure Push_Class
    (Self  : in out Code_Model_Builder'Class;
     Scope : not null Code_Model.Class_Access) is
   begin
      Self.Stack.Append (Self.State);
      Self.State :=
       (Kind  => Class,
        Scope => Code_Model.Scope_Access (Scope));
   end Push_Class;

   --------------------
   -- Push_Namespace --
   --------------------

   procedure Push_Namespace
    (Self  : in out Code_Model_Builder'Class;
     Scope : not null Code_Model.Namespace_Access) is
   begin
      Self.Stack.Append (Self.State);
      Self.State :=
       (Kind  => Namespace,
        Scope => Code_Model.Scope_Access (Scope));
   end Push_Namespace;

end Code_Model.Builders;
