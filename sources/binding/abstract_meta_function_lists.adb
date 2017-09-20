
package body Abstract_Meta_Function_Lists is

   procedure AbstractMetaFunctionList_adjust
    (This : in out Internals.AbstractMetaFunctionList_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunctionList__adjust";

   procedure AbstractMetaFunctionList_finalize
    (This : in out Internals.AbstractMetaFunctionList_Access)
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunctionList__finalize";

   function AbstractMetaFunctionList_size
    (This : Internals.AbstractMetaFunctionList_Access) return Interfaces.C.int
       with Import     => True,
            Convention => C,
            Link_Name  => "AbstractMetaFunctionList_size";

   function AbstractMetaFunctionList_value
    (This  : Internals.AbstractMetaFunctionList_Access;
     Index : Interfaces.C.int)
       return Abstract_Meta_Functions.AbstractMetaFunction_Access
         with Import     => True,
              Convention => C,
              Link_Name  => "AbstractMetaFunctionList_value";

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Abstract_Meta_Function_List) is
   begin
      AbstractMetaFunctionList_adjust (Self.Object);
   end Adjust;

   -------------
   -- Cursors --
   -------------

   package body Cursors is

      function Each (Self : aliased in out Abstract_Meta_Function_List'Class)
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

   function Each (Self : aliased in out Abstract_Meta_Function_List'Class)
     return Cursors.Forward_Iterator renames Cursors.Each;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Abstract_Meta_Function_List) is
   begin
      AbstractMetaFunctionList_finalize (Self.Object);
   end Finalize;

   ---------------
   -- Internals --
   ---------------

   package body Internals is

      --------------
      -- Internal --
      --------------

      function Internal
       (Item : Abstract_Meta_Function_List'Class)
          return AbstractMetaFunctionList_Access is
      begin
         return Item.Object;
      end Internal;

   end Internals;

   ----------
   -- Size --
   ----------

   function Size (Self : Abstract_Meta_Function_List'Class)
     return Interfaces.C.int is
   begin
      return AbstractMetaFunctionList_size (Self.Object);
   end Size;

   -----------
   -- Value --
   -----------

   function Value
    (Self  : Abstract_Meta_Function_List'Class;
     Index : Interfaces.C.int)
      return Abstract_Meta_Functions.Abstract_Meta_Function is
   begin
      return
        Abstract_Meta_Functions.Internals.Wrap
         (AbstractMetaFunctionList_value (Self.Object, Index));
   end Value;

end Abstract_Meta_Function_Lists;
