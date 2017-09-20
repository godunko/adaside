private with Ada.Finalization;
with Ada.Iterator_Interfaces;
with Interfaces.C;

with Abstract_Meta_Classes;

package Abstract_Meta_Class_Lists is

   type Abstract_Meta_Class_List is tagged private
     with Iterator_Element  => Abstract_Meta_Classes.Abstract_Meta_Class,
          Constant_Indexing => Value,
          Default_Iterator  => Each;

   function Size (Self : Abstract_Meta_Class_List'Class) return Interfaces.C.int;

   function Value
    (Self  : Abstract_Meta_Class_List'Class;
     Index : Interfaces.C.int) return Abstract_Meta_Classes.Abstract_Meta_Class;

   package Internals is

      type AbstractMetaClassList is null record with Convention => C;
      type AbstractMetaClassList_Access is access all AbstractMetaClassList
        with Convention => C;

      function Internal
       (Item : Abstract_Meta_Class_List'Class)
          return AbstractMetaClassList_Access;

   end Internals;

   package Cursors is

      function Has_Element (Self : Interfaces.C.int) return Boolean;

      package Iterator_Interfaces is new Ada.Iterator_Interfaces
        (Cursor       => Interfaces.C.int,
         Has_Element  => Cursors.Has_Element);

      type Forward_Iterator is
        new Iterator_Interfaces.Forward_Iterator with private;

      function Each (Self : aliased in out Abstract_Meta_Class_List'Class)
                        return Cursors.Forward_Iterator;

   private
      type Forward_Iterator is
        new Iterator_Interfaces.Forward_Iterator with record
         List  : access constant Abstract_Meta_Class_List'Class;
      end record;

      overriding function First
        (Self : Forward_Iterator) return Interfaces.C.int;

      overriding function Next
        (Self     : Forward_Iterator;
         Position : Interfaces.C.int) return Interfaces.C.int;

   end Cursors;

   function Each (Self : aliased in out Abstract_Meta_Class_List'Class)
     return Cursors.Forward_Iterator;

private

   function AbstractMetaClassList_new return Internals.AbstractMetaClassList_Access
     with Import     => True,
          Convention => C,
          Link_Name  => "AbstractMetaClassList__new";

   type Abstract_Meta_Class_List is new Ada.Finalization.Controlled with record
      Object : Internals.AbstractMetaClassList_Access := AbstractMetaClassList_new;
   end record;

   overriding procedure Adjust (Self : in out Abstract_Meta_Class_List);
   overriding procedure Finalize (Self : in out Abstract_Meta_Class_List);

end Abstract_Meta_Class_Lists;
