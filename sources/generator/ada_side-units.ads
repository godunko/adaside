private with Ada.Finalization;

with League.Strings;
private with League.String_Vectors;

package Ada_Side.Units is

   type Abstract_Unit is abstract tagged limited private;

   procedure Put
    (Self : in out Abstract_Unit'Class;
     Item : League.Strings.Universal_String);

   procedure Put_Line
    (Self : in out Abstract_Unit'Class;
     Item : League.Strings.Universal_String);

   procedure New_Line (Self : in out Abstract_Unit'Class);

   procedure Save
    (Self      : in out Abstract_Unit'Class;
     Directory : League.Strings.Universal_String);

   not overriding function Generated_File_Name
    (Self : Abstract_Unit)
       return League.Strings.Universal_String is abstract;

   type Abstract_Ada_Unit is abstract new Abstract_Unit with private;

   procedure Set_Package_Name
    (Self : in out Abstract_Ada_Unit'Class;
     Name : League.Strings.Universal_String);
   --  Sets name of the generated package.

   type Ada_Spec_Unit is new Abstract_Ada_Unit with private;

   type Ada_Body_Unit is new Abstract_Ada_Unit with private;

   type Abstract_CXX_Unit is abstract new Abstract_Unit with private;

   procedure Set_Class_Name
    (Self : in out Abstract_CXX_Unit'Class;
     Name : League.Strings.Universal_String);
   --  Sets name of the generated class.

   type CXX_H_Unit is new Abstract_CXX_Unit with private;

   type CXX_Cpp_Unit is new Abstract_CXX_Unit with private;

private

   type Abstract_Unit is
     abstract new Ada.Finalization.Limited_Controlled with
   record
      Text    : League.String_Vectors.Universal_String_Vector;
      Flushed : Boolean := True;
   end record;

   overriding procedure Initialize (Self : in out Abstract_Unit);

   overriding procedure Finalize (Self : in out Abstract_Unit);

   -----------------------
   -- Abstract_Ada_Unit --
   -----------------------

   type Abstract_Ada_Unit is abstract new Abstract_Unit with record
      Name : League.Strings.Universal_String;
   end record;

   -------------------
   -- Ada_Spec_Unit --
   -------------------

   type Ada_Spec_Unit is new Abstract_Ada_Unit with null record;

   overriding function Generated_File_Name
    (Self : Ada_Spec_Unit) return League.Strings.Universal_String;

   -------------------
   -- Ada_Body_Unit --
   -------------------

   type Ada_Body_Unit is new Abstract_Ada_Unit with null record;

   overriding function Generated_File_Name
    (Self : Ada_Body_Unit) return League.Strings.Universal_String;

   -----------------------
   -- Abstract_CXX_Unit --
   -----------------------

   type Abstract_CXX_Unit is abstract new Abstract_Unit with record
      Name : League.Strings.Universal_String;
   end record;

   ----------------
   -- CXX_H_Unit --
   ----------------

   type CXX_H_Unit is new Abstract_CXX_Unit with null record;

   overriding function Generated_File_Name
    (Self : CXX_H_Unit) return League.Strings.Universal_String;

   ------------------
   -- CXX_Cpp_Unit --
   ------------------

   type CXX_Cpp_Unit is new Abstract_CXX_Unit with null record;

   overriding function Generated_File_Name
    (Self : CXX_Cpp_Unit) return League.Strings.Universal_String;

end Ada_Side.Units;
