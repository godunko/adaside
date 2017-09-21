with Ada_Side.Outputs.Names;
with Ada_Side.Outputs.Packages;
with Ada_Side.Outputs.Units;

package body Ada_Side.Outputs is
   pragma Warnings (Off);

   --------------
   -- Document --
   --------------

   not overriding function Document
    (Self    : Node;
     Printer : not null access League.Pretty_Printers.Printer'Class)
     return League.Pretty_Printers.Document is
   begin
      raise Program_Error;
      return Printer.New_Document;
   end Document;

   --------------------------
   -- New_Compilation_Unit --
   --------------------------

   not overriding function New_Compilation_Unit
     (Self    : access Factory;
      Root    : not null Node_Access;
      Clauses : Node_Access := null;
      License : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
      return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Units.New_Compilation_Unit
                             (Root, Clauses, License));
   end New_Compilation_Unit;

   --------------
   -- New_List --
   --------------

   not overriding function New_List
     (Self : access Factory;
      Head : Node_Access := null;
      Tail : Node_Access := null)
      return not null Node_Access
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "New_List unimplemented");
      return raise Program_Error with "Unimplemented function New_List";
   end New_List;

   -----------------
   -- New_Literal --
   -----------------

   not overriding function New_Literal
     (Self : access Factory;
      Name : Natural;
      Base : Positive := 10)
      return not null Node_Access
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "New_Literal unimplemented");
      return raise Program_Error with "Unimplemented function New_Literal";
   end New_Literal;

   --------------
   -- New_Name --
   --------------

   not overriding function New_Name
     (Self : access Factory;
      Name : League.Strings.Universal_String)
      return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Names.New_Name (Name));
   end New_Name;

   -----------------
   -- New_Package --
   -----------------

   not overriding function New_Package
     (Self         : access Factory;
      Name         : not null Node_Access;
      Public_Part  : Node_Access := null;
      Private_Part : Node_Access := null;
      Comment      : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
      return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Packages.New_Package
                             (Name, Public_Part, Private_Part, Comment));
   end New_Package;

   ----------------------
   -- New_Package_Body --
   ----------------------

   not overriding function New_Package_Body
     (Self : access Factory;
      Name : not null Node_Access;
      List : Node_Access)
      return not null Node_Access
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning
        (Standard.True, "New_Package_Body unimplemented");
      return raise Program_Error with
        "Unimplemented function New_Package_Body";
   end New_Package_Body;

   ----------------
   -- New_Pragma --
   ----------------

   not overriding function New_Pragma
     (Self      : access Factory;
      Name      : not null Node_Access;
      Arguments : Node_Access;
      Comment   : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
      return not null Node_Access
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "New_Pragma unimplemented");
      return raise Program_Error with "Unimplemented function New_Pragma";
   end New_Pragma;

   -----------------------
   -- New_Selected_Name --
   -----------------------

   not overriding function New_Selected_Name
     (Self     : access Factory;
      Prefix   : not null Node_Access;
      Selector : not null Node_Access)
      return not null Node_Access
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning
        (Standard.True, "New_Selected_Name unimplemented");
      return raise Program_Error with
        "Unimplemented function New_Selected_Name";
   end New_Selected_Name;

   ------------------------
   -- New_String_Literal --
   ------------------------

   not overriding function New_String_Literal
     (Self : access Factory;
      Name : League.Strings.Universal_String)
      return not null Node_Access
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning
        (Standard.True, "New_String_Literal unimplemented");
      return raise Program_Error with
        "Unimplemented function New_String_Literal";
   end New_String_Literal;

   -----------------
   -- New_Subtype --
   -----------------

   not overriding function New_Subtype
     (Self          : access Factory;
      Name          : not null Node_Access;
      Definition    : not null Node_Access;
      Constrain     : Node_Access := null;
      Comment       : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
      return not null Node_Access
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "New_Subtype unimplemented");
      return raise Program_Error with "Unimplemented function New_Subtype";
   end New_Subtype;

   --------------
   -- New_Type --
   --------------

   not overriding function New_Type
     (Self          : access Factory;
      Name          : not null Node_Access;
      Discriminants : Node_Access := null;
      Definition    : Node_Access;
      Aspects       : Node_Access := null;
      Comment       : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
      return not null Node_Access
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "New_Type unimplemented");
      return raise Program_Error with "Unimplemented function New_Type";
   end New_Type;

   ------------------
   -- New_Variable --
   ------------------

   not overriding function New_Variable
     (Self            : access Factory;
      Name            : not null Node_Access;
      Type_Definition : Node_Access;
      Initialization  : Node_Access;
      Is_Constant     : Boolean := False;
      Is_Aliased      : Boolean := False;
      Comment         : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
      return not null Node_Access
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning
        (Standard.True, "New_Variable unimplemented");
      return raise Program_Error with
        "Unimplemented function New_Variable";
   end New_Variable;

   -------------
   -- To_Text --
   -------------

   not overriding function To_Text
     (Self : access Factory;
      Unit : not null Node_Access)
      return League.Strings.Universal_String
   is
      Printer  : aliased League.Pretty_Printers.Printer;
      Document : League.Pretty_Printers.Document :=
        Unit.Document (Printer'Access);
   begin
      return Printer.Pretty (Width => 79, Input => Document);
   end To_Text;

end Ada_Side.Outputs;
