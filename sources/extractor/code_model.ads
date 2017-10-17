with Ada.Containers.Vectors;

limited with Code_Model.Classes;
limited with Code_Model.Files;
limited with Code_Model.Models;
limited with Code_Model.Namespaces;
limited with Code_Model.Scopes;

package Code_Model is

   pragma Preelaborate;

   type Class_Access is access all Code_Model.Classes.Class'Class;
   type File_Access is access all Code_Model.Files.File'Class;
   type Code_Model_Access is access all Code_Model.Models.Code_Model'Class;
   type Namespace_Access is access all Code_Model.Namespaces.Namespace'Class;
   type Scope_Access is access all Code_Model.Scopes.Abstract_Scope'Class;

--  private

   package Class_Vectors is
     new Ada.Containers.Vectors (Positive, Class_Access);

   package File_Vectors is
     new Ada.Containers.Vectors (Positive, File_Access);

   package Namespace_Vectors is
     new Ada.Containers.Vectors (Positive, Namespace_Access);

end Code_Model;
