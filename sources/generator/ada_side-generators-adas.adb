with Abstract_Meta_Types;

with Ada_Side.Generators.Adas.Value_API_Spec;
with Ada_Side.Generators.Adas.Value_Spec;
with Ada_Side.Generators.Adas.Values;

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

   -------------------------------
   -- Generate_User_Declaration --
   -------------------------------

   procedure Generate_User_Declaration
    (Generator  : Abstract_Generator'Class;
     Unit       : in out Ada_Side.Units.Abstract_Ada_Unit'Class;
     Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Abstract_Meta_Functions.Abstract_Meta_Function'Class)
   is
      use type Abstract_Meta_Classes.Abstract_Meta_Class;

      Return_Type  : constant Abstract_Meta_Types.Abstract_Meta_Type
        := Subprogram.Get_Type;
      Return_Class : constant Abstract_Meta_Classes.Abstract_Meta_Class
        := (if Return_Type.Is_Null
              then Abstract_Meta_Classes.Null_Abstract_Meta_Class
              else Generator.Find_Class (Return_Type.Type_Entry));

   begin
      Unit.New_Line;
      Unit.Put_Line
       ("   function " & Values.To_Ada_Identifier (Subprogram.Name));
      Unit.Put_Line
       ("    (Self : "
          & User_Tagged_Type_Name (Class) & "'Class)");

      if Return_Type.Type_Entry.Is_Primitive then
         Unit.Put
          ("       return "
             & Return_Type.Type_Entry.Target_Lang_Name
                 .To_Universal_String);

      elsif Return_Type.Is_Value then
         if Abstract_Meta_Classes.Abstract_Meta_Class (Class)
              /= Return_Class
         then
            Unit.Add_With_Clause
             (User_Package_Full_Name (Return_Class));
         end if;

         Unit.Put
          ("       return "
             & User_Tagged_Type_Full_Name (Return_Class));

      else
         raise Program_Error;
      end if;
   end Generate_User_Declaration;

   ----------------------------
   -- User_Package_Full_Name --
   ----------------------------

   function User_Package_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String
         renames Ada_Side.Generators.Adas.Value_Spec.User_Package_Full_Name;

   --------------------------------
   -- User_Tagged_Type_Full_Name --
   --------------------------------

   function User_Tagged_Type_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return
        User_Package_Full_Name (Class)
          & '.'
          & User_Tagged_Type_Name (Class);
   end User_Tagged_Type_Full_Name;

   ---------------------------
   -- User_Tagged_Type_Name --
   ---------------------------

   function User_Tagged_Type_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String
         renames Ada_Side.Generators.Adas.Value_Spec.User_Tagged_Type_Name;

end Ada_Side.Generators.Adas;
