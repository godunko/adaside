with clang_c_Index_h;

package Clang.Cursors is

   function Get_Spelling
    (Kind : clang_c_Index_h.CXCursorKind)
       return League.Strings.Universal_String;

end Clang.Cursors;
