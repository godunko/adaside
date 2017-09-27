with Interfaces.C.Extensions;

package body Abstract_Meta_Argument_Lists is

   use type Interfaces.C.Extensions.bool;

   procedure AbstractMetaArgumentList_adjust
    (This : in out Internals.AbstractMetaArgumentList_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaArgumentList__adjust";

   procedure AbstractMetaArgumentList_finalize
    (This : in out Internals.AbstractMetaArgumentList_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaArgumentList__finalize";

   function AbstractMetaArgumentList_isEmpty
    (This : Internals.AbstractMetaArgumentList_Access)
       return Interfaces.C.Extensions.bool
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaArgumentList_isEmpty";

   function AbstractMetaArgumentList_size
    (This : Internals.AbstractMetaArgumentList_Access) return Interfaces.C.int
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaArgumentList_size";

   function AbstractMetaArgumentList_value
    (This  : Internals.AbstractMetaArgumentList_Access;
     Index : Interfaces.C.int)
       return Abstract_Meta_Arguments.AbstractMetaArgument_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaArgumentList_value";

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Abstract_Meta_Argument_List) is
   begin
      AbstractMetaArgumentList_adjust (Self.Object);
   end Adjust;

   -------------
   -- Cursors --
   -------------

   package body Cursors is

      function Each (Self : aliased in out Abstract_Meta_Argument_List'Class)
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

   function Each (Self : aliased in out Abstract_Meta_Argument_List'Class)
     return Cursors.Forward_Iterator renames Cursors.Each;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Abstract_Meta_Argument_List) is
   begin
      AbstractMetaArgumentList_finalize (Self.Object);
   end Finalize;

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      --------------
      -- Internal --
      --------------

      function Internal
       (Item : Abstract_Meta_Argument_List'Class)
          return AbstractMetaArgumentList_Access is
      begin
         return Item.Object;
      end Internal;

   end Internals;

   --------------
   -- Is_Empty --
   --------------

   function Is_Empty
    (Self : Abstract_Meta_Argument_List'Class) return Boolean is
   begin
      return AbstractMetaArgumentList_isEmpty (Self.Object) /= 0;
   end Is_Empty;

   ----------
   -- Size --
   ----------

   function Size (Self : Abstract_Meta_Argument_List'Class)
     return Interfaces.C.int is
   begin
      return AbstractMetaArgumentList_size (Self.Object);
   end Size;

   -----------
   -- Value --
   -----------

   function Value
    (Self  : Abstract_Meta_Argument_List'Class;
     Index : Interfaces.C.int)
      return Abstract_Meta_Arguments.Abstract_Meta_Argument is
   begin
      return
        Abstract_Meta_Arguments.Internals.Wrap
         (AbstractMetaArgumentList_value (Self.Object, Index));
   end Value;

end Abstract_Meta_Argument_Lists;
