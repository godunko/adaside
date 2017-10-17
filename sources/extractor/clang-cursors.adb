
package body Clang.Cursors is

   ------------------
   -- Get_Spelling --
   ------------------

   function Get_Spelling
    (Kind : clang_c_Index_h.CXCursorKind)
       return League.Strings.Universal_String is
   begin
      return
        To_Universal_String
         (clang_c_Index_h.clang_getCursorKindSpelling (Kind));
   end Get_Spelling;

end Clang.Cursors;
