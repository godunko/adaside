
package body Ada_Side.Generators is

   use type League.Strings.Universal_String;

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
