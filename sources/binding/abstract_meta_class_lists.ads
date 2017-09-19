private with Ada.Finalization;

package Abstract_Meta_Class_Lists is

   type Abstract_Meta_Class_List is tagged private;

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
