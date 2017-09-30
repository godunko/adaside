with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Interfaces.C;

package body Debug is

   Indent : Count := 1;

   procedure Debug_Image
    (Item : Abstract_Meta_Functions.Abstract_Meta_Function'Class)
   is
   begin
      Set_Col (Indent);
      Put ("{");
      Indent := Indent + 2;

      Set_Col (Indent);
      Put ("Arguments              =>");
      Put (Interfaces.C.int'Wide_Wide_Image (Item.Arguments.Size));

      Set_Col (Indent);
      Put ("Is_Arithmetic_Operator => ");
      Put (Boolean'Wide_Wide_Image (Item.Is_Arithmetic_Operator));

      Set_Col (Indent);
      Put ("Is_Bitwise_Operator    => ");
      Put (Boolean'Wide_Wide_Image (Item.Is_Bitwise_Operator));

      Set_Col (Indent);
      Put ("Is_Constant            => ");
      Put (Boolean'Wide_Wide_Image (Item.Is_Constant));

      Set_Col (Indent);
      Put ("Is_Constructor         => ");
      Put (Boolean'Wide_Wide_Image (Item.Is_Constructor));

      Set_Col (Indent);
      Put ("Is_Friendly            => ");
      Put (Boolean'Wide_Wide_Image (Item.Is_Friendly));

      Set_Col (Indent);
      Put ("Is_Static              => ");
      Put (Boolean'Wide_Wide_Image (Item.Is_Static));

      Set_Col (Indent);
      Put ("Name                   => ");
      Put (Item.Name.To_Universal_String.To_Wide_Wide_String);

      Indent := Indent - 2;

--   function Get_Type (Self : Abstract_Meta_Function'Class)
--     return Abstract_Meta_Types.Abstract_Meta_Type;

      Set_Col (Indent);
      Put ("}");
   end Debug_Image;

end Debug;
