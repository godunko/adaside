with Ada_Side.Outputs.Definitions;
with Ada_Side.Outputs.Clauses;
with Ada_Side.Outputs.Declarations;
with Ada_Side.Outputs.Expressions;
with Ada_Side.Outputs.Joins;
with Ada_Side.Outputs.Statements;
with Ada_Side.Outputs.Units;

package body Ada_Side.Outputs is

   --------------
   -- Document --
   --------------

   not overriding function Document
    (Self    : Node;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
     return League.Pretty_Printers.Document is
   begin
      raise Program_Error;
      return Printer.New_Document;
   end Document;

   ----------
   -- Join --
   ----------

   overriding function Join
    (Self    : Declaration;
     List    : Node_Access_Array;
     Pad     : Natural;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.Append (Node'Class (Self).Document (Printer, Pad));

      for J in List'Range loop
         Result.New_Line;
         Result.Append (List (J).Document (Printer, Pad));
      end loop;

      return Result;
   end Join;

   ----------
   -- Join --
   ----------

   not overriding function Join
    (Self    : Node;
     List    : Node_Access_Array;
     Pad     : Natural;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.Append (Node'Class (Self).Document (Printer, Pad));

      for J in List'Range loop
         Result.Append (List (J).Document (Printer, Pad));
      end loop;

      return Result;
   end Join;

   ----------
   -- Join --
   ----------

   overriding function Join
    (Self    : Expression;
     List    : Node_Access_Array;
     Pad     : Natural;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
   begin
      Result.Append (Node'Class (Self).Document (Printer, Pad));

      for J in List'Range loop
         if List (J).all not in Expressions.Infix then
            Result.Put (",");
            Result.New_Line;
         end if;

         Result.Append (List (J).Document (Printer, Pad));
      end loop;

      Result.Group;
      return Result;
   end Join;

   ----------------
   -- New_Access --
   ----------------

   not overriding function New_Access
     (Self   : access Factory;
      Is_All : Boolean;
      Target : not null Node_Access) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Definitions.New_Access
                             (Is_All => Is_All, Target => Target));
   end New_Access;

   ---------------
   -- New_Apply --
   ---------------

   not overriding function New_Apply
     (Self      : access Factory;
      Prefix    : not null Node_Access;
      Arguments : not null Node_Access) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Expressions.New_Apply
                               (Prefix, Arguments));
   end New_Apply;

   ----------------
   -- New_Aspect --
   ----------------

   not overriding function New_Aspect
     (Self  : access Factory;
      Name  : not null Node_Access;
      Value : Node_Access := null) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Clauses.New_Aspect (Name, Value));
   end New_Aspect;

   --------------------
   -- New_Assignment --
   --------------------

   not overriding function New_Assignment
     (Self  : access Factory;
      Left  : not null Node_Access;
      Right : not null Node_Access) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Statements.New_Assignment (Left, Right));
   end New_Assignment;

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

   -----------------
   -- New_Derived --
   -----------------

   not overriding function New_Derived
     (Self   : access Factory;
      Parent : not null Node_Access) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Definitions.New_Derived (Parent));
   end New_Derived;

   ---------------
   -- New_Elsif --
   ---------------

   not overriding function New_Elsif
     (Self       : access Factory;
      Condition  : not null Node_Access;
      List       : not null Node_Access) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Statements.New_Elsif (Condition, List));
   end New_Elsif;

   ----------------------
   -- New_If_Statement --
   ----------------------

   not overriding function New_If
     (Self       : access Factory;
      Condition  : not null Node_Access;
      Then_Path  : not null Node_Access;
      Elsif_List : Node_Access := null;
      Else_Path  : Node_Access := null) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Statements.New_If
                             (Condition, Then_Path, Elsif_List, Else_Path));
   end New_If;

   ---------------
   -- New_Infix --
   ---------------

   not overriding function New_Infix
     (Self     : access Factory;
      Operator : League.Strings.Universal_String;
      Left     : not null Node_Access) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Expressions.New_Infix (Operator, Left));
   end New_Infix;

   --------------
   -- New_List --
   --------------

   not overriding function New_List
     (Self : access Factory;
      Head : not null Node_Access;
      Tail : not null Node_Access) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Joins.New_Join (Head, Tail));
   end New_List;

   --------------
   -- New_List --
   --------------

   not overriding function New_List
     (Self : access Factory;
      List : Node_Access_Array) return not null Node_Access
   is
      Result : Node_Access := List (List'First);
   begin
      for J in List'First + 1 .. List'Last loop
         Result := Self.New_List (Result, List (J));
      end loop;

      return Result;
   end New_List;

   -----------------
   -- New_Literal --
   -----------------

   not overriding function New_Literal
     (Self  : access Factory;
      Value : Natural;
      Base  : Positive := 10) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Expressions.New_Literal
                               (Value, Base));
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
      return new Node'Class'(Outputs.Expressions.New_Name (Name));
   end New_Name;

   ------------------------
   -- New_Null_Exclusion --
   ------------------------

   not overriding function New_Null_Exclusion
     (Self       : access Factory;
      Definition : not null Node_Access;
      Exclude    : Boolean := True) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Definitions.New_Null_Exclusion
                             (Definition, Exclude));
   end New_Null_Exclusion;

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
      return new Node'Class'(Outputs.Declarations.New_Package
                             (Name, Public_Part, Private_Part, Comment));
   end New_Package;

   ----------------------
   -- New_Package_Body --
   ----------------------

   not overriding function New_Package_Body
     (Self : access Factory;
      Name : not null Node_Access;
      List : Node_Access := null) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Declarations.New_Package_Body
                             (Name, List));
   end New_Package_Body;

   -------------------
   -- New_Parameter --
   -------------------

   not overriding function New_Parameter
     (Self            : access Factory;
      Name            : not null Node_Access;
      Type_Definition : not null Node_Access;
      Initialization  : Node_Access := null;
      Is_In           : Boolean := False;
      Is_Out          : Boolean := False;
      Is_Aliased      : Boolean := False;
      Comment         : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Declarations.New_Parameter
                             (Name, Type_Definition, Initialization,
                               Is_In, Is_Out, Is_Aliased, Comment));
   end New_Parameter;

   ----------------
   -- New_Pragma --
   ----------------

   not overriding function New_Pragma
     (Self      : access Factory;
      Name      : not null Node_Access;
      Arguments : Node_Access := null;
      Comment   : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
      return not null Node_Access
   is
      pragma Unreferenced (Self, Comment);
   begin
      return new Node'Class'(Outputs.Clauses.New_Pragma (Name, Arguments));
   end New_Pragma;

   ------------------------
   -- New_Private_Record --
   ------------------------

   not overriding function New_Private_Record
     (Self      : access Factory;
      Is_Tagged : Boolean := False) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Definitions.New_Private_Record
                               (Is_Tagged));
   end New_Private_Record;

   ----------------
   -- New_Record --
   ----------------

   not overriding function New_Record
     (Self       : access Factory;
      Parent     : Node_Access := null;
      Components : Node_Access := null) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Definitions.New_Record
                               (Parent, Components));
   end New_Record;

   ----------------
   -- New_Return --
   ----------------

   not overriding function New_Return
     (Self       : access Factory;
      Expression : Node_Access := null) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Statements.New_Return (Expression));
   end New_Return;

   -----------------------
   -- New_Selected_Name --
   -----------------------

   not overriding function New_Selected_Name
     (Self     : access Factory;
      Prefix   : not null Node_Access;
      Selector : not null Node_Access)
      return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Expressions.New_Selected_Name
                             (Prefix, Selector));
   end New_Selected_Name;

   not overriding function New_Selected_Name
     (Self : access Factory;
      Name : League.Strings.Universal_String) return not null Node_Access
   is
      List : constant League.String_Vectors.Universal_String_Vector :=
        Name.Split ('.');
      Result : Node_Access := Self.New_Name (List.Element (1));
   begin
      for J in 2 .. List.Length loop
         Result := Self.New_Selected_Name
           (Result, Self.New_Name (List.Element (J)));
      end loop;

      return Result;
   end New_Selected_Name;

   -------------------
   -- New_Statement --
   -------------------

   not overriding function New_Statement
     (Self       : access Factory;
      Expression : Node_Access := null) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Statements.New_Statement (Expression));
   end New_Statement;

   ------------------------
   -- New_String_Literal --
   ------------------------

   not overriding function New_String_Literal
     (Self : access Factory;
      Text : League.Strings.Universal_String)
      return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Expressions.New_String (Text));
   end New_String_Literal;

   -------------------------
   -- New_Subprogram_Body --
   -------------------------

   not overriding function New_Subprogram_Body
     (Self          : access Factory;
      Specification : not null Node_Access;
      Declarations  : Node_Access := null;
      Statements    : Node_Access := null;
      Exceptions    : Node_Access := null) return not null Node_Access is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Declarations.New_Subprogram_Body
                             (Specification,
                              Declarations,
                              Statements,
                              Exceptions));
   end New_Subprogram_Body;

   --------------------------------
   -- New_Subprogram_Declaration --
   --------------------------------

   not overriding function New_Subprogram_Declaration
     (Self          : access Factory;
      Specification : not null Node_Access;
      Aspects       : Node_Access := null;
      Comment       : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Declarations.New_Subprogram_Declaration
                             (Specification, Aspects, Comment));
   end New_Subprogram_Declaration;

   --------------------
   -- New_Subprogram --
   --------------------

   not overriding function New_Subprogram_Specification
     (Self          : access Factory;
      Is_Overriding : Boolean := False;
      Name          : Node_Access := null;
      Parameters    : Node_Access := null;
      Result        : Node_Access := null) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Definitions.New_Subprogram
                             (Is_Overriding,
                              Name,
                              Parameters,
                              Result));
   end New_Subprogram_Specification;

   -----------------
   -- New_Subtype --
   -----------------

   pragma Warnings (Off);
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
   pragma Warnings (On);

   --------------
   -- New_Type --
   --------------

   not overriding function New_Type
     (Self          : access Factory;
      Name          : not null Node_Access;
      Discriminants : Node_Access := null;
      Definition    : Node_Access := null;
      Aspects       : Node_Access := null;
      Comment       : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
      return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Declarations.New_Type
                             (Name,
                              Discriminants,
                              Definition,
                              Aspects,
                              Comment));
   end New_Type;

   -------------
   -- New_Use --
   -------------

   not overriding function New_Use
     (Self       : access Factory;
      Name       : not null Node_Access;
      Use_Type   : Boolean := False) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Clauses.New_Use (Name, Use_Type));
   end New_Use;

   ------------------
   -- New_Variable --
   ------------------

   not overriding function New_Variable
     (Self            : access Factory;
      Name            : not null Node_Access;
      Type_Definition : Node_Access := null;
      Initialization  : Node_Access := null;
      Is_Constant     : Boolean := False;
      Is_Aliased      : Boolean := False;
      Aspects         : Node_Access := null;
      Comment         : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Declarations.New_Variable
                             (Name,
                              Type_Definition,
                              Initialization,
                              Is_Constant,
                              Is_Aliased,
                              Aspects,
                              Comment));
   end New_Variable;

   --------------
   -- New_With --
   --------------

   not overriding function New_With
     (Self : access Factory;
      Name : not null Node_Access;
      Is_Limited : Boolean := False;
      Is_Private : Boolean := False) return not null Node_Access
   is
      pragma Unreferenced (Self);
   begin
      return new Node'Class'(Outputs.Clauses.New_With
                               (Name, Is_Limited, Is_Private));
   end New_With;

   ------------------
   -- Print_Aspect --
   ------------------

   function Print_Aspect
    (Aspect  : Node_Access;
     Printer : not null access League.Pretty_Printers.Printer'Class)
     return League.Pretty_Printers.Document
   is
      Result : League.Pretty_Printers.Document := Printer.New_Document;
      Pad    : constant Natural := 0;
   begin
      if Aspect = null then
         return Result;
      end if;

      Result.New_Line;
      Result.Put ("with ");
      Result.Append (Aspect.Document (Printer, Pad));
      Result.Nest (2);

      if Aspect.all in Clauses.Aspect then
         Result.Group;
      end if;

      return Result;
   end Print_Aspect;

   -------------
   -- To_Text --
   -------------

   not overriding function To_Text
     (Self : access Factory;
      Unit : not null Node_Access)
      return League.String_Vectors.Universal_String_Vector
   is
      pragma Unreferenced (Self);
      Printer  : aliased League.Pretty_Printers.Printer;
      Document : constant League.Pretty_Printers.Document :=
        Unit.Document (Printer'Access, 0);
   begin
      return Printer.Pretty (Width => 79, Input => Document);
   end To_Text;

end Ada_Side.Outputs;
