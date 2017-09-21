
package Type_Entries is

   type TypeEntry is null record with Convention => C;
   type TypeEntry_Access is access all TypeEntry with Convention => C;

   type Type_Entry is tagged private;

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
