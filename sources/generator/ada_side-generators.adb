
package body Ada_Side.Generators is

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
