private with Ada.Finalization;

with League.Strings;
private with League.String_Vectors;

package Ada_Side.Units is

   type Abstract_Ada_Unit is abstract tagged limited private;

   procedure Put
    (Self : in out Abstract_Ada_Unit'Class;
     Item : League.Strings.Universal_String);

   procedure Put_Line
    (Self : in out Abstract_Ada_Unit'Class;
     Item : League.Strings.Universal_String);

   procedure New_Line (Self : in out Abstract_Ada_Unit'Class);

   procedure Set_Package_Name
    (Self : in out Abstract_Ada_Unit'Class;
     Name : League.Strings.Universal_String);
   --  Sets name of the generated package.

   procedure Save
    (Self      : in out Abstract_Ada_Unit'Class;
     Directory : League.Strings.Universal_String);

   not overriding function Generated_File_Name
    (Self : Abstract_Ada_Unit)
       return League.Strings.Universal_String is abstract;

   type Ada_Spec_Unit is new Abstract_Ada_Unit with private;

   type Ada_Body_Unit is new Abstract_Ada_Unit with private;

private

   type Abstract_Ada_Unit is
     abstract new Ada.Finalization.Limited_Controlled with
   record
      Text    : League.String_Vectors.Universal_String_Vector;
      Flushed : Boolean := True;
      Name    : League.Strings.Universal_String;
   end record;

   overriding procedure Initialize (Self : in out Abstract_Ada_Unit);

   overriding procedure Finalize (Self : in out Abstract_Ada_Unit);

   type Ada_Spec_Unit is new Abstract_Ada_Unit with null record;

   overriding function Generated_File_Name
    (Self : Ada_Spec_Unit) return League.Strings.Universal_String;

   type Ada_Body_Unit is new Abstract_Ada_Unit with null record;

   overriding function Generated_File_Name
    (Self : Ada_Body_Unit) return League.Strings.Universal_String;

end Ada_Side.Units;
