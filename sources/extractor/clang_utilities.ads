------------------------------------------------------------------------------
--  Utilities to simplify code to use Clang C API.
------------------------------------------------------------------------------
with Interfaces.C;

with League.Strings;
with League.String_Vectors;

with clang_c_CXErrorCode_h;
with clang_c_Index_h;

with Base_Visitors;

package Clang_Utilities is

   function Parse_Translation_Unit
    (Index                  : clang_c_Index_h.CXIndex;
     Source_Filename        : League.Strings.Universal_String;
     Command_Line_Arguments : League.String_Vectors.Universal_String_Vector;
     Options                : Interfaces.C.unsigned;
     Translation_Unit       : out clang_c_Index_h.CXTranslationUnit)
       return clang_c_CXErrorCode_h.CXErrorCode;

   procedure Visit_Children
    (Cursor  : clang_c_Index_h.CXCursor;
     Visitor : in out Base_Visitors.Base_Visitor'Class);

end Clang_Utilities;
