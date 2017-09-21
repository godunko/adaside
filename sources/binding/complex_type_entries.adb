
package body Complex_Type_Entries is

   function cast_TypeEntry
    (Item : ComplexTypeEntry_Access) return Type_Entries.TypeEntry_Access
       with Import     => True,
            Convention => C,
            Link_Name  => "dynamic_cast__ComplexTypeEntry__TypeEntry";

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self : in out Complex_Type_Entry'Class;
        View : ComplexTypeEntry_Access) is
      begin
         Self.ComplexTypeEntry_View := View;
         Type_Entries.Internals.Initialize
          (Self, cast_TypeEntry (Self.ComplexTypeEntry_View));
      end Initialize;

      ----------
      -- Wrap --
      ----------

      function Wrap
       (View : ComplexTypeEntry_Access) return Complex_Type_Entry is
      begin
         return Result : Complex_Type_Entry
                  := (Type_Entries.Type_Entry with
                        ComplexTypeEntry_View => View)
         do
            Type_Entries.Internals.Initialize
             (Result, cast_TypeEntry (Result.ComplexTypeEntry_View));
         end return;
      end Wrap;

   end Internals;

end Complex_Type_Entries;
