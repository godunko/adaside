with Code_Model.Namespaces;
pragma Unreferenced (Code_Model.Namespaces);
--  XXX GNAT 20171008 generates spurious warning.

package body Code_Model.Namespaces is

   use type League.Strings.Universal_String;

   ----------------------
   -- Lookup_Namespace --
   ----------------------

   function Lookup_Namespace
    (Self : Namespace'Class;
     Name : League.Strings.Universal_String)
       return Code_Model.Namespace_Access is
   begin
      for Namespace of Self.Namespaces loop
         if Namespace.Name = Name then
            return Namespace;
         end if;
      end loop;

      return null;
   end Lookup_Namespace;

end Code_Model.Namespaces;
