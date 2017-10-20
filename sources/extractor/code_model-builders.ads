private with Ada.Containers.Indefinite_Vectors;
private with Ada.Text_IO;

private with clang_c_Index_h;

with Base_Visitors;

package Code_Model.Builders is

   type Code_Model_Builder is
     limited new Base_Visitors.Base_Visitor with private;

   procedure Initialize (Self : in out Code_Model_Builder'Class);

private

   type State_Kinds is (Invalid, Namespace, Class);

   type State_Record (Kind : State_Kinds := Invalid) is record
      Scope : Code_Model.Scope_Access;
   end record;

   package State_Vectors is
     new Ada.Containers.Indefinite_Vectors (Positive, State_Record);

   type Code_Model_Builder is
     limited new Base_Visitors.Base_Visitor with
--     limited new Ada.Finalization.Limited_Controlled
--       and Base_Visitors.Base_Visitor with
--  XXX GNAT 20171008: use of Limited_Controlled raise finalization failure in
--  visitor traversal code.
   record
      Indent : Ada.Text_IO.Count := 1;
      Model  : Code_Model.Model_Access;
      File   : Code_Model.File_Access;
      State  : State_Record;
      Stack  : State_Vectors.Vector;
   end record;

   overriding procedure Enter_Token
    (Self    : in out Code_Model_Builder;
     Cursor  : clang_c_Index_h.CXCursor;
     Control : in out Base_Visitors.Traverse_Control);

   overriding procedure Leave_Token
    (Self    : in out Code_Model_Builder;
     Cursor  : clang_c_Index_h.CXCursor;
     Control : in out Base_Visitors.Traverse_Control);

end Code_Model.Builders;
