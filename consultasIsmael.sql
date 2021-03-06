/*consulta B JUGADOR QUE HA BATALLADO MAS VECES CONTRA YUGI MUTO*/

select jugador.nombrecompleto
  from jugador,(      
      Select aux.CODIGO as codigo, SUM(aux.CANT) AS encuentros
          FROM
          (select duelo.CodJugador1 AS CODIgO , count(duelo.codjugador2) AS CANT
            from duelo ,jugador j
            where duelo.CodJugador2=j.CodJugador and j.nombrecompleto ='Yugi Muto'
            group by duelo.codjugador1    
          UNION    
          select duelo.CodJugador2 AS CODIGO, count(duelo.codjugador1)AS CANT
            from duelo ,jugador j
            where duelo.CodJugador1=j.CodJugador and j.nombrecompleto ='Yugi Muto' 
            group by duelo.codjugador2) aux
      group by aux.CODIGO order by encuentros desc ) total
where total.codigo=jugador.codjugador and rownum=1;

/*Consulta H NOMBRE DEL PAQUETE DE EXPANCION DE PRIMERA GENERACION QUE TENGAN EN SU COLECCION TODOS LOS JUGADORES*/
select paquete.nombre
  FROM (SELECT nombre, count(DISTINCT Codjugador) cantidad
            FROM Paquetecoleccionable
            group by nombre) paquete,
        (SELECT COUNT(DISTINCT Jugador.codJugador) as cantidad
                From Jugador) player
  WHERE paquete.cantidad=player.cantidad;


/*consulta G JUGADORES FEMENINOS CON MAS CARTAS DE TIPO MOSNTRUO Y QUE HAYAN GANADO MAS DUELOS QUE EL PROMEDIO*/
SELECT jugador.nombreCompleto 
from jugador,
      (SELECT jugador.codjugador as codigo 
        FROM MAZO,jugador 
        where jugador.genero='F' and mazo.codjugador=jugador.codjugador and mazo.totalcartasmontruo>mazo.totalcartasmagica and mazo.totalcartasmontruo>mazo.totalcartastrampa
      
      INTERSECT
      
      SELECT player.ganador
        from/*cada jugador y sus victorias*/
            (Select historialduelos.ganador ganador, count(idduelo) duelos
              from historialduelos, jugador
              where historialduelos.cantidadturnosjugados>5 and historialduelos.ganador=jugador.codjugador and jugador.genero='F'
              group by historialduelos.ganador
            ) player,
              /*promedio de los duelos*/
            (SELECT avg(duelos) duelos
                  from (Select count(idduelo) duelos
                  from historialduelos, jugador
                  where historialduelos.cantidadturnosjugados>5 and historialduelos.ganador=jugador.codjugador and jugador.genero='F'
                  group by historialduelos.ganador) player
            ) promedio 
        where player.duelos>promedio.duelos) aux 
where aux.codigo=jugador.codjugador;