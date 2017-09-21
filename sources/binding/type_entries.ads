with Q_Strings;

package Type_Entries is

   type TypeEntry is null record with Convention => C;
   type TypeEntry_Access is access all TypeEntry with Convention => C;

   type Type_Entry is tagged private;

   function Is_Value (Self : Type_Entry'Class) return Boolean;

   function Name (Self : Type_Entry'Class) return Q_Strings.Q_String;

   package Internals is

      procedure Initialize
       (Self : in out Type_Entry'Class;
        View : TypeEntry_Access);

   end Internals;

private

   type Type_Entry is tagged record
      TypeEntry_View : TypeEntry_Access;
   end record;

end Type_Entries;
