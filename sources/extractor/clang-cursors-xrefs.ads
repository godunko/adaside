with League.Strings;

with clang_c_Index_h;

package Clang.Cursors.Xrefs is

   function Get_Spelling
    (Cursor : clang_c_Index_h.CXCursor) return League.Strings.Universal_String;
   --  Wrapper for clang_getCursorSpelling()

   function Is_Definition (Cursor : clang_c_Index_h.CXCursor) return Boolean;
   --  Wrapper for clang_isCursorDefinition()

end Clang.Cursors.Xrefs;
