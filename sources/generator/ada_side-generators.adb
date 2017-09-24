
package body Ada_Side.Generators is

   ------------------------------
   -- API_Subprogram_Link_Name --
   ------------------------------

   function API_Subprogram_Link_Name
    (Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Protocol_Subprograms)
       return League.Strings.Universal_String
   is
      use type League.Strings.Universal_String;

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

   -----------
   -- Setup --
   -----------

   not overriding procedure Setup
    (Self             : in out Abstract_Generator;
     Output_Directory : League.Strings.Universal_String) is
   begin
      Self.Output_Directory := Output_Directory;
   end Setup;

end Ada_Side.Generators;
