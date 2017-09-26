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

   function View_Expression
    (Generated_Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Class           : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Name            : League.Strings.Universal_String)
       return League.Strings.Universal_String;
   --  Returns texf expression to access "view" component.

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

            elsif not Return_Type.Is_Null
              and then Method.Is_Constant
              and then Method.Arguments.Size = 0
              and then not Method.Get_Type.Is_Reference
            then
               if Return_Type.Type_Entry.Is_Primitive then
                  Unit.New_Line;
                  Unit.Put_Line
                   ("   function " & API_Subprogram_Name (Class, Method));
                  Unit.Put_Line
                   ("    (Self    : not null "
                      & API_Access_Type_Full_Name (Class) & ")");
                  Unit.Put_Line
                   ("       return "
                      & Return_Type.Type_Entry.Target_Lang_Name
                          .To_Universal_String);
                  Unit.Put_Line (+"         with Import     => True,");
                  Unit.Put_Line (+"              Convention => C,");
                  Unit.Put_Line
                   ("              Link_Name  => """
                      & API_Subprogram_Link_Name (Class, Method) & """;");

               elsif Method.Get_Type.Is_Value then
                  Unit.New_Line;
                  Unit.Put_Line
                   ("   procedure " & API_Subprogram_Name (Class, Method));

                  if Abstract_Meta_Classes.Abstract_Meta_Class (Class)
                       = Return_Class
                  then
                     Unit.Put_Line
                      ("    (View    : in out "
                         & API_Access_Type_Full_Name (Return_Class) & ";");
                     Unit.Put_Line (+"     Storage : System.Address;");

                  else
                     Unit.Add_With_Clause
                      (API_Package_Full_Name (Return_Class));
                     Unit.Put_Line
                      ("    (View    : not null "
                         & API_Access_Type_Full_Name (Return_Class) & ";");
                  end if;

                  Unit.Put_Line
                   ("     Self    : not null "
                      & API_Access_Type_Full_Name (Class) & ")");
                  Unit.Put_Line (+"       with Import     => True,");
                  Unit.Put_Line (+"            Convention => C,");
                  Unit.Put_Line
                   ("            Link_Name  => """
                      & API_Subprogram_Link_Name (Class, Method) & """;");
               end if;

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
          & " (" & View_Expression (Class, Class, +"Self")
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
      Unit.Put_Line
       ("      if " & View_Expression (Class, Class, +"Self") & " /= null");
      Unit.Put_Line (+"        and not Self.Wrapper");
      Unit.Put_Line (+"      then");
      Unit.Put_Line
       ("         " & API_Subprogram_Name (Class, Finalize)
          & " (" & View_Expression (Class, Class, +"Self") & ");");
      Unit.Put_Line (+"      end if;");
      Unit.Put_Line (+"   end Finalize;");

      Unit.New_Line;
      Unit.Put_Line
       ("   overriding procedure Initialize (Self : in out "
          & User_Tagged_Type_Name (Class) & ") is");
      Unit.Put_Line (+"   begin");
      Unit.Put_Line
       ("      " & API_Subprogram_Name (Class, Initialize)
          & " (" & View_Expression (Class, Class, +"Self")
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

            elsif not Return_Type.Is_Null
              and then Method.Is_Constant
              and then Method.Arguments.Size = 0
              and then not Method.Get_Type.Is_Reference
            then
               if Return_Type.Type_Entry.Is_Primitive then
                  Unit.New_Line;
                  Unit.Put_Line
                   ("   function "
                      & Values.To_Ada_Identifier (Method.Name));
                  Unit.Put_Line
                   ("    (Self : "
                      & User_Tagged_Type_Name (Class) & "'Class)");
                  Unit.Put_Line
                   ("       return "
                      & Return_Type.Type_Entry.Target_Lang_Name
                          .To_Universal_String & " is");
                  Unit.Put_Line (+"   begin");
                  Unit.Put_Line
                   ("      return "
                      & API_Subprogram_Name (Class, Method)
                      & " (" & View_Expression (Class, Class, +"Self") & ");");
                  Unit.Put_Line
                   ("   end "
                      & Values.To_Ada_Identifier (Method.Name) & ";");

               elsif Return_Type.Is_Value then
                  Unit.New_Line;
                  Unit.Put_Line
                   ("   function "
                      & Values.To_Ada_Identifier (Method.Name));
                  Unit.Put_Line
                   ("    (Self : "
                      & User_Tagged_Type_Name (Class) & "'Class)");
                  Unit.Put_Line
                   ("       return "
                      & User_Tagged_Type_Full_Name (Return_Class) & " is");
                  Unit.Put_Line (+"   begin");

                  if Abstract_Meta_Classes.Abstract_Meta_Class (Class)
                       = Return_Class
                  then
                     Unit.Put_Line
                      ("      return QtAda_Result : "
                         & User_Tagged_Type_Full_Name (Return_Class)
                         & " := (Ada.Finalization.Controlled with"
                         & " others => <>) do");

                  else
                     Unit.Put_Line
                      ("      return QtAda_Result : "
                         & User_Tagged_Type_Full_Name (Return_Class)
                         & " do");
                  end if;

                  Unit.Put_Line
                   ("         " & API_Subprogram_Name (Class, Method));
                  Unit.Put
                   ("          ("
                      & View_Expression
                         (Class, Return_Class, +"QtAda_Result"));

                  if Abstract_Meta_Classes.Abstract_Meta_Class (Class)
                       = Return_Class
                  then
                     Unit.Put (+", QtAda_Result.Storage'Address");

                  else
                     Unit.Add_With_Clause
                      (User_Package_Full_Name (Return_Class) & ".Internals");
                  end if;

                  Unit.Put_Line
                   (", " & View_Expression (Class, Class, +"Self") & ");");

                  Unit.Put_Line (+"      end return;");
                  Unit.Put_Line
                   ("   end " & Values.To_Ada_Identifier (Method.Name) & ";");
               end if;

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

   ---------------------
   -- View_Expression --
   ---------------------

   function View_Expression
    (Generated_Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Class           : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Name            : League.Strings.Universal_String)
       return League.Strings.Universal_String is
   begin
      if Generated_Class = Class then
         return Name & '.' & Class.Name.To_Universal_String & "_View";

      else
         return
           User_Package_Full_Name (Class)
             & ".Internals."
             & Class.Name.To_Universal_String & "_View (" & Name & ')';
      end if;
   end View_Expression;

end Ada_Side.Generators.Adas.Value_Body;
