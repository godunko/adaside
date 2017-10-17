
package body Clang.Locations is

   ----------------------------
   -- Get_Expansion_Location --
   ----------------------------

   procedure Get_Expansion_Location
    (Location : clang_c_Index_h.CXSourceLocation;
     File     : out clang_c_Index_h.CXFile;
     Line     : out Interfaces.C.unsigned;
     Column   : out Interfaces.C.unsigned;
     Offset   : out Interfaces.C.unsigned)
   is
      C_Line   : aliased Interfaces.C.unsigned;
      C_Column : aliased Interfaces.C.unsigned;
      C_Offset : aliased Interfaces.C.unsigned;

   begin
      clang_c_Index_h.clang_getExpansionLocation
       (Location,
        File'Address,
        C_Line'Access,
        C_Column'Access,
        C_Offset'Access);
      Line := C_Line;
      Column := C_Column;
      Offset := C_Offset;
   end Get_Expansion_Location;

end Clang.Locations;
