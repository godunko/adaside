------------------------------------------------------------------------------
--  Utilities to simplify code to use Clang C API.
------------------------------------------------------------------------------
with clang_c_Index_h;

with Base_Visitors;

package Clang_Utilities is

   procedure Visit_Children
    (Cursor  : clang_c_Index_h.CXCursor;
     Visitor : in out Base_Visitors.Base_Visitor'Class);

end Clang_Utilities;
