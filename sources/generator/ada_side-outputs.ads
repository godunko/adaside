with League.Strings;
private with League.Pretty_Printers;

package Ada_Side.Outputs is

   type Node is abstract tagged private;
   type Node_Access is access constant Node'Class;
   type Node_Access_Array is array (Positive range <>) of not null Node_Access;

   type Factory is tagged private;

   not overriding function To_Text
     (Self : access Factory;
      Unit : not null Node_Access) return League.Strings.Universal_String;

   not overriding function New_Compilation_Unit
     (Self    : access Factory;
      Root    : not null Node_Access;
      Clauses : Node_Access := null;
      License : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String) return not null Node_Access;

   not overriding function New_List
     (Self : access Factory;
      Head : not null Node_Access;
      Tail : not null Node_Access) return not null Node_Access;

   not overriding function New_List
     (Self : access Factory;
      List : Node_Access_Array) return not null Node_Access;

   not overriding function New_Name
     (Self : access Factory;
      Name : League.Strings.Universal_String) return not null Node_Access;
   --  Identifier, character literal ('X'), operator ("<")

   not overriding function New_Literal
     (Self  : access Factory;
      Value : Natural;
      Base  : Positive := 10) return not null Node_Access;

   not overriding function New_String_Literal
     (Self : access Factory;
      Text : League.Strings.Universal_String) return not null Node_Access;

   not overriding function New_Type
     (Self          : access Factory;
      Name          : not null Node_Access;
      Discriminants : Node_Access := null;
      Definition    : Node_Access := null;
      Aspects       : Node_Access := null;
      Comment       : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String) return not null Node_Access;

   not overriding function New_Subtype
     (Self          : access Factory;
      Name          : not null Node_Access;
      Definition    : not null Node_Access;
      Constrain     : Node_Access := null;
      Comment       : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String) return not null Node_Access;

   not overriding function New_Selected_Name
     (Self     : access Factory;
      Prefix   : not null Node_Access;
      Selector : not null Node_Access) return not null Node_Access;

   not overriding function New_Selected_Name
     (Self : access Factory;
      Name : League.Strings.Universal_String) return not null Node_Access;

   not overriding function New_Package
     (Self         : access Factory;
      Name         : not null Node_Access;
      Public_Part  : Node_Access := null;
      Private_Part : Node_Access := null;
      Comment      : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String) return not null Node_Access;

   not overriding function New_Package_Body
     (Self : access Factory;
      Name : not null Node_Access;
      List : Node_Access := null) return not null Node_Access;

   not overriding function New_Pragma
     (Self      : access Factory;
      Name      : not null Node_Access;
      Arguments : Node_Access := null;
      Comment   : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String) return not null Node_Access;

   not overriding function New_Variable
     (Self            : access Factory;
      Name            : not null Node_Access;
      Type_Definition : Node_Access := null;
      Initialization  : Node_Access := null;
      Is_Constant     : Boolean := False;
      Is_Aliased      : Boolean := False;
      Aspects         : Node_Access := null;
      Comment         : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String) return not null Node_Access;

   not overriding function New_With
     (Self       : access Factory;
      Name       : not null Node_Access;
      Is_Limited : Boolean := False;
      Is_Private : Boolean := False) return not null Node_Access;

   not overriding function New_Use
     (Self       : access Factory;
      Name       : not null Node_Access;
      Use_Type   : Boolean := False) return not null Node_Access;

   not overriding function New_Record
     (Self       : access Factory;
      Parent     : Node_Access := null;
      Components : Node_Access := null) return not null Node_Access;

   not overriding function New_Private_Record
     (Self      : access Factory;
      Is_Tagged : Boolean := False) return not null Node_Access;

   not overriding function New_Apply
     (Self      : access Factory;
      Prefix    : not null Node_Access;
      Arguments : not null Node_Access) return not null Node_Access;
   --  This node represent construction in form 'prefix (arguments)'
   --  This includes function_call, indexed_component, slice,
   --  subtype_indication, etc

   not overriding function New_Access
     (Self   : access Factory;
      Is_All : Boolean;
      Target : not null Node_Access) return not null Node_Access;

   not overriding function New_Aspect
     (Self  : access Factory;
      Name  : not null Node_Access;
      Value : Node_Access := null) return not null Node_Access;

   not overriding function New_Infix
     (Self     : access Factory;
      Operator : League.Strings.Universal_String;
      Left     : not null Node_Access) return not null Node_Access;

   not overriding function New_Subprogram_Declaration
     (Self          : access Factory;
      Specification : not null Node_Access;
      Aspects       : Node_Access := null;
      Comment       : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String) return not null Node_Access;

   not overriding function New_Subprogram_Specification
     (Self          : access Factory;
      Is_Overriding : Boolean := False;
      Name          : Node_Access := null;
      Parameters    : Node_Access := null;
      Result        : Node_Access := null) return not null Node_Access;

   not overriding function New_Parameter
     (Self            : access Factory;
      Name            : not null Node_Access;
      Type_Definition : not null Node_Access;
      Initialization  : Node_Access := null;
      Is_In           : Boolean := False;
      Is_Out          : Boolean := False;
      Is_Aliased      : Boolean := False;
      Comment         : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String) return not null Node_Access;

   not overriding function New_Subprogram_Body
     (Self          : access Factory;
      Specification : not null Node_Access;
      Declarations  : Node_Access := null;
      Statements    : Node_Access := null;
      Exceptions    : Node_Access := null) return not null Node_Access;

   not overriding function New_Statement
     (Self       : access Factory;
      Expression : Node_Access := null) return not null Node_Access;

   not overriding function New_Assignment
     (Self  : access Factory;
      Left  : not null Node_Access;
      Right : not null Node_Access) return not null Node_Access;

   not overriding function New_If
     (Self       : access Factory;
      Condition  : not null Node_Access;
      Then_Path  : not null Node_Access;
      Elsif_List : Node_Access := null;
      Else_Path  : Node_Access := null) return not null Node_Access;

   not overriding function New_Elsif
     (Self       : access Factory;
      Condition  : not null Node_Access;
      List       : not null Node_Access) return not null Node_Access;

private
   type Node is abstract tagged null record;

   not overriding function Document
    (Self    : Node;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   not overriding function Max_Pad (Self : Node) return Natural is (0);
   --  Return maximum lengh of name in Node

   not overriding function Join
    (Self    : Node;
     List    : Node_Access_Array;
     Pad     : Natural;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document;
   --  Join documents of several nodes in a list

   type Expression is abstract new Node with null record;

   overriding function Join
    (Self    : Expression;
     List    : Node_Access_Array;
     Pad     : Natural;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document;

   type Factory is tagged null record;

   function Print_Aspect
    (Aspect  : Node_Access;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document;

end Ada_Side.Outputs;
