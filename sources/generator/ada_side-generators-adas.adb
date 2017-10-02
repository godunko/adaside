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

      procedure New_Parameter;

      Return_Type   : constant Abstract_Meta_Types.Abstract_Meta_Type
        := Subprogram.Get_Type;
      Has_Parameter : Boolean := False;

      -------------------
      -- New_Parameter --
      -------------------

      procedure New_Parameter is
      begin
         if Has_Parameter then
            Unit.Put_Line (+";");
            Unit.Put (+"     ");

         else
            Unit.Put (+"    (");
            Has_Parameter := True;
         end if;
      end New_Parameter;

   begin
      Unit.New_Line;

      if Return_Type.Is_Null
        and not Subprogram.Is_Constructor
      then
         Unit.Put (+"   procedure ");

      else
         Unit.Put (+"   function ");
      end if;

      Unit.Put_Line (User_Subprogram_Name (Subprogram));

      if not Subprogram.Is_Constructor
        and not Subprogram.Is_Static
        and not (Subprogram.Is_Arithmetic_Operator
                   or Subprogram.Is_Comparison_Operator)
      then
         New_Parameter;
         Unit.Put
          ("Self : "
             & (if Subprogram.Is_Constant then "" else "in out ")
             & User_Tagged_Type_Name (Class) & "'Class");
      end if;

      if (Subprogram.Is_Arithmetic_Operator
            or Subprogram.Is_Comparison_Operator)
        and not Subprogram.Is_Reverse_Operator
      then
         New_Parameter;
         Unit.Put ("Self : " & User_Tagged_Type_Name (Class) & "'Class");
      end if;

      declare
         Parameters : Abstract_Meta_Argument_Lists.Abstract_Meta_Argument_List
           := Subprogram.Arguments;

      begin
         for Parameter of Parameters loop
            New_Parameter;

            Unit.Put
             (Values.To_Ada_Identifier (Parameter.Name.To_Universal_String)
                & " : ");

            if Parameter.Get_Type.Is_Primitive then
               Unit.Put
                (Parameter.Get_Type.Type_Entry.Target_Lang_Name
                   .To_Universal_String);

            elsif Parameter.Get_Type.Is_Constant then
               declare
                  Parameter_Class : constant
                    Abstract_Meta_Classes.Abstract_Meta_Class
                      := Generator.Find_Class (Parameter.Get_Type.Type_Entry);

               begin
                  Unit.Put
                   (User_Tagged_Type_Full_Name (Parameter_Class) & "'Class");

                  if Parameter_Class
                       /= Abstract_Meta_Classes.Abstract_Meta_Class (Class)
                  then
                     Unit.Add_Limited_With_Clause
                      (User_Package_Full_Name (Parameter_Class));
                  end if;
               end;

            else
               raise Program_Error;
            end if;
         end loop;
      end;

      if (Subprogram.Is_Arithmetic_Operator
            or Subprogram.Is_Comparison_Operator)
        and Subprogram.Is_Reverse_Operator
      then
         New_Parameter;
         Unit.Put ("Self : " & User_Tagged_Type_Name (Class) & "'Class");
      end if;

      if Has_Parameter then
         Unit.Put (+")");
      end if;

      if Subprogram.Is_Constructor then
         Unit.New_Line;
         Unit.Put ("       return " & User_Tagged_Type_Full_Name (Class));

      elsif not Return_Type.Is_Null then
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

   -------------------------------
   -- Generate_User_Declaration --
   -------------------------------

   procedure Generate_User_Declaration
    (Generator  : Abstract_Generator'Class;
     Unit       : in out Ada_Side.Units.Abstract_Ada_Unit'Class;
     Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Abstract_Meta_Functions.Abstract_Meta_Function'Class;
     Factory    : access Ada_Side.Outputs.Factory'Class;
     Result     : out Ada_Side.Outputs.Node_Access)
   is
      use type Abstract_Meta_Classes.Abstract_Meta_Class;

      F : access Ada_Side.Outputs.Factory'Class renames Factory;

      Parameters : Abstract_Meta_Argument_Lists.Abstract_Meta_Argument_List
        := Subprogram.Arguments;

      Parameter_List : Ada_Side.Outputs.Node_Access;
      --  Node list corresponding to Parameters

      Return_Type   : constant Abstract_Meta_Types.Abstract_Meta_Type
        := Subprogram.Get_Type;

      Result_Type : Ada_Side.Outputs.Node_Access;
      --  Node corresponding to Return_Type

      Subprogram_Name  : constant Ada_Side.Outputs.Node_Access :=
        F.New_Name (User_Subprogram_Name (Subprogram));

      Self_Name  : constant Ada_Side.Outputs.Node_Access :=
        F.New_Name (+"Self");

      Class_Type    :  constant Ada_Side.Outputs.Node_Access :=
        F.New_Name (User_Tagged_Type_Name (Class) & "'Class");

   begin
      if not Subprogram.Is_Constructor
        and not Subprogram.Is_Static
        and not (Subprogram.Is_Arithmetic_Operator
                   or Subprogram.Is_Comparison_Operator)
      then
         Parameter_List := F.New_List
           (Parameter_List,
            F.New_Parameter
              (Name            => Self_Name,
               Type_Definition => Class_Type,
               Is_In           => not Subprogram.Is_Constant,
               Is_Out          => not Subprogram.Is_Constant));

      elsif (Subprogram.Is_Arithmetic_Operator
               or Subprogram.Is_Comparison_Operator)
        and not Subprogram.Is_Reverse_Operator
      then
         Parameter_List := F.New_List
           (Parameter_List,
            F.New_Parameter
              (Name            => Self_Name,
               Type_Definition => Class_Type));
      end if;

      for Parameter of Parameters loop
         declare
            Parameter_Type : Ada_Side.Outputs.Node_Access;
         begin
            if Parameter.Get_Type.Is_Primitive then
               Parameter_Type := F.New_Selected_Name
                 (Parameter.Get_Type.Type_Entry.Target_Lang_Name
                    .To_Universal_String);
            elsif Parameter.Get_Type.Is_Constant then
               declare
                  Parameter_Class : constant
                    Abstract_Meta_Classes.Abstract_Meta_Class
                      := Generator.Find_Class (Parameter.Get_Type.Type_Entry);

               begin
                  Parameter_Type := F.New_Selected_Name
                    (User_Tagged_Type_Full_Name (Parameter_Class) & "'Class");

                  if Parameter_Class
                    /= Abstract_Meta_Classes.Abstract_Meta_Class (Class)
                  then
                     Unit.Add_Limited_With_Clause
                       (User_Package_Full_Name (Parameter_Class));
                  end if;
               end;

            else
               raise Program_Error;
            end if;

            Parameter_List := F.New_List
              (Parameter_List,
               F.New_Parameter
                 (F.New_Name
                      (Values.To_Ada_Identifier
                           (Parameter.Name.To_Universal_String)),
                  Type_Definition => Parameter_Type));
         end;
      end loop;

      if Subprogram.Is_Constructor then
         Result_Type := Class_Type;

      elsif not Return_Type.Is_Null then
         declare
            Return_Class : constant Abstract_Meta_Classes.Abstract_Meta_Class
              := Generator.Find_Class (Return_Type.Type_Entry);

         begin
            if Return_Type.Type_Entry.Is_Primitive then
               Result_Type := F.New_Selected_Name
                (Return_Type.Type_Entry.Target_Lang_Name.To_Universal_String);

            elsif Return_Type.Is_Value then
               if Abstract_Meta_Classes.Abstract_Meta_Class (Class)
                    /= Return_Class
               then
                  Unit.Add_With_Clause
                   (User_Package_Full_Name (Return_Class));
               end if;

               Result_Type := F.New_Selected_Name
                (User_Tagged_Type_Full_Name (Return_Class));

            else
               raise Program_Error;
            end if;
         end;
      end if;

      Result := F.New_Subprogram_Specification
        (Name       => Subprogram_Name,
         Parameters => Parameter_List,
         Result     => Result_Type);
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

      elsif Subprogram.Is_Constructor then
         return "Create_" & Values.To_Ada_Identifier (Name);

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
