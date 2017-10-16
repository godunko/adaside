with League.Strings;

with Code_Model.Scopes;

package Code_Model.Namespaces is

   pragma Preelaborate;

   type Namespace is new Code_Model.Scopes.Abstract_Scope with record
      Namespaces : Namespace_Vectors.Vector;
   end record;

   function Lookup_Namespace
    (Self : Namespace'Class;
     Name : League.Strings.Universal_String)
       return Code_Model.Namespace_Access;

end Code_Model.Namespaces;
