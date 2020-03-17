/*A. Información completa de los Jugadores que hayan ganado en al menos 3 duelos y
cuya edad sea menor a 15.*/

/*Se Usa la funcion CalcularEdad*/
 Create or replace function CalcularEdad(nacimiento date) 
 return number is
  edad   NUMBER(3, 1);
  BEGIN
  edad := floor(MONTHS_BETWEEN(SYSDATE, nacimiento))/12;  
  return edad;
  END;
   /

SELECT *
FROM Jugador J
WHERE CalcularEdad(J.fechaNacimiento) <= 15 AND J.DuelosGanados >= 3;

/***************************************************************************/


