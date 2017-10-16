with League.Strings;

private with clang_c_CXString_h;
with clang_c_Index_h;

package Clang.Cursors is

   function Get_Spelling
    (Kind : clang_c_Index_h.CXCursorKind)
       return League.Strings.Universal_String;

private

   function To_Universal_String
    (Item : clang_c_CXString_h.CXString)
       return League.Strings.Universal_String;
   --  Converts CXString to Universal_String and release CXString object.

end Clang.Cursors;
