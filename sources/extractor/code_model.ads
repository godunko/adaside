with Ada.Containers.Vectors;

limited with Code_Model.Classes;
limited with Code_Model.Namespaces;
limited with Code_Model.Scopes;

package Code_Model is

   pragma Preelaborate;

   type Class_Access is access all Code_Model.Classes.Class'Class;
   type Namespace_Access is access all Code_Model.Namespaces.Namespace'Class;
   type Scope_Access is access all Code_Model.Scopes.Abstract_Scope'Class;

--  private

   package Class_Vectors is
     new Ada.Containers.Vectors (Positive, Class_Access);

   package Namespace_Vectors is
     new Ada.Containers.Vectors (Positive, Namespace_Access);

end Code_Model;
