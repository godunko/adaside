with League.Strings;

with clang_c_Index_h;

package Clang.Translation_Units is

   function Save
    (Unit      : clang_c_Index_h.CXTranslationUnit;
     File_Name : League.Strings.Universal_String)
       return clang_c_Index_h.CXSaveError;
   --  wrapper of clang_saveTranslationUnit(), clang_defaultSaveOptions() is
   --  used to obtain save options.

end Clang.Translation_Units;
