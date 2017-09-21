
package body Type_Entries is

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self : in out Type_Entry'Class;
        View : TypeEntry_Access) is
      begin
         Self.TypeEntry_View := View;
      end Initialize;

   end Internals;

end Type_Entries;
