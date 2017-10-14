with Interfaces.C.Strings;

with League.Application;
with League.Strings;

with clang_c_CXErrorCode_h;
with clang_c_Index_h;

with Clang_Utilities;
with Code_Model.Builders;

procedure Extractor_Driver is

   use type Interfaces.C.unsigned;
   use type clang_c_CXErrorCode_h.CXErrorCode;

   Source_File : Interfaces.C.Strings.chars_ptr
     := Interfaces.C.Strings.New_String ("global.h");

   Index   : clang_c_Index_h.CXIndex;
   Error   : clang_c_CXErrorCode_h.CXErrorCode;
   Unit    : clang_c_Index_h.CXTranslationUnit;
   Cursor  : clang_c_Index_h.CXCursor;
   Dummy   : Interfaces.C.unsigned;
   Builder : Code_Model.Builders.Code_Model_Builder;

begin
   Index := clang_c_Index_h.clang_createIndex (0, 1);
   Error :=
     Clang_Utilities.Parse_Translation_Unit
      (Index,
       League.Strings.To_Universal_String ("global.h"),
       League.Application.Arguments,
       clang_c_Index_h.CXTranslationUnit_Incomplete
         and clang_c_Index_h.CXTranslationUnit_SkipFunctionBodies,
       Unit);

   if Error /= clang_c_CXErrorCode_h.CXError_Success then
      raise Program_Error
        with "parseTranslationUnit returns "
               & clang_c_CXErrorCode_h.CXErrorCode'Image (Error);
   end if;

   Cursor := clang_c_Index_h.clang_getTranslationUnitCursor (Unit);

   Builder.Initialize;
   Clang_Utilities.Visit_Children (Cursor, Builder);

   clang_c_Index_h.clang_disposeTranslationUnit (Unit);
   clang_c_Index_h.clang_disposeIndex (Index);
   Interfaces.C.Strings.Free (Source_File);
end Extractor_Driver;
