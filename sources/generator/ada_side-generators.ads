with Abstract_Meta_Classes;

package Ada_Side.Generators is

   type Abstract_Generator is abstract tagged limited private;

   type Generator_Access is access all Abstract_Generator'Class;

   not overriding function Should_Generate
    (Self  : in out Abstract_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return Boolean is abstract;
   --  Returns True when some code need to be generated for this class.

private

   type Abstract_Generator is abstract tagged limited record
      null;
   end record;

end Ada_Side.Generators;
