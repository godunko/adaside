private with Type_Entries;

package Ada_Side.Generators.Adas.Value_Spec is

   type Value_Ada_Spec_Generator is new Abstract_Generator with private;

   function User_Package_Full_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

   function User_Tagged_Type_Name
    (Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class)
       return League.Strings.Universal_String;

private

   type Value_Ada_Spec_Generator is new Abstract_Generator with record
      null;
   end record;

   overriding function Should_Generate
    (Self  : in out Value_Ada_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class) return Boolean;

   overriding procedure Generate
    (Self  : in out Value_Ada_Spec_Generator;
     Class : Abstract_Meta_Classes.Abstract_Meta_Class'Class);

   function Find_Class
    (Self       : Value_Ada_Spec_Generator;
     Type_Entry : Type_Entries.Type_Entry)
       return Abstract_Meta_Classes.Abstract_Meta_Class;

end Ada_Side.Generators.Adas.Value_Spec;
