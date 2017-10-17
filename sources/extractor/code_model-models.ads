
package Code_Model.Models is

   pragma Preelaborate;

   type Code_Model is tagged limited private;

private

   type Code_Model is tagged limited record
      Files      : File_Vectors.Vector;
      Classes    : Class_Vectors.Vector;
      Namespaces : Namespace_Vectors.Vector;
   end record;

end Code_Model.Models;
