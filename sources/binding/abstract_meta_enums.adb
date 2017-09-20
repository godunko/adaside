

package body Abstract_Meta_Enums is

   function cast_AbstractMetaEnum_AbstractMetaAttributes
    (This : AbstractMetaEnum_Access)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access
         with Import     => True,
              Convention => C,
              Link_Name  =>
               "dynamic_cast__AbstractMetaEnum__AbstractMetaAttributes";

   procedure AbstractMetaEnum_fullName
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaEnum_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaEnum_fullName";

   procedure AbstractMetaEnum_name
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaEnum_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaEnum_name";

   ---------------
   -- Full_Name --
   ---------------

   function Full_Name
    (Self : Abstract_Meta_Enum'Class) return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         AbstractMetaEnum_fullName
          (Q_Strings.Internals.Internal (Result), Self.Object);
      end return;
   end Full_Name;

   --------------
   -- Internal --
   --------------

   overriding function Internal
    (Self : Abstract_Meta_Enum)
       return Abstract_Meta_Attributes.AbstractMetaAttributes_Access is
   begin
      return cast_AbstractMetaEnum_AbstractMetaAttributes (Self.Object);
   end Internal;

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      ----------
      -- Wrap --
      ----------

      function Wrap
       (Object : AbstractMetaEnum_Access) return Abstract_Meta_Enum is
      begin
         return (Object => Object);
      end Wrap;

   end Internals;

   ----------
   -- Name --
   ----------

   function Name (Self : Abstract_Meta_Enum'Class)
     return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         AbstractMetaEnum_name
          (Q_Strings.Internals.Internal (Result), Self.Object);
      end return;
   end Name;

end Abstract_Meta_Enums;
