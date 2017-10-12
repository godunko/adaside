pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with System;
with Interfaces.C.Strings;
with clang_c_CXErrorCode_h;

package clang_c_BuildSystem_h is

   function clang_getBuildSessionTimestamp return Extensions.unsigned_long_long;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:34
   pragma Import (C, clang_getBuildSessionTimestamp, "clang_getBuildSessionTimestamp");

   --  skipped empty struct CXVirtualFileOverlayImpl

   type CXVirtualFileOverlay is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:40

   function clang_VirtualFileOverlay_create (arg1 : unsigned) return CXVirtualFileOverlay;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:49
   pragma Import (C, clang_VirtualFileOverlay_create, "clang_VirtualFileOverlay_create");

   function clang_VirtualFileOverlay_addFileMapping
     (arg1 : CXVirtualFileOverlay;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr) return clang_c_CXErrorCode_h.CXErrorCode;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:57
   pragma Import (C, clang_VirtualFileOverlay_addFileMapping, "clang_VirtualFileOverlay_addFileMapping");

   function clang_VirtualFileOverlay_setCaseSensitivity (arg1 : CXVirtualFileOverlay; arg2 : int) return clang_c_CXErrorCode_h.CXErrorCode;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:68
   pragma Import (C, clang_VirtualFileOverlay_setCaseSensitivity, "clang_VirtualFileOverlay_setCaseSensitivity");

   function clang_VirtualFileOverlay_writeToBuffer
     (arg1 : CXVirtualFileOverlay;
      arg2 : unsigned;
      arg3 : System.Address;
      arg4 : access unsigned) return clang_c_CXErrorCode_h.CXErrorCode;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:81
   pragma Import (C, clang_VirtualFileOverlay_writeToBuffer, "clang_VirtualFileOverlay_writeToBuffer");

   procedure clang_free (arg1 : System.Address);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:91
   pragma Import (C, clang_free, "clang_free");

   procedure clang_VirtualFileOverlay_dispose (arg1 : CXVirtualFileOverlay);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:96
   pragma Import (C, clang_VirtualFileOverlay_dispose, "clang_VirtualFileOverlay_dispose");

   --  skipped empty struct CXModuleMapDescriptorImpl

   type CXModuleMapDescriptor is new System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:101

   function clang_ModuleMapDescriptor_create (arg1 : unsigned) return CXModuleMapDescriptor;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:110
   pragma Import (C, clang_ModuleMapDescriptor_create, "clang_ModuleMapDescriptor_create");

   function clang_ModuleMapDescriptor_setFrameworkModuleName (arg1 : CXModuleMapDescriptor; arg2 : Interfaces.C.Strings.chars_ptr) return clang_c_CXErrorCode_h.CXErrorCode;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:117
   pragma Import (C, clang_ModuleMapDescriptor_setFrameworkModuleName, "clang_ModuleMapDescriptor_setFrameworkModuleName");

   function clang_ModuleMapDescriptor_setUmbrellaHeader (arg1 : CXModuleMapDescriptor; arg2 : Interfaces.C.Strings.chars_ptr) return clang_c_CXErrorCode_h.CXErrorCode;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:125
   pragma Import (C, clang_ModuleMapDescriptor_setUmbrellaHeader, "clang_ModuleMapDescriptor_setUmbrellaHeader");

   function clang_ModuleMapDescriptor_writeToBuffer
     (arg1 : CXModuleMapDescriptor;
      arg2 : unsigned;
      arg3 : System.Address;
      arg4 : access unsigned) return clang_c_CXErrorCode_h.CXErrorCode;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:138
   pragma Import (C, clang_ModuleMapDescriptor_writeToBuffer, "clang_ModuleMapDescriptor_writeToBuffer");

   procedure clang_ModuleMapDescriptor_dispose (arg1 : CXModuleMapDescriptor);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/BuildSystem.h:145
   pragma Import (C, clang_ModuleMapDescriptor_dispose, "clang_ModuleMapDescriptor_dispose");

end clang_c_BuildSystem_h;
