with Interfaces.C.Extensions;

package body Abstract_Meta_Attributes is

   use type Interfaces.C.Extensions.bool;

   function AbstractMetaAttributes_isStatic
    (Self : not null AbstractMetaAttributes_Access)
       return Interfaces.C.Extensions.bool
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaAttributes_isStatic";

   ---------------
   -- Is_Static --
   ---------------

   function Is_Static (Self : Abstract_Meta_Attributes'Class) return Boolean is
   begin
      return AbstractMetaAttributes_isStatic (Self.Internal) /= 0;
   end Is_Static;

end Abstract_Meta_Attributes;
