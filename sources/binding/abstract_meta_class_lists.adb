
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

   function AbstractMetaClassList_value
    (This  : Internals.AbstractMetaClassList_Access;
     Index : Interfaces.C.int)
       return Abstract_Meta_Classes.AbstractMetaClass_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaClassList_value";

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

   -----------
   -- Value --
   -----------

   function Value
    (Self  : Abstract_Meta_Class_List'Class;
     Index : Interfaces.C.int) return Abstract_Meta_Classes.Abstract_Meta_Class is
   begin
      return
        Abstract_Meta_Classes.Internals.Wrap
         (AbstractMetaClassList_value (Self.Object, Index));
   end Value;

end Abstract_Meta_Class_Lists;
