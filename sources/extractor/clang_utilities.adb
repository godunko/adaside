with Interfaces.C.Strings;
with System.Address_To_Access_Conversions;

package body Clang_Utilities is

   package Visitor_Conversions is
     new System.Address_To_Access_Conversions
          (Base_Visitors.Base_Visitor'Class);

   function Visitor_Callback
    (Cursor : clang_c_Index_h.CXCursor;
     Parent : clang_c_Index_h.CXCursor;
     Data   : clang_c_Index_h.CXClientData)
       return clang_c_Index_h.CXChildVisitResult
         with Convention => C;

   ----------------------------
   -- Parse_Translation_Unit --
   ----------------------------

   function Parse_Translation_Unit
    (Index                  : clang_c_Index_h.CXIndex;
     Source_Filename        : League.Strings.Universal_String;
     Command_Line_Arguments : League.String_Vectors.Universal_String_Vector;
     Options                : Interfaces.C.unsigned;
     Translation_Unit       : out clang_c_Index_h.CXTranslationUnit)
       return clang_c_CXErrorCode_h.CXErrorCode
   is
      File_Name : Interfaces.C.Strings.chars_ptr
        := Interfaces.C.Strings.New_String (Source_Filename.To_UTF_8_String);
      Arguments :
        array (1 .. Command_Line_Arguments.Length)
          of Interfaces.C.Strings.chars_ptr with Convention => C;
      Result    : clang_c_CXErrorCode_h.CXErrorCode;

   begin
      for J in 1 .. Command_Line_Arguments.Length loop
         Arguments (J) :=
           Interfaces.C.Strings.New_String
            (Command_Line_Arguments.Element (J).To_UTF_8_String);
      end loop;

      Result :=
        clang_c_Index_h.clang_parseTranslationUnit2
         (Index,
          File_Name,
          (if Arguments'Length = 0
             then System.Null_Address
             else Arguments (Arguments'First)'Address),
          Arguments'Length,
          null,
          0,
          Options,
          Translation_Unit'Address);

      for J in Arguments'Range loop
         Interfaces.C.Strings.Free (Arguments (J));
      end loop;

      Interfaces.C.Strings.Free (File_Name);

      return Result;
   end Parse_Translation_Unit;

   --------------------
   -- Visit_Children --
   --------------------

   procedure Visit_Children
    (Cursor  : clang_c_Index_h.CXCursor;
     Visitor : in out Base_Visitors.Base_Visitor'Class)
   is
      Dummy : Interfaces.C.unsigned;

   begin
      Dummy :=
        clang_c_Index_h.clang_visitChildren
         (Cursor,
          Visitor_Callback'Access,
          clang_c_Index_h.CXClientData
           (Visitor_Conversions.To_Address (Visitor'Unchecked_Access)));
   end Visit_Children;

   ----------------------
   -- Visitor_Callback --
   ----------------------

   function Visitor_Callback
    (Cursor : clang_c_Index_h.CXCursor;
     Parent : clang_c_Index_h.CXCursor;
     Data   : clang_c_Index_h.CXClientData)
       return clang_c_Index_h.CXChildVisitResult
   is
      pragma Unreferenced (Parent);

      use type Base_Visitors.Traverse_Control;
      use type Interfaces.C.unsigned;

      Visitor : constant Visitor_Conversions.Object_Pointer
        := Visitor_Conversions.To_Pointer (System.Address (Data));
      Control : Base_Visitors.Traverse_Control := Base_Visitors.Continue;
      Dummy   : Interfaces.C.unsigned;

   begin
      Visitor.Enter_Token (Cursor, Control);

      if Control = Base_Visitors.Continue then
         if clang_c_Index_h.clang_visitChildren
             (Cursor, Visitor_Callback'Access, Data) /= 0
         then
            Control := Base_Visitors.Terminate_Immediately;
         end if;
      end if;

      if Control = Base_Visitors.Terminate_Immediately then
         return clang_c_Index_h.CXChildVisit_Break;
      end if;

      Visitor.Leave_Token (Cursor, Control);

      if Control = Base_Visitors.Terminate_Immediately then
         return clang_c_Index_h.CXChildVisit_Break;

      else
         return clang_c_Index_h.CXChildVisit_Continue;
      end if;
   end Visitor_Callback;

end Clang_Utilities;
