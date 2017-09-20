
package Abstract_Meta_Attributes is

   type AbstractMetaAttributes is null record with Convention => C;
   type AbstractMetaAttributes_Access is access all AbstractMetaAttributes;

   type Abstract_Meta_Attributes is abstract tagged null record;

   not overriding function Internal
    (Self : Abstract_Meta_Attributes)
       return AbstractMetaAttributes_Access is abstract;

end Abstract_Meta_Attributes;
