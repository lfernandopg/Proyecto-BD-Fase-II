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
/*********************************************************/


/* C. para cada jugador listar los nombres de los mazos y la cantidad de cartas en total
que tiene ese mazo. Debe mostrarse el nombre del jugador */

SELECT J.nombreCompleto "Nombre Jugador", M.nombre "Nombre Mazo", N.cantidad "Cantidad Cartas"
FROM Jugador J, Mazo M,
(SELECT M.codMazo, COUNT(C.idCarta) Cantidad 		
 FROM Mazo M, Carta C 
 WHERE C.codMazo = M.codMazo
 GROUP BY M.codMazo) N
WHERE J.codJugador = M.codJugador AND M.codMazo = N.codMazo;


/*********************************************************/
/*D. Cantidad de duelos entre ​“yugi muto” y ​“​Katsuya Jonouchi”*/
SELECT count(D.idDuelo) "Numero de Duelos"
FROM Duelo D,
(SELECT J.codJugador
 FROM Jugador J
 WHERE J.nombreCompleto LIKE '%Yugi Muto%') J1, 
(SELECT J.codJugador
 FROM Jugador J
 WHERE J.nombreCompleto LIKE '%Katsuya Jonouchi%') J2
WHERE ((D.CodJugador1 = J1.codJugador) OR  
	   (D.CodJugador1 = J2.codJugador)) AND
	  ((D.CodJugador2 = J1.codJugador) OR   
	   (D.CodJugador2 = J2.codJugador));

/************************************************************/

/*E. jugadores que tienen al menos 2 mazos con la carta de nombre “ Mago Oscuro”
y que la cantidad de cartas de ese mazo sea mayor a 20.*/

SELECT j.nombrecompleto "Nombre Jugador"
FROM Jugador J,
(SELECT DISTINCT M.codMazo, M.codJugador
FROM Mazo M, Carta C
WHERE C.nombre LIKE '%Mago Oscuro%' AND C.codMazo = M.codMazo AND
	  C.codMazo IN (SELECT M.codMazo		
	  				FROM Mazo M, Carta C 
	  				WHERE C.codMazo = M.codMazo
	  				GROUP BY M.codMazo
	  				HAVING count(C.idCarta) >= 20)) M
WHERE J.codJugador = M.codJugador
GROUP BY j.nombrecompleto
HAVING count(M.codMazo) >= 2;

/*************************************************************/

/*F. Listar la información de todas las cartas de la primera edición que se han usado en
duelos que tiene mas de 3 turnos*/

SELECT C.*
FROM Carta C, 
(SELECT C.idCarta
FROM Carta C, Turno T
WHERE C.edicion LIKE '%Primera%' AND
	 (C.idCarta = T.idCartaMostruoJugador OR
	  C.idCarta = T.idCartaMagicaJugador OR
	  C.idCarta = T.idCartaTrampaJugador OR
	  C.idCarta = T.idCartaTrampaRival)
GROUP BY C.idCarta
HAVING count(T.idTurno) >= 3) Ca
WHERE C.idCarta = Ca.idCarta;

/*************************************************************/

/* I. Nombre mazos que cumplan con alguna de las siguientes condiciones:
a. Pertenecen a jugadores masculinos y tiene al menos 5 cartas mágicas de
tercera generación.
b. Pertenecen a jugadores femeninos que hayan participado en mas de 5 duelos ,
que tengan al menos 2 sobres de expansión en su propiedad y hayan ganado
en tantos o más duelos que la cantidad de duelos en las que ha participado el
jugador “Pegasus J. Crawford” */

SELECT DISTINCT M.nombre
FROM Mazo M,
(SELECT M.codMazo
 FROM Jugador J, Mazo M, Carta C, CartaMagica Ma
 WHERE J.codJugador = M.codJugador AND
	  C.codMazo = M.codMazo AND
	  Ma.idcartaMa = C.idCarta AND
	  C.edicion LIKE '%Tercera%' AND
	  J.genero = 'M'
 GROUP BY M.codMazo
 HAVING count(C.idCarta) >= 5) Ma,
(SELECT M.codMazo
FROM Mazo M,
(SELECT j.codjugador
FROM SobreExpansion SE, PaqueteColeccionable PC,
(SELECT j.codjugador
FROM Jugador J
WHERE  J.genero = 'F' AND J.DuelosParticipado >= 5 AND
	   J.DuelosGanados >= (SELECT J.DuelosParticipado
                           FROM Jugador J
                           WHERE J.nombreCompleto LIKE '%Pegasus J. Crawford%')) J
WHERE J.codjugador = PC.codjugador AND
	  PC.CodigoUnico = SE.IdSobreExpansion
GROUP BY j.codjugador
HAVING COUNT(pc.codigounico) >= 2) J
WHERE M.codJugador = J.codJugador) Mb 
WHERE M.codMazo = Ma.codMazo OR M.codMazo = Mb.codMazo;  


/*************************************************************/




