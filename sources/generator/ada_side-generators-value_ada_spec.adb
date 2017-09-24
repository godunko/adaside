with League.Characters;
with League.Strings;

with Ada_Side.Units;

package body Ada_Side.Generators.Value_Ada_Spec is

   use type League.Strings.Universal_String;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   function Generated_Package_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

   function Generated_Package_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

   function Tagged_Type_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

   function To_Ada_Identifier
    (Name : League.Strings.Universal_String)
       return League.Strings.Universal_String;
   --  Converts identifier from C++ to Ada conventions.

   Q_Underline_Prefix : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("Q_");

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_Ada_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      Unit : Ada_Side.Units.Ada_Spec_Unit;

   begin
      Unit.Set_Package_Name (Generated_Package_Full_Name (Class), False);

      Unit.Put_Line (+"private with Ada.Finalization;");
      Unit.New_Line;
      Unit.Put_Line ("package " & Generated_Package_Full_Name (Class) & " is");
      Unit.New_Line;
      Unit.Put_Line (+"   pragma Preelaborate;");
      Unit.New_Line;
      Unit.Put_Line
       ("   type " & Tagged_Type_Name (Class) & " is tagged private;");
      Unit.New_Line;
      Unit.Put_Line (+"private");
      Unit.New_Line;
      Unit.Put_Line
       ("   type " & Tagged_Type_Name (Class)
          & " is new Ada.Finalization.Controlled with record");
      Unit.Put_Line (+"      null;");
      Unit.Put_Line (+"   end record;");
      Unit.New_Line;
      Unit.Put_Line ("end " & Generated_Package_Full_Name (Class) & ";");

      Unit.Save (Self.Output_Directory);
   end Generate;

   ---------------------------------
   -- Generated_Package_Full_Name --
   ---------------------------------

   function Generated_Package_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return "Qt5.Qt_Core." & Generated_Package_Name (Class);
   end Generated_Package_Full_Name;

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

   ----------------------
   -- Tagged_Type_Name --
   ----------------------

   function Tagged_Type_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return
       To_Ada_Identifier
        (League.Strings.From_UTF_8_String (Class.Type_Entry.Name.To_UTF8));
   end Tagged_Type_Name;

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
            if J > 1 then
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
            end if;

            Result.Append (Name (J));
         end loop;
      end return;
   end To_Ada_Identifier;

end Ada_Side.Generators.Value_Ada_Spec;
