private with Ada.Containers.Ordered_Maps;
private with Ada.Containers.Ordered_Sets;
private with Ada.Finalization;

with League.Strings;
with League.String_Vectors;

package Ada_Side.Units is

   type Abstract_Unit is abstract tagged limited private;

   procedure Put
    (Self : in out Abstract_Unit'Class;
     Item : League.Strings.Universal_String);

   procedure Put_Line
    (Self : in out Abstract_Unit'Class;
     Item : League.Strings.Universal_String);

   procedure New_Line (Self : in out Abstract_Unit'Class);

   procedure Put_Lines
    (Self  : in out Abstract_Unit'Class;
     Lines : League.String_Vectors.Universal_String_Vector);

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

   procedure Add_With_Clause
    (Self : in out Abstract_Ada_Unit'Class;
     Name : League.Strings.Universal_String);

   procedure Add_Limited_With_Clause
    (Self : in out Abstract_Ada_Unit'Class;
     Name : League.Strings.Universal_String);

   procedure Add_Use_Type_Clause
    (Self : in out Abstract_Ada_Unit'Class;
     Name : League.Strings.Universal_String);

   type Ada_Spec_Unit is new Abstract_Ada_Unit with private;

   procedure Add_Private_With_Clause
    (Self : in out Abstract_Ada_Unit'Class;
     Name : League.Strings.Universal_String);

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

   not overriding function Get_Context
    (Self : Abstract_Unit)
       return League.String_Vectors.Universal_String_Vector;

   overriding procedure Initialize (Self : in out Abstract_Unit);

   overriding procedure Finalize (Self : in out Abstract_Unit);

   -----------------
   -- Ada_Context --
   -----------------

   type Context_Record;
   type Context_Record_Access is access all Context_Record;

   package Context_Maps is
     new Ada.Containers.Ordered_Maps
          (League.Strings.Universal_String,
           Context_Record_Access,
           League.Strings."<");

   type Context_Record is record
      Name       : League.Strings.Universal_String;
      Is_Limited : Boolean;
      Is_Private : Boolean;
   end record;

   type Ada_Context is tagged limited record
      Records : Context_Maps.Map;
   end record;

   function Generate_Unit_Context_Clauses
    (Self    : Ada_Context;
     Is_Body : Boolean) return League.String_Vectors.Universal_String_Vector;

   package Universal_String_Sets is
     new Ada.Containers.Ordered_Sets
          (League.Strings.Universal_String,
           League.Strings."<",
           League.Strings."=");

   -----------------------
   -- Abstract_Ada_Unit --
   -----------------------

   type Abstract_Ada_Unit is abstract new Abstract_Unit with record
      Name     : League.Strings.Universal_String;
      Context  : Ada_Context;
      Use_Type : Universal_String_Sets.Set;
   end record;

   -------------------
   -- Ada_Spec_Unit --
   -------------------

   type Ada_Spec_Unit is new Abstract_Ada_Unit with null record;

   overriding function Generated_File_Name
    (Self : Ada_Spec_Unit) return League.Strings.Universal_String;

   overriding function Get_Context
    (Self : Ada_Spec_Unit)
       return League.String_Vectors.Universal_String_Vector;

   -------------------
   -- Ada_Body_Unit --
   -------------------

   type Ada_Body_Unit is new Abstract_Ada_Unit with null record;

   overriding function Generated_File_Name
    (Self : Ada_Body_Unit) return League.Strings.Universal_String;

   overriding function Get_Context
    (Self : Ada_Body_Unit)
       return League.String_Vectors.Universal_String_Vector;

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
