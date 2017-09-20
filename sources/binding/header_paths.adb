
package body Header_Paths is

   procedure HeaderPath_adjust (Self : in out Internals.HeaderPath_Access)
     with Import     => True,
          Convention => C,
          Link_Name  => "HeaderPath__adjust";

   procedure HeaderPath_delete (Self : in out Internals.HeaderPath_Access)
     with Import     => True,
          Convention => C,
          Link_Name  => "HeaderPath__delete";

   function HeaderPath_new_2
    (Path : Q_Strings.Internals.QString_Access)
       return Internals.HeaderPath_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "HeaderPath__new_2";

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Header_Path) is
   begin
      HeaderPath_adjust (Self.Object);
   end Adjust;

   ------------
   -- Create --
   ------------

   function Create (Path : Q_Strings.Q_String) return Header_Path is
   begin
      return (Ada.Finalization.Controlled
                with Object => HeaderPath_new_2
                                (Q_Strings.Internals.Internal (Path)));
   end Create;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Header_Path) is
      use type Header_Paths.Internals.HeaderPath_Access;

   begin
      if Self.Object /= null then
         HeaderPath_delete (Self.Object);
      end if;
   end Finalize;

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      --------------
      -- Internal --
      --------------

      function Internal (Self : Header_Path'Class) return HeaderPath_Access is
      begin
         return Self.Object;
      end Internal;

   end Internals;

end Header_Paths;
