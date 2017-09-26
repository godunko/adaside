with Ada.Wide_Wide_Text_IO;
with Interfaces.C;

with League.Strings;

with Abstract_Meta_Function_Lists;
with Abstract_Meta_Types;

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
      use type Abstract_Meta_Classes.Abstract_Meta_Class;

      Unit      : Ada_Side.Units.Ada_Spec_Unit;
      Functions : Abstract_Meta_Function_Lists.Abstract_Meta_Function_List;

   begin
      Unit.Set_Package_Name (User_Package_Full_Name (Class));

      Unit.Put_Line (+"private with Ada.Finalization;");
      Unit.New_Line;
      Unit.Put_Line ("private with " & API_Package_Full_Name (Class) & ";");
      Unit.New_Line;
      Unit.Put_Line ("package " & User_Package_Full_Name (Class) & " is");
      Unit.New_Line;
      Unit.Put_Line (+"   pragma Preelaborate;");
      Unit.New_Line;
      Unit.Put_Line
       ("   type " & User_Tagged_Type_Name (Class) & " is tagged private;");

      Functions := Class.Functions;

      for Method of Functions loop
         declare
            use type Interfaces.C.int;

            Return_Type  : constant Abstract_Meta_Types.Abstract_Meta_Type
              := Method.Get_Type;
            Return_Class : constant Abstract_Meta_Classes.Abstract_Meta_Class
              := (if Return_Type.Is_Null
                    then Abstract_Meta_Classes.Null_Abstract_Meta_Class
                    else Self.Find_Class (Return_Type.Type_Entry));

         begin
            if Method.Is_Constructor then
               --  XXX Not supported yet.

               Ada.Wide_Wide_Text_IO.Put_Line
                ("Skipping "
                   & Method.Name.To_Universal_String.To_Wide_Wide_String);

            elsif Abstract_Meta_Classes.Abstract_Meta_Class (Class)
                    = Return_Class
              and Method.Is_Constant
              and Method.Arguments.Size = 0
              and Method.Get_Type.Is_Value
              and not Method.Get_Type.Is_Reference
            then
               Unit.New_Line;
               Unit.Put_Line
                ("   function "
                   & Values.To_Ada_Identifier (Method.Name));
               Unit.Put_Line
                ("    (Self : "
                   & User_Tagged_Type_Name (Class) & "'Class)");
               Unit.Put_Line
                ("       return "
                   & User_Tagged_Type_Name (Return_Class) & ";");

            else
               --  XXX Not supported yet.

               Ada.Wide_Wide_Text_IO.Put_Line
                ("Skipping "
                   & Method.Name.To_Universal_String.To_Wide_Wide_String);
            end if;
         end;
      end loop;

      Unit.New_Line;
      Unit.Put_Line (+"private");
      Unit.New_Line;
      Unit.Put_Line
       ("   type " & User_Tagged_Type_Name (Class)
          & " is new Ada.Finalization.Controlled with record");
      Unit.Put_Line
      ("      " & Class.Name.To_Universal_String
         & "_View : " & API_Access_Type_Full_Name (Class) & ";");
      Unit.Put_Line (+"      Wrapper : Boolean := False;");
      Unit.Put_Line
       ("      Storage : " & API_Storage_Type_Full_Name (Class) & ";");
      Unit.Put_Line (+"   end record;");
      Unit.New_Line;
      Unit.Put_Line
       ("   overriding procedure Initialize (Self : in out "
          & User_Tagged_Type_Name (Class) & ");");
      Unit.New_Line;
      Unit.Put_Line
       ("   overriding procedure Adjust (Self : in out "
          & User_Tagged_Type_Name (Class) & ");");
      Unit.New_Line;
      Unit.Put_Line
       ("   overriding procedure Finalize (Self : in out "
          & User_Tagged_Type_Name (Class) & ");");
      Unit.New_Line;
      Unit.Put_Line ("end " & User_Package_Full_Name (Class) & ";");

      Unit.Save (Self.Output_Directory);
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

         Result.Append ('s');
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
