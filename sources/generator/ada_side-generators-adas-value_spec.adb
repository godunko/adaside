with Ada.Wide_Wide_Text_IO;
with Interfaces.C;

with League.Characters;
with League.Strings;

with Abstract_Meta_Function_Lists;
with Abstract_Meta_Types;

with Ada_Side.Units;

package body Ada_Side.Generators.Adas.Value_Spec is

   use type League.Strings.Universal_String;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   function Generated_Package_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

   function To_Ada_Identifier
    (Name : League.Strings.Universal_String)
       return League.Strings.Universal_String;
   --  Converts identifier from C++ to Ada conventions.

   Q_Underline_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("Q_");

   ----------------
   -- Find_Class --
   ----------------

   function Find_Class
    (Self       : Value_Ada_Spec_Generator;
     Type_Entry : Type_Entries.Type_Entry)
       return Abstract_Meta_Classes.Abstract_Meta_Class is
   begin
      return Abstract_Meta_Classes.Find_Class (Self.Classes, Type_Entry);
   end Find_Class;

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
                   & To_Ada_Identifier (Method.Name.To_Universal_String));
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
      Unit.Put_Line (+"      Wrapper : Boolean;");
      Unit.Put_Line (+"      Storage : Boolean;");
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
        := To_Ada_Identifier
            (League.Strings.From_UTF_8_String
              (Class.Type_Entry.Name.To_UTF8));

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

   -----------------------
   -- To_Ada_Identifier --
   -----------------------

   function To_Ada_Identifier
    (Name : League.Strings.Universal_String)
       return League.Strings.Universal_String
   is
      use type League.Characters.Universal_Character;

   begin
      return Result : League.Strings.Universal_String do
         for J in 1 .. Name.Length loop
            if J = 1 then
               Result.Append (Name (J).Simple_Uppercase_Mapping);

            else
               if J = 2
                 and Name (J - 1) = 'Q'
                 and Name (J).Uppercase
               then
                  --  Special exception to translate Qt Classes' names, for
                  --  example, 'QRect' -> 'Q_Rect'.
                  Result.Append ('_');

               elsif Name (J).Uppercase
                 and Name (J - 1).Lowercase
               then
                  Result.Append ('_');
               end if;

               Result.Append (Name (J));
            end if;
         end loop;
      end return;
   end To_Ada_Identifier;

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
      return
       To_Ada_Identifier
        (League.Strings.From_UTF_8_String (Class.Type_Entry.Name.To_UTF8));
   end User_Tagged_Type_Name;

end Ada_Side.Generators.Adas.Value_Spec;
