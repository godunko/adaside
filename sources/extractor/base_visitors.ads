------------------------------------------------------------------------------
--  Base visitor interface to traverse Clang tree.
------------------------------------------------------------------------------
with clang_c_Index_h;

package Base_Visitors is

   type Traverse_Control is
    (Continue,
     --  Continues the normal depth-first traversal.

     Abandon_Children,
     --  Prevents traversal of the current element's children.

--     Abandon_Siblings,
--     --  Prevents traversal of the current element's children and remaining
--     --  siblings.

     Terminate_Immediately);
     --  Does exactly that.

   type Base_Visitor is limited interface;

   not overriding procedure Enter_Token
    (Self    : in out Base_Visitor;
     Cursor  : clang_c_Index_h.CXCursor;
     Control : in out Traverse_Control) is null;

   not overriding procedure Leave_Token
    (Self    : in out Base_Visitor;
     Cursor  : clang_c_Index_h.CXCursor;
     Control : in out Traverse_Control) is null;

end Base_Visitors;
