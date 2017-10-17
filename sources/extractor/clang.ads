with League.Strings;

private with clang_c_CXString_h;

package Clang is

private

   function To_Universal_String
    (Item : clang_c_CXString_h.CXString)
       return League.Strings.Universal_String;
   --  Converts CXString to Universal_String and release CXString object.

end Clang;
