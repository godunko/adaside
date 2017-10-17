with Interfaces.C.Strings;

package body Clang.Translation_Units is

   ----------
   -- Save --
   ----------

   function Save
    (Unit      : clang_c_Index_h.CXTranslationUnit;
     File_Name : League.Strings.Universal_String)
       return clang_c_Index_h.CXSaveError
   is
      C_File_Name : Interfaces.C.Strings.chars_ptr
        := Interfaces.C.Strings.New_String (File_Name.To_UTF_8_String);

   begin
      return Result : constant clang_c_Index_h.CXSaveError
        := clang_c_Index_h.CXSaveError'Val
            (clang_c_Index_h.clang_saveTranslationUnit
              (Unit,
               C_File_Name,
               clang_c_Index_h.clang_defaultSaveOptions (Unit)))
      do
         Interfaces.C.Strings.Free (C_File_Name);
      end return;
   end Save;

end Clang.Translation_Units;
