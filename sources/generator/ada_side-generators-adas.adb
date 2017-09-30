with Abstract_Meta_Argument_Lists;
with Abstract_Meta_Types;

with Ada_Side.Generators.Adas.Value_API_Spec;
with Ada_Side.Generators.Adas.Value_Spec;
with Ada_Side.Generators.Adas.Values;

package body Ada_Side.Generators.Adas is

   use type League.Strings.Universal_String;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

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

      Return_Type     : constant Abstract_Meta_Types.Abstract_Meta_Type
        := Subprogram.Get_Type;
      First_Parameter : Boolean := True;

   begin
      Unit.New_Line;

      if Return_Type.Is_Null then
         Unit.Put (+"   procedure ");

      else
         Unit.Put (+"   function ");
      end if;

      Unit.Put_Line (User_Subprogram_Name (Subprogram));

      if not Subprogram.Is_Static
        and not (Subprogram.Is_Arithmetic_Operator
                   or Subprogram.Is_Comparison_Operator)
      then
         Unit.Put
          ("    (Self : "
             & (if Subprogram.Is_Constant then "" else "in out ")
             & User_Tagged_Type_Name (Class) & "'Class");
         First_Parameter := False;
      end if;

      if (Subprogram.Is_Arithmetic_Operator
            or Subprogram.Is_Comparison_Operator)
        and not Subprogram.Is_Reverse_Operator
      then
         Unit.Put ("    (Self : " & User_Tagged_Type_Name (Class) & "'Class");
         First_Parameter := False;
      end if;

      declare
         Parameters : Abstract_Meta_Argument_Lists.Abstract_Meta_Argument_List
           := Subprogram.Arguments;

      begin
         for Parameter of Parameters loop
            if First_Parameter then
               Unit.Put (+"    (");
               First_Parameter := False;

            else
               Unit.Put_Line (+";");
               Unit.Put (+"     ");
            end if;

            if Parameter.Get_Type.Is_Primitive then
               Unit.Put
                (Parameter.Name.To_Universal_String
                   & " : "
                   & Parameter.Get_Type.Type_Entry.Target_Lang_Name
                       .To_Universal_String);

            elsif Parameter.Get_Type.Is_Constant then
               Unit.Put
                (Parameter.Name.To_Universal_String
                   & " : "
                   & User_Tagged_Type_Full_Name
                      (Generator.Find_Class (Parameter.Get_Type.Type_Entry))
                   & "'Class");

            else
               raise Program_Error;
            end if;
         end loop;
      end;

      if (Subprogram.Is_Arithmetic_Operator
            or Subprogram.Is_Comparison_Operator)
        and Subprogram.Is_Reverse_Operator
      then
         if First_Parameter then
            Unit.Put (+"    (");
            First_Parameter := False;

         else
            Unit.Put_Line (+";");
            Unit.Put (+"     ");
         end if;

         Unit.Put ("Self : " & User_Tagged_Type_Name (Class) & "'Class");
      end if;

      if not First_Parameter then
         Unit.Put (+")");
      end if;

      if not Return_Type.Is_Null then
         declare
            Return_Class : constant Abstract_Meta_Classes.Abstract_Meta_Class
              := Generator.Find_Class (Return_Type.Type_Entry);

         begin
            Unit.New_Line;

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
         end;
      end if;
   end Generate_User_Declaration;

   ----------------------------
   -- User_Package_Full_Name --
   ----------------------------

   function User_Package_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String
         renames Ada_Side.Generators.Adas.Value_Spec.User_Package_Full_Name;

   --------------------------
   -- User_Subprogram_Name --
   --------------------------

   function User_Subprogram_Name
    (Subprogram : Abstract_Meta_Functions.Abstract_Meta_Function'Class)
       return League.Strings.Universal_String
   is
      Name : constant League.Strings.Universal_String
        := Subprogram.Name.To_Universal_String;

   begin
      if Subprogram.Is_Arithmetic_Operator
        or Subprogram.Is_Comparison_Operator
      then
         --  Arithmetic operators.

         if Name = +"operator+" then
            return +"""+""";

         elsif Name = +"operator-" then
            return +"""-""";

         elsif Name = +"operator*" then
            return +"""*""";

         elsif Name = +"operator/" then
            return +"""/""";

         --  Comparison operators.

         elsif Name = +"operator==" then
            return +"""=""";

         else
            raise Program_Error;
         end if;

      else
         return Values.To_Ada_Identifier (Name);
      end if;
   end User_Subprogram_Name;

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
