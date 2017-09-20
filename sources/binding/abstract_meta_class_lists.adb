
package body Abstract_Meta_Class_Lists is

   procedure AbstractMetaClassList_adjust
    (This : in out Internals.AbstractMetaClassList_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaClassList__adjust";

   procedure AbstractMetaClassList_finalize
    (This : in out Internals.AbstractMetaClassList_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaClassList__finalize";

   function AbstractMetaClassList_size
    (This : Internals.AbstractMetaClassList_Access) return Interfaces.C.int
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaClassList_size";

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Abstract_Meta_Class_List) is
   begin
      AbstractMetaClassList_adjust (Self.Object);
   end Adjust;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Abstract_Meta_Class_List) is
   begin
      AbstractMetaClassList_finalize (Self.Object);
   end Finalize;

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      --------------
      -- Internal --
      --------------

      function Internal
       (Item : Abstract_Meta_Class_List'Class)
          return AbstractMetaClassList_Access is
      begin
          return Item.Object;
      end Internal;

   end Internals;

   ----------
   -- Size --
   ----------

   function Size (Self : Abstract_Meta_Class_List'Class) return Interfaces.C.int is
   begin
      return AbstractMetaClassList_size (Self.Object);
   end Size;

end Abstract_Meta_Class_Lists;
