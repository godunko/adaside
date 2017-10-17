with League.Strings;

package Code_Model.Files is

   pragma Preelaborate;

   type File is tagged limited record
      Name    : League.Strings.Universal_String;
      Classes : Class_Vectors.Vector;
   end record;

end Code_Model.Files;
