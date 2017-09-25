with Interfaces.C.Extensions;

package body Type_Entries is

   function TypeEntry_isValue
    (Self : not null TypeEntry_Access) return Interfaces.C.Extensions.bool
       with Import     => True,
            Convention => C,
            Link_Name  => "TypeEntry_isValue";

   procedure TypeEntry_name
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null TypeEntry_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "TypeEntry_name";

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

      --------------
      -- Internal --
      --------------

      function Internal (Self : Type_Entry'Class) return TypeEntry_Access is
      begin
         return Self.TypeEntry_View;
      end Internal;

   end Internals;

   --------------
   -- Is_Value --
   --------------

   function Is_Value (Self : Type_Entry'Class) return Boolean is
      use type Interfaces.C.Extensions.bool;

   begin
      return TypeEntry_isValue (Self.TypeEntry_View) /= 0;
   end Is_Value;

   ----------
   -- Name --
   ----------

   function Name (Self : Type_Entry'Class) return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         TypeEntry_name
          (Q_Strings.Internals.Internal (Result), Self.TypeEntry_View);
      end return;
   end Name;

end Type_Entries;
