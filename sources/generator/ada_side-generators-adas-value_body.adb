with Ada_Side.Units;

package body Ada_Side.Generators.Adas.Value_Body is

   use type League.Strings.Universal_String;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   type Protocol_Subprograms is (Adjust, Finalize, Initialize);

   function API_Subprogram_Name
    (Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Protocol_Subprograms)
       return League.Strings.Universal_String;

   function API_Subprogram_Link_Name
    (Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Protocol_Subprograms)
       return League.Strings.Universal_String;

   function View_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;
   --  Name of "view" component.

   ------------------------------
   -- API_Subprogram_Link_Name --
   ------------------------------

   function API_Subprogram_Link_Name
    (Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Protocol_Subprograms)
       return League.Strings.Universal_String is
   begin
      case Subprogram is
         when Adjust =>
            return Class.Name.To_Universal_String & "___adjust";

         when Finalize =>
            return Class.Name.To_Universal_String & "___finalize";

         when Initialize =>
            return Class.Name.To_Universal_String & "___initialize";
      end case;
   end API_Subprogram_Link_Name;

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

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_Ada_Body_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      Unit : Ada_Side.Units.Ada_Body_Unit;

   begin
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
