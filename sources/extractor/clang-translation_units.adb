with Interfaces.C.Strings;
with System;

package body Clang.Translation_Units is

   ------------
   -- Create --
   ------------

   function Create
    (Index            : clang_c_Index_h.CXIndex;
     AST_File_Name    : League.Strings.Universal_String;
     Translation_Unit : out clang_c_Index_h.CXTranslationUnit)
       return clang_c_CXErrorCode_h.CXErrorCode
   is
      C_AST_File_Name : Interfaces.C.Strings.chars_ptr
        := Interfaces.C.Strings.New_String (AST_File_Name.To_UTF_8_String);
      Result          : clang_c_CXErrorCode_h.CXErrorCode;

   begin
      Result :=
        clang_c_Index_h.clang_createTranslationUnit2
         (Index,
          C_AST_File_Name,
          Translation_Unit'Address);

      Interfaces.C.Strings.Free (C_AST_File_Name);

      return Result;
   end Create;

   -----------
   -- Parse --
   -----------

   function Parse
    (Index                  : clang_c_Index_h.CXIndex;
     Source_File_Name       : League.Strings.Universal_String;
     Command_Line_Arguments : League.String_Vectors.Universal_String_Vector;
     Options                : Interfaces.C.unsigned;
     Translation_Unit       : out clang_c_Index_h.CXTranslationUnit)
       return clang_c_CXErrorCode_h.CXErrorCode
   is
      C_Source_File_Name : Interfaces.C.Strings.chars_ptr
        := Interfaces.C.Strings.New_String (Source_File_Name.To_UTF_8_String);
      Arguments :
        array (1 .. Command_Line_Arguments.Length)
          of Interfaces.C.Strings.chars_ptr with Convention => C;
      Result    : clang_c_CXErrorCode_h.CXErrorCode;

   begin
      for J in 1 .. Command_Line_Arguments.Length loop
         Arguments (J) :=
           Interfaces.C.Strings.New_String
            (Command_Line_Arguments.Element (J).To_UTF_8_String);
      end loop;

      Result :=
        clang_c_Index_h.clang_parseTranslationUnit2
         (Index,
          C_Source_File_Name,
          (if Arguments'Length = 0
             then System.Null_Address
             else Arguments (Arguments'First)'Address),
          Arguments'Length,
          null,
          0,
          Options,
          Translation_Unit'Address);

      for J in Arguments'Range loop
         Interfaces.C.Strings.Free (Arguments (J));
      end loop;

      Interfaces.C.Strings.Free (C_Source_File_Name);

      return Result;
   end Parse;

   ----------
   -- Save --
   ----------

   function Save
    (Unit          : clang_c_Index_h.CXTranslationUnit;
     AST_File_Name : League.Strings.Universal_String)
       return clang_c_Index_h.CXSaveError
   is
      C_AST_File_Name : Interfaces.C.Strings.chars_ptr
        := Interfaces.C.Strings.New_String (AST_File_Name.To_UTF_8_String);

   begin
      return Result : constant clang_c_Index_h.CXSaveError
        := clang_c_Index_h.CXSaveError'Val
            (clang_c_Index_h.clang_saveTranslationUnit
              (Unit,
               C_AST_File_Name,
               clang_c_Index_h.clang_defaultSaveOptions (Unit)))
      do
         Interfaces.C.Strings.Free (C_AST_File_Name);
      end return;
   end Save;

end Clang.Translation_Units;
