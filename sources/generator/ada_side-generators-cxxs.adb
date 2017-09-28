with Abstract_Meta_Argument_Lists;
with Abstract_Meta_Types;

package body Ada_Side.Generators.CXXs is

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   --------------------------
   -- Generate_Declaration --
   --------------------------

   procedure Generate_Declaration
    (Generator  : Abstract_Generator'Class;
     Unit       : in out Ada_Side.Units.Abstract_CXX_Unit'Class;
     Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Abstract_Meta_Functions.Abstract_Meta_Function'Class)
   is
      use type League.Strings.Universal_String;
      use type Abstract_Meta_Classes.Abstract_Meta_Class;

      Return_Type    : constant Abstract_Meta_Types.Abstract_Meta_Type
        := Subprogram.Get_Type;
      Return_Class   : constant Abstract_Meta_Classes.Abstract_Meta_Class
        := (if Return_Type.Is_Null
              then Abstract_Meta_Classes.Null_Abstract_Meta_Class
              else Generator.Find_Class (Return_Type.Type_Entry));
      Parameters     : Abstract_Meta_Argument_Lists.Abstract_Meta_Argument_List
        := Subprogram.Arguments;

      Has_Parameters : Boolean := False;

   begin
      if Return_Type.Is_Null then
         Unit.Put
          ("void "
             & API_Subprogram_Link_Name (Class, Subprogram)
             & "(");

      elsif Return_Type.Type_Entry.Is_Primitive then
         Unit.Put
          (Return_Type.Type_Entry.Name.To_Universal_String
             & " "
             & API_Subprogram_Link_Name (Class, Subprogram)
             & "(");

      elsif Return_Type.Is_Value then
         if Abstract_Meta_Classes.Abstract_Meta_Class (Class)
              = Return_Class
         then
            Unit.Put
             ("void "
                & API_Subprogram_Link_Name (Class, Subprogram)
                & "(" & Return_Class.Name.To_Universal_String
                & "** ___view, void* ___storage");

         else
            Unit.Put
             ("void "
                & API_Subprogram_Link_Name (Class, Subprogram)
                & "(" & Return_Class.Name.To_Universal_String
                & "* ___view");
         end if;

         Has_Parameters := True;
      end if;

      if not Subprogram.Is_Static then
         if Has_Parameters then
            Unit.Put (+", ");

         else
            Has_Parameters := True;
         end if;

         Unit.Put
          ((if Subprogram.Is_Constant then "const " else "")
             & Class.Name.To_Universal_String
             & "* self");
      end if;

      for Parameter of Parameters loop
         if Has_Parameters then
            Unit.Put (+", ");

         else
            Has_Parameters := True;
         end if;

         if Parameter.Get_Type.Is_Primitive then
            Unit.Put
             (Parameter.Get_Type.Type_Entry.Name.To_Universal_String
                & " "
                & Parameter.Name.To_Universal_String);

         elsif Parameter.Get_Type.Is_Constant then
            Unit.Put
             ("const "
                & Parameter.Get_Type.Name.To_Universal_String
                & "* "
                & Parameter.Name.To_Universal_String);

         else
            raise Program_Error;
         end if;
      end loop;

      Unit.Put (+")");
   end Generate_Declaration;

end Ada_Side.Generators.CXXs;
