with League.Strings;

with clang_c_Index_h;

package Clang.Files is

   function Get_Name
    (File : clang_c_Index_h.CXFile) return League.Strings.Universal_String;
   --  Wrapper for clang_getFileName().

end Clang.Files;
