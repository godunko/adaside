pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
with Interfaces.C.Strings;

package clang_c_CXString_h is

   type CXString is record
      data : System.Address;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/CXString.h:39
      private_flags : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/CXString.h:40
   end record;
   pragma Convention (C_Pass_By_Copy, CXString);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/CXString.h:41

   type CXStringSet is record
      Strings : access CXString;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/CXString.h:44
      Count : aliased unsigned;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/CXString.h:45
   end record;
   pragma Convention (C_Pass_By_Copy, CXStringSet);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/CXString.h:46

   function clang_getCString (arg1 : CXString) return Interfaces.C.Strings.chars_ptr;  -- /home/godunko/local/llvm-5.0.0/include/clang-c/CXString.h:51
   pragma Import (C, clang_getCString, "clang_getCString");

   procedure clang_disposeString (arg1 : CXString);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/CXString.h:56
   pragma Import (C, clang_disposeString, "clang_disposeString");

   procedure clang_disposeStringSet (arg1 : access CXStringSet);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/CXString.h:61
   pragma Import (C, clang_disposeStringSet, "clang_disposeStringSet");

end clang_c_CXString_h;
