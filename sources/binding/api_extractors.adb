with Interfaces.C.Extensions;

package body API_Extractors is

   use type Interfaces.C.Extensions.bool;

   procedure ApiExtractor_delete (This : in out ApiExtractor_Access)
     with Import     => True,
          Convention => C,
          Link_Name  => "ApiExtractor__delete";

   function ApiExtractor_run (This : not null ApiExtractor_Access)
     return Interfaces.C.Extensions.bool
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

   procedure ApiExtractor_addIncludePath
    (This : not null ApiExtractor_Access;
     Path : not null Header_Paths.Internals.HeaderPath_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "ApiExtractor__addIncludePath";

   procedure ApiExtractor_classes
    (Result : not null Abstract_Meta_Class_Lists.Internals
                        .AbstractMetaClassList_Access;
     This   : not null ApiExtractor_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "ApiExtractor__classes";

   ----------------------
   -- Add_Include_Path --
   ----------------------

   procedure Add_Include_Path
    (Self : in out API_Extractor'Class;
     Path : Header_Paths.Header_Path'Class) is
   begin
      ApiExtractor_addIncludePath
        (Self.Object, Header_Paths.Internals.Internal (Path));
   end Add_Include_Path;

   -------------
   -- Classes --
   -------------

   function Classes
    (Self : API_Extractor'Class)
       return Abstract_Meta_Class_Lists.Abstract_Meta_Class_List is
   begin
      return Result : Abstract_Meta_Class_Lists.Abstract_Meta_Class_List do
         ApiExtractor_classes
          (Abstract_Meta_Class_Lists.Internals.Internal (Result), Self.Object);
      end return;
   end Classes;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out API_Extractor) is
   begin
      if Self.Object /= null then
         ApiExtractor_delete (Self.Object);
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
      ApiExtractor_setCppFileName
        (Self.Object, Q_Strings.Internals.Internal (File_Name));
   end Set_Cpp_File_Name;

   ---------------------
   -- Set_Type_System --
   ---------------------

   procedure Set_Type_System
    (Self      : in out API_Extractor'Class;
     File_Name : Q_Strings.Q_String'Class) is
   begin
      ApiExtractor_setTypeSystem
        (Self.Object, Q_Strings.Internals.Internal (File_Name));
   end Set_Type_System;

end API_Extractors;
