private with Ada.Containers.Hashed_Maps;

with League.Strings;
private with League.Strings.Hash;

package Code_Model.Models is

   pragma Preelaborate;

   type Model is tagged limited private;

   function Lookup_Or_Create
    (Self      : in out Model'Class;
     File_Name : League.Strings.Universal_String)
       return not null File_Access;

private

   package File_Maps is
     new Ada.Containers.Hashed_Maps
          (Key_Type        => League.Strings.Universal_String,
           Element_Type    => Code_Model.File_Access,
           Hash            => League.Strings.Hash,
           Equivalent_Keys => League.Strings."=");

   type Model is tagged limited record
      Files      : File_Maps.Map;
      Classes    : Class_Vectors.Vector;
      Namespaces : Namespace_Vectors.Vector;
   end record;

end Code_Model.Models;
