with Interfaces.C.Strings;

with League.Strings.Internals;
with Matreshka.Internals.Strings.C;
with Matreshka.Internals.Utf16;

package body Q_Strings is

   procedure QString_adjust (Self : in out Internals.QString_Access)
     with Import     => True,
          Convention => C,
          Link_Name  => "QString__adjust";

   procedure QString_delete (Self : in out Internals.QString_Access)
     with Import     => True,
          Convention => C,
          Link_Name  => "QString__delete";

   function QString_fromUtf16
    (data : not null Matreshka.Internals.Strings.C.Utf16_Code_Unit_Access;
     size : Interfaces.C.int) return Internals.QString_Access
       with Import     => True,
            Convention => C,
            Link_Name  => "QString__fromUtf16";

   function QString_fromUtf8
    (str  : access constant Interfaces.C.char;
     size : Interfaces.C.int) return Internals.QString_Access
       with Import     => True,
            Convention => C,
            Link_Name  => "QString__fromUtf8";

   function QString_toUtf8
    (Self : not null Internals.QString_Access)
       return Interfaces.C.Strings.chars_ptr
         with Import     => True,
              Convention => C,
              Link_Name  => "QString_toUtf8";

   function QString_size
    (Self : not null Internals.QString_Access) return Interfaces.C.int
       with Import     => True,
            Convention => C,
            Link_Name  => "QString__size";

   function QString_utf16
    (Self : not null Internals.QString_Access)
       return not null Matreshka.Internals.Strings.C.Utf16_Code_Unit_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "QString__utf16";

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Q_String) is
   begin
      QString_adjust (Self.Object);
   end Adjust;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Q_String) is
      use type Internals.QString_Access;

   begin
      if Self.Object /= null then
         QString_delete (Self.Object);
      end if;
   end Finalize;

   ---------------------------
   -- From_Universal_String --
   ---------------------------

   function From_Universal_String
    (Item : League.Strings.Universal_String) return Q_String
   is
      Aux : constant Matreshka.Internals.Strings.Shared_String_Access
        := League.Strings.Internals.Internal (Item);

   begin
      return (Ada.Finalization.Controlled with
                Object => QString_fromUtf16
                           (Aux.Value (0)'Access,
                            Interfaces.C.int (Aux.Unused)));
   end From_Universal_String;

   ---------------
   -- From_UTF8 --
   ---------------

   function From_UTF8 (Item : String) return Q_String is
      C : constant Interfaces.C.char_array := Interfaces.C.To_C (Item);

   begin
      return (Ada.Finalization.Controlled
                with Object => QString_fromUtf8
                                (C (C'First)'Access, Item'Length));
   end From_UTF8;

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      function Internal (Item : Q_String'Class) return QString_Access is
      begin
         return Item.Object;
      end Internal;

   end Internals;

   -------------------------
   -- To_Universal_String --
   -------------------------

   function To_Universal_String
    (Self : Q_String'Class) return League.Strings.Universal_String is
   begin
      return
        Matreshka.Internals.Strings.C.To_Valid_Universal_String
         (QString_utf16 (Self.Object),
          Matreshka.Internals.Utf16.Utf16_String_Index
           (QString_size (Self.Object)));
   end To_Universal_String;

   -------------
   -- To_UTF8 --
   -------------

   function To_UTF8 (Self : Q_String'Class) return String is
      Aux : Interfaces.C.Strings.chars_ptr := QString_toUtf8 (Self.Object);

   begin
      return Result : constant String := Interfaces.C.Strings.Value (Aux) do
         Interfaces.C.Strings.Free (Aux);
      end return;
   end To_UTF8;

end Q_Strings;
