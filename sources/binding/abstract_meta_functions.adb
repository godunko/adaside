with Interfaces.C.Extensions;

with Abstract_Meta_Classes;

package body Abstract_Meta_Functions is

   use type Interfaces.C.Extensions.bool;

   function cast_AbstractMetaFunction_AbstractMetaAttributes
    (This : AbstractMetaFunction_Access)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access
         with Import     => True,
              Convention => C,
              Link_Name  =>
               "dynamic_cast__AbstractMetaFunction__AbstractMetaAttributes";

   procedure AbstractMetaFunction_arguments
    (Result : not null
       Abstract_Meta_Argument_Lists.Internals.AbstractMetaArgumentList_Access;
     Self   : not null AbstractMetaFunction_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_arguments";

   function AbstractMetaFunction_declaringClass
    (Self : not null AbstractMetaFunction_Access)
       return Abstract_Meta_Classes.AbstractMetaClass_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaFunction_declaringClass";

   function AbstractMetaFunction_functionType
    (Self : not null AbstractMetaFunction_Access)
       return Function_Types
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaFunction_functionType";

   function AbstractMetaFunction_implementingClass
    (Self : not null AbstractMetaFunction_Access)
       return Abstract_Meta_Classes.AbstractMetaClass_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaFunction_implementingClass";

   function AbstractMetaFunction_isArithmeticOperator
    (This : AbstractMetaFunction_Access) return Interfaces.C.Extensions.bool
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_isArithmeticOperator";

   function AbstractMetaFunction_isBitwiseOperator
    (This : AbstractMetaFunction_Access) return Interfaces.C.Extensions.bool
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_isBitwiseOperator";

   function AbstractMetaFunction_isComparisonOperator
    (This : AbstractMetaFunction_Access) return Interfaces.C.Extensions.bool
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_isComparisonOperator";

   function AbstractMetaFunction_isConstant
    (This : AbstractMetaFunction_Access) return Interfaces.C.Extensions.bool
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_isConstant";

   function AbstractMetaFunction_isConstructor
    (This : AbstractMetaFunction_Access) return Interfaces.C.Extensions.bool
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_isConstructor";

   function AbstractMetaFunction_isInGlobalScope
    (This : AbstractMetaFunction_Access) return Interfaces.C.Extensions.bool
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_isInGlobalScope";

   function AbstractMetaFunction_isReverseOperator
    (This : AbstractMetaFunction_Access) return Interfaces.C.Extensions.bool
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_isReverseOperator";

   procedure AbstractMetaFunction_minimalSignature
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaFunction_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_minimalSignature";

   procedure AbstractMetaFunction_name
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaFunction_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_name";

   function AbstractMetaFunction_ownerClass
    (Self : not null AbstractMetaFunction_Access)
       return Abstract_Meta_Classes.AbstractMetaClass_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaFunction_ownerClass";

   procedure AbstractMetaFunction_signature
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaFunction_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_signature";

   function AbstractMetaFunction_type
    (This : AbstractMetaFunction_Access)
       return Abstract_Meta_Types.AbstractMetaType_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaFunction_type";

   ---------------
   -- Arguments --
   ---------------

   function Arguments
    (Self : Abstract_Meta_Function'Class)
       return Abstract_Meta_Argument_Lists.Abstract_Meta_Argument_List is
   begin
      return Result :
               Abstract_Meta_Argument_Lists.Abstract_Meta_Argument_List
      do
         AbstractMetaFunction_arguments
          (Abstract_Meta_Argument_Lists.Internals.Internal (Result),
           Self.Object);
      end return;
   end Arguments;

   ---------------------
   -- Declaring_Class --
   ---------------------

   function Declaring_Class
    (Self : Abstract_Meta_Function'Class)
       return Abstract_Meta_Classes.Abstract_Meta_Class is
   begin
      return
        Abstract_Meta_Classes.Internals.Wrap
         (AbstractMetaFunction_declaringClass (Self.Object));
   end Declaring_Class;

   -------------------
   -- Function_Type --
   -------------------

   function Function_Type
    (Self : Abstract_Meta_Function'Class) return Function_Types is
   begin
      return AbstractMetaFunction_functionType (Self.Object);
   end Function_Type;

   --------------
   -- Get_Type --
   --------------

   function Get_Type (Self : Abstract_Meta_Function'Class)
     return Abstract_Meta_Types.Abstract_Meta_Type is
   begin
      return
        Abstract_Meta_Types.Internals.Wrap
         (AbstractMetaFunction_type (Self.Object));
   end Get_Type;

   ------------------------
   -- Implementing_Class --
   ------------------------

   function Implementing_Class
    (Self : Abstract_Meta_Function'Class)
       return Abstract_Meta_Classes.Abstract_Meta_Class is
   begin
      return
        Abstract_Meta_Classes.Internals.Wrap
         (AbstractMetaFunction_implementingClass (Self.Object));
   end Implementing_Class;

   --------------
   -- Internal --
   --------------

   overriding function Internal
    (Self : Abstract_Meta_Function)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access is
   begin
      return cast_AbstractMetaFunction_AbstractMetaAttributes (Self.Object);
   end Internal;

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      ----------
      -- Wrap --
      ----------

      function Wrap
       (Object : AbstractMetaFunction_Access) return Abstract_Meta_Function is
      begin
         return (Object => Object);
      end Wrap;

   end Internals;

   ----------------------------
   -- Is_Arithmetic_Operator --
   ----------------------------

   function Is_Arithmetic_Operator
    (Self : Abstract_Meta_Function'Class) return Boolean is
   begin
      return AbstractMetaFunction_isArithmeticOperator (Self.Object) /= 0;
   end Is_Arithmetic_Operator;

   -------------------------
   -- Is_Bitwise_Operator --
   -------------------------

   function Is_Bitwise_Operator
    (Self : Abstract_Meta_Function'Class) return Boolean is
   begin
      return AbstractMetaFunction_isBitwiseOperator (Self.Object) /= 0;
   end Is_Bitwise_Operator;

   ----------------------------
   -- Is_Comparison_Operator --
   ----------------------------

   function Is_Comparison_Operator
    (Self : Abstract_Meta_Function'Class) return Boolean is
   begin
      return AbstractMetaFunction_isComparisonOperator (Self.Object) /= 0;
   end Is_Comparison_Operator;

   -----------------
   -- Is_Constant --
   -----------------

   function Is_Constant
    (Self : Abstract_Meta_Function'Class) return Boolean is
   begin
      return AbstractMetaFunction_isConstant (Self.Object) /= 0;
   end Is_Constant;

   --------------------
   -- Is_Constructor --
   --------------------

   function Is_Constructor
    (Self : Abstract_Meta_Function'Class) return Boolean is
   begin
      return AbstractMetaFunction_isConstructor (Self.Object) /= 0;
   end Is_Constructor;

   -------------------------
   -- Is_Copy_Constructor --
   -------------------------

   function Is_Copy_Constructor
    (Self : Abstract_Meta_Function'Class) return Boolean is
   begin
      return Self.Function_Type = Copy_Constructor_Function;
   end Is_Copy_Constructor;

   ------------------------
   -- Is_In_Global_Scope --
   ------------------------

   function Is_In_Global_Scope
    (Self : Abstract_Meta_Function'Class) return Boolean is
   begin
      return AbstractMetaFunction_isInGlobalScope (Self.Object) /= 0;
   end Is_In_Global_Scope;

   -------------------------
   -- Is_Reverse_Operator --
   -------------------------

   function Is_Reverse_Operator
    (Self : Abstract_Meta_Function'Class) return Boolean is
   begin
      return AbstractMetaFunction_isReverseOperator (Self.Object) /= 0;
   end Is_Reverse_Operator;

   -----------------------
   -- Minimal_Signature --
   -----------------------

   function Minimal_Signature
    (Self : Abstract_Meta_Function'Class) return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         AbstractMetaFunction_minimalSignature
          (Q_Strings.Internals.Internal (Result), Self.Object);
      end return;
   end Minimal_Signature;

   -----------------------
   -- Minimal_Signature --
   -----------------------

   function Minimal_Signature
    (Self : Abstract_Meta_Function'Class)
       return League.Strings.Universal_String is
   begin
      return Self.Minimal_Signature.To_Universal_String;
   end Minimal_Signature;

   ----------
   -- Name --
   ----------

   function Name (Self : Abstract_Meta_Function'Class)
     return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         AbstractMetaFunction_name
          (Q_Strings.Internals.Internal (Result), Self.Object);
      end return;
   end Name;

   ----------
   -- Name --
   ----------

   function Name
    (Self : Abstract_Meta_Function'Class)
       return League.Strings.Universal_String is
   begin
      return Self.Name.To_Universal_String;
   end Name;

   -----------------
   -- Owner_Class --
   -----------------

   function Owner_Class
    (Self : Abstract_Meta_Function'Class)
       return Abstract_Meta_Classes.Abstract_Meta_Class is
   begin
      return
        Abstract_Meta_Classes.Internals.Wrap
         (AbstractMetaFunction_ownerClass (Self.Object));
   end Owner_Class;

   ---------------
   -- Signature --
   ---------------

   function Signature
    (Self : Abstract_Meta_Function'Class) return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         AbstractMetaFunction_signature
          (Q_Strings.Internals.Internal (Result), Self.Object);
      end return;
   end Signature;

   ---------------
   -- Signature --
   ---------------

   function Signature
    (Self : Abstract_Meta_Function'Class)
       return League.Strings.Universal_String is
   begin
      return Self.Signature.To_Universal_String;
   end Signature;

end Abstract_Meta_Functions;
