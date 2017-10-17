
package body Clang.Files is

   --------------
   -- Get_Name --
   --------------

   function Get_Name
    (File : clang_c_Index_h.CXFile) return League.Strings.Universal_String is
   begin
      return To_Universal_String (clang_c_Index_h.clang_getFileName (File));
   end Get_Name;

end Clang.Files;
