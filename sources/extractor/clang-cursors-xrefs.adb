
package body Clang.Cursors.Xrefs is

   ------------------
   -- Get_Spelling --
   ------------------

   function Get_Spelling
    (Cursor : clang_c_Index_h.CXCursor)
       return League.Strings.Universal_String is
   begin
      return
        To_Universal_String (clang_c_Index_h.clang_getCursorSpelling (Cursor));
   end Get_Spelling;

end Clang.Cursors.Xrefs;
