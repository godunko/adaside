with Code_Model.Scopes;

package Code_Model.Namespaces is

   pragma Preelaborate;

   type Namespace is new Code_Model.Scopes.Abstract_Scope with record
      null;
   end record;

end Code_Model.Namespaces;
