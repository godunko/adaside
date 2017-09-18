with Interfaces.C.Extensions;

package body API_Extractors is

   use type Interfaces.C.Extensions.bool;

   procedure ApiExtractor_delete (This : in out ApiExtractor_Access)
     with Import     => True,
          Convention => C,
          Link_Name  => "ApiExtractor__delete";

   function ApiExtractor_run (This : not null ApiExtractor_Access) return Interfaces.C.Extensions.bool
     with Import     => True,
          Convention => C,
          Link_Name  => "ApiExtractor__run";

   procedure ApiExtractor_setCppFileName
    (This      : not null ApiExtractor_Access;
     File_Name : not null Q_Strings.Internals.QString_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "ApiExtractor__setCppFileName";

   procedure ApiExtractor_setTypeSystem
    (This      : not null ApiExtractor_Access;
     File_Name : not null Q_Strings.Internals.QString_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "ApiExtractor__setTypeSystem";

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out API_Extractor) is
   begin
      if Self.Object /= null then
         ApiExtractor_delete(Self.Object);
         Self.Object := null;
      end if;
   end Finalize;

   ---------
   -- Run --
   ---------

   function Run (Self : in out API_Extractor'Class) return Boolean is
   begin
      return ApiExtractor_run (Self.Object) /= 0;
   end Run;

   -----------------------
   -- Set_Cpp_File_Name --
   -----------------------

   procedure Set_Cpp_File_Name
    (Self      : in out API_Extractor'Class;
     File_Name : Q_Strings.Q_String'Class) is
   begin
      ApiExtractor_setCppFileName (Self.Object, Q_Strings.Internals.Internal (File_Name));
   end Set_Cpp_File_Name;

   ---------------------
   -- Set_Type_System --
   ---------------------

   procedure Set_Type_System
    (Self      : in out API_Extractor'Class;
     File_Name : Q_Strings.Q_String'Class) is
   begin
      ApiExtractor_setTypeSystem (Self.Object, Q_Strings.Internals.Internal (File_Name));
   end Set_Type_System;

end API_Extractors;
