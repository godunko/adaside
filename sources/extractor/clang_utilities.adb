with Interfaces.C;
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
