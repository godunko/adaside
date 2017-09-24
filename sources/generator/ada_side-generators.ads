with League.Strings;

with Abstract_Meta_Classes;

package Ada_Side.Generators is

   type Abstract_Generator is abstract tagged limited private;

   type Generator_Access is access all Abstract_Generator'Class;

   not overriding function Should_Generate
    (Self  : in out Abstract_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return Boolean is abstract;
   --  Returns True when some code need to be generated for this class.

   not overriding procedure Generate
    (Self  : in out Abstract_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) is abstract;
   --  Generates code.

   not overriding procedure Setup
    (Self             : in out Abstract_Generator;
     Output_Directory : League.Strings.Universal_String);
   --  Initialize generator.

private

   type Abstract_Generator is abstract tagged limited record
      Output_Directory : League.Strings.Universal_String;
   end record;

   type Protocol_Subprograms is (Adjust, Finalize, Initialize);

   function API_Subprogram_Link_Name
    (Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Protocol_Subprograms)
       return League.Strings.Universal_String;

   function API_Size_Of_Link_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

end Ada_Side.Generators;
