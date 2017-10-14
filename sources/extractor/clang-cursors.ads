with League.Strings;

with clang_c_Index_h;

package Clang.Cursors is

   function Get_Spelling
    (Cursor : clang_c_Index_h.CXCursor) return League.Strings.Universal_String;

   function Get_Spelling
    (Kind : clang_c_Index_h.CXCursorKind)
       return League.Strings.Universal_String;

end Clang.Cursors;
