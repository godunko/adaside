private with Ada.Finalization;

with Q_Strings;

package Header_Paths is

   type Header_Path is tagged private;

   function Create (Path : Q_Strings.Q_String) return Header_Path;

   package Internals is

      type HeaderPath is null record with Convention => C;
      type HeaderPath_Access is access all HeaderPath with Convention => C;

      function Internal (Self : Header_Path'Class) return HeaderPath_Access;

   end Internals;

private

   function HeaderPath_new return Internals.HeaderPath_Access
     with Import     => True,
          Convention => C,
          Link_Name  => "HeaderPath__new";

   type Header_Path is new Ada.Finalization.Controlled with record
      Object : Internals.HeaderPath_Access := HeaderPath_new;
   end record;

   overriding procedure Adjust (Self : in out Header_Path);
   overriding procedure Finalize (Self : in out Header_Path);

end Header_Paths;
