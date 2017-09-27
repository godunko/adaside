
package body Abstract_Meta_Variables is

   procedure AbstractMetaVariable_name
    (Result : not null Q_Strings.Internals.QString_Access;
     Self   : not null AbstractMetaVariable_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaVariable_name";

   function AbstractMetaVariable_type
    (This : AbstractMetaVariable_Access)
       return Abstract_Meta_Types.AbstractMetaType_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaVariable_type";

   --------------
   -- Get_Type --
   --------------

   function Get_Type (Self : Abstract_Meta_Variable'Class)
     return Abstract_Meta_Types.Abstract_Meta_Type is
   begin
      return
        Abstract_Meta_Types.Internals.Wrap
         (AbstractMetaVariable_type (Self.AbstractMetaVariable_View));
   end Get_Type;

   ----------
   -- Name --
   ----------

   function Name
    (Self : Abstract_Meta_Variable'Class) return Q_Strings.Q_String is
   begin
      return Result : Q_Strings.Q_String do
         AbstractMetaVariable_name
          (Q_Strings.Internals.Internal (Result),
           Self.AbstractMetaVariable_View);
      end return;
   end Name;

end Abstract_Meta_Variables;
