pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package clang_c_CXErrorCode_h is

   type CXErrorCode is 
     (CXError_Success,
      CXError_Failure,
      CXError_Crashed,
      CXError_InvalidArguments,
      CXError_ASTReadError);
   pragma Convention (C, CXErrorCode);  -- /home/godunko/local/llvm-5.0.0/include/clang-c/CXErrorCode.h:29

end clang_c_CXErrorCode_h;
