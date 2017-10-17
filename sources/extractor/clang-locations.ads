with Interfaces.C;

with clang_c_Index_h;

package Clang.Locations is

   procedure Get_Expansion_Location
    (Location : clang_c_Index_h.CXSourceLocation;
     File     : out clang_c_Index_h.CXFile;
     Line     : out Interfaces.C.unsigned;
     Column   : out Interfaces.C.unsigned;
     Offset   : out Interfaces.C.unsigned);
   --  Wrapper of clang_getExpansionLocation().

end Clang.Locations;
