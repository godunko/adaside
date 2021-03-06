with Ada.Wide_Wide_Text_IO;

with Abstract_Meta_Argument_Lists;
with Abstract_Meta_Types;

package body Ada_Side.Generators is

   use type League.Strings.Universal_String;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   ---------------------------
   -- API_Size_Of_Link_Name --
   ---------------------------

   function API_Size_Of_Link_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String is
   begin
      return "__qtada___sizeof_" & Class.Name.To_Universal_String;
   end API_Size_Of_Link_Name;

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
            return "__qtada__" & Class.Name.To_Universal_String & "___adjust";

         when Finalize =>
            return
              "__qtada__" & Class.Name.To_Universal_String & "___finalize";

         when Initialize =>
            return
              "__qtada__" & Class.Name.To_Universal_String & "___initialize";
      end case;
   end API_Subprogram_Link_Name;

   ------------------------------
   -- API_Subprogram_Link_Name --
   ------------------------------

   function API_Subprogram_Link_Name
    (Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Abstract_Meta_Functions.Abstract_Meta_Function'Class)
       return League.Strings.Universal_String
   is
      Name       : constant League.Strings.Universal_String
        := Subprogram.Name.To_Universal_String;
      Parameters : Abstract_Meta_Argument_Lists.Abstract_Meta_Argument_List
        := Subprogram.Arguments;

   begin
      return Result : League.Strings.Universal_String
        := "__qtada__"
             & Class.Name.To_Universal_String
             & "__"
      do
         if Subprogram.Is_Arithmetic_Operator
           or else Subprogram.Is_Comparison_Operator
         then
            --  Arithmetic operators

            if Name = +"operator+" then
               Result.Append ("_operator_plus");

            elsif Name = +"operator-" then
               Result.Append ("_operator_minus");

            elsif Name = +"operator*" then
               Result.Append ("_operator_multiply");

            elsif Name = +"operator/" then
               Result.Append ("_operator_divide");

            --  Comparison operators

            elsif Name = +"operator==" then
               Result.Append ("_operator_equal");

            else
               raise Program_Error;
            end if;

            if not Subprogram.Is_Reverse_Operator then
               Result.Append ('_');
               Result.Append (Class.Name.To_Universal_String);
            end if;

         else
            Result.Append (Name);
         end if;

         for Parameter of Parameters loop
            Result.Append ('_');
            Result.Append
             (Parameter.Get_Type.Type_Entry.Name.To_Universal_String);
         end loop;

         if Subprogram.Is_Arithmetic_Operator
           and Subprogram.Is_Reverse_Operator
         then
            Result.Append ('_');
            Result.Append (Class.Name.To_Universal_String);
         end if;
      end return;
   end API_Subprogram_Link_Name;

   ----------------------
   -- Can_Be_Generated --
   ----------------------

   function Can_Be_Generated
    (Generator : Abstract_Generator'Class;
     Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Abstract_Meta_Functions.Abstract_Meta_Function'Class)
       return Boolean
   is
      pragma Unreferenced (Generator, Class);

   begin
      if Subprogram.Is_Constructor
        and (Subprogram.Arguments.Is_Empty or Subprogram.Is_Copy_Constructor)
      then
         --  Binding for default & copy constructors are not need to be
         --  generated.

         return False;
      end if;

      if Subprogram.Is_Bitwise_Operator then
         --  XXX Not supported yet.

         Ada.Wide_Wide_Text_IO.Put_Line
          (" Skip '" & Subprogram.Minimal_Signature.To_Wide_Wide_String & ''');

         return False;
      end if;

      declare
         Parameters : Abstract_Meta_Argument_Lists.Abstract_Meta_Argument_List
           := Subprogram.Arguments;

      begin
         for Parameter of Parameters loop
            if Parameter.Get_Type.Is_Primitive then
               --  XXX Primitive means no & or *

               null;

            elsif not Parameter.Get_Type.Is_Value
              or not Parameter.Get_Type.Is_Constant
              or not Parameter.Get_Type.Is_L_Value_Reference
            then
               Ada.Wide_Wide_Text_IO.Put_Line
                (" Skip '"
                   & Subprogram.Minimal_Signature.To_Wide_Wide_String & ''');

               return False;
            end if;
         end loop;
      end;

      if Subprogram.Get_Type.Is_Null then
         return True;
      end if;

      if Subprogram.Get_Type.Is_Reference then
         Ada.Wide_Wide_Text_IO.Put_Line
          (" Skip '" & Subprogram.Minimal_Signature.To_Wide_Wide_String & ''');

         return False;
      end if;

      declare
         Return_Type  : constant Abstract_Meta_Types.Abstract_Meta_Type
           := Subprogram.Get_Type;
--         Return_Class : constant Abstract_Meta_Classes.Abstract_Meta_Class
--           := Generator.Find_Class (Return_Type.Type_Entry);
--           := (if Return_Type.Is_Null
--                 then Abstract_Meta_Classes.Null_Abstract_Meta_Class
--                 else Self.Find_Class (Return_Type.Type_Entry));

      begin
         if Return_Type.Type_Entry.Is_Primitive
           or Return_Type.Is_Value
         then
            return True;
         end if;
      end;

      Ada.Wide_Wide_Text_IO.Put_Line
       (" Skip '" & Subprogram.Minimal_Signature.To_Wide_Wide_String & ''');

      return False;
   end Can_Be_Generated;

   ----------------
   -- Find_Class --
   ----------------

   function Find_Class
    (Self       : Abstract_Generator'Class;
     Type_Entry : Type_Entries.Type_Entry)
       return Abstract_Meta_Classes.Abstract_Meta_Class is
   begin
      return Abstract_Meta_Classes.Find_Class (Self.Classes, Type_Entry);
   end Find_Class;

   -----------
   -- Setup --
   -----------

   not overriding procedure Setup
    (Self             : in out Abstract_Generator;
     Output_Directory : League.Strings.Universal_String;
     Classes          : Abstract_Meta_Class_Lists.Abstract_Meta_Class_List) is
   begin
      Self.Output_Directory := Output_Directory;
      Self.Classes          := Classes;
   end Setup;

end Ada_Side.Generators;
