private package Ada_Side.Outputs.Declarations is

   type Package_Body is new Node with private;

   function New_Package_Body
     (Name : not null Node_Access;
      List : Node_Access) return Node'Class;

   type Package_Spec is new Node with private;

   function New_Package
     (Name         : not null Node_Access;
      Public_Part  : Node_Access;
      Private_Part : Node_Access;
      Comment      : League.Strings.Universal_String) return Node'Class;

   type Parameter is new Node with private;

   function New_Parameter
     (Name            : not null Node_Access;
      Type_Definition : Node_Access;
      Initialization  : Node_Access;
      Is_In           : Boolean;
      Is_Out          : Boolean;
      Is_Aliased      : Boolean;
      Comment         : League.Strings.Universal_String) return Node'Class;

   type Subprogram_Body is new Node with private;

   function New_Subprogram_Body
     (Specification : not null Node_Access;
      Declarations  : Node_Access;
      Statements    : Node_Access;
      Exceptions    : Node_Access) return Node'Class;

   type Subprogram_Declaration is new Node with private;

   function New_Subprogram_Declaration
     (Specification : not null Node_Access;
      Aspects       : Node_Access := null;
      Comment       : League.Strings.Universal_String) return Node'Class;

   type Type_Declaration is new Node with private;

   function New_Type
     (Name          : not null Node_Access;
      Discriminants : Node_Access;
      Definition    : Node_Access;
      Aspects       : Node_Access;
      Comment       : League.Strings.Universal_String) return Node'Class;

   type Variable is new Node with private;

   function New_Variable
     (Name            : not null Node_Access;
      Type_Definition : Node_Access;
      Initialization  : Node_Access;
      Is_Constant     : Boolean;
      Is_Aliased      : Boolean;
      Aspects         : Node_Access;
      Comment         : League.Strings.Universal_String) return Node'Class;

private

   type Package_Body is new Node with record
      Name : not null Node_Access;
      List : Node_Access;
   end record;

   overriding function Document
    (Self    : Package_Body;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Package_Spec is new Node with record
      Name         : not null Node_Access;
      Public_Part  : Node_Access;
      Private_Part : Node_Access;
      Comment      : League.Strings.Universal_String;
   end record;

   overriding function Document
    (Self    : Package_Spec;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Parameter is new Node with record
      Name            : not null Node_Access;
      Type_Definition : not null Node_Access;
      Initialization  : Node_Access;
      Is_In           : Boolean;
      Is_Out          : Boolean;
      Is_Aliased      : Boolean;
      Comment         : League.Strings.Universal_String;
   end record;

   overriding function Document
    (Self    : Parameter;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   overriding function Join
    (Self    : Parameter;
     List    : Node_Access_Array;
     Pad     : Natural;
     Printer : not null access League.Pretty_Printers.Printer'Class)
      return League.Pretty_Printers.Document;

   overriding function Max_Pad (Self : Parameter) return Natural is
     (Self.Name.Max_Pad);

   type Subprogram_Body is new Node with record
      Specification : not null Node_Access;
      Declarations  : Node_Access;
      Statements    : Node_Access;
      Exceptions    : Node_Access;
   end record;

   overriding function Document
    (Self    : Subprogram_Body;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Subprogram_Declaration is new Node with record
      Specification : not null Node_Access;
      Aspects       : Node_Access;
      Comment       : League.Strings.Universal_String;
   end record;

   overriding function Document
    (Self    : Subprogram_Declaration;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Type_Declaration is new Node with record
      Name          : not null Node_Access;
      Discriminants : Node_Access;
      Definition    : Node_Access;
      Aspects       : Node_Access;
      Comment       : League.Strings.Universal_String;
   end record;

   overriding function Document
    (Self    : Type_Declaration;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

   type Variable is new Node with record
      Name            : not null Node_Access;
      Type_Definition : Node_Access;
      Initialization  : Node_Access;
      Is_Constant     : Boolean;
      Is_Aliased      : Boolean;
      Aspects         : Node_Access;
      Comment         : League.Strings.Universal_String;
   end record;

   overriding function Max_Pad (Self : Variable) return Natural is
     (Self.Name.Max_Pad);

   overriding function Document
    (Self    : Variable;
     Printer : not null access League.Pretty_Printers.Printer'Class;
     Pad     : Natural)
      return League.Pretty_Printers.Document;

end Ada_Side.Outputs.Declarations;
