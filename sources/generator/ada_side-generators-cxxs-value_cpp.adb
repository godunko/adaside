with Ada.Wide_Wide_Text_IO;

with Abstract_Meta_Argument_Lists;
with Abstract_Meta_Function_Lists;
with Abstract_Meta_Types;

with Ada_Side.Units;

package body Ada_Side.Generators.CXXs.Value_Cpp is

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   --------------
   -- Generate --
   --------------

   overriding procedure Generate
    (Self  : in out Value_Cpp_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
   is
      use type League.Strings.Universal_String;
      use type Abstract_Meta_Classes.Abstract_Meta_Class;

      Unit      : Ada_Side.Units.CXX_Cpp_Unit;
      Functions : Abstract_Meta_Function_Lists.Abstract_Meta_Function_List
        := Class.Functions;

   begin
      Unit.Set_Class_Name (Class.Name.To_Universal_String);

      Unit.Put_Line
       ("#include """
          & Class.Name.To_Universal_String.To_Lowercase & "_wrapper.h""");

      Unit.New_Line;
      Unit.Put_Line
       ("const size_t "
          & API_Size_Of_Link_Name (Class)
          & " = sizeof(" & Class.Name.To_Universal_String & ");");

      Unit.New_Line;
      Unit.Put_Line
       ("void "
          & API_Subprogram_Link_Name (Class, Adjust)
          & "(" & Class.Name.To_Universal_String
          & "** ___view, void* ___storage)");
      Unit.Put_Line (+"{");
      Unit.Put_Line
       (+"    *___view = new (___storage) "
           & Class.Name.To_Universal_String & "(**___view);");
      Unit.Put_Line (+"}");

      Unit.New_Line;
      Unit.Put_Line
       ("void "
          & API_Subprogram_Link_Name (Class, Finalize)
          & "(" & Class.Name.To_Universal_String & "** ___view)");
      Unit.Put_Line (+"{");
      Unit.Put_Line
       ("    (*___view)->~" & Class.Name.To_Universal_String & "();");
      Unit.Put_Line (+"    *___view = 0;");
      Unit.Put_Line (+"}");

      Unit.New_Line;
      Unit.Put_Line
       ("void "
          & API_Subprogram_Link_Name (Class, Initialize)
          & "(" & Class.Name.To_Universal_String
          & "** ___view, void* ___storage)");
      Unit.Put_Line (+"{");
      Unit.Put_Line
       (+"    *___view = new (___storage) "
           & Class.Name.To_Universal_String & "();");
      Unit.Put_Line (+"}");

      for Method of Functions loop
         declare
            Return_Type  : constant Abstract_Meta_Types.Abstract_Meta_Type
              := Method.Get_Type;
            Return_Class : constant Abstract_Meta_Classes.Abstract_Meta_Class
              := (if Return_Type.Is_Null
                    then Abstract_Meta_Classes.Null_Abstract_Meta_Class
                    else Self.Find_Class (Return_Type.Type_Entry));
            First_Arg    : Boolean := True;
            Second_Close : Boolean := False;

         begin
            if Self.Can_Be_Generated (Class, Method) then
               Generate_Declaration (Self, Unit, Class, Method);
               Unit.New_Line;
               Unit.Put_Line (+"{");

               if Return_Type.Type_Entry.Is_Primitive then
                  Unit.Put
                      ("    return "
                         & "self->"
                         & Method.Name.To_Universal_String
                         & "(");

               elsif Method.Get_Type.Is_Value then
                  Unit.New_Line;

                  if Abstract_Meta_Classes.Abstract_Meta_Class (Class)
                       = Return_Class
                  then
                     Unit.Put
                      ("    *___view = new (___storage) "
                         & Class.Name.To_Universal_String
                         & "(self->"
                         & Method.Name.To_Universal_String
                         & "(");
                     Second_Close := True;

                  else
                     Unit.Put
                      ("    *___view = "
                         & "self->"
                         & Method.Name.To_Universal_String
                         & "(");
                  end if;

                  declare
                     Parameters :
                       Abstract_Meta_Argument_Lists.Abstract_Meta_Argument_List
                         := Method.Arguments;

                  begin
                     for Parameter of Parameters loop
                        if First_Arg then
                           First_Arg := False;

                        else
                           Unit.Put (+", ");
                        end if;

                        if Parameter.Get_Type.Is_Constant then
                           Unit.Put ("*" & Parameter.Name.To_Universal_String);

                        else
                           raise Program_Error;
                        end if;
                     end loop;
                  end;
               end if;

               if Second_Close then
                  Unit.Put (+")");
               end if;

               Unit.Put_Line (+");");
               Unit.Put_Line (+"}");

            else
               --  XXX Not supported yet.

               Ada.Wide_Wide_Text_IO.Put_Line
                ("Skipping "
                   & Method.Name.To_Universal_String.To_Wide_Wide_String);
            end if;
         end;
      end loop;

      Unit.Save (Self.Output_Directory);
   end Generate;

   ---------------------
   -- Should_Generate --
   ---------------------

   overriding function Should_Generate
    (Self  : in out Value_Cpp_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean
   is
      pragma Unreferenced (Self);

   begin
      return Class.Type_Entry.Is_Value;
   end Should_Generate;

end Ada_Side.Generators.CXXs.Value_Cpp;
