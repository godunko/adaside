with Ada_Side.Generators;

package Ada_Side.Setup is

   type Generator_Array is
     array (Positive range <>)
       of not null Ada_Side.Generators.Generator_Access;

   function Generators return Generator_Array;
   --  Returns set of registered generators.

end Ada_Side.Setup;
