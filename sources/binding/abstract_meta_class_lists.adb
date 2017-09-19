
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

end Abstract_Meta_Class_Lists;
