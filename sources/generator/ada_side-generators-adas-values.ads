with Q_Strings;

package Ada_Side.Generators.Adas.Values is

   function To_Ada_Identifier
    (Name : League.Strings.Universal_String)
       return League.Strings.Universal_String;
   function To_Ada_Identifier
    (Name : Q_Strings.Q_String)
       return League.Strings.Universal_String;
   --  Converts identifier from C++ to Ada conventions.

end Ada_Side.Generators.Adas.Values;
