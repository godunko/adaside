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
     (Self : access Factory;
      Name : Natural;
      Base : Positive := 10) return not null Node_Access;

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

   not overriding function New_Record
     (Self : access Factory;
      List : Node_Access := null) return not null Node_Access;

   not overriding function New_Access
     (Self   : access Factory;
      Is_All : Boolean;
      Target : not null Node_Access) return not null Node_Access;

   not overriding function New_Aspect
     (Self  : access Factory;
      Name  : not null Node_Access;
      Value : Node_Access := null) return not null Node_Access;

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

   type Factory is tagged null record;

   function Print_Aspect
    (Aspect  : Node_Access;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document;

end Ada_Side.Outputs;
