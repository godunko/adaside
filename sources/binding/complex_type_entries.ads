with Type_Entries;

package Complex_Type_Entries is

   type ComplexTypeEntry is null record with Convention => C;
   type ComplexTypeEntry_Access is access all ComplexTypeEntry
     with Convention => C;

   type Complex_Type_Entry is new Type_Entries.Type_Entry with private;

   package Internals is

      function Wrap (View : ComplexTypeEntry_Access) return Complex_Type_Entry;

      procedure Initialize
       (Self : in out Complex_Type_Entry'Class;
        View : ComplexTypeEntry_Access);

   end Internals;

private

   type Complex_Type_Entry is new Type_Entries.Type_Entry with record
      ComplexTypeEntry_View : ComplexTypeEntry_Access;
   end record;

end Complex_Type_Entries;
