with League.Characters;

package body Ada_Side.Generators.Adas.Values is

   -----------------------
   -- To_Ada_Identifier --
   -----------------------

   function To_Ada_Identifier
    (Name : League.Strings.Universal_String)
       return League.Strings.Universal_String
   is
      use type League.Characters.Universal_Character;

   begin
      return Result : League.Strings.Universal_String do
         for J in 1 .. Name.Length loop
            if J = 1 then
               Result.Append (Name (J).Simple_Uppercase_Mapping);

            else
               if J = 2
                 and Name (J - 1) = 'Q'
                 and Name (J).Uppercase
               then
                  --  Special exception to translate Qt Classes' names, for
                  --  example, 'QRect' -> 'Q_Rect'.
                  Result.Append ('_');

               elsif Name (J).Uppercase
                 and Name (J - 1).Lowercase
               then
                  Result.Append ('_');
               end if;

               if Name (J - 1) /= '_' and Name (J) /= '_' then
                  Result.Append (Name (J));
               end if;
            end if;
         end loop;
      end return;
   end To_Ada_Identifier;

   -----------------------
   -- To_Ada_Identifier --
   -----------------------

   function To_Ada_Identifier
    (Name : Q_Strings.Q_String)
       return League.Strings.Universal_String is
   begin
      return To_Ada_Identifier (Name.To_Universal_String);
   end To_Ada_Identifier;

end Ada_Side.Generators.Adas.Values;
