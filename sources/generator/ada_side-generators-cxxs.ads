private with Ada_Side.Units;

package Ada_Side.Generators.CXXs is

private

   procedure Generate_Declaration
    (Generator  : Abstract_Generator'Class;
     Unit       : in out Ada_Side.Units.Abstract_CXX_Unit'Class;
     Class      : Abstract_Meta_Classes.Abstract_Meta_Class'Class;
     Subprogram : Abstract_Meta_Functions.Abstract_Meta_Function'Class);

end Ada_Side.Generators.CXXs;
