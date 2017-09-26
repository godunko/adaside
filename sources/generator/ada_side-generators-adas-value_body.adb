with Ada.Wide_Wide_Text_IO;
with Interfaces.C;

with Abstract_Meta_Function_Lists;
with Abstract_Meta_Functions;
with Abstract_Meta_Types;

with Ada_Side.Generators.Adas.Values;
with Ada_Side.Units;

package body Ada_Side.Generators.Adas.Value_Body is

   use type League.Strings.Universal_String;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   function API_Subprogram_Name
    (Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Protocol_Subprograms)
       return League.Strings.Universal_String;

   function API_Subprogram_Name
    (Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Abstract_Meta_Functions.Abstract_Meta_Function'Class)
       return League.Strings.Universal_String;

   function View_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;
   --  Name of "view" component.

   -------------------------
   -- API_Subprogram_Name --
   -------------------------

   function API_Subprogram_Name
    (Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Protocol_Subprograms)
       return League.Strings.Universal_String is
   begin
      case Subprogram is
         when Adjust =>
            return Class.Name.To_Universal_String & "_adjust";

         when Finalize =>
            return Class.Name.To_Universal_String & "_finalize";

         when Initialize =>
            return Class.Name.To_Universal_String & "_initialize";
      end case;
   end API_Subprogram_Name;

   -------------------------
   -- API_Subprogram_Name --
   -------------------------

   function API_Subprogram_Name
    (Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Abstract_Meta_Functions.Abstract_Meta_Function'Class)
       return League.Strings.Universal_String is
   begin
      return
        Class.Name.To_Universal_String
          & "_"
          & Subprogram.Name.To_Universal_String;
   end API_Subprogram_Name;

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_Ada_Body_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      use type Abstract_Meta_Classes.Abstract_Meta_Class;

      Unit      : Ada_Side.Units.Ada_Body_Unit;
      Functions : Abstract_Meta_Function_Lists.Abstract_Meta_Function_List;

   begin
      Functions := Class.Functions;

      Unit.Set_Package_Name (User_Package_Full_Name (Class));

      Unit.Put_Line (+"with System;");
      Unit.New_Line;
      Unit.Put_Line ("package body " & User_Package_Full_Name (Class) & " is");

      Unit.New_Line;
      Unit.Put_Line
       ("   procedure " & API_Subprogram_Name (Class, Adjust));
      Unit.Put_Line
       ("    (Self    : in out " & API_Access_Type_Full_Name (Class) & ";");
      Unit.Put_Line (+"     Storage : System.Address)");
      Unit.Put_Line (+"       with Import     => True,");
      Unit.Put_Line (+"            Convention => C,");
      Unit.Put_Line
       ("            Link_Name  => """
          & API_Subprogram_Link_Name (Class, Adjust) & """;");

      Unit.New_Line;
      Unit.Put_Line
       ("   procedure " & API_Subprogram_Name (Class, Finalize));
      Unit.Put_Line
       ("    (Self    : in out " & API_Access_Type_Full_Name (Class) & ")");
      Unit.Put_Line (+"       with Import     => True,");
      Unit.Put_Line (+"            Convention => C,");
      Unit.Put_Line
       ("            Link_Name  => """
          & API_Subprogram_Link_Name (Class, Finalize) & """;");

      Unit.New_Line;
      Unit.Put_Line
       ("   procedure " & API_Subprogram_Name (Class, Initialize));
      Unit.Put_Line
       ("    (Self    : in out " & API_Access_Type_Full_Name (Class) & ";");
      Unit.Put_Line (+"     Storage : System.Address)");
      Unit.Put_Line (+"       with Import     => True,");
      Unit.Put_Line (+"            Convention => C,");
      Unit.Put_Line
       ("            Link_Name  => """
          & API_Subprogram_Link_Name (Class, Initialize) & """;");

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
                ("   procedure " & API_Subprogram_Name (Class, Method));
               Unit.Put_Line
                ("    (View    : in out "
                   & API_Access_Type_Full_Name (Class) & ";");
               Unit.Put_Line (+"     Storage : System.Address;");
               Unit.Put_Line
                ("    Self     : not null "
                   & API_Access_Type_Full_Name (Class) & ")");
               Unit.Put_Line (+"       with Import     => True,");
               Unit.Put_Line (+"            Convention => C,");
               Unit.Put_Line
                ("            Link_Name  => """
                   & API_Subprogram_Link_Name (Class, Method) & """;");

            else
               --  XXX Not supported yet.

               Ada.Wide_Wide_Text_IO.Put_Line
                ("Skipping "
                   & Method.Name.To_Universal_String.To_Wide_Wide_String);
            end if;
         end;
      end loop;

      Unit.New_Line;
      Unit.Put_Line
       ("   overriding procedure Adjust (Self : in out "
          & User_Tagged_Type_Name (Class) & ") is");
      Unit.Put_Line (+"   begin");
      Unit.Put_Line
       ("      " & API_Subprogram_Name (Class, Adjust)
          & " (Self." & View_Name (Class)
          & ", Self.Storage'Address);");
      Unit.Put_Line (+"      Self.Wrapper := False;");
      Unit.Put_Line (+"   end Adjust;");

      Unit.New_Line;
      Unit.Put_Line
       ("   overriding procedure Finalize (Self : in out "
          & User_Tagged_Type_Name (Class) & ") is");
      Unit.Put_Line
       (+"      use type " & API_Access_Type_Full_Name (Class) & ";");
      Unit.New_Line;
      Unit.Put_Line (+"   begin");
      Unit.Put_Line ("      if Self." & View_Name (Class) & " /= null then");
      Unit.Put_Line (+"         if Self.Wrapper then");
      Unit.Put_Line ("             Self." & View_Name (Class) & " := null;");
      Unit.New_Line;
      Unit.Put_Line (+"         else");
      Unit.Put_Line
       ("            " & API_Subprogram_Name (Class, Finalize)
          & " (Self." & View_Name (Class) & ");");
      Unit.Put_Line (+"         end if;");
      Unit.Put_Line (+"      end if;");
      Unit.Put_Line (+"   end Finalize;");

      Unit.New_Line;
      Unit.Put_Line
       ("   overriding procedure Initialize (Self : in out "
          & User_Tagged_Type_Name (Class) & ") is");
      Unit.Put_Line (+"   begin");
      Unit.Put_Line
       ("      " & API_Subprogram_Name (Class, Initialize)
          & " (Self." & View_Name (Class)
          & ", Self.Storage'Address);");
      Unit.Put_Line (+"      Self.Wrapper := False;");
      Unit.Put_Line (+"   end Initialize;");

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
                   & User_Tagged_Type_Name (Return_Class) & " is");
               Unit.Put_Line (+"   begin");
               Unit.Put_Line
                ("      return QtAda_Result : "
                   & User_Tagged_Type_Name (Class)
                   & " := (Ada.Finalization.Controlled with others => <>) do");
               Unit.Put_Line
                ("         " & API_Subprogram_Name (Class, Method));
               Unit.Put_Line
                ("          (QtAda_Result." & View_Name (Class)
                   & ", QtAda_Result.Storage'Address, Self."
                   & View_Name (Class) & ");");
               Unit.Put_Line (+"         QtAda_Result.Wrapper := False;");
               Unit.Put_Line (+"      end return;");
               Unit.Put_Line
                ("   end " & Values.To_Ada_Identifier (Method.Name) & ";");

            else
               --  XXX Not supported yet.

               Ada.Wide_Wide_Text_IO.Put_Line
                ("Skipping "
                   & Method.Name.To_Universal_String.To_Wide_Wide_String);
            end if;
         end;
      end loop;

      Unit.New_Line;
      Unit.Put_Line ("end " & User_Package_Full_Name (Class) & ";");

      Unit.Save (Self.Output_Directory);
   end Generate;

   ---------------------
   -- Should_Generate --
   ---------------------

   overriding function Should_Generate
    (Self  : in out Value_Ada_Body_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean
   is
      pragma Unreferenced (Self);

   begin
      return Class.Type_Entry.Is_Value;
   end Should_Generate;

   ---------------
   -- View_Name --
   ---------------

   function View_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return Class.Name.To_Universal_String & "_View";
   end View_Name;

end Ada_Side.Generators.Adas.Value_Body;
