with Interfaces.C.Strings;

package body Clang.Cursors is

--   function Get_CString
--    (Item : clang_c_CXString_h.CXString)
--       return League.Strings.Universal_String;
--
--   -----------------
--   -- Get_CString --
--   -----------------
--
--   function Get_CString
--    (Item : clang_c_CXString_h.CXString)
--       return League.Strings.Universal_String is
--   begin
--      return
--        League.Strings.From_UTF_8_String
--         (Interfaces.C.Strings.Value
--           (clang_c_CXString_h.clang_getCString (Item)));
--   end Get_CString;

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

   -------------------------
   -- To_Universal_String --
   -------------------------

   function To_Universal_String
    (Item : clang_c_CXString_h.CXString)
       return League.Strings.Universal_String is
   begin
      return Result : constant League.Strings.Universal_String
        := League.Strings.From_UTF_8_String
            (Interfaces.C.Strings.Value
              (clang_c_CXString_h.clang_getCString (Item)))
      do
         clang_c_CXString_h.clang_disposeString (Item);
      end return;
   end To_Universal_String;

end Clang.Cursors;
