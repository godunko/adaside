with Abstract_Meta_Types;

package body Ada_Side.Generators.CXXs is

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

      Return_Type  : constant Abstract_Meta_Types.Abstract_Meta_Type
        := Subprogram.Get_Type;
      Return_Class : constant Abstract_Meta_Classes.Abstract_Meta_Class
        := (if Return_Type.Is_Null
              then Abstract_Meta_Classes.Null_Abstract_Meta_Class
              else Generator.Find_Class (Return_Type.Type_Entry));

   begin
      if Return_Type.Type_Entry.Is_Primitive then
         Unit.Put
          (Return_Type.Type_Entry.Name.To_Universal_String
             & " "
             & API_Subprogram_Link_Name (Class, Subprogram)
             & "("
             & Class.Name.To_Universal_String
             & "* self)");

      elsif Return_Type.Is_Value then
         if Abstract_Meta_Classes.Abstract_Meta_Class (Class)
              = Return_Class
         then
            Unit.Put
             ("void "
                & API_Subprogram_Link_Name (Class, Subprogram)
                & "(" & Return_Class.Name.To_Universal_String
                & "** ___view, void* ___storage, const "
                & Class.Name.To_Universal_String
                & "* self)");

         else
            Unit.Put
             ("void "
                & API_Subprogram_Link_Name (Class, Subprogram)
                & "(" & Return_Class.Name.To_Universal_String
                & "* ___view, const "
                & Class.Name.To_Universal_String
                & "* self)");
         end if;
      end if;
   end Generate_Declaration;

end Ada_Side.Generators.CXXs;
