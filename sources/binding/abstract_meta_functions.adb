with Interfaces.C.Extensions;

package body Abstract_Meta_Functions is

   use type Interfaces.C.Extensions.bool;

   function cast_AbstractMetaFunction_AbstractMetaAttributes
    (This : AbstractMetaFunction_Access)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access
         with Import     => True,
              Convention => C,
              Link_Name  =>
               "dynamic_cast__AbstractMetaFunction__AbstractMetaAttributes";

   function AbstractMetaFunction_isConstructor
    (This : AbstractMetaFunction_Access) return Interfaces.C.Extensions.bool
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_isConstructor";

   procedure AbstractMetaFunction_name
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaFunction_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunction_name";

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

   --------------------
   -- Is_Constructor --
   --------------------

   function Is_Constructor
    (Self : Abstract_Meta_Function'Class) return Boolean is
   begin
      return AbstractMetaFunction_isConstructor (Self.Object) /= 0;
   end Is_Constructor;

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

end Abstract_Meta_Functions;
