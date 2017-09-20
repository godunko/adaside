with Q_Strings;

package Abstract_Meta_Variables is

   type AbstractMetaVariable is null record with Convention => C;
   type AbstractMetaVariable_Access is access all AbstractMetaVariable;

   type Abstract_Meta_Variable is interface;

   not overriding function Internal
    (Self : Abstract_Meta_Variable)
       return AbstractMetaVariable_Access is abstract;

   not overriding function Name (Self : Abstract_Meta_Variable)
     return Q_Strings.Q_String is abstract;

end Abstract_Meta_Variables;
