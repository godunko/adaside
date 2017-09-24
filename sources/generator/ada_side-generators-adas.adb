with Ada_Side.Generators.Adas.Value_API_Spec;
with Ada_Side.Generators.Adas.Value_Spec;

package body Ada_Side.Generators.Adas is

   use type League.Strings.Universal_String;

   -------------------------------
   -- API_Access_Type_Full_Name --
   -------------------------------

   function API_Access_Type_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return
        API_Package_Full_Name (Class)
          & '.'
          & Ada_Side.Generators.Adas.Value_API_Spec.API_Access_Type_Name
             (Class);
   end API_Access_Type_Full_Name;

   ---------------------------
   -- API_Package_Full_Name --
   ---------------------------

   function API_Package_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String
         renames Ada_Side.Generators.Adas.Value_API_Spec.API_Package_Full_Name;

   --------------------------------
   -- API_Storage_Type_Full_Name --
   --------------------------------

   function API_Storage_Type_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return
        API_Package_Full_Name (Class)
          & '.'
          & Ada_Side.Generators.Adas.Value_API_Spec.API_Storage_Type_Name
             (Class);
   end API_Storage_Type_Full_Name;

   ----------------------------
   -- User_Package_Full_Name --
   ----------------------------

   function User_Package_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String
         renames Ada_Side.Generators.Adas.Value_Spec.User_Package_Full_Name;

end Ada_Side.Generators.Adas;
