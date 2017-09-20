private with Ada.Finalization;

package Q_Strings is

   pragma Preelaborate;

   type Q_String is tagged private;

   function From_UTF8 (Item : String) return Q_String;

   function To_UTF8 (Self : Q_String'Class) return String;

   package Internals is

      type QString is null record with Convention => C;
      type QString_Access is access all QString with Convention => C;

      function Internal (Item : Q_String'Class) return QString_Access;

   end Internals;

private

   function QString_new return Internals.QString_Access
     with Import     => True,
          Convention => C,
          Link_Name  => "QString__new";

   type Q_String is new Ada.Finalization.Controlled with record
      Object : Internals.QString_Access := QString_new;
   end record;

--   overriding procedure Initialize (Self : in out Q_String);
   overriding procedure Adjust (Self : in out Q_String);
   overriding procedure Finalize (Self : in out Q_String);

end Q_Strings;
