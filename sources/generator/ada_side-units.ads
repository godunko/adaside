private with Ada.Finalization;

with League.Strings;
private with League.String_Vectors;

package Ada_Side.Units is

   type Ada_Spec_Unit is tagged limited private;

   procedure Put
    (Self : in out Ada_Spec_Unit; Item : League.Strings.Universal_String);

   procedure Put_Line
    (Self : in out Ada_Spec_Unit; Item : League.Strings.Universal_String);

private

   type Ada_Spec_Unit is new Ada.Finalization.Limited_Controlled with record
      Text    : League.String_Vectors.Universal_String_Vector;
      Flushed : Boolean := True;
   end record;

   overriding procedure Initialize (Self : in out Ada_Spec_Unit);

   overriding procedure Finalize (Self : in out Ada_Spec_Unit);

end Ada_Side.Units;
