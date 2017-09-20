
package body Abstract_Meta_Field_Lists is

   procedure AbstractMetaFieldList_adjust
    (This : in out Internals.AbstractMetaFieldList_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFieldList__adjust";

   procedure AbstractMetaFieldList_finalize
    (This : in out Internals.AbstractMetaFieldList_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFieldList__finalize";

   function AbstractMetaFieldList_size
    (This : Internals.AbstractMetaFieldList_Access) return Interfaces.C.int
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFieldList_size";

   function AbstractMetaFieldList_value
    (This  : Internals.AbstractMetaFieldList_Access;
     Index : Interfaces.C.int)
       return Abstract_Meta_Fields.AbstractMetaField_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaFieldList_value";

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Abstract_Meta_Field_List) is
   begin
      AbstractMetaFieldList_adjust (Self.Object);
   end Adjust;

   -------------
   -- Cursors --
   -------------

   package body Cursors is

      function Each (Self : aliased in out Abstract_Meta_Field_List'Class)
        return Cursors.Forward_Iterator is
      begin
         return (List => Self'Access);
      end Each;

      overriding function First
        (Self : Forward_Iterator) return Interfaces.C.int
      is
         use type Interfaces.C.int;
      begin
         return Self.Next (-1);
      end First;

      function Has_Element (Self : Interfaces.C.int) return Boolean is
         use type Interfaces.C.int;
      begin
         return Self >= 0;
      end Has_Element;

      overriding function Next
        (Self     : Forward_Iterator;
         Position : Interfaces.C.int) return Interfaces.C.int
      is
         use type Interfaces.C.int;
         Result : Interfaces.C.int := Position + 1;
      begin
         if Result >= Self.List.Size then
            Result := -1;
         end if;

         return Result;
      end Next;

   end Cursors;

   ----------
   -- Each --
   ----------

   function Each (Self : aliased in out Abstract_Meta_Field_List'Class)
     return Cursors.Forward_Iterator renames Cursors.Each;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Abstract_Meta_Field_List) is
   begin
      AbstractMetaFieldList_finalize (Self.Object);
   end Finalize;

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      --------------
      -- Internal --
      --------------

      function Internal
       (Item : Abstract_Meta_Field_List'Class)
          return AbstractMetaFieldList_Access is
      begin
         return Item.Object;
      end Internal;

   end Internals;

   ----------
   -- Size --
   ----------

   function Size (Self : Abstract_Meta_Field_List'Class)
     return Interfaces.C.int is
   begin
      return AbstractMetaFieldList_size (Self.Object);
   end Size;

   -----------
   -- Value --
   -----------

   function Value
    (Self  : Abstract_Meta_Field_List'Class;
     Index : Interfaces.C.int)
      return Abstract_Meta_Fields.Abstract_Meta_Field is
   begin
      return
        Abstract_Meta_Fields.Internals.Wrap
         (AbstractMetaFieldList_value (Self.Object, Index));
   end Value;

end Abstract_Meta_Field_Lists;
