with League.Strings;

with clang_c_CXErrorCode_h;
with clang_c_Index_h;

package Clang.Translation_Units is

   function Save
    (Unit          : clang_c_Index_h.CXTranslationUnit;
     AST_File_Name : League.Strings.Universal_String)
       return clang_c_Index_h.CXSaveError;
   --  Wrapper of clang_saveTranslationUnit(), clang_defaultSaveOptions() is
   --  used to obtain save options.

   function Create
    (Index            : clang_c_Index_h.CXIndex;
     AST_File_Name    : League.Strings.Universal_String;
     Translation_Unit : out clang_c_Index_h.CXTranslationUnit)
       return clang_c_CXErrorCode_h.CXErrorCode;
   --  Wrapper for clang_createTranslationUnit2().

end Clang.Translation_Units;
