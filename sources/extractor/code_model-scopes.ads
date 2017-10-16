with League.Strings;

package Code_Model.Scopes is

   pragma Preelaborate;

   type Abstract_Scope is abstract tagged limited record
      Name    : League.Strings.Universal_String;
      Classes : Class_Vectors.Vector;
   end record;

   function Lookup_Class
    (Self : Abstract_Scope'Class;
     Name : League.Strings.Universal_String) return Code_Model.Class_Access;

end Code_Model.Scopes;
