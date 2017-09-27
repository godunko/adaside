with Ada.Characters.Wide_Wide_Latin_1;

with League.Strings;
with League.String_Vectors;

with Ada_Side.Units;
with Ada_Side.Outputs;

package body Ada_Side.Generators.Adas.Value_API_Spec is

   use type League.Strings.Universal_String;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   function Generated_Package_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

   function API_Record_Type_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

   function API_Size_Of_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

   --------------------------
   -- API_Access_Type_Name --
   --------------------------

   function API_Access_Type_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return API_Record_Type_Name (Class) & "_Access";
   end API_Access_Type_Name;

   ---------------------------
   -- API_Package_Full_Name --
   ---------------------------

   function API_Package_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return +"Qt_Ada.API." & Generated_Package_Name (Class);
   end API_Package_Full_Name;

   --------------------------
   -- API_Record_Type_Name --
   --------------------------

   function API_Record_Type_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return
        League.Strings.From_UTF_8_String (Class.Type_Entry.Name.To_UTF8);
   end API_Record_Type_Name;

   ----------------------
   -- API_Size_Of_Name --
   ----------------------

   function API_Size_Of_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return "sizeof_" & API_Record_Type_Name (Class);
   end API_Size_Of_Name;

   ---------------------------
   -- API_Storage_Type_Name --
   ---------------------------

   function API_Storage_Type_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return API_Record_Type_Name (Class) & "_Storage";
   end API_Storage_Type_Name;

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_API_Ada_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      Unit : Ada_Side.Units.Ada_Spec_Unit;
      F    : aliased Ada_Side.Outputs.Factory;

      Package_Name : constant League.Strings.Universal_String :=
        API_Package_Full_Name (Class);

      With_Clause : constant Ada_Side.Outputs.Node_Access :=
        F.New_With (F.New_Selected_Name (+"Interfaces.C"));

      Preelaborate : constant Ada_Side.Outputs.Node_Access :=
        F.New_Pragma (F.New_Name (+"Preelaborate"));

      Record_Type_Name : constant Ada_Side.Outputs.Node_Access :=
        F.New_Name (API_Record_Type_Name (Class));

      Convention  : constant Ada_Side.Outputs.Node_Access :=
        F.New_Aspect (F.New_Name (+"Convention"), F.New_Name (+"C"));

      Import : constant Ada_Side.Outputs.Node_Access :=
        F.New_Aspect (F.New_Name (+"Import"), F.New_Name (+"True"));

      Link_Name : constant Ada_Side.Outputs.Node_Access :=
        F.New_Aspect
          (F.New_Name (+"Link_Name"),
           F.New_String_Literal (API_Size_Of_Link_Name (Class)));

      Alignment : constant Ada_Side.Outputs.Node_Access :=
        F.New_Aspect
          (F.New_Name (+"Alignment"),
           F.New_Name (+"Standard'Maximum_Alignment"));

      Record_Type : constant Ada_Side.Outputs.Node_Access :=
        F.New_Type
          (Name          => Record_Type_Name,
           Definition    => F.New_Record,
           Aspects       => Convention);

      Access_Type : constant Ada_Side.Outputs.Node_Access :=
        F.New_Type
          (Name          => F.New_Name (API_Access_Type_Name (Class)),
           Definition    => F.New_Access
             (Is_All => True,
              Target => Record_Type_Name),
           Aspects       => Convention);

      Size_Of_Name : constant Ada_Side.Outputs.Node_Access :=
        F.New_Name (API_Size_Of_Name (Class));

      Size_Of   : constant Ada_Side.Outputs.Node_Access :=
        F.New_Variable
          (Name            => Size_Of_Name,
           Type_Definition => F.New_Selected_Name (+"Interfaces.C.size_t"),
           Is_Constant     => True,
           Aspects         =>
             F.New_List ((Import, Convention, Link_Name)));

      Storage_Type : constant Ada_Side.Outputs.Node_Access :=
        F.New_Type
          (Name          => F.New_Name (API_Storage_Type_Name (Class)),
           Definition    => F.New_Derived
             (Parent => F.New_Apply
                (Prefix    => F.New_Selected_Name (+"Interfaces.C.char_array"),
                 Arguments => F.New_List
                   (F.New_Literal (1),
                    F.New_Infix
                      (+"..", Size_Of_Name)))),
           Aspects       => Alignment);

      Public_Part : constant Ada_Side.Outputs.Node_Access :=
        F.New_List
          ((Preelaborate, Record_Type, Access_Type, Size_Of, Storage_Type));

      Package_Spec : constant Ada_Side.Outputs.Node_Access :=
        F.New_Package
          (Name         => F.New_Selected_Name (Package_Name),
           Public_Part  => Public_Part);

      Spec_Unit : constant Ada_Side.Outputs.Node_Access :=
        F.New_Compilation_Unit (Package_Spec, With_Clause);

      Lines : constant League.String_Vectors.Universal_String_Vector :=
        F.To_Text (Spec_Unit).Split (Ada.Characters.Wide_Wide_Latin_1.LF);
   begin
      Unit.Set_Package_Name (Package_Name);

      for J in 1 .. Lines.Length loop
         declare
            Line : constant League.Strings.Universal_String := Lines (J);
         begin
            Unit.Put_Line (Line);
         end;
      end loop;

      Unit.Save (Self.Output_Directory);
   end Generate;

   ----------------------------
   -- Generated_Package_Name --
   ----------------------------

   function Generated_Package_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String
   is
      Class_Name : constant League.Strings.Universal_String
        := League.Strings.From_UTF_8_String
            (Class.Type_Entry.Name.To_UTF8);

   begin
      return Class_Name.Tail_From (2);
   end Generated_Package_Name;

   ---------------------
   -- Should_Generate --
   ---------------------

   overriding function Should_Generate
    (Self  : in out Value_API_Ada_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean
   is
      pragma Unreferenced (Self);

   begin
      return Class.Type_Entry.Is_Value;
   end Should_Generate;

end Ada_Side.Generators.Adas.Value_API_Spec;
