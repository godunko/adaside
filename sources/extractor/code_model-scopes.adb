with Code_Model.Classes;
pragma Unreferenced (Code_Model.Classes);
--  XXX GNAT 20171008 generates spurious warning.

package body Code_Model.Scopes is

   use type League.Strings.Universal_String;

   ------------------
   -- Lookup_Class --
   ------------------

   function Lookup_Class
    (Self : Abstract_Scope'Class;
     Name : League.Strings.Universal_String) return Code_Model.Class_Access is
   begin
      for Class of Self.Classes loop
         if Class.Name = Name then
            return Class;
         end if;
      end loop;

      return null;
   end Lookup_Class;

end Code_Model.Scopes;
