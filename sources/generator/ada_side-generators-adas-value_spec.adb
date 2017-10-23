with Ada.Wide_Wide_Text_IO;

with League.Strings;

with Abstract_Meta_Function_Lists;

with Ada_Side.Generators.Adas.Values;
with Ada_Side.Units;

package body Ada_Side.Generators.Adas.Value_Spec is

   use type League.Strings.Universal_String;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   function Generated_Package_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

   Q_Underline_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("Q_");

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_Ada_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      Unit      : Ada_Side.Units.Ada_Spec_Unit;
      F         : aliased Ada_Outputs.Factory;
      Functions : Abstract_Meta_Function_Lists.Abstract_Meta_Function_List
        := Class.Functions;

      Generated : Universal_String_Sets.Set;

      Package_Name : constant League.Strings.Universal_String :=
        User_Package_Full_Name (Class);

      With_Clause : constant Ada_Outputs.Node_Access :=
        F.New_List
          ((F.New_With (F.New_Selected_Name (+"Ada.Finalization"),
                        Is_Private => True),
            F.New_With (F.New_Selected_Name (API_Package_Full_Name (Class)),
                        Is_Private => True)));

      Preelaborate : constant Ada_Outputs.Node_Access :=
        F.New_Pragma (F.New_Name (+"Preelaborate"));

      User_Type : constant Ada_Outputs.Node_Access :=
        F.New_Name (User_Tagged_Type_Name (Class));

      Private_Type : constant Ada_Outputs.Node_Access :=
        F.New_Type
          (Name          => User_Type,
           Definition    => F.New_Private_Record (Is_Tagged => True));

      Public_Part : Ada_Outputs.Node_Access :=
        F.New_List ((Preelaborate, Private_Type));

   begin
      Unit.Set_Package_Name (Package_Name);

      for Method of Functions loop
         if Self.Can_Be_Generated (Class, Method) then
            if Generated.Contains (Method.Minimal_Signature) then
               Ada.Wide_Wide_Text_IO.Put_Line
                (" Skip '"
                   & Method.Name.To_Wide_Wide_String
                   & "' - already generated");

            else
               declare
                  Spec : Ada_Outputs.Node_Access;

               begin
                  Generated.Include (Method.Minimal_Signature);
                  --  Protect from generation of duplicate for operators.

                  Generate_User_Declaration
                    (Self, Unit, Class, Method, F'Access, Spec);

                  Public_Part := F.New_List
                    (Public_Part,
                     F.New_Subprogram_Declaration (Spec));
               end;
            end if;
         end if;
      end loop;

      declare
         View : constant Ada_Outputs.Node_Access :=
           F.New_Variable
             (F.New_Name (Class.Name.To_Universal_String & "_View"),
              F.New_Selected_Name (API_Access_Type_Full_Name (Class)));

         Wrapper : constant Ada_Outputs.Node_Access :=
           F.New_Variable
             (F.New_Name (+"Wrapper"),
              F.New_Name (+"Boolean"),
              F.New_Name (+"False"));

         Storage : constant Ada_Outputs.Node_Access :=
           F.New_Variable
             (F.New_Name (+"Storage"),
              F.New_Selected_Name (API_Storage_Type_Full_Name (Class)));

         Private_View : constant Ada_Outputs.Node_Access :=
           F.New_Type
             (Name          => User_Type,
              Definition    => F.New_Record
                (Parent     => F.New_Selected_Name
                                 (+"Ada.Finalization.Controlled"),
                 Components => F.New_List
                                 ((View, Wrapper, Storage))));

         Self_In_Out : constant Ada_Outputs.Node_Access :=
           F.New_Parameter
             (Name            => F.New_Name (+"Self"),
              Type_Definition => User_Type,
              Is_In           => True,
              Is_Out          => True);

         Initialize : constant Ada_Outputs.Node_Access :=
           F.New_Subprogram_Declaration
             (F.New_Subprogram_Specification
                (Is_Overriding => True,
                 Name          => F.New_Name (+"Initialize"),
                 Parameters    => Self_In_Out));

         Adjust : constant Ada_Outputs.Node_Access :=
           F.New_Subprogram_Declaration
             (F.New_Subprogram_Specification
                (Is_Overriding => True,
                 Name          => F.New_Name (+"Adjust"),
                 Parameters    => Self_In_Out));

         Finalize : constant Ada_Outputs.Node_Access :=
           F.New_Subprogram_Declaration
             (F.New_Subprogram_Specification
                (Is_Overriding => True,
                 Name          => F.New_Name (+"Finalize"),
                 Parameters    => Self_In_Out));

         Private_Part : constant Ada_Outputs.Node_Access :=
           F.New_List ((Private_View, Initialize, Adjust, Finalize));

         Package_Spec : constant Ada_Outputs.Node_Access :=
           F.New_Package
             (Name         => F.New_Selected_Name (Package_Name),
              Public_Part  => Public_Part,
              Private_Part => Private_Part);

         Spec_Unit : constant Ada_Outputs.Node_Access :=
           F.New_Compilation_Unit (Package_Spec, With_Clause);

      begin
         Unit.Put_Lines (F.To_Text (Spec_Unit));
         Unit.Save (Self.Output_Directory);
      end;
   end Generate;

   ----------------------------
   -- Generated_Package_Name --
   ----------------------------

   function Generated_Package_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String
   is
      Type_Name : constant League.Strings.Universal_String
        := Values.To_Ada_Identifier (Class.Type_Entry.Name);

   begin
      return Result : League.Strings.Universal_String do
         if Type_Name.Starts_With (Q_Underline_Prefix) then
            Result := Type_Name.Tail_From (3);

         else
            Result := Type_Name;
         end if;

         if Result.Ends_With (+"s") then
            --  Naming exceptions for known plurals.

            if Result /= +"Margins" then
               Result.Append ('s');
            end if;

         else
            Result.Append ('s');
         end if;
      end return;
   end Generated_Package_Name;

   ---------------------
   -- Should_Generate --
   ---------------------

   overriding function Should_Generate
    (Self  : in out Value_Ada_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean
   is
      pragma Unreferenced (Self);

   begin
      return Class.Type_Entry.Is_Value;
   end Should_Generate;

   ----------------------------
   -- User_Package_Full_Name --
   ----------------------------

   function User_Package_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return "Qt5.Qt_Core." & Generated_Package_Name (Class);
   end User_Package_Full_Name;

   ---------------------------
   -- User_Tagged_Type_Name --
   ---------------------------

   function User_Tagged_Type_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return Values.To_Ada_Identifier (Class.Type_Entry.Name);
   end User_Tagged_Type_Name;

end Ada_Side.Generators.Adas.Value_Spec;
