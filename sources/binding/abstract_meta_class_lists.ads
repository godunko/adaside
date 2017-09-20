private with Ada.Finalization;
with Interfaces.C;

with Abstract_Meta_Classes;

package Abstract_Meta_Class_Lists is

   type Abstract_Meta_Class_List is tagged private;

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
