with Interfaces.C;

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

   -------------------
   -- Is_Definition --
   -------------------

   function Is_Definition (Cursor : clang_c_Index_h.CXCursor) return Boolean is
      use type Interfaces.C.unsigned;

   begin
      return clang_c_Index_h.clang_isCursorDefinition (Cursor) /= 0;
   end Is_Definition;

end Clang.Cursors.Xrefs;
