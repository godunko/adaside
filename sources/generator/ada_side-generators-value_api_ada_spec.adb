with League.Strings;

with Ada_Side.Units;

package body Ada_Side.Generators.Value_API_Ada_Spec is

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

   function API_Access_Type_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

   function API_Size_Of_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

   function API_Size_Of_Link_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

   function API_Storage_Type_Name
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

   ---------------------------
   -- API_Size_Of_Link_Name --
   ---------------------------

   function API_Size_Of_Link_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return "__qtada__sizeof__" & API_Record_Type_Name (Class);
   end API_Size_Of_Link_Name;

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
      pragma Unreferenced (Self);

      Unit : Ada_Side.Units.Ada_Spec_Unit;

   begin
      Unit.Put_Line (+"with Interfaces.C;");
      Unit.Put_Line (+"with System;");
      Unit.New_Line;
      Unit.Put_Line
       ("package Qt_Ada.API." & Generated_Package_Name (Class) & " is");
      Unit.New_Line;
      Unit.Put_Line (+"   pragma Preelaborate;");
      Unit.New_Line;
      Unit.Put_Line
       ("   type " & API_Record_Type_Name (Class) & " is null record");
      Unit.Put_Line (+"     with Convention => C;");
      Unit.New_Line;
      Unit.Put_Line
       ("   type " & API_Access_Type_Name (Class)
          & " is access all " & API_Record_Type_Name (Class));
      Unit.Put_Line (+"     with Convention => C;");
      Unit.New_Line;
      Unit.Put_Line
       ("   " & API_Size_Of_Name (Class)
          & " : constant Interfaces.C.size_t");
      Unit.Put_Line (+"     with Import     => True,");
      Unit.Put_Line (+"          Convention => C,");
      Unit.Put_Line
       ("          Link_Name  => """
          & API_Size_Of_Link_Name (Class) & """;");
      Unit.New_Line;
      Unit.Put_Line
       ("   type " & API_Storage_Type_Name (Class)
          & " is new Interfaces.C.char_array (1 .. "
          & API_Size_Of_Name (Class) & ")");
      Unit.Put_Line (+"     with Alignment => System'Maximum_Alignment;");
      Unit.New_Line;
      Unit.Put_Line ("end Qt_Ada.API." & Generated_Package_Name (Class) & ";");
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
      return +"Qt_Ada.API." & Class_Name.Tail_From (2);
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

end Ada_Side.Generators.Value_API_Ada_Spec;
