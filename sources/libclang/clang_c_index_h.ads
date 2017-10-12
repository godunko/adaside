pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
with Interfaces.C.Strings;
with clang_c_CXString_h;
with time_h;
with Interfaces.C.Extensions;
with clang_c_CXErrorCode_h;

package clang_c_Index_h is

   CINDEX_VERSION_MAJOR : constant := 0;  --  /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:34
   CINDEX_VERSION_MINOR : constant := 43;  --  /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:35
   --  arg-macro: function CINDEX_VERSION_ENCODE (major, minor)
   --    return  ((major) * 10000) + ((minor) * 1);
   --  unsupported macro: CINDEX_VERSION CINDEX_VERSION_ENCODE( CINDEX_VERSION_MAJOR, CINDEX_VERSION_MINOR )
   --  unsupported macro: CINDEX_VERSION_STRINGIZE_(major,minor) #major"."#minor
   --  arg-macro: procedure CINDEX_VERSION_STRINGIZE (major, minor)
   --    CINDEX_VERSION_STRINGIZE_(major, minor)
   --  unsupported macro: CINDEX_VERSION_STRING CINDEX_VERSION_STRINGIZE( CINDEX_VERSION_MAJOR, CINDEX_VERSION_MINOR)

   type CXIndex is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:81

   --  skipped empty struct CXTargetInfoImpl

   type CXTargetInfo is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:87

   --  skipped empty struct CXTranslationUnitImpl

   type CXTranslationUnit is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:92

   type CXClientData is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:98

   type CXUnsavedFile is record
      Filename : Interfaces.C.Strings.chars_ptr;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:113
      Contents : Interfaces.C.Strings.chars_ptr;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:118
      Length : aliased unsigned_long;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:123
   end record;
   pragma Convention (C_Pass_By_Copy, CXUnsavedFile);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:107

   type CXAvailabilityKind is 
     (CXAvailability_Available,
      CXAvailability_Deprecated,
      CXAvailability_NotAvailable,
      CXAvailability_NotAccessible);
   pragma Convention (C, CXAvailabilityKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:131

   type CXVersion is record
      Major : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:160
      Minor : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:166
      Subminor : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:172
   end record;
   pragma Convention (C_Pass_By_Copy, CXVersion);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:155

   type CXCursor_ExceptionSpecificationKind is 
     (CXCursor_ExceptionSpecificationKind_None,
      CXCursor_ExceptionSpecificationKind_DynamicNone,
      CXCursor_ExceptionSpecificationKind_Dynamic,
      CXCursor_ExceptionSpecificationKind_MSAny,
      CXCursor_ExceptionSpecificationKind_BasicNoexcept,
      CXCursor_ExceptionSpecificationKind_ComputedNoexcept,
      CXCursor_ExceptionSpecificationKind_Unevaluated,
      CXCursor_ExceptionSpecificationKind_Uninstantiated,
      CXCursor_ExceptionSpecificationKind_Unparsed);
   pragma Convention (C, CXCursor_ExceptionSpecificationKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:180

   function clang_createIndex (arg1 : int; arg2 : int) return CXIndex;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:268
   pragma Import (C, clang_createIndex, "clang_createIndex");

   procedure clang_disposeIndex (arg1 : CXIndex);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:277
   pragma Import (C, clang_disposeIndex, "clang_disposeIndex");

   type CXGlobalOptFlags is 
     (CXGlobalOpt_None,
      CXGlobalOpt_ThreadBackgroundPriorityForIndexing,
      CXGlobalOpt_ThreadBackgroundPriorityForEditing,
      CXGlobalOpt_ThreadBackgroundPriorityForAll);
   pragma Convention (C, CXGlobalOptFlags);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:311

   procedure clang_CXIndex_setGlobalOptions (arg1 : CXIndex; arg2 : unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:326
   pragma Import (C, clang_CXIndex_setGlobalOptions, "clang_CXIndex_setGlobalOptions");

   function clang_CXIndex_getGlobalOptions (arg1 : CXIndex) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:334
   pragma Import (C, clang_CXIndex_getGlobalOptions, "clang_CXIndex_getGlobalOptions");

   type CXFile is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:345

   function clang_getFileName (arg1 : CXFile) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:350
   pragma Import (C, clang_getFileName, "clang_getFileName");

   function clang_getFileTime (arg1 : CXFile) return time_h.time_t;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:355
   pragma Import (C, clang_getFileTime, "clang_getFileTime");

   type CXFileUniqueID_data_array is array (0 .. 2) of aliased Extensions.unsigned_long_long;
   type CXFileUniqueID is record
      data : aliased CXFileUniqueID_data_array;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:362
   end record;
   pragma Convention (C_Pass_By_Copy, CXFileUniqueID);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:363

   function clang_getFileUniqueID (arg1 : CXFile; arg2 : access CXFileUniqueID) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:373
   pragma Import (C, clang_getFileUniqueID, "clang_getFileUniqueID");

   function clang_isFileMultipleIncludeGuarded (arg1 : CXTranslationUnit; arg2 : CXFile) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:381
   pragma Import (C, clang_isFileMultipleIncludeGuarded, "clang_isFileMultipleIncludeGuarded");

   function clang_getFile (arg1 : CXTranslationUnit; arg2 : Interfaces.C.Strings.chars_ptr) return CXFile;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:393
   pragma Import (C, clang_getFile, "clang_getFile");

   function clang_File_isEqual (arg1 : CXFile; arg2 : CXFile) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:400
   pragma Import (C, clang_File_isEqual, "clang_File_isEqual");

   type CXSourceLocation_ptr_data_array is array (0 .. 1) of System.Address;
   type CXSourceLocation is record
      ptr_data : CXSourceLocation_ptr_data_array;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:427
      int_data : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:428
   end record;
   pragma Convention (C_Pass_By_Copy, CXSourceLocation);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:429

   type CXSourceRange_ptr_data_array is array (0 .. 1) of System.Address;
   type CXSourceRange is record
      ptr_data : CXSourceRange_ptr_data_array;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:438
      begin_int_data : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:439
      end_int_data : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:440
   end record;
   pragma Convention (C_Pass_By_Copy, CXSourceRange);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:441

   function clang_getNullLocation return CXSourceLocation;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:446
   pragma Import (C, clang_getNullLocation, "clang_getNullLocation");

   function clang_equalLocations (arg1 : CXSourceLocation; arg2 : CXSourceLocation) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:456
   pragma Import (C, clang_equalLocations, "clang_equalLocations");

   function clang_getLocation
     (arg1 : CXTranslationUnit;
      arg2 : CXFile;
      arg3 : unsigned;
      arg4 : unsigned) return CXSourceLocation;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:463
   pragma Import (C, clang_getLocation, "clang_getLocation");

   function clang_getLocationForOffset
     (arg1 : CXTranslationUnit;
      arg2 : CXFile;
      arg3 : unsigned) return CXSourceLocation;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:471
   pragma Import (C, clang_getLocationForOffset, "clang_getLocationForOffset");

   function clang_Location_isInSystemHeader (arg1 : CXSourceLocation) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:478
   pragma Import (C, clang_Location_isInSystemHeader, "clang_Location_isInSystemHeader");

   function clang_Location_isFromMainFile (arg1 : CXSourceLocation) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:484
   pragma Import (C, clang_Location_isFromMainFile, "clang_Location_isFromMainFile");

   function clang_getNullRange return CXSourceRange;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:489
   pragma Import (C, clang_getNullRange, "clang_getNullRange");

   function clang_getRange (arg1 : CXSourceLocation; arg2 : CXSourceLocation) return CXSourceRange;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:495
   pragma Import (C, clang_getRange, "clang_getRange");

   function clang_equalRanges (arg1 : CXSourceRange; arg2 : CXSourceRange) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:503
   pragma Import (C, clang_equalRanges, "clang_equalRanges");

   function clang_Range_isNull (arg1 : CXSourceRange) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:509
   pragma Import (C, clang_Range_isNull, "clang_Range_isNull");

   procedure clang_getExpansionLocation
     (arg1 : CXSourceLocation;
      arg2 : System.Address;
      arg3 : access unsigned;
      arg4 : access unsigned;
      arg5 : access unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:533
   pragma Import (C, clang_getExpansionLocation, "clang_getExpansionLocation");

   procedure clang_getPresumedLocation
     (arg1 : CXSourceLocation;
      arg2 : access clang_c_CXString_h.CXString;
      arg3 : access unsigned;
      arg4 : access unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:579
   pragma Import (C, clang_getPresumedLocation, "clang_getPresumedLocation");

   procedure clang_getInstantiationLocation
     (arg1 : CXSourceLocation;
      arg2 : System.Address;
      arg3 : access unsigned;
      arg4 : access unsigned;
      arg5 : access unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:592
   pragma Import (C, clang_getInstantiationLocation, "clang_getInstantiationLocation");

   procedure clang_getSpellingLocation
     (arg1 : CXSourceLocation;
      arg2 : System.Address;
      arg3 : access unsigned;
      arg4 : access unsigned;
      arg5 : access unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:620
   pragma Import (C, clang_getSpellingLocation, "clang_getSpellingLocation");

   procedure clang_getFileLocation
     (arg1 : CXSourceLocation;
      arg2 : System.Address;
      arg3 : access unsigned;
      arg4 : access unsigned;
      arg5 : access unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:649
   pragma Import (C, clang_getFileLocation, "clang_getFileLocation");

   function clang_getRangeStart (arg1 : CXSourceRange) return CXSourceLocation;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:659
   pragma Import (C, clang_getRangeStart, "clang_getRangeStart");

   function clang_getRangeEnd (arg1 : CXSourceRange) return CXSourceLocation;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:665
   pragma Import (C, clang_getRangeEnd, "clang_getRangeEnd");

   type CXSourceRangeList is record
      count : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:672
      ranges : access CXSourceRange;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:676
   end record;
   pragma Convention (C_Pass_By_Copy, CXSourceRangeList);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:677

   function clang_getSkippedRanges (arg1 : CXTranslationUnit; arg2 : CXFile) return access CXSourceRangeList;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:685
   pragma Import (C, clang_getSkippedRanges, "clang_getSkippedRanges");

   function clang_getAllSkippedRanges (arg1 : CXTranslationUnit) return access CXSourceRangeList;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:695
   pragma Import (C, clang_getAllSkippedRanges, "clang_getAllSkippedRanges");

   procedure clang_disposeSourceRangeList (arg1 : access CXSourceRangeList);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:700
   pragma Import (C, clang_disposeSourceRangeList, "clang_disposeSourceRangeList");

   type CXDiagnosticSeverity is 
     (CXDiagnostic_Ignored,
      CXDiagnostic_Note,
      CXDiagnostic_Warning,
      CXDiagnostic_Error,
      CXDiagnostic_Fatal);
   pragma Convention (C, CXDiagnosticSeverity);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:715

   type CXDiagnostic is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:751

   type CXDiagnosticSet is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:756

   function clang_getNumDiagnosticsInSet (arg1 : CXDiagnosticSet) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:761
   pragma Import (C, clang_getNumDiagnosticsInSet, "clang_getNumDiagnosticsInSet");

   function clang_getDiagnosticInSet (arg1 : CXDiagnosticSet; arg2 : unsigned) return CXDiagnostic;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:772
   pragma Import (C, clang_getDiagnosticInSet, "clang_getDiagnosticInSet");

   type CXLoadDiag_Error is 
     (CXLoadDiag_None,
      CXLoadDiag_Unknown,
      CXLoadDiag_CannotLoad,
      CXLoadDiag_InvalidFile);
   pragma Convention (C, CXLoadDiag_Error);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:779

   function clang_loadDiagnostics
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : access CXLoadDiag_Error;
      arg3 : access clang_c_CXString_h.CXString) return CXDiagnosticSet;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:817
   pragma Import (C, clang_loadDiagnostics, "clang_loadDiagnostics");

   procedure clang_disposeDiagnosticSet (arg1 : CXDiagnosticSet);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:824
   pragma Import (C, clang_disposeDiagnosticSet, "clang_disposeDiagnosticSet");

   function clang_getChildDiagnostics (arg1 : CXDiagnostic) return CXDiagnosticSet;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:832
   pragma Import (C, clang_getChildDiagnostics, "clang_getChildDiagnostics");

   function clang_getNumDiagnostics (arg1 : CXTranslationUnit) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:838
   pragma Import (C, clang_getNumDiagnostics, "clang_getNumDiagnostics");

   function clang_getDiagnostic (arg1 : CXTranslationUnit; arg2 : unsigned) return CXDiagnostic;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:849
   pragma Import (C, clang_getDiagnostic, "clang_getDiagnostic");

   function clang_getDiagnosticSetFromTU (arg1 : CXTranslationUnit) return CXDiagnosticSet;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:859
   pragma Import (C, clang_getDiagnosticSetFromTU, "clang_getDiagnosticSetFromTU");

   procedure clang_disposeDiagnostic (arg1 : CXDiagnostic);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:864
   pragma Import (C, clang_disposeDiagnostic, "clang_disposeDiagnostic");

   subtype CXDiagnosticDisplayOptions is unsigned;
   CXDiagnostic_DisplaySourceLocation : constant CXDiagnosticDisplayOptions := 1;
   CXDiagnostic_DisplayColumn : constant CXDiagnosticDisplayOptions := 2;
   CXDiagnostic_DisplaySourceRanges : constant CXDiagnosticDisplayOptions := 4;
   CXDiagnostic_DisplayOption : constant CXDiagnosticDisplayOptions := 8;
   CXDiagnostic_DisplayCategoryId : constant CXDiagnosticDisplayOptions := 16;
   CXDiagnostic_DisplayCategoryName : constant CXDiagnosticDisplayOptions := 32;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:872

   function clang_formatDiagnostic (arg1 : CXDiagnostic; arg2 : unsigned) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:949
   pragma Import (C, clang_formatDiagnostic, "clang_formatDiagnostic");

   function clang_defaultDiagnosticDisplayOptions return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:959
   pragma Import (C, clang_defaultDiagnosticDisplayOptions, "clang_defaultDiagnosticDisplayOptions");

   function clang_getDiagnosticSeverity (arg1 : CXDiagnostic) return CXDiagnosticSeverity;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:965
   pragma Import (C, clang_getDiagnosticSeverity, "clang_getDiagnosticSeverity");

   function clang_getDiagnosticLocation (arg1 : CXDiagnostic) return CXSourceLocation;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:973
   pragma Import (C, clang_getDiagnosticLocation, "clang_getDiagnosticLocation");

   function clang_getDiagnosticSpelling (arg1 : CXDiagnostic) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:978
   pragma Import (C, clang_getDiagnosticSpelling, "clang_getDiagnosticSpelling");

   function clang_getDiagnosticOption (arg1 : CXDiagnostic; arg2 : access clang_c_CXString_h.CXString) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:992
   pragma Import (C, clang_getDiagnosticOption, "clang_getDiagnosticOption");

   function clang_getDiagnosticCategory (arg1 : CXDiagnostic) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1005
   pragma Import (C, clang_getDiagnosticCategory, "clang_getDiagnosticCategory");

   function clang_getDiagnosticCategoryName (arg1 : unsigned) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1018
   pragma Import (C, clang_getDiagnosticCategoryName, "clang_getDiagnosticCategoryName");

   function clang_getDiagnosticCategoryText (arg1 : CXDiagnostic) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1025
   pragma Import (C, clang_getDiagnosticCategoryText, "clang_getDiagnosticCategoryText");

   function clang_getDiagnosticNumRanges (arg1 : CXDiagnostic) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1031
   pragma Import (C, clang_getDiagnosticNumRanges, "clang_getDiagnosticNumRanges");

   function clang_getDiagnosticRange (arg1 : CXDiagnostic; arg2 : unsigned) return CXSourceRange;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1046
   pragma Import (C, clang_getDiagnosticRange, "clang_getDiagnosticRange");

   function clang_getDiagnosticNumFixIts (arg1 : CXDiagnostic) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1053
   pragma Import (C, clang_getDiagnosticNumFixIts, "clang_getDiagnosticNumFixIts");

   function clang_getDiagnosticFixIt
     (arg1 : CXDiagnostic;
      arg2 : unsigned;
      arg3 : access CXSourceRange) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1080
   pragma Import (C, clang_getDiagnosticFixIt, "clang_getDiagnosticFixIt");

   function clang_getTranslationUnitSpelling (arg1 : CXTranslationUnit) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1102
   pragma Import (C, clang_getTranslationUnitSpelling, "clang_getTranslationUnitSpelling");

   function clang_createTranslationUnitFromSourceFile
     (arg1 : CXIndex;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : int;
      arg4 : System.Address;
      arg5 : unsigned;
      arg6 : access CXUnsavedFile) return CXTranslationUnit;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1144
   pragma Import (C, clang_createTranslationUnitFromSourceFile, "clang_createTranslationUnitFromSourceFile");

   function clang_createTranslationUnit (arg1 : CXIndex; arg2 : Interfaces.C.Strings.chars_ptr) return CXTranslationUnit;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1158
   pragma Import (C, clang_createTranslationUnit, "clang_createTranslationUnit");

   function clang_createTranslationUnit2
     (arg1 : CXIndex;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : System.Address) return clang_c_CXErrorCode_h.CXErrorCode;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1170
   pragma Import (C, clang_createTranslationUnit2, "clang_createTranslationUnit2");

   subtype CXTranslationUnit_Flags is unsigned;
   CXTranslationUnit_None : constant CXTranslationUnit_Flags := 0;
   CXTranslationUnit_DetailedPreprocessingRecord : constant CXTranslationUnit_Flags := 1;
   CXTranslationUnit_Incomplete : constant CXTranslationUnit_Flags := 2;
   CXTranslationUnit_PrecompiledPreamble : constant CXTranslationUnit_Flags := 4;
   CXTranslationUnit_CacheCompletionResults : constant CXTranslationUnit_Flags := 8;
   CXTranslationUnit_ForSerialization : constant CXTranslationUnit_Flags := 16;
   CXTranslationUnit_CXXChainedPCH : constant CXTranslationUnit_Flags := 32;
   CXTranslationUnit_SkipFunctionBodies : constant CXTranslationUnit_Flags := 64;
   CXTranslationUnit_IncludeBriefCommentsInCodeCompletion : constant CXTranslationUnit_Flags := 128;
   CXTranslationUnit_CreatePreambleOnFirstParse : constant CXTranslationUnit_Flags := 256;
   CXTranslationUnit_KeepGoing : constant CXTranslationUnit_Flags := 512;
   CXTranslationUnit_SingleFileParse : constant CXTranslationUnit_Flags := 1024;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1182

   function clang_defaultEditingTranslationUnitOptions return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1310
   pragma Import (C, clang_defaultEditingTranslationUnitOptions, "clang_defaultEditingTranslationUnitOptions");

   function clang_parseTranslationUnit
     (arg1 : CXIndex;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : System.Address;
      arg4 : int;
      arg5 : access CXUnsavedFile;
      arg6 : unsigned;
      arg7 : unsigned) return CXTranslationUnit;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1319
   pragma Import (C, clang_parseTranslationUnit, "clang_parseTranslationUnit");

   function clang_parseTranslationUnit2
     (arg1 : CXIndex;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : System.Address;
      arg4 : int;
      arg5 : access CXUnsavedFile;
      arg6 : unsigned;
      arg7 : unsigned;
      arg8 : System.Address) return clang_c_CXErrorCode_h.CXErrorCode;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1372
   pragma Import (C, clang_parseTranslationUnit2, "clang_parseTranslationUnit2");

   function clang_parseTranslationUnit2FullArgv
     (arg1 : CXIndex;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : System.Address;
      arg4 : int;
      arg5 : access CXUnsavedFile;
      arg6 : unsigned;
      arg7 : unsigned;
      arg8 : System.Address) return clang_c_CXErrorCode_h.CXErrorCode;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1386
   pragma Import (C, clang_parseTranslationUnit2FullArgv, "clang_parseTranslationUnit2FullArgv");

   type CXSaveTranslationUnit_Flags is 
     (CXSaveTranslationUnit_None);
   pragma Convention (C, CXSaveTranslationUnit_Flags);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1399

   function clang_defaultSaveOptions (arg1 : CXTranslationUnit) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1415
   pragma Import (C, clang_defaultSaveOptions, "clang_defaultSaveOptions");

   type CXSaveError is 
     (CXSaveError_None,
      CXSaveError_Unknown,
      CXSaveError_TranslationErrors,
      CXSaveError_InvalidTU);
   pragma Convention (C, CXSaveError);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1421

   function clang_saveTranslationUnit
     (arg1 : CXTranslationUnit;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : unsigned) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1475
   pragma Import (C, clang_saveTranslationUnit, "clang_saveTranslationUnit");

   function clang_suspendTranslationUnit (arg1 : CXTranslationUnit) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1486
   pragma Import (C, clang_suspendTranslationUnit, "clang_suspendTranslationUnit");

   procedure clang_disposeTranslationUnit (arg1 : CXTranslationUnit);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1491
   pragma Import (C, clang_disposeTranslationUnit, "clang_disposeTranslationUnit");

   type CXReparse_Flags is 
     (CXReparse_None);
   pragma Convention (C, CXReparse_Flags);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1500

   function clang_defaultReparseOptions (arg1 : CXTranslationUnit) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1517
   pragma Import (C, clang_defaultReparseOptions, "clang_defaultReparseOptions");

   function clang_reparseTranslationUnit
     (arg1 : CXTranslationUnit;
      arg2 : unsigned;
      arg3 : access CXUnsavedFile;
      arg4 : unsigned) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1558
   pragma Import (C, clang_reparseTranslationUnit, "clang_reparseTranslationUnit");

   subtype CXTUResourceUsageKind is unsigned;
   CXTUResourceUsage_AST : constant CXTUResourceUsageKind := 1;
   CXTUResourceUsage_Identifiers : constant CXTUResourceUsageKind := 2;
   CXTUResourceUsage_Selectors : constant CXTUResourceUsageKind := 3;
   CXTUResourceUsage_GlobalCompletionResults : constant CXTUResourceUsageKind := 4;
   CXTUResourceUsage_SourceManagerContentCache : constant CXTUResourceUsageKind := 5;
   CXTUResourceUsage_AST_SideTables : constant CXTUResourceUsageKind := 6;
   CXTUResourceUsage_SourceManager_Membuffer_Malloc : constant CXTUResourceUsageKind := 7;
   CXTUResourceUsage_SourceManager_Membuffer_MMap : constant CXTUResourceUsageKind := 8;
   CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc : constant CXTUResourceUsageKind := 9;
   CXTUResourceUsage_ExternalASTSource_Membuffer_MMap : constant CXTUResourceUsageKind := 10;
   CXTUResourceUsage_Preprocessor : constant CXTUResourceUsageKind := 11;
   CXTUResourceUsage_PreprocessingRecord : constant CXTUResourceUsageKind := 12;
   CXTUResourceUsage_SourceManager_DataStructures : constant CXTUResourceUsageKind := 13;
   CXTUResourceUsage_Preprocessor_HeaderSearch : constant CXTUResourceUsageKind := 14;
   CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN : constant CXTUResourceUsageKind := 1;
   CXTUResourceUsage_MEMORY_IN_BYTES_END : constant CXTUResourceUsageKind := 14;
   CXTUResourceUsage_First : constant CXTUResourceUsageKind := 1;
   CXTUResourceUsage_Last : constant CXTUResourceUsageKind := 14;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1566

   function clang_getTUResourceUsageName (arg1 : CXTUResourceUsageKind) return Interfaces.C.Strings.chars_ptr;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1594
   pragma Import (C, clang_getTUResourceUsageName, "clang_getTUResourceUsageName");

   type CXTUResourceUsageEntry is record
      kind : aliased CXTUResourceUsageKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1598
      amount : aliased unsigned_long;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1601
   end record;
   pragma Convention (C_Pass_By_Copy, CXTUResourceUsageEntry);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1596

   type CXTUResourceUsage is record
      data : System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1609
      numEntries : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1612
      entries : access CXTUResourceUsageEntry;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1616
   end record;
   pragma Convention (C_Pass_By_Copy, CXTUResourceUsage);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1607

   function clang_getCXTUResourceUsage (arg1 : CXTranslationUnit) return CXTUResourceUsage;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1624
   pragma Import (C, clang_getCXTUResourceUsage, "clang_getCXTUResourceUsage");

   procedure clang_disposeCXTUResourceUsage (arg1 : CXTUResourceUsage);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1626
   pragma Import (C, clang_disposeCXTUResourceUsage, "clang_disposeCXTUResourceUsage");

   function clang_getTranslationUnitTargetInfo (arg1 : CXTranslationUnit) return CXTargetInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1634
   pragma Import (C, clang_getTranslationUnitTargetInfo, "clang_getTranslationUnitTargetInfo");

   procedure clang_TargetInfo_dispose (arg1 : CXTargetInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1640
   pragma Import (C, clang_TargetInfo_dispose, "clang_TargetInfo_dispose");

   function clang_TargetInfo_getTriple (arg1 : CXTargetInfo) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1648
   pragma Import (C, clang_TargetInfo_getTriple, "clang_TargetInfo_getTriple");

   function clang_TargetInfo_getPointerWidth (arg1 : CXTargetInfo) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1656
   pragma Import (C, clang_TargetInfo_getPointerWidth, "clang_TargetInfo_getPointerWidth");

   subtype CXCursorKind is unsigned;
   CXCursor_UnexposedDecl : constant CXCursorKind := 1;
   CXCursor_StructDecl : constant CXCursorKind := 2;
   CXCursor_UnionDecl : constant CXCursorKind := 3;
   CXCursor_ClassDecl : constant CXCursorKind := 4;
   CXCursor_EnumDecl : constant CXCursorKind := 5;
   CXCursor_FieldDecl : constant CXCursorKind := 6;
   CXCursor_EnumConstantDecl : constant CXCursorKind := 7;
   CXCursor_FunctionDecl : constant CXCursorKind := 8;
   CXCursor_VarDecl : constant CXCursorKind := 9;
   CXCursor_ParmDecl : constant CXCursorKind := 10;
   CXCursor_ObjCInterfaceDecl : constant CXCursorKind := 11;
   CXCursor_ObjCCategoryDecl : constant CXCursorKind := 12;
   CXCursor_ObjCProtocolDecl : constant CXCursorKind := 13;
   CXCursor_ObjCPropertyDecl : constant CXCursorKind := 14;
   CXCursor_ObjCIvarDecl : constant CXCursorKind := 15;
   CXCursor_ObjCInstanceMethodDecl : constant CXCursorKind := 16;
   CXCursor_ObjCClassMethodDecl : constant CXCursorKind := 17;
   CXCursor_ObjCImplementationDecl : constant CXCursorKind := 18;
   CXCursor_ObjCCategoryImplDecl : constant CXCursorKind := 19;
   CXCursor_TypedefDecl : constant CXCursorKind := 20;
   CXCursor_CXXMethod : constant CXCursorKind := 21;
   CXCursor_Namespace : constant CXCursorKind := 22;
   CXCursor_LinkageSpec : constant CXCursorKind := 23;
   CXCursor_Constructor : constant CXCursorKind := 24;
   CXCursor_Destructor : constant CXCursorKind := 25;
   CXCursor_ConversionFunction : constant CXCursorKind := 26;
   CXCursor_TemplateTypeParameter : constant CXCursorKind := 27;
   CXCursor_NonTypeTemplateParameter : constant CXCursorKind := 28;
   CXCursor_TemplateTemplateParameter : constant CXCursorKind := 29;
   CXCursor_FunctionTemplate : constant CXCursorKind := 30;
   CXCursor_ClassTemplate : constant CXCursorKind := 31;
   CXCursor_ClassTemplatePartialSpecialization : constant CXCursorKind := 32;
   CXCursor_NamespaceAlias : constant CXCursorKind := 33;
   CXCursor_UsingDirective : constant CXCursorKind := 34;
   CXCursor_UsingDeclaration : constant CXCursorKind := 35;
   CXCursor_TypeAliasDecl : constant CXCursorKind := 36;
   CXCursor_ObjCSynthesizeDecl : constant CXCursorKind := 37;
   CXCursor_ObjCDynamicDecl : constant CXCursorKind := 38;
   CXCursor_CXXAccessSpecifier : constant CXCursorKind := 39;
   CXCursor_FirstDecl : constant CXCursorKind := 1;
   CXCursor_LastDecl : constant CXCursorKind := 39;
   CXCursor_FirstRef : constant CXCursorKind := 40;
   CXCursor_ObjCSuperClassRef : constant CXCursorKind := 40;
   CXCursor_ObjCProtocolRef : constant CXCursorKind := 41;
   CXCursor_ObjCClassRef : constant CXCursorKind := 42;
   CXCursor_TypeRef : constant CXCursorKind := 43;
   CXCursor_CXXBaseSpecifier : constant CXCursorKind := 44;
   CXCursor_TemplateRef : constant CXCursorKind := 45;
   CXCursor_NamespaceRef : constant CXCursorKind := 46;
   CXCursor_MemberRef : constant CXCursorKind := 47;
   CXCursor_LabelRef : constant CXCursorKind := 48;
   CXCursor_OverloadedDeclRef : constant CXCursorKind := 49;
   CXCursor_VariableRef : constant CXCursorKind := 50;
   CXCursor_LastRef : constant CXCursorKind := 50;
   CXCursor_FirstInvalid : constant CXCursorKind := 70;
   CXCursor_InvalidFile : constant CXCursorKind := 70;
   CXCursor_NoDeclFound : constant CXCursorKind := 71;
   CXCursor_NotImplemented : constant CXCursorKind := 72;
   CXCursor_InvalidCode : constant CXCursorKind := 73;
   CXCursor_LastInvalid : constant CXCursorKind := 73;
   CXCursor_FirstExpr : constant CXCursorKind := 100;
   CXCursor_UnexposedExpr : constant CXCursorKind := 100;
   CXCursor_DeclRefExpr : constant CXCursorKind := 101;
   CXCursor_MemberRefExpr : constant CXCursorKind := 102;
   CXCursor_CallExpr : constant CXCursorKind := 103;
   CXCursor_ObjCMessageExpr : constant CXCursorKind := 104;
   CXCursor_BlockExpr : constant CXCursorKind := 105;
   CXCursor_IntegerLiteral : constant CXCursorKind := 106;
   CXCursor_FloatingLiteral : constant CXCursorKind := 107;
   CXCursor_ImaginaryLiteral : constant CXCursorKind := 108;
   CXCursor_StringLiteral : constant CXCursorKind := 109;
   CXCursor_CharacterLiteral : constant CXCursorKind := 110;
   CXCursor_ParenExpr : constant CXCursorKind := 111;
   CXCursor_UnaryOperator : constant CXCursorKind := 112;
   CXCursor_ArraySubscriptExpr : constant CXCursorKind := 113;
   CXCursor_BinaryOperator : constant CXCursorKind := 114;
   CXCursor_CompoundAssignOperator : constant CXCursorKind := 115;
   CXCursor_ConditionalOperator : constant CXCursorKind := 116;
   CXCursor_CStyleCastExpr : constant CXCursorKind := 117;
   CXCursor_CompoundLiteralExpr : constant CXCursorKind := 118;
   CXCursor_InitListExpr : constant CXCursorKind := 119;
   CXCursor_AddrLabelExpr : constant CXCursorKind := 120;
   CXCursor_StmtExpr : constant CXCursorKind := 121;
   CXCursor_GenericSelectionExpr : constant CXCursorKind := 122;
   CXCursor_GNUNullExpr : constant CXCursorKind := 123;
   CXCursor_CXXStaticCastExpr : constant CXCursorKind := 124;
   CXCursor_CXXDynamicCastExpr : constant CXCursorKind := 125;
   CXCursor_CXXReinterpretCastExpr : constant CXCursorKind := 126;
   CXCursor_CXXConstCastExpr : constant CXCursorKind := 127;
   CXCursor_CXXFunctionalCastExpr : constant CXCursorKind := 128;
   CXCursor_CXXTypeidExpr : constant CXCursorKind := 129;
   CXCursor_CXXBoolLiteralExpr : constant CXCursorKind := 130;
   CXCursor_CXXNullPtrLiteralExpr : constant CXCursorKind := 131;
   CXCursor_CXXThisExpr : constant CXCursorKind := 132;
   CXCursor_CXXThrowExpr : constant CXCursorKind := 133;
   CXCursor_CXXNewExpr : constant CXCursorKind := 134;
   CXCursor_CXXDeleteExpr : constant CXCursorKind := 135;
   CXCursor_UnaryExpr : constant CXCursorKind := 136;
   CXCursor_ObjCStringLiteral : constant CXCursorKind := 137;
   CXCursor_ObjCEncodeExpr : constant CXCursorKind := 138;
   CXCursor_ObjCSelectorExpr : constant CXCursorKind := 139;
   CXCursor_ObjCProtocolExpr : constant CXCursorKind := 140;
   CXCursor_ObjCBridgedCastExpr : constant CXCursorKind := 141;
   CXCursor_PackExpansionExpr : constant CXCursorKind := 142;
   CXCursor_SizeOfPackExpr : constant CXCursorKind := 143;
   CXCursor_LambdaExpr : constant CXCursorKind := 144;
   CXCursor_ObjCBoolLiteralExpr : constant CXCursorKind := 145;
   CXCursor_ObjCSelfExpr : constant CXCursorKind := 146;
   CXCursor_OMPArraySectionExpr : constant CXCursorKind := 147;
   CXCursor_ObjCAvailabilityCheckExpr : constant CXCursorKind := 148;
   CXCursor_LastExpr : constant CXCursorKind := 148;
   CXCursor_FirstStmt : constant CXCursorKind := 200;
   CXCursor_UnexposedStmt : constant CXCursorKind := 200;
   CXCursor_LabelStmt : constant CXCursorKind := 201;
   CXCursor_CompoundStmt : constant CXCursorKind := 202;
   CXCursor_CaseStmt : constant CXCursorKind := 203;
   CXCursor_DefaultStmt : constant CXCursorKind := 204;
   CXCursor_IfStmt : constant CXCursorKind := 205;
   CXCursor_SwitchStmt : constant CXCursorKind := 206;
   CXCursor_WhileStmt : constant CXCursorKind := 207;
   CXCursor_DoStmt : constant CXCursorKind := 208;
   CXCursor_ForStmt : constant CXCursorKind := 209;
   CXCursor_GotoStmt : constant CXCursorKind := 210;
   CXCursor_IndirectGotoStmt : constant CXCursorKind := 211;
   CXCursor_ContinueStmt : constant CXCursorKind := 212;
   CXCursor_BreakStmt : constant CXCursorKind := 213;
   CXCursor_ReturnStmt : constant CXCursorKind := 214;
   CXCursor_GCCAsmStmt : constant CXCursorKind := 215;
   CXCursor_AsmStmt : constant CXCursorKind := 215;
   CXCursor_ObjCAtTryStmt : constant CXCursorKind := 216;
   CXCursor_ObjCAtCatchStmt : constant CXCursorKind := 217;
   CXCursor_ObjCAtFinallyStmt : constant CXCursorKind := 218;
   CXCursor_ObjCAtThrowStmt : constant CXCursorKind := 219;
   CXCursor_ObjCAtSynchronizedStmt : constant CXCursorKind := 220;
   CXCursor_ObjCAutoreleasePoolStmt : constant CXCursorKind := 221;
   CXCursor_ObjCForCollectionStmt : constant CXCursorKind := 222;
   CXCursor_CXXCatchStmt : constant CXCursorKind := 223;
   CXCursor_CXXTryStmt : constant CXCursorKind := 224;
   CXCursor_CXXForRangeStmt : constant CXCursorKind := 225;
   CXCursor_SEHTryStmt : constant CXCursorKind := 226;
   CXCursor_SEHExceptStmt : constant CXCursorKind := 227;
   CXCursor_SEHFinallyStmt : constant CXCursorKind := 228;
   CXCursor_MSAsmStmt : constant CXCursorKind := 229;
   CXCursor_NullStmt : constant CXCursorKind := 230;
   CXCursor_DeclStmt : constant CXCursorKind := 231;
   CXCursor_OMPParallelDirective : constant CXCursorKind := 232;
   CXCursor_OMPSimdDirective : constant CXCursorKind := 233;
   CXCursor_OMPForDirective : constant CXCursorKind := 234;
   CXCursor_OMPSectionsDirective : constant CXCursorKind := 235;
   CXCursor_OMPSectionDirective : constant CXCursorKind := 236;
   CXCursor_OMPSingleDirective : constant CXCursorKind := 237;
   CXCursor_OMPParallelForDirective : constant CXCursorKind := 238;
   CXCursor_OMPParallelSectionsDirective : constant CXCursorKind := 239;
   CXCursor_OMPTaskDirective : constant CXCursorKind := 240;
   CXCursor_OMPMasterDirective : constant CXCursorKind := 241;
   CXCursor_OMPCriticalDirective : constant CXCursorKind := 242;
   CXCursor_OMPTaskyieldDirective : constant CXCursorKind := 243;
   CXCursor_OMPBarrierDirective : constant CXCursorKind := 244;
   CXCursor_OMPTaskwaitDirective : constant CXCursorKind := 245;
   CXCursor_OMPFlushDirective : constant CXCursorKind := 246;
   CXCursor_SEHLeaveStmt : constant CXCursorKind := 247;
   CXCursor_OMPOrderedDirective : constant CXCursorKind := 248;
   CXCursor_OMPAtomicDirective : constant CXCursorKind := 249;
   CXCursor_OMPForSimdDirective : constant CXCursorKind := 250;
   CXCursor_OMPParallelForSimdDirective : constant CXCursorKind := 251;
   CXCursor_OMPTargetDirective : constant CXCursorKind := 252;
   CXCursor_OMPTeamsDirective : constant CXCursorKind := 253;
   CXCursor_OMPTaskgroupDirective : constant CXCursorKind := 254;
   CXCursor_OMPCancellationPointDirective : constant CXCursorKind := 255;
   CXCursor_OMPCancelDirective : constant CXCursorKind := 256;
   CXCursor_OMPTargetDataDirective : constant CXCursorKind := 257;
   CXCursor_OMPTaskLoopDirective : constant CXCursorKind := 258;
   CXCursor_OMPTaskLoopSimdDirective : constant CXCursorKind := 259;
   CXCursor_OMPDistributeDirective : constant CXCursorKind := 260;
   CXCursor_OMPTargetEnterDataDirective : constant CXCursorKind := 261;
   CXCursor_OMPTargetExitDataDirective : constant CXCursorKind := 262;
   CXCursor_OMPTargetParallelDirective : constant CXCursorKind := 263;
   CXCursor_OMPTargetParallelForDirective : constant CXCursorKind := 264;
   CXCursor_OMPTargetUpdateDirective : constant CXCursorKind := 265;
   CXCursor_OMPDistributeParallelForDirective : constant CXCursorKind := 266;
   CXCursor_OMPDistributeParallelForSimdDirective : constant CXCursorKind := 267;
   CXCursor_OMPDistributeSimdDirective : constant CXCursorKind := 268;
   CXCursor_OMPTargetParallelForSimdDirective : constant CXCursorKind := 269;
   CXCursor_OMPTargetSimdDirective : constant CXCursorKind := 270;
   CXCursor_OMPTeamsDistributeDirective : constant CXCursorKind := 271;
   CXCursor_OMPTeamsDistributeSimdDirective : constant CXCursorKind := 272;
   CXCursor_OMPTeamsDistributeParallelForSimdDirective : constant CXCursorKind := 273;
   CXCursor_OMPTeamsDistributeParallelForDirective : constant CXCursorKind := 274;
   CXCursor_OMPTargetTeamsDirective : constant CXCursorKind := 275;
   CXCursor_OMPTargetTeamsDistributeDirective : constant CXCursorKind := 276;
   CXCursor_OMPTargetTeamsDistributeParallelForDirective : constant CXCursorKind := 277;
   CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective : constant CXCursorKind := 278;
   CXCursor_OMPTargetTeamsDistributeSimdDirective : constant CXCursorKind := 279;
   CXCursor_LastStmt : constant CXCursorKind := 279;
   CXCursor_TranslationUnit : constant CXCursorKind := 300;
   CXCursor_FirstAttr : constant CXCursorKind := 400;
   CXCursor_UnexposedAttr : constant CXCursorKind := 400;
   CXCursor_IBActionAttr : constant CXCursorKind := 401;
   CXCursor_IBOutletAttr : constant CXCursorKind := 402;
   CXCursor_IBOutletCollectionAttr : constant CXCursorKind := 403;
   CXCursor_CXXFinalAttr : constant CXCursorKind := 404;
   CXCursor_CXXOverrideAttr : constant CXCursorKind := 405;
   CXCursor_AnnotateAttr : constant CXCursorKind := 406;
   CXCursor_AsmLabelAttr : constant CXCursorKind := 407;
   CXCursor_PackedAttr : constant CXCursorKind := 408;
   CXCursor_PureAttr : constant CXCursorKind := 409;
   CXCursor_ConstAttr : constant CXCursorKind := 410;
   CXCursor_NoDuplicateAttr : constant CXCursorKind := 411;
   CXCursor_CUDAConstantAttr : constant CXCursorKind := 412;
   CXCursor_CUDADeviceAttr : constant CXCursorKind := 413;
   CXCursor_CUDAGlobalAttr : constant CXCursorKind := 414;
   CXCursor_CUDAHostAttr : constant CXCursorKind := 415;
   CXCursor_CUDASharedAttr : constant CXCursorKind := 416;
   CXCursor_VisibilityAttr : constant CXCursorKind := 417;
   CXCursor_DLLExport : constant CXCursorKind := 418;
   CXCursor_DLLImport : constant CXCursorKind := 419;
   CXCursor_LastAttr : constant CXCursorKind := 419;
   CXCursor_PreprocessingDirective : constant CXCursorKind := 500;
   CXCursor_MacroDefinition : constant CXCursorKind := 501;
   CXCursor_MacroExpansion : constant CXCursorKind := 502;
   CXCursor_MacroInstantiation : constant CXCursorKind := 502;
   CXCursor_InclusionDirective : constant CXCursorKind := 503;
   CXCursor_FirstPreprocessing : constant CXCursorKind := 500;
   CXCursor_LastPreprocessing : constant CXCursorKind := 503;
   CXCursor_ModuleImportDecl : constant CXCursorKind := 600;
   CXCursor_TypeAliasTemplateDecl : constant CXCursorKind := 601;
   CXCursor_StaticAssert : constant CXCursorKind := 602;
   CXCursor_FriendDecl : constant CXCursorKind := 603;
   CXCursor_FirstExtraDecl : constant CXCursorKind := 600;
   CXCursor_LastExtraDecl : constant CXCursorKind := 603;
   CXCursor_OverloadCandidate : constant CXCursorKind := 700;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:1665

   type CXCursor_data_array is array (0 .. 2) of System.Address;
   type CXCursor is record
      kind : aliased CXCursorKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2570
      xdata : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2571
      data : CXCursor_data_array;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2572
   end record;
   pragma Convention (C_Pass_By_Copy, CXCursor);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2573

   function clang_getNullCursor return CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2584
   pragma Import (C, clang_getNullCursor, "clang_getNullCursor");

   function clang_getTranslationUnitCursor (arg1 : CXTranslationUnit) return CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2592
   pragma Import (C, clang_getTranslationUnitCursor, "clang_getTranslationUnitCursor");

   function clang_equalCursors (arg1 : CXCursor; arg2 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2597
   pragma Import (C, clang_equalCursors, "clang_equalCursors");

   function clang_Cursor_isNull (arg1 : CXCursor) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2602
   pragma Import (C, clang_Cursor_isNull, "clang_Cursor_isNull");

   function clang_hashCursor (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2607
   pragma Import (C, clang_hashCursor, "clang_hashCursor");

   function clang_getCursorKind (arg1 : CXCursor) return CXCursorKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2612
   pragma Import (C, clang_getCursorKind, "clang_getCursorKind");

   function clang_isDeclaration (arg1 : CXCursorKind) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2617
   pragma Import (C, clang_isDeclaration, "clang_isDeclaration");

   function clang_isReference (arg1 : CXCursorKind) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2627
   pragma Import (C, clang_isReference, "clang_isReference");

   function clang_isExpression (arg1 : CXCursorKind) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2632
   pragma Import (C, clang_isExpression, "clang_isExpression");

   function clang_isStatement (arg1 : CXCursorKind) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2637
   pragma Import (C, clang_isStatement, "clang_isStatement");

   function clang_isAttribute (arg1 : CXCursorKind) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2642
   pragma Import (C, clang_isAttribute, "clang_isAttribute");

   function clang_Cursor_hasAttrs (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2647
   pragma Import (C, clang_Cursor_hasAttrs, "clang_Cursor_hasAttrs");

   function clang_isInvalid (arg1 : CXCursorKind) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2653
   pragma Import (C, clang_isInvalid, "clang_isInvalid");

   function clang_isTranslationUnit (arg1 : CXCursorKind) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2659
   pragma Import (C, clang_isTranslationUnit, "clang_isTranslationUnit");

   function clang_isPreprocessing (arg1 : CXCursorKind) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2665
   pragma Import (C, clang_isPreprocessing, "clang_isPreprocessing");

   function clang_isUnexposed (arg1 : CXCursorKind) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2671
   pragma Import (C, clang_isUnexposed, "clang_isUnexposed");

   type CXLinkageKind is 
     (CXLinkage_Invalid,
      CXLinkage_NoLinkage,
      CXLinkage_Internal,
      CXLinkage_UniqueExternal,
      CXLinkage_External);
   pragma Convention (C, CXLinkageKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2676

   function clang_getCursorLinkage (arg1 : CXCursor) return CXLinkageKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2697
   pragma Import (C, clang_getCursorLinkage, "clang_getCursorLinkage");

   type CXVisibilityKind is 
     (CXVisibility_Invalid,
      CXVisibility_Hidden,
      CXVisibility_Protected,
      CXVisibility_Default);
   pragma Convention (C, CXVisibilityKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2699

   function clang_getCursorVisibility (arg1 : CXCursor) return CXVisibilityKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2723
   pragma Import (C, clang_getCursorVisibility, "clang_getCursorVisibility");

   function clang_getCursorAvailability (arg1 : CXCursor) return CXAvailabilityKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2734
   pragma Import (C, clang_getCursorAvailability, "clang_getCursorAvailability");

   type CXPlatformAvailability is record
      Platform : aliased clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2747
      Introduced : aliased CXVersion;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2751
      Deprecated : aliased CXVersion;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2756
      Obsoleted : aliased CXVersion;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2761
      Unavailable : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2765
      Message : aliased clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2770
   end record;
   pragma Convention (C_Pass_By_Copy, CXPlatformAvailability);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2740

   function clang_getCursorPlatformAvailability
     (arg1 : CXCursor;
      arg2 : access int;
      arg3 : access clang_c_CXString_h.CXString;
      arg4 : access int;
      arg5 : access clang_c_CXString_h.CXString;
      arg6 : access CXPlatformAvailability;
      arg7 : int) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2810
   pragma Import (C, clang_getCursorPlatformAvailability, "clang_getCursorPlatformAvailability");

   procedure clang_disposeCXPlatformAvailability (arg1 : access CXPlatformAvailability);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2822
   pragma Import (C, clang_disposeCXPlatformAvailability, "clang_disposeCXPlatformAvailability");

   type CXLanguageKind is 
     (CXLanguage_Invalid,
      CXLanguage_C,
      CXLanguage_ObjC,
      CXLanguage_CPlusPlus);
   pragma Convention (C, CXLanguageKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2827

   function clang_getCursorLanguage (arg1 : CXCursor) return CXLanguageKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2837
   pragma Import (C, clang_getCursorLanguage, "clang_getCursorLanguage");

   function clang_Cursor_getTranslationUnit (arg1 : CXCursor) return CXTranslationUnit;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2842
   pragma Import (C, clang_Cursor_getTranslationUnit, "clang_Cursor_getTranslationUnit");

   --  skipped empty struct CXCursorSetImpl

   type CXCursorSet is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2847

   function clang_createCXCursorSet return CXCursorSet;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2852
   pragma Import (C, clang_createCXCursorSet, "clang_createCXCursorSet");

   procedure clang_disposeCXCursorSet (arg1 : CXCursorSet);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2857
   pragma Import (C, clang_disposeCXCursorSet, "clang_disposeCXCursorSet");

   function clang_CXCursorSet_contains (arg1 : CXCursorSet; arg2 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2864
   pragma Import (C, clang_CXCursorSet_contains, "clang_CXCursorSet_contains");

   function clang_CXCursorSet_insert (arg1 : CXCursorSet; arg2 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2872
   pragma Import (C, clang_CXCursorSet_insert, "clang_CXCursorSet_insert");

   function clang_getCursorSemanticParent (arg1 : CXCursor) return CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2908
   pragma Import (C, clang_getCursorSemanticParent, "clang_getCursorSemanticParent");

   function clang_getCursorLexicalParent (arg1 : CXCursor) return CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2944
   pragma Import (C, clang_getCursorLexicalParent, "clang_getCursorLexicalParent");

   procedure clang_getOverriddenCursors
     (arg1 : CXCursor;
      arg2 : System.Address;
      arg3 : access unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2989
   pragma Import (C, clang_getOverriddenCursors, "clang_getOverriddenCursors");

   procedure clang_disposeOverriddenCursors (arg1 : access CXCursor);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:2997
   pragma Import (C, clang_disposeOverriddenCursors, "clang_disposeOverriddenCursors");

   function clang_getIncludedFile (arg1 : CXCursor) return CXFile;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3003
   pragma Import (C, clang_getIncludedFile, "clang_getIncludedFile");

   function clang_getCursor (arg1 : CXTranslationUnit; arg2 : CXSourceLocation) return CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3035
   pragma Import (C, clang_getCursor, "clang_getCursor");

   function clang_getCursorLocation (arg1 : CXCursor) return CXSourceLocation;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3047
   pragma Import (C, clang_getCursorLocation, "clang_getCursorLocation");

   function clang_getCursorExtent (arg1 : CXCursor) return CXSourceRange;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3060
   pragma Import (C, clang_getCursorExtent, "clang_getCursorExtent");

   subtype CXTypeKind is unsigned;
   CXType_Invalid : constant CXTypeKind := 0;
   CXType_Unexposed : constant CXTypeKind := 1;
   CXType_Void : constant CXTypeKind := 2;
   CXType_Bool : constant CXTypeKind := 3;
   CXType_Char_U : constant CXTypeKind := 4;
   CXType_UChar : constant CXTypeKind := 5;
   CXType_Char16 : constant CXTypeKind := 6;
   CXType_Char32 : constant CXTypeKind := 7;
   CXType_UShort : constant CXTypeKind := 8;
   CXType_UInt : constant CXTypeKind := 9;
   CXType_ULong : constant CXTypeKind := 10;
   CXType_ULongLong : constant CXTypeKind := 11;
   CXType_UInt128 : constant CXTypeKind := 12;
   CXType_Char_S : constant CXTypeKind := 13;
   CXType_SChar : constant CXTypeKind := 14;
   CXType_WChar : constant CXTypeKind := 15;
   CXType_Short : constant CXTypeKind := 16;
   CXType_Int : constant CXTypeKind := 17;
   CXType_Long : constant CXTypeKind := 18;
   CXType_LongLong : constant CXTypeKind := 19;
   CXType_Int128 : constant CXTypeKind := 20;
   CXType_Float : constant CXTypeKind := 21;
   CXType_Double : constant CXTypeKind := 22;
   CXType_LongDouble : constant CXTypeKind := 23;
   CXType_NullPtr : constant CXTypeKind := 24;
   CXType_Overload : constant CXTypeKind := 25;
   CXType_Dependent : constant CXTypeKind := 26;
   CXType_ObjCId : constant CXTypeKind := 27;
   CXType_ObjCClass : constant CXTypeKind := 28;
   CXType_ObjCSel : constant CXTypeKind := 29;
   CXType_Float128 : constant CXTypeKind := 30;
   CXType_Half : constant CXTypeKind := 31;
   CXType_FirstBuiltin : constant CXTypeKind := 2;
   CXType_LastBuiltin : constant CXTypeKind := 31;
   CXType_Complex : constant CXTypeKind := 100;
   CXType_Pointer : constant CXTypeKind := 101;
   CXType_BlockPointer : constant CXTypeKind := 102;
   CXType_LValueReference : constant CXTypeKind := 103;
   CXType_RValueReference : constant CXTypeKind := 104;
   CXType_Record : constant CXTypeKind := 105;
   CXType_Enum : constant CXTypeKind := 106;
   CXType_Typedef : constant CXTypeKind := 107;
   CXType_ObjCInterface : constant CXTypeKind := 108;
   CXType_ObjCObjectPointer : constant CXTypeKind := 109;
   CXType_FunctionNoProto : constant CXTypeKind := 110;
   CXType_FunctionProto : constant CXTypeKind := 111;
   CXType_ConstantArray : constant CXTypeKind := 112;
   CXType_Vector : constant CXTypeKind := 113;
   CXType_IncompleteArray : constant CXTypeKind := 114;
   CXType_VariableArray : constant CXTypeKind := 115;
   CXType_DependentSizedArray : constant CXTypeKind := 116;
   CXType_MemberPointer : constant CXTypeKind := 117;
   CXType_Auto : constant CXTypeKind := 118;
   CXType_Elaborated : constant CXTypeKind := 119;
   CXType_Pipe : constant CXTypeKind := 120;
   CXType_OCLImage1dRO : constant CXTypeKind := 121;
   CXType_OCLImage1dArrayRO : constant CXTypeKind := 122;
   CXType_OCLImage1dBufferRO : constant CXTypeKind := 123;
   CXType_OCLImage2dRO : constant CXTypeKind := 124;
   CXType_OCLImage2dArrayRO : constant CXTypeKind := 125;
   CXType_OCLImage2dDepthRO : constant CXTypeKind := 126;
   CXType_OCLImage2dArrayDepthRO : constant CXTypeKind := 127;
   CXType_OCLImage2dMSAARO : constant CXTypeKind := 128;
   CXType_OCLImage2dArrayMSAARO : constant CXTypeKind := 129;
   CXType_OCLImage2dMSAADepthRO : constant CXTypeKind := 130;
   CXType_OCLImage2dArrayMSAADepthRO : constant CXTypeKind := 131;
   CXType_OCLImage3dRO : constant CXTypeKind := 132;
   CXType_OCLImage1dWO : constant CXTypeKind := 133;
   CXType_OCLImage1dArrayWO : constant CXTypeKind := 134;
   CXType_OCLImage1dBufferWO : constant CXTypeKind := 135;
   CXType_OCLImage2dWO : constant CXTypeKind := 136;
   CXType_OCLImage2dArrayWO : constant CXTypeKind := 137;
   CXType_OCLImage2dDepthWO : constant CXTypeKind := 138;
   CXType_OCLImage2dArrayDepthWO : constant CXTypeKind := 139;
   CXType_OCLImage2dMSAAWO : constant CXTypeKind := 140;
   CXType_OCLImage2dArrayMSAAWO : constant CXTypeKind := 141;
   CXType_OCLImage2dMSAADepthWO : constant CXTypeKind := 142;
   CXType_OCLImage2dArrayMSAADepthWO : constant CXTypeKind := 143;
   CXType_OCLImage3dWO : constant CXTypeKind := 144;
   CXType_OCLImage1dRW : constant CXTypeKind := 145;
   CXType_OCLImage1dArrayRW : constant CXTypeKind := 146;
   CXType_OCLImage1dBufferRW : constant CXTypeKind := 147;
   CXType_OCLImage2dRW : constant CXTypeKind := 148;
   CXType_OCLImage2dArrayRW : constant CXTypeKind := 149;
   CXType_OCLImage2dDepthRW : constant CXTypeKind := 150;
   CXType_OCLImage2dArrayDepthRW : constant CXTypeKind := 151;
   CXType_OCLImage2dMSAARW : constant CXTypeKind := 152;
   CXType_OCLImage2dArrayMSAARW : constant CXTypeKind := 153;
   CXType_OCLImage2dMSAADepthRW : constant CXTypeKind := 154;
   CXType_OCLImage2dArrayMSAADepthRW : constant CXTypeKind := 155;
   CXType_OCLImage3dRW : constant CXTypeKind := 156;
   CXType_OCLSampler : constant CXTypeKind := 157;
   CXType_OCLEvent : constant CXTypeKind := 158;
   CXType_OCLQueue : constant CXTypeKind := 159;
   CXType_OCLReserveID : constant CXTypeKind := 160;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3075

   subtype CXCallingConv is unsigned;
   CXCallingConv_Default : constant CXCallingConv := 0;
   CXCallingConv_C : constant CXCallingConv := 1;
   CXCallingConv_X86StdCall : constant CXCallingConv := 2;
   CXCallingConv_X86FastCall : constant CXCallingConv := 3;
   CXCallingConv_X86ThisCall : constant CXCallingConv := 4;
   CXCallingConv_X86Pascal : constant CXCallingConv := 5;
   CXCallingConv_AAPCS : constant CXCallingConv := 6;
   CXCallingConv_AAPCS_VFP : constant CXCallingConv := 7;
   CXCallingConv_X86RegCall : constant CXCallingConv := 8;
   CXCallingConv_IntelOclBicc : constant CXCallingConv := 9;
   CXCallingConv_Win64 : constant CXCallingConv := 10;
   CXCallingConv_X86_64Win64 : constant CXCallingConv := 10;
   CXCallingConv_X86_64SysV : constant CXCallingConv := 11;
   CXCallingConv_X86VectorCall : constant CXCallingConv := 12;
   CXCallingConv_Swift : constant CXCallingConv := 13;
   CXCallingConv_PreserveMost : constant CXCallingConv := 14;
   CXCallingConv_PreserveAll : constant CXCallingConv := 15;
   CXCallingConv_Invalid : constant CXCallingConv := 100;
   CXCallingConv_Unexposed : constant CXCallingConv := 200;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3197

   type CXType_data_array is array (0 .. 1) of System.Address;
   type CXType is record
      kind : aliased CXTypeKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3226
      data : CXType_data_array;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3227
   end record;
   pragma Convention (C_Pass_By_Copy, CXType);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3228

   function clang_getCursorType (arg1 : CXCursor) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3233
   pragma Import (C, clang_getCursorType, "clang_getCursorType");

   function clang_getTypeSpelling (arg1 : CXType) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3241
   pragma Import (C, clang_getTypeSpelling, "clang_getTypeSpelling");

   function clang_getTypedefDeclUnderlyingType (arg1 : CXCursor) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3249
   pragma Import (C, clang_getTypedefDeclUnderlyingType, "clang_getTypedefDeclUnderlyingType");

   function clang_getEnumDeclIntegerType (arg1 : CXCursor) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3257
   pragma Import (C, clang_getEnumDeclIntegerType, "clang_getEnumDeclIntegerType");

   function clang_getEnumConstantDeclValue (arg1 : CXCursor) return Long_Long_Integer;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3267
   pragma Import (C, clang_getEnumConstantDeclValue, "clang_getEnumConstantDeclValue");

   function clang_getEnumConstantDeclUnsignedValue (arg1 : CXCursor) return Extensions.unsigned_long_long;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3277
   pragma Import (C, clang_getEnumConstantDeclUnsignedValue, "clang_getEnumConstantDeclUnsignedValue");

   function clang_getFieldDeclBitWidth (arg1 : CXCursor) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3284
   pragma Import (C, clang_getFieldDeclBitWidth, "clang_getFieldDeclBitWidth");

   function clang_Cursor_getNumArguments (arg1 : CXCursor) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3293
   pragma Import (C, clang_Cursor_getNumArguments, "clang_Cursor_getNumArguments");

   function clang_Cursor_getArgument (arg1 : CXCursor; arg2 : unsigned) return CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3302
   pragma Import (C, clang_Cursor_getArgument, "clang_Cursor_getArgument");

   type CXTemplateArgumentKind is 
     (CXTemplateArgumentKind_Null,
      CXTemplateArgumentKind_Type,
      CXTemplateArgumentKind_Declaration,
      CXTemplateArgumentKind_NullPtr,
      CXTemplateArgumentKind_Integral,
      CXTemplateArgumentKind_Template,
      CXTemplateArgumentKind_TemplateExpansion,
      CXTemplateArgumentKind_Expression,
      CXTemplateArgumentKind_Pack,
      CXTemplateArgumentKind_Invalid);
   pragma Convention (C, CXTemplateArgumentKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3310

   function clang_Cursor_getNumTemplateArguments (arg1 : CXCursor) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3340
   pragma Import (C, clang_Cursor_getNumTemplateArguments, "clang_Cursor_getNumTemplateArguments");

   function clang_Cursor_getTemplateArgumentKind (arg1 : CXCursor; arg2 : unsigned) return CXTemplateArgumentKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3358
   pragma Import (C, clang_Cursor_getTemplateArgumentKind, "clang_Cursor_getTemplateArgumentKind");

   function clang_Cursor_getTemplateArgumentType (arg1 : CXCursor; arg2 : unsigned) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3379
   pragma Import (C, clang_Cursor_getTemplateArgumentType, "clang_Cursor_getTemplateArgumentType");

   function clang_Cursor_getTemplateArgumentValue (arg1 : CXCursor; arg2 : unsigned) return Long_Long_Integer;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3399
   pragma Import (C, clang_Cursor_getTemplateArgumentValue, "clang_Cursor_getTemplateArgumentValue");

   function clang_Cursor_getTemplateArgumentUnsignedValue (arg1 : CXCursor; arg2 : unsigned) return Extensions.unsigned_long_long;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3419
   pragma Import (C, clang_Cursor_getTemplateArgumentUnsignedValue, "clang_Cursor_getTemplateArgumentUnsignedValue");

   function clang_equalTypes (arg1 : CXType; arg2 : CXType) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3428
   pragma Import (C, clang_equalTypes, "clang_equalTypes");

   function clang_getCanonicalType (arg1 : CXType) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3438
   pragma Import (C, clang_getCanonicalType, "clang_getCanonicalType");

   function clang_isConstQualifiedType (arg1 : CXType) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3445
   pragma Import (C, clang_isConstQualifiedType, "clang_isConstQualifiedType");

   function clang_Cursor_isMacroFunctionLike (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3451
   pragma Import (C, clang_Cursor_isMacroFunctionLike, "clang_Cursor_isMacroFunctionLike");

   function clang_Cursor_isMacroBuiltin (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3457
   pragma Import (C, clang_Cursor_isMacroBuiltin, "clang_Cursor_isMacroBuiltin");

   function clang_Cursor_isFunctionInlined (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3463
   pragma Import (C, clang_Cursor_isFunctionInlined, "clang_Cursor_isFunctionInlined");

   function clang_isVolatileQualifiedType (arg1 : CXType) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3470
   pragma Import (C, clang_isVolatileQualifiedType, "clang_isVolatileQualifiedType");

   function clang_isRestrictQualifiedType (arg1 : CXType) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3477
   pragma Import (C, clang_isRestrictQualifiedType, "clang_isRestrictQualifiedType");

   function clang_getAddressSpace (arg1 : CXType) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3482
   pragma Import (C, clang_getAddressSpace, "clang_getAddressSpace");

   function clang_getTypedefName (arg1 : CXType) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3487
   pragma Import (C, clang_getTypedefName, "clang_getTypedefName");

   function clang_getPointeeType (arg1 : CXType) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3492
   pragma Import (C, clang_getPointeeType, "clang_getPointeeType");

   function clang_getTypeDeclaration (arg1 : CXType) return CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3497
   pragma Import (C, clang_getTypeDeclaration, "clang_getTypeDeclaration");

   function clang_getDeclObjCTypeEncoding (arg1 : CXCursor) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3502
   pragma Import (C, clang_getDeclObjCTypeEncoding, "clang_getDeclObjCTypeEncoding");

   function clang_Type_getObjCEncoding (arg1 : CXType) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3507
   pragma Import (C, clang_Type_getObjCEncoding, "clang_Type_getObjCEncoding");

   function clang_getTypeKindSpelling (arg1 : CXTypeKind) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3512
   pragma Import (C, clang_getTypeKindSpelling, "clang_getTypeKindSpelling");

   function clang_getFunctionTypeCallingConv (arg1 : CXType) return CXCallingConv;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3519
   pragma Import (C, clang_getFunctionTypeCallingConv, "clang_getFunctionTypeCallingConv");

   function clang_getResultType (arg1 : CXType) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3526
   pragma Import (C, clang_getResultType, "clang_getResultType");

   function clang_getExceptionSpecificationType (arg1 : CXType) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3533
   pragma Import (C, clang_getExceptionSpecificationType, "clang_getExceptionSpecificationType");

   function clang_getNumArgTypes (arg1 : CXType) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3541
   pragma Import (C, clang_getNumArgTypes, "clang_getNumArgTypes");

   function clang_getArgType (arg1 : CXType; arg2 : unsigned) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3549
   pragma Import (C, clang_getArgType, "clang_getArgType");

   function clang_isFunctionTypeVariadic (arg1 : CXType) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3554
   pragma Import (C, clang_isFunctionTypeVariadic, "clang_isFunctionTypeVariadic");

   function clang_getCursorResultType (arg1 : CXCursor) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3561
   pragma Import (C, clang_getCursorResultType, "clang_getCursorResultType");

   function clang_getCursorExceptionSpecificationType (arg1 : CXCursor) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3568
   pragma Import (C, clang_getCursorExceptionSpecificationType, "clang_getCursorExceptionSpecificationType");

   function clang_isPODType (arg1 : CXType) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3574
   pragma Import (C, clang_isPODType, "clang_isPODType");

   function clang_getElementType (arg1 : CXType) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3582
   pragma Import (C, clang_getElementType, "clang_getElementType");

   function clang_getNumElements (arg1 : CXType) return Long_Long_Integer;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3590
   pragma Import (C, clang_getNumElements, "clang_getNumElements");

   function clang_getArrayElementType (arg1 : CXType) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3597
   pragma Import (C, clang_getArrayElementType, "clang_getArrayElementType");

   function clang_getArraySize (arg1 : CXType) return Long_Long_Integer;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3604
   pragma Import (C, clang_getArraySize, "clang_getArraySize");

   function clang_Type_getNamedType (arg1 : CXType) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3611
   pragma Import (C, clang_Type_getNamedType, "clang_Type_getNamedType");

   function clang_Type_isTransparentTagTypedef (arg1 : CXType) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3621
   pragma Import (C, clang_Type_isTransparentTagTypedef, "clang_Type_isTransparentTagTypedef");

   subtype CXTypeLayoutError is int;
   CXTypeLayoutError_Invalid : constant CXTypeLayoutError := -1;
   CXTypeLayoutError_Incomplete : constant CXTypeLayoutError := -2;
   CXTypeLayoutError_Dependent : constant CXTypeLayoutError := -3;
   CXTypeLayoutError_NotConstantSize : constant CXTypeLayoutError := -4;
   CXTypeLayoutError_InvalidFieldName : constant CXTypeLayoutError := -5;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3631

   function clang_Type_getAlignOf (arg1 : CXType) return Long_Long_Integer;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3666
   pragma Import (C, clang_Type_getAlignOf, "clang_Type_getAlignOf");

   function clang_Type_getClassType (arg1 : CXType) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3673
   pragma Import (C, clang_Type_getClassType, "clang_Type_getClassType");

   function clang_Type_getSizeOf (arg1 : CXType) return Long_Long_Integer;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3684
   pragma Import (C, clang_Type_getSizeOf, "clang_Type_getSizeOf");

   function clang_Type_getOffsetOf (arg1 : CXType; arg2 : Interfaces.C.Strings.chars_ptr) return Long_Long_Integer;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3699
   pragma Import (C, clang_Type_getOffsetOf, "clang_Type_getOffsetOf");

   function clang_Cursor_getOffsetOfField (arg1 : CXCursor) return Long_Long_Integer;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3714
   pragma Import (C, clang_Cursor_getOffsetOfField, "clang_Cursor_getOffsetOfField");

   function clang_Cursor_isAnonymous (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3720
   pragma Import (C, clang_Cursor_isAnonymous, "clang_Cursor_isAnonymous");

   type CXRefQualifierKind is 
     (CXRefQualifier_None,
      CXRefQualifier_LValue,
      CXRefQualifier_RValue);
   pragma Convention (C, CXRefQualifierKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3722

   function clang_Type_getNumTemplateArguments (arg1 : CXType) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3735
   pragma Import (C, clang_Type_getNumTemplateArguments, "clang_Type_getNumTemplateArguments");

   function clang_Type_getTemplateArgumentAsType (arg1 : CXType; arg2 : unsigned) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3744
   pragma Import (C, clang_Type_getTemplateArgumentAsType, "clang_Type_getTemplateArgumentAsType");

   function clang_Type_getCXXRefQualifier (arg1 : CXType) return CXRefQualifierKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3752
   pragma Import (C, clang_Type_getCXXRefQualifier, "clang_Type_getCXXRefQualifier");

   function clang_Cursor_isBitField (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3758
   pragma Import (C, clang_Cursor_isBitField, "clang_Cursor_isBitField");

   function clang_isVirtualBase (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3764
   pragma Import (C, clang_isVirtualBase, "clang_isVirtualBase");

   type CX_CXXAccessSpecifier is 
     (CX_CXXInvalidAccessSpecifier,
      CX_CXXPublic,
      CX_CXXProtected,
      CX_CXXPrivate);
   pragma Convention (C, CX_CXXAccessSpecifier);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3770

   function clang_getCXXAccessSpecifier (arg1 : CXCursor) return CX_CXXAccessSpecifier;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3784
   pragma Import (C, clang_getCXXAccessSpecifier, "clang_getCXXAccessSpecifier");

   type CX_StorageClass is 
     (CX_SC_Invalid,
      CX_SC_None,
      CX_SC_Extern,
      CX_SC_Static,
      CX_SC_PrivateExtern,
      CX_SC_OpenCLWorkGroupLocal,
      CX_SC_Auto,
      CX_SC_Register);
   pragma Convention (C, CX_StorageClass);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3790

   function clang_Cursor_getStorageClass (arg1 : CXCursor) return CX_StorageClass;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3807
   pragma Import (C, clang_Cursor_getStorageClass, "clang_Cursor_getStorageClass");

   function clang_getNumOverloadedDecls (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3818
   pragma Import (C, clang_getNumOverloadedDecls, "clang_getNumOverloadedDecls");

   function clang_getOverloadedDecl (arg1 : CXCursor; arg2 : unsigned) return CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3834
   pragma Import (C, clang_getOverloadedDecl, "clang_getOverloadedDecl");

   function clang_getIBOutletCollectionType (arg1 : CXCursor) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3852
   pragma Import (C, clang_getIBOutletCollectionType, "clang_getIBOutletCollectionType");

   type CXChildVisitResult is 
     (CXChildVisit_Break,
      CXChildVisit_Continue,
      CXChildVisit_Recurse);
   pragma Convention (C, CXChildVisitResult);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3874

   type CXCursorVisitor is access function 
        (arg1 : CXCursor;
         arg2 : CXCursor;
         arg3 : CXClientData) return CXChildVisitResult;
   pragma Convention (C, CXCursorVisitor);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3903

   function clang_visitChildren
     (arg1 : CXCursor;
      arg2 : CXCursorVisitor;
      arg3 : CXClientData) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3929
   pragma Import (C, clang_visitChildren, "clang_visitChildren");

   function clang_getCursorUSR (arg1 : CXCursor) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3980
   pragma Import (C, clang_getCursorUSR, "clang_getCursorUSR");

   function clang_constructUSR_ObjCClass (arg1 : Interfaces.C.Strings.chars_ptr) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3985
   pragma Import (C, clang_constructUSR_ObjCClass, "clang_constructUSR_ObjCClass");

   function clang_constructUSR_ObjCCategory (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : Interfaces.C.Strings.chars_ptr) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3991
   pragma Import (C, clang_constructUSR_ObjCCategory, "clang_constructUSR_ObjCCategory");

   function clang_constructUSR_ObjCProtocol (arg1 : Interfaces.C.Strings.chars_ptr) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:3998
   pragma Import (C, clang_constructUSR_ObjCProtocol, "clang_constructUSR_ObjCProtocol");

   function clang_constructUSR_ObjCIvar (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : clang_c_CXString_h.CXString) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4004
   pragma Import (C, clang_constructUSR_ObjCIvar, "clang_constructUSR_ObjCIvar");

   function clang_constructUSR_ObjCMethod
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : unsigned;
      arg3 : clang_c_CXString_h.CXString) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4011
   pragma Import (C, clang_constructUSR_ObjCMethod, "clang_constructUSR_ObjCMethod");

   function clang_constructUSR_ObjCProperty (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : clang_c_CXString_h.CXString) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4019
   pragma Import (C, clang_constructUSR_ObjCProperty, "clang_constructUSR_ObjCProperty");

   function clang_getCursorSpelling (arg1 : CXCursor) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4025
   pragma Import (C, clang_getCursorSpelling, "clang_getCursorSpelling");

   function clang_Cursor_getSpellingNameRange
     (arg1 : CXCursor;
      arg2 : unsigned;
      arg3 : unsigned) return CXSourceRange;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4038
   pragma Import (C, clang_Cursor_getSpellingNameRange, "clang_Cursor_getSpellingNameRange");

   function clang_getCursorDisplayName (arg1 : CXCursor) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4049
   pragma Import (C, clang_getCursorDisplayName, "clang_getCursorDisplayName");

   function clang_getCursorReferenced (arg1 : CXCursor) return CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4061
   pragma Import (C, clang_getCursorReferenced, "clang_getCursorReferenced");

   function clang_getCursorDefinition (arg1 : CXCursor) return CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4091
   pragma Import (C, clang_getCursorDefinition, "clang_getCursorDefinition");

   function clang_isCursorDefinition (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4097
   pragma Import (C, clang_isCursorDefinition, "clang_isCursorDefinition");

   function clang_getCanonicalCursor (arg1 : CXCursor) return CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4123
   pragma Import (C, clang_getCanonicalCursor, "clang_getCanonicalCursor");

   function clang_Cursor_getObjCSelectorIndex (arg1 : CXCursor) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4136
   pragma Import (C, clang_Cursor_getObjCSelectorIndex, "clang_Cursor_getObjCSelectorIndex");

   function clang_Cursor_isDynamicCall (arg1 : CXCursor) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4149
   pragma Import (C, clang_Cursor_isDynamicCall, "clang_Cursor_isDynamicCall");

   function clang_Cursor_getReceiverType (arg1 : CXCursor) return CXType;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4155
   pragma Import (C, clang_Cursor_getReceiverType, "clang_Cursor_getReceiverType");

   subtype CXObjCPropertyAttrKind is unsigned;
   CXObjCPropertyAttr_noattr : constant CXObjCPropertyAttrKind := 0;
   CXObjCPropertyAttr_readonly : constant CXObjCPropertyAttrKind := 1;
   CXObjCPropertyAttr_getter : constant CXObjCPropertyAttrKind := 2;
   CXObjCPropertyAttr_assign : constant CXObjCPropertyAttrKind := 4;
   CXObjCPropertyAttr_readwrite : constant CXObjCPropertyAttrKind := 8;
   CXObjCPropertyAttr_retain : constant CXObjCPropertyAttrKind := 16;
   CXObjCPropertyAttr_copy : constant CXObjCPropertyAttrKind := 32;
   CXObjCPropertyAttr_nonatomic : constant CXObjCPropertyAttrKind := 64;
   CXObjCPropertyAttr_setter : constant CXObjCPropertyAttrKind := 128;
   CXObjCPropertyAttr_atomic : constant CXObjCPropertyAttrKind := 256;
   CXObjCPropertyAttr_weak : constant CXObjCPropertyAttrKind := 512;
   CXObjCPropertyAttr_strong : constant CXObjCPropertyAttrKind := 1024;
   CXObjCPropertyAttr_unsafe_unretained : constant CXObjCPropertyAttrKind := 2048;
   CXObjCPropertyAttr_class : constant CXObjCPropertyAttrKind := 4096;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4175

   function clang_Cursor_getObjCPropertyAttributes (arg1 : CXCursor; arg2 : unsigned) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4184
   pragma Import (C, clang_Cursor_getObjCPropertyAttributes, "clang_Cursor_getObjCPropertyAttributes");

   subtype CXObjCDeclQualifierKind is unsigned;
   CXObjCDeclQualifier_None : constant CXObjCDeclQualifierKind := 0;
   CXObjCDeclQualifier_In : constant CXObjCDeclQualifierKind := 1;
   CXObjCDeclQualifier_Inout : constant CXObjCDeclQualifierKind := 2;
   CXObjCDeclQualifier_Out : constant CXObjCDeclQualifierKind := 4;
   CXObjCDeclQualifier_Bycopy : constant CXObjCDeclQualifierKind := 8;
   CXObjCDeclQualifier_Byref : constant CXObjCDeclQualifierKind := 16;
   CXObjCDeclQualifier_Oneway : constant CXObjCDeclQualifierKind := 32;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4199

   function clang_Cursor_getObjCDeclQualifiers (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4207
   pragma Import (C, clang_Cursor_getObjCDeclQualifiers, "clang_Cursor_getObjCDeclQualifiers");

   function clang_Cursor_isObjCOptional (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4214
   pragma Import (C, clang_Cursor_isObjCOptional, "clang_Cursor_isObjCOptional");

   function clang_Cursor_isVariadic (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4219
   pragma Import (C, clang_Cursor_isVariadic, "clang_Cursor_isVariadic");

   function clang_Cursor_isExternalSymbol
     (arg1 : CXCursor;
      arg2 : access clang_c_CXString_h.CXString;
      arg3 : access clang_c_CXString_h.CXString;
      arg4 : access unsigned) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4234
   pragma Import (C, clang_Cursor_isExternalSymbol, "clang_Cursor_isExternalSymbol");

   function clang_Cursor_getCommentRange (arg1 : CXCursor) return CXSourceRange;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4243
   pragma Import (C, clang_Cursor_getCommentRange, "clang_Cursor_getCommentRange");

   function clang_Cursor_getRawCommentText (arg1 : CXCursor) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4249
   pragma Import (C, clang_Cursor_getRawCommentText, "clang_Cursor_getRawCommentText");

   function clang_Cursor_getBriefCommentText (arg1 : CXCursor) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4256
   pragma Import (C, clang_Cursor_getBriefCommentText, "clang_Cursor_getBriefCommentText");

   function clang_Cursor_getMangling (arg1 : CXCursor) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4270
   pragma Import (C, clang_Cursor_getMangling, "clang_Cursor_getMangling");

   function clang_Cursor_getCXXManglings (arg1 : CXCursor) return access clang_c_CXString_h.CXStringSet;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4276
   pragma Import (C, clang_Cursor_getCXXManglings, "clang_Cursor_getCXXManglings");

   type CXModule is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4290

   function clang_Cursor_getModule (arg1 : CXCursor) return CXModule;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4295
   pragma Import (C, clang_Cursor_getModule, "clang_Cursor_getModule");

   function clang_getModuleForFile (arg1 : CXTranslationUnit; arg2 : CXFile) return CXModule;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4301
   pragma Import (C, clang_getModuleForFile, "clang_getModuleForFile");

   function clang_Module_getASTFile (arg1 : CXModule) return CXFile;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4308
   pragma Import (C, clang_Module_getASTFile, "clang_Module_getASTFile");

   function clang_Module_getParent (arg1 : CXModule) return CXModule;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4316
   pragma Import (C, clang_Module_getParent, "clang_Module_getParent");

   function clang_Module_getName (arg1 : CXModule) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4324
   pragma Import (C, clang_Module_getName, "clang_Module_getName");

   function clang_Module_getFullName (arg1 : CXModule) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4331
   pragma Import (C, clang_Module_getFullName, "clang_Module_getFullName");

   function clang_Module_isSystem (arg1 : CXModule) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4338
   pragma Import (C, clang_Module_isSystem, "clang_Module_isSystem");

   function clang_Module_getNumTopLevelHeaders (arg1 : CXTranslationUnit; arg2 : CXModule) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4345
   pragma Import (C, clang_Module_getNumTopLevelHeaders, "clang_Module_getNumTopLevelHeaders");

   function clang_Module_getTopLevelHeader
     (arg1 : CXTranslationUnit;
      arg2 : CXModule;
      arg3 : unsigned) return CXFile;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4356
   pragma Import (C, clang_Module_getTopLevelHeader, "clang_Module_getTopLevelHeader");

   function clang_CXXConstructor_isConvertingConstructor (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4375
   pragma Import (C, clang_CXXConstructor_isConvertingConstructor, "clang_CXXConstructor_isConvertingConstructor");

   function clang_CXXConstructor_isCopyConstructor (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4380
   pragma Import (C, clang_CXXConstructor_isCopyConstructor, "clang_CXXConstructor_isCopyConstructor");

   function clang_CXXConstructor_isDefaultConstructor (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4385
   pragma Import (C, clang_CXXConstructor_isDefaultConstructor, "clang_CXXConstructor_isDefaultConstructor");

   function clang_CXXConstructor_isMoveConstructor (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4390
   pragma Import (C, clang_CXXConstructor_isMoveConstructor, "clang_CXXConstructor_isMoveConstructor");

   function clang_CXXField_isMutable (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4395
   pragma Import (C, clang_CXXField_isMutable, "clang_CXXField_isMutable");

   function clang_CXXMethod_isDefaulted (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4400
   pragma Import (C, clang_CXXMethod_isDefaulted, "clang_CXXMethod_isDefaulted");

   function clang_CXXMethod_isPureVirtual (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4406
   pragma Import (C, clang_CXXMethod_isPureVirtual, "clang_CXXMethod_isPureVirtual");

   function clang_CXXMethod_isStatic (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4412
   pragma Import (C, clang_CXXMethod_isStatic, "clang_CXXMethod_isStatic");

   function clang_CXXMethod_isVirtual (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4419
   pragma Import (C, clang_CXXMethod_isVirtual, "clang_CXXMethod_isVirtual");

   function clang_EnumDecl_isScoped (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4424
   pragma Import (C, clang_EnumDecl_isScoped, "clang_EnumDecl_isScoped");

   function clang_CXXMethod_isConst (arg1 : CXCursor) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4430
   pragma Import (C, clang_CXXMethod_isConst, "clang_CXXMethod_isConst");

   function clang_getTemplateCursorKind (arg1 : CXCursor) return CXCursorKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4449
   pragma Import (C, clang_getTemplateCursorKind, "clang_getTemplateCursorKind");

   function clang_getSpecializedCursorTemplate (arg1 : CXCursor) return CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4479
   pragma Import (C, clang_getSpecializedCursorTemplate, "clang_getSpecializedCursorTemplate");

   function clang_getCursorReferenceNameRange
     (arg1 : CXCursor;
      arg2 : unsigned;
      arg3 : unsigned) return CXSourceRange;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4499
   pragma Import (C, clang_getCursorReferenceNameRange, "clang_getCursorReferenceNameRange");

   subtype CXNameRefFlags is unsigned;
   CXNameRange_WantQualifier : constant CXNameRefFlags := 1;
   CXNameRange_WantTemplateArgs : constant CXNameRefFlags := 2;
   CXNameRange_WantSinglePiece : constant CXNameRefFlags := 4;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4503

   type CXTokenKind is 
     (CXToken_Punctuation,
      CXToken_Keyword,
      CXToken_Identifier,
      CXToken_Literal,
      CXToken_Comment);
   pragma Convention (C, CXTokenKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4546

   type CXToken_int_data_array is array (0 .. 3) of aliased unsigned;
   type CXToken is record
      int_data : aliased CXToken_int_data_array;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4577
      ptr_data : System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4578
   end record;
   pragma Convention (C_Pass_By_Copy, CXToken);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4579

   function clang_getTokenKind (arg1 : CXToken) return CXTokenKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4584
   pragma Import (C, clang_getTokenKind, "clang_getTokenKind");

   function clang_getTokenSpelling (arg1 : CXTranslationUnit; arg2 : CXToken) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4592
   pragma Import (C, clang_getTokenSpelling, "clang_getTokenSpelling");

   function clang_getTokenLocation (arg1 : CXTranslationUnit; arg2 : CXToken) return CXSourceLocation;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4597
   pragma Import (C, clang_getTokenLocation, "clang_getTokenLocation");

   function clang_getTokenExtent (arg1 : CXTranslationUnit; arg2 : CXToken) return CXSourceRange;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4603
   pragma Import (C, clang_getTokenExtent, "clang_getTokenExtent");

   procedure clang_tokenize
     (arg1 : CXTranslationUnit;
      arg2 : CXSourceRange;
      arg3 : System.Address;
      arg4 : access unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4622
   pragma Import (C, clang_tokenize, "clang_tokenize");

   procedure clang_annotateTokens
     (arg1 : CXTranslationUnit;
      arg2 : access CXToken;
      arg3 : unsigned;
      arg4 : access CXCursor);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4655
   pragma Import (C, clang_annotateTokens, "clang_annotateTokens");

   procedure clang_disposeTokens
     (arg1 : CXTranslationUnit;
      arg2 : access CXToken;
      arg3 : unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4662
   pragma Import (C, clang_disposeTokens, "clang_disposeTokens");

   function clang_getCursorKindSpelling (arg1 : CXCursorKind) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4679
   pragma Import (C, clang_getCursorKindSpelling, "clang_getCursorKindSpelling");

   procedure clang_getDefinitionSpellingAndExtent
     (arg1 : CXCursor;
      arg2 : System.Address;
      arg3 : System.Address;
      arg4 : access unsigned;
      arg5 : access unsigned;
      arg6 : access unsigned;
      arg7 : access unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4680
   pragma Import (C, clang_getDefinitionSpellingAndExtent, "clang_getDefinitionSpellingAndExtent");

   procedure clang_enableStackTraces;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4687
   pragma Import (C, clang_enableStackTraces, "clang_enableStackTraces");

   procedure clang_executeOnThread
     (arg1 : access procedure  (arg1 : System.Address);
      arg2 : System.Address;
      arg3 : unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4688
   pragma Import (C, clang_executeOnThread, "clang_executeOnThread");

   type CXCompletionString is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4720

   type CXCompletionResult is record
      CursorKind : aliased CXCursorKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4736
      CompletionString : CXCompletionString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4742
   end record;
   pragma Convention (C_Pass_By_Copy, CXCompletionResult);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4743

   type CXCompletionChunkKind is 
     (CXCompletionChunk_Optional,
      CXCompletionChunk_TypedText,
      CXCompletionChunk_Text,
      CXCompletionChunk_Placeholder,
      CXCompletionChunk_Informative,
      CXCompletionChunk_CurrentParameter,
      CXCompletionChunk_LeftParen,
      CXCompletionChunk_RightParen,
      CXCompletionChunk_LeftBracket,
      CXCompletionChunk_RightBracket,
      CXCompletionChunk_LeftBrace,
      CXCompletionChunk_RightBrace,
      CXCompletionChunk_LeftAngle,
      CXCompletionChunk_RightAngle,
      CXCompletionChunk_Comma,
      CXCompletionChunk_ResultType,
      CXCompletionChunk_Colon,
      CXCompletionChunk_SemiColon,
      CXCompletionChunk_Equal,
      CXCompletionChunk_HorizontalSpace,
      CXCompletionChunk_VerticalSpace);
   pragma Convention (C, CXCompletionChunkKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4752

   function clang_getCompletionChunkKind (arg1 : CXCompletionString; arg2 : unsigned) return CXCompletionChunkKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4926
   pragma Import (C, clang_getCompletionChunkKind, "clang_getCompletionChunkKind");

   function clang_getCompletionChunkText (arg1 : CXCompletionString; arg2 : unsigned) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4940
   pragma Import (C, clang_getCompletionChunkText, "clang_getCompletionChunkText");

   function clang_getCompletionChunkCompletionString (arg1 : CXCompletionString; arg2 : unsigned) return CXCompletionString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4955
   pragma Import (C, clang_getCompletionChunkCompletionString, "clang_getCompletionChunkCompletionString");

   function clang_getNumCompletionChunks (arg1 : CXCompletionString) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4962
   pragma Import (C, clang_getNumCompletionChunks, "clang_getNumCompletionChunks");

   function clang_getCompletionPriority (arg1 : CXCompletionString) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4977
   pragma Import (C, clang_getCompletionPriority, "clang_getCompletionPriority");

   function clang_getCompletionAvailability (arg1 : CXCompletionString) return CXAvailabilityKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:4988
   pragma Import (C, clang_getCompletionAvailability, "clang_getCompletionAvailability");

   function clang_getCompletionNumAnnotations (arg1 : CXCompletionString) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5000
   pragma Import (C, clang_getCompletionNumAnnotations, "clang_getCompletionNumAnnotations");

   function clang_getCompletionAnnotation (arg1 : CXCompletionString; arg2 : unsigned) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5014
   pragma Import (C, clang_getCompletionAnnotation, "clang_getCompletionAnnotation");

   function clang_getCompletionParent (arg1 : CXCompletionString; arg2 : access CXCursorKind) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5034
   pragma Import (C, clang_getCompletionParent, "clang_getCompletionParent");

   function clang_getCompletionBriefComment (arg1 : CXCompletionString) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5042
   pragma Import (C, clang_getCompletionBriefComment, "clang_getCompletionBriefComment");

   function clang_getCursorCompletionString (arg1 : CXCursor) return CXCompletionString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5054
   pragma Import (C, clang_getCursorCompletionString, "clang_getCursorCompletionString");

   type CXCodeCompleteResults is record
      Results : access CXCompletionResult;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5067
      NumResults : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5073
   end record;
   pragma Convention (C_Pass_By_Copy, CXCodeCompleteResults);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5074

   subtype CXCodeComplete_Flags is unsigned;
   CXCodeComplete_IncludeMacros : constant CXCodeComplete_Flags := 1;
   CXCodeComplete_IncludeCodePatterns : constant CXCodeComplete_Flags := 2;
   CXCodeComplete_IncludeBriefComments : constant CXCodeComplete_Flags := 4;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5083

   subtype CXCompletionContext is unsigned;
   CXCompletionContext_Unexposed : constant CXCompletionContext := 0;
   CXCompletionContext_AnyType : constant CXCompletionContext := 1;
   CXCompletionContext_AnyValue : constant CXCompletionContext := 2;
   CXCompletionContext_ObjCObjectValue : constant CXCompletionContext := 4;
   CXCompletionContext_ObjCSelectorValue : constant CXCompletionContext := 8;
   CXCompletionContext_CXXClassTypeValue : constant CXCompletionContext := 16;
   CXCompletionContext_DotMemberAccess : constant CXCompletionContext := 32;
   CXCompletionContext_ArrowMemberAccess : constant CXCompletionContext := 64;
   CXCompletionContext_ObjCPropertyAccess : constant CXCompletionContext := 128;
   CXCompletionContext_EnumTag : constant CXCompletionContext := 256;
   CXCompletionContext_UnionTag : constant CXCompletionContext := 512;
   CXCompletionContext_StructTag : constant CXCompletionContext := 1024;
   CXCompletionContext_ClassTag : constant CXCompletionContext := 2048;
   CXCompletionContext_Namespace : constant CXCompletionContext := 4096;
   CXCompletionContext_NestedNameSpecifier : constant CXCompletionContext := 8192;
   CXCompletionContext_ObjCInterface : constant CXCompletionContext := 16384;
   CXCompletionContext_ObjCProtocol : constant CXCompletionContext := 32768;
   CXCompletionContext_ObjCCategory : constant CXCompletionContext := 65536;
   CXCompletionContext_ObjCInstanceMessage : constant CXCompletionContext := 131072;
   CXCompletionContext_ObjCClassMessage : constant CXCompletionContext := 262144;
   CXCompletionContext_ObjCSelectorName : constant CXCompletionContext := 524288;
   CXCompletionContext_MacroName : constant CXCompletionContext := 1048576;
   CXCompletionContext_NaturalLanguage : constant CXCompletionContext := 2097152;
   CXCompletionContext_Unknown : constant CXCompletionContext := 4194303;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5109

   function clang_defaultCodeCompleteOptions return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5238
   pragma Import (C, clang_defaultCodeCompleteOptions, "clang_defaultCodeCompleteOptions");

   function clang_codeCompleteAt
     (arg1 : CXTranslationUnit;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : unsigned;
      arg4 : unsigned;
      arg5 : access CXUnsavedFile;
      arg6 : unsigned;
      arg7 : unsigned) return access CXCodeCompleteResults;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5309
   pragma Import (C, clang_codeCompleteAt, "clang_codeCompleteAt");

   procedure clang_sortCodeCompletionResults (arg1 : access CXCompletionResult; arg2 : unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5325
   pragma Import (C, clang_sortCodeCompletionResults, "clang_sortCodeCompletionResults");

   procedure clang_disposeCodeCompleteResults (arg1 : access CXCodeCompleteResults);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5332
   pragma Import (C, clang_disposeCodeCompleteResults, "clang_disposeCodeCompleteResults");

   function clang_codeCompleteGetNumDiagnostics (arg1 : access CXCodeCompleteResults) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5339
   pragma Import (C, clang_codeCompleteGetNumDiagnostics, "clang_codeCompleteGetNumDiagnostics");

   function clang_codeCompleteGetDiagnostic (arg1 : access CXCodeCompleteResults; arg2 : unsigned) return CXDiagnostic;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5351
   pragma Import (C, clang_codeCompleteGetDiagnostic, "clang_codeCompleteGetDiagnostic");

   function clang_codeCompleteGetContexts (arg1 : access CXCodeCompleteResults) return Extensions.unsigned_long_long;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5364
   pragma Import (C, clang_codeCompleteGetContexts, "clang_codeCompleteGetContexts");

   function clang_codeCompleteGetContainerKind (arg1 : access CXCodeCompleteResults; arg2 : access unsigned) return CXCursorKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5384
   pragma Import (C, clang_codeCompleteGetContainerKind, "clang_codeCompleteGetContainerKind");

   function clang_codeCompleteGetContainerUSR (arg1 : access CXCodeCompleteResults) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5398
   pragma Import (C, clang_codeCompleteGetContainerUSR, "clang_codeCompleteGetContainerUSR");

   function clang_codeCompleteGetObjCSelector (arg1 : access CXCodeCompleteResults) return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5412
   pragma Import (C, clang_codeCompleteGetObjCSelector, "clang_codeCompleteGetObjCSelector");

   function clang_getClangVersion return clang_c_CXString_h.CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5428
   pragma Import (C, clang_getClangVersion, "clang_getClangVersion");

   procedure clang_toggleCrashRecovery (arg1 : unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5436
   pragma Import (C, clang_toggleCrashRecovery, "clang_toggleCrashRecovery");

   type CXInclusionVisitor is access procedure 
        (arg1 : CXFile;
         arg2 : access CXSourceLocation;
         arg3 : unsigned;
         arg4 : CXClientData);
   pragma Convention (C, CXInclusionVisitor);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5449

   procedure clang_getInclusions
     (arg1 : CXTranslationUnit;
      arg2 : CXInclusionVisitor;
      arg3 : CXClientData);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5460
   pragma Import (C, clang_getInclusions, "clang_getInclusions");

   subtype CXEvalResultKind is unsigned;
   CXEval_Int : constant CXEvalResultKind := 1;
   CXEval_Float : constant CXEvalResultKind := 2;
   CXEval_ObjCStrLiteral : constant CXEvalResultKind := 3;
   CXEval_StrLiteral : constant CXEvalResultKind := 4;
   CXEval_CFStr : constant CXEvalResultKind := 5;
   CXEval_Other : constant CXEvalResultKind := 6;
   CXEval_UnExposed : constant CXEvalResultKind := 0;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5474

   type CXEvalResult is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5479

   function clang_Cursor_Evaluate (arg1 : CXCursor) return CXEvalResult;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5486
   pragma Import (C, clang_Cursor_Evaluate, "clang_Cursor_Evaluate");

   function clang_EvalResult_getKind (arg1 : CXEvalResult) return CXEvalResultKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5491
   pragma Import (C, clang_EvalResult_getKind, "clang_EvalResult_getKind");

   function clang_EvalResult_getAsInt (arg1 : CXEvalResult) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5497
   pragma Import (C, clang_EvalResult_getAsInt, "clang_EvalResult_getAsInt");

   function clang_EvalResult_getAsLongLong (arg1 : CXEvalResult) return Long_Long_Integer;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5504
   pragma Import (C, clang_EvalResult_getAsLongLong, "clang_EvalResult_getAsLongLong");

   function clang_EvalResult_isUnsignedInt (arg1 : CXEvalResult) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5510
   pragma Import (C, clang_EvalResult_isUnsignedInt, "clang_EvalResult_isUnsignedInt");

   function clang_EvalResult_getAsUnsigned (arg1 : CXEvalResult) return Extensions.unsigned_long_long;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5516
   pragma Import (C, clang_EvalResult_getAsUnsigned, "clang_EvalResult_getAsUnsigned");

   function clang_EvalResult_getAsDouble (arg1 : CXEvalResult) return double;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5522
   pragma Import (C, clang_EvalResult_getAsDouble, "clang_EvalResult_getAsDouble");

   function clang_EvalResult_getAsStr (arg1 : CXEvalResult) return Interfaces.C.Strings.chars_ptr;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5530
   pragma Import (C, clang_EvalResult_getAsStr, "clang_EvalResult_getAsStr");

   procedure clang_EvalResult_dispose (arg1 : CXEvalResult);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5535
   pragma Import (C, clang_EvalResult_dispose, "clang_EvalResult_dispose");

   type CXRemapping is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5548

   function clang_getRemappings (arg1 : Interfaces.C.Strings.chars_ptr) return CXRemapping;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5558
   pragma Import (C, clang_getRemappings, "clang_getRemappings");

   function clang_getRemappingsFromFileList (arg1 : System.Address; arg2 : unsigned) return CXRemapping;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5571
   pragma Import (C, clang_getRemappingsFromFileList, "clang_getRemappingsFromFileList");

   function clang_remap_getNumFiles (arg1 : CXRemapping) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5577
   pragma Import (C, clang_remap_getNumFiles, "clang_remap_getNumFiles");

   procedure clang_remap_getFilenames
     (arg1 : CXRemapping;
      arg2 : unsigned;
      arg3 : access clang_c_CXString_h.CXString;
      arg4 : access clang_c_CXString_h.CXString);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5587
   pragma Import (C, clang_remap_getFilenames, "clang_remap_getFilenames");

   procedure clang_remap_dispose (arg1 : CXRemapping);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5593
   pragma Import (C, clang_remap_dispose, "clang_remap_dispose");

   type CXVisitorResult is 
     (CXVisit_Break,
      CXVisit_Continue);
   pragma Convention (C, CXVisitorResult);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5604

   type CXCursorAndRangeVisitor is record
      context : System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5610
      visit : access function 
           (arg1 : System.Address;
            arg2 : CXCursor;
            arg3 : CXSourceRange) return CXVisitorResult;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5611
   end record;
   pragma Convention (C_Pass_By_Copy, CXCursorAndRangeVisitor);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5609

   type CXResult is 
     (CXResult_Success,
      CXResult_Invalid,
      CXResult_VisitBreak);
   pragma Convention (C, CXResult);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5629

   function clang_findReferencesInFile
     (arg1 : CXCursor;
      arg2 : CXFile;
      arg3 : CXCursorAndRangeVisitor) return CXResult;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5645
   pragma Import (C, clang_findReferencesInFile, "clang_findReferencesInFile");

   function clang_findIncludesInFile
     (arg1 : CXTranslationUnit;
      arg2 : CXFile;
      arg3 : CXCursorAndRangeVisitor) return CXResult;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5660
   pragma Import (C, clang_findIncludesInFile, "clang_findIncludesInFile");

   type CXIdxClientFile is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5684

   type CXIdxClientEntity is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5689

   type CXIdxClientContainer is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5695

   type CXIdxClientASTFile is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5701

   type CXIdxLoc_ptr_data_array is array (0 .. 1) of System.Address;
   type CXIdxLoc is record
      ptr_data : CXIdxLoc_ptr_data_array;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5707
      int_data : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5708
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxLoc);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5709

   type CXIdxIncludedFileInfo is record
      hashLoc : aliased CXIdxLoc;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5718
      filename : Interfaces.C.Strings.chars_ptr;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5722
      file : CXFile;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5726
      isImport : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5727
      isAngled : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5728
      isModuleImport : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5733
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxIncludedFileInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5734

   type CXIdxImportedASTFileInfo is record
      file : CXFile;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5743
      module : CXModule;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5747
      loc : aliased CXIdxLoc;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5751
      isImplicit : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5756
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxImportedASTFileInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5758

   type CXIdxEntityKind is 
     (CXIdxEntity_Unexposed,
      CXIdxEntity_Typedef,
      CXIdxEntity_Function,
      CXIdxEntity_Variable,
      CXIdxEntity_Field,
      CXIdxEntity_EnumConstant,
      CXIdxEntity_ObjCClass,
      CXIdxEntity_ObjCProtocol,
      CXIdxEntity_ObjCCategory,
      CXIdxEntity_ObjCInstanceMethod,
      CXIdxEntity_ObjCClassMethod,
      CXIdxEntity_ObjCProperty,
      CXIdxEntity_ObjCIvar,
      CXIdxEntity_Enum,
      CXIdxEntity_Struct,
      CXIdxEntity_Union,
      CXIdxEntity_CXXClass,
      CXIdxEntity_CXXNamespace,
      CXIdxEntity_CXXNamespaceAlias,
      CXIdxEntity_CXXStaticVariable,
      CXIdxEntity_CXXStaticMethod,
      CXIdxEntity_CXXInstanceMethod,
      CXIdxEntity_CXXConstructor,
      CXIdxEntity_CXXDestructor,
      CXIdxEntity_CXXConversionFunction,
      CXIdxEntity_CXXTypeAlias,
      CXIdxEntity_CXXInterface);
   pragma Convention (C, CXIdxEntityKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5793

   type CXIdxEntityLanguage is 
     (CXIdxEntityLang_None,
      CXIdxEntityLang_C,
      CXIdxEntityLang_ObjC,
      CXIdxEntityLang_CXX,
      CXIdxEntityLang_Swift);
   pragma Convention (C, CXIdxEntityLanguage);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5801

   type CXIdxEntityCXXTemplateKind is 
     (CXIdxEntity_NonTemplate,
      CXIdxEntity_Template,
      CXIdxEntity_TemplatePartialSpecialization,
      CXIdxEntity_TemplateSpecialization);
   pragma Convention (C, CXIdxEntityCXXTemplateKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5818

   type CXIdxAttrKind is 
     (CXIdxAttr_Unexposed,
      CXIdxAttr_IBAction,
      CXIdxAttr_IBOutlet,
      CXIdxAttr_IBOutletCollection);
   pragma Convention (C, CXIdxAttrKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5825

   type CXIdxAttrInfo is record
      kind : aliased CXIdxAttrKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5828
      cursor : aliased CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5829
      loc : aliased CXIdxLoc;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5830
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxAttrInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5831

   type CXIdxEntityInfo is record
      kind : aliased CXIdxEntityKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5834
      templateKind : aliased CXIdxEntityCXXTemplateKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5835
      lang : aliased CXIdxEntityLanguage;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5836
      name : Interfaces.C.Strings.chars_ptr;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5837
      USR : Interfaces.C.Strings.chars_ptr;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5838
      cursor : aliased CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5839
      attributes : System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5840
      numAttributes : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5841
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxEntityInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5842

   type CXIdxContainerInfo is record
      cursor : aliased CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5845
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxContainerInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5846

   type CXIdxIBOutletCollectionAttrInfo is record
      attrInfo : access constant CXIdxAttrInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5849
      objcClass : access constant CXIdxEntityInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5850
      classCursor : aliased CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5851
      classLoc : aliased CXIdxLoc;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5852
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxIBOutletCollectionAttrInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5853

   subtype CXIdxDeclInfoFlags is unsigned;
   CXIdxDeclFlag_Skipped : constant CXIdxDeclInfoFlags := 1;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5857

   type CXIdxDeclInfo is record
      entityInfo : access constant CXIdxEntityInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5860
      cursor : aliased CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5861
      loc : aliased CXIdxLoc;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5862
      semanticContainer : access constant CXIdxContainerInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5863
      lexicalContainer : access constant CXIdxContainerInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5868
      isRedeclaration : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5869
      isDefinition : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5870
      isContainer : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5871
      declAsContainer : access constant CXIdxContainerInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5872
      isImplicit : aliased int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5877
      attributes : System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5878
      numAttributes : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5879
      flags : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5881
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxDeclInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5883

   type CXIdxObjCContainerKind is 
     (CXIdxObjCContainer_ForwardRef,
      CXIdxObjCContainer_Interface,
      CXIdxObjCContainer_Implementation);
   pragma Convention (C, CXIdxObjCContainerKind);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5889

   type CXIdxObjCContainerDeclInfo is record
      declInfo : access constant CXIdxDeclInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5892
      kind : aliased CXIdxObjCContainerKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5893
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxObjCContainerDeclInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5894

   type CXIdxBaseClassInfo is record
      base : access constant CXIdxEntityInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5897
      cursor : aliased CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5898
      loc : aliased CXIdxLoc;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5899
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxBaseClassInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5900

   type CXIdxObjCProtocolRefInfo is record
      protocol : access constant CXIdxEntityInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5903
      cursor : aliased CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5904
      loc : aliased CXIdxLoc;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5905
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxObjCProtocolRefInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5906

   type CXIdxObjCProtocolRefListInfo is record
      protocols : System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5909
      numProtocols : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5910
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxObjCProtocolRefListInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5911

   type CXIdxObjCInterfaceDeclInfo is record
      containerInfo : access constant CXIdxObjCContainerDeclInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5914
      superInfo : access constant CXIdxBaseClassInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5915
      protocols : access constant CXIdxObjCProtocolRefListInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5916
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxObjCInterfaceDeclInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5917

   type CXIdxObjCCategoryDeclInfo is record
      containerInfo : access constant CXIdxObjCContainerDeclInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5920
      objcClass : access constant CXIdxEntityInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5921
      classCursor : aliased CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5922
      classLoc : aliased CXIdxLoc;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5923
      protocols : access constant CXIdxObjCProtocolRefListInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5924
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxObjCCategoryDeclInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5925

   type CXIdxObjCPropertyDeclInfo is record
      declInfo : access constant CXIdxDeclInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5928
      getter : access constant CXIdxEntityInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5929
      setter : access constant CXIdxEntityInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5930
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxObjCPropertyDeclInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5931

   type CXIdxCXXClassDeclInfo is record
      declInfo : access constant CXIdxDeclInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5934
      bases : System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5935
      numBases : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5936
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxCXXClassDeclInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5937

   subtype CXIdxEntityRefKind is unsigned;
   CXIdxEntityRef_Direct : constant CXIdxEntityRefKind := 1;
   CXIdxEntityRef_Implicit : constant CXIdxEntityRefKind := 2;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5952

   type CXIdxEntityRefInfo is record
      kind : aliased CXIdxEntityRefKind;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5958
      cursor : aliased CXCursor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5962
      loc : aliased CXIdxLoc;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5963
      referencedEntity : access constant CXIdxEntityInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5967
      parentEntity : access constant CXIdxEntityInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5979
      container : access constant CXIdxContainerInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5983
   end record;
   pragma Convention (C_Pass_By_Copy, CXIdxEntityRefInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5984

   type IndexerCallbacks is record
      abortQuery : access function  (arg1 : CXClientData; arg2 : System.Address) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:5995
      diagnostic : access procedure 
           (arg1 : CXClientData;
            arg2 : CXDiagnosticSet;
            arg3 : System.Address);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6000
      enteredMainFile : access function 
           (arg1 : CXClientData;
            arg2 : CXFile;
            arg3 : System.Address) return CXIdxClientFile;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6003
      ppIncludedFile : access function  (arg1 : CXClientData; arg2 : access constant CXIdxIncludedFileInfo) return CXIdxClientFile;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6009
      importedASTFile : access function  (arg1 : CXClientData; arg2 : access constant CXIdxImportedASTFileInfo) return CXIdxClientASTFile;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6020
      startedTranslationUnit : access function  (arg1 : CXClientData; arg2 : System.Address) return CXIdxClientContainer;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6026
      indexDeclaration : access procedure  (arg1 : CXClientData; arg2 : access constant CXIdxDeclInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6029
      indexEntityReference : access procedure  (arg1 : CXClientData; arg2 : access constant CXIdxEntityRefInfo);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6035
   end record;
   pragma Convention (C_Pass_By_Copy, IndexerCallbacks);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6038

   function clang_index_isEntityObjCContainerKind (arg1 : CXIdxEntityKind) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6040
   pragma Import (C, clang_index_isEntityObjCContainerKind, "clang_index_isEntityObjCContainerKind");

   function clang_index_getObjCContainerDeclInfo (arg1 : access constant CXIdxDeclInfo) return access constant CXIdxObjCContainerDeclInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6042
   pragma Import (C, clang_index_getObjCContainerDeclInfo, "clang_index_getObjCContainerDeclInfo");

   function clang_index_getObjCInterfaceDeclInfo (arg1 : access constant CXIdxDeclInfo) return access constant CXIdxObjCInterfaceDeclInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6045
   pragma Import (C, clang_index_getObjCInterfaceDeclInfo, "clang_index_getObjCInterfaceDeclInfo");

   function clang_index_getObjCCategoryDeclInfo (arg1 : access constant CXIdxDeclInfo) return access constant CXIdxObjCCategoryDeclInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6049
   pragma Import (C, clang_index_getObjCCategoryDeclInfo, "clang_index_getObjCCategoryDeclInfo");

   function clang_index_getObjCProtocolRefListInfo (arg1 : access constant CXIdxDeclInfo) return access constant CXIdxObjCProtocolRefListInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6052
   pragma Import (C, clang_index_getObjCProtocolRefListInfo, "clang_index_getObjCProtocolRefListInfo");

   function clang_index_getObjCPropertyDeclInfo (arg1 : access constant CXIdxDeclInfo) return access constant CXIdxObjCPropertyDeclInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6055
   pragma Import (C, clang_index_getObjCPropertyDeclInfo, "clang_index_getObjCPropertyDeclInfo");

   function clang_index_getIBOutletCollectionAttrInfo (arg1 : access constant CXIdxAttrInfo) return access constant CXIdxIBOutletCollectionAttrInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6058
   pragma Import (C, clang_index_getIBOutletCollectionAttrInfo, "clang_index_getIBOutletCollectionAttrInfo");

   function clang_index_getCXXClassDeclInfo (arg1 : access constant CXIdxDeclInfo) return access constant CXIdxCXXClassDeclInfo;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6061
   pragma Import (C, clang_index_getCXXClassDeclInfo, "clang_index_getCXXClassDeclInfo");

   function clang_index_getClientContainer (arg1 : access constant CXIdxContainerInfo) return CXIdxClientContainer;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6068
   pragma Import (C, clang_index_getClientContainer, "clang_index_getClientContainer");

   procedure clang_index_setClientContainer (arg1 : access constant CXIdxContainerInfo; arg2 : CXIdxClientContainer);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6075
   pragma Import (C, clang_index_setClientContainer, "clang_index_setClientContainer");

   function clang_index_getClientEntity (arg1 : access constant CXIdxEntityInfo) return CXIdxClientEntity;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6081
   pragma Import (C, clang_index_getClientEntity, "clang_index_getClientEntity");

   procedure clang_index_setClientEntity (arg1 : access constant CXIdxEntityInfo; arg2 : CXIdxClientEntity);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6087
   pragma Import (C, clang_index_setClientEntity, "clang_index_setClientEntity");

   type CXIndexAction is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6093

   function clang_IndexAction_create (arg1 : CXIndex) return CXIndexAction;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6101
   pragma Import (C, clang_IndexAction_create, "clang_IndexAction_create");

   procedure clang_IndexAction_dispose (arg1 : CXIndexAction);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6109
   pragma Import (C, clang_IndexAction_dispose, "clang_IndexAction_dispose");

   subtype CXIndexOptFlags is unsigned;
   CXIndexOpt_None : constant CXIndexOptFlags := 0;
   CXIndexOpt_SuppressRedundantRefs : constant CXIndexOptFlags := 1;
   CXIndexOpt_IndexFunctionLocalSymbols : constant CXIndexOptFlags := 2;
   CXIndexOpt_IndexImplicitTemplateInstantiations : constant CXIndexOptFlags := 4;
   CXIndexOpt_SuppressWarnings : constant CXIndexOptFlags := 8;
   CXIndexOpt_SkipParsedBodiesInSession : constant CXIndexOptFlags := 16;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6148

   function clang_indexSourceFile
     (arg1 : CXIndexAction;
      arg2 : CXClientData;
      arg3 : access IndexerCallbacks;
      arg4 : unsigned;
      arg5 : unsigned;
      arg6 : Interfaces.C.Strings.chars_ptr;
      arg7 : System.Address;
      arg8 : int;
      arg9 : access CXUnsavedFile;
      arg10 : unsigned;
      arg11 : System.Address;
      arg12 : unsigned) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6175
   pragma Import (C, clang_indexSourceFile, "clang_indexSourceFile");

   function clang_indexSourceFileFullArgv
     (arg1 : CXIndexAction;
      arg2 : CXClientData;
      arg3 : access IndexerCallbacks;
      arg4 : unsigned;
      arg5 : unsigned;
      arg6 : Interfaces.C.Strings.chars_ptr;
      arg7 : System.Address;
      arg8 : int;
      arg9 : access CXUnsavedFile;
      arg10 : unsigned;
      arg11 : System.Address;
      arg12 : unsigned) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6193
   pragma Import (C, clang_indexSourceFileFullArgv, "clang_indexSourceFileFullArgv");

   function clang_indexTranslationUnit
     (arg1 : CXIndexAction;
      arg2 : CXClientData;
      arg3 : access IndexerCallbacks;
      arg4 : unsigned;
      arg5 : unsigned;
      arg6 : CXTranslationUnit) return int;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6216
   pragma Import (C, clang_indexTranslationUnit, "clang_indexTranslationUnit");

   procedure clang_indexLoc_getFileLocation
     (arg1 : CXIdxLoc;
      arg2 : System.Address;
      arg3 : System.Address;
      arg4 : access unsigned;
      arg5 : access unsigned;
      arg6 : access unsigned);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6231
   pragma Import (C, clang_indexLoc_getFileLocation, "clang_indexLoc_getFileLocation");

   function clang_indexLoc_getCXSourceLocation (arg1 : CXIdxLoc) return CXSourceLocation;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6242
   pragma Import (C, clang_indexLoc_getCXSourceLocation, "clang_indexLoc_getCXSourceLocation");

   type CXFieldVisitor is access function  (arg1 : CXCursor; arg2 : CXClientData) return CXVisitorResult;
   pragma Convention (C, CXFieldVisitor);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6255

   function clang_Type_visitFields
     (arg1 : CXType;
      arg2 : CXFieldVisitor;
      arg3 : CXClientData) return unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/Index.h:6277
   pragma Import (C, clang_Type_visitFields, "clang_Type_visitFields");

end clang_c_Index_h;
