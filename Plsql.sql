/* PROCEDIMIENTOS PARA LAS INSERCIONES DE CADA TABLA
   NOTA: TODAS LA VALIDACIONES SE HICIERON CON ALTER TABLE, POR LO QUE NO HACE FALTA VALIDAR EN ESTOS PROCEDIMIENTOS*/
   
CREATE OR REPLACE PROCEDURE InsertarJugador (CodJugador VARCHAR2,nombreCompleto VARCHAR,genero CHAR,fechaNacimiento DATE,
											estatura INT,DuelosParticipado INT,DuelosGanados INT)
AS
BEGIN	
	INSERT INTO Jugador VALUES (CodJugador,nombreCompleto,genero,fechaNacimiento,estatura,DuelosParticipado,DuelosGanados);
end;
/

CREATE OR REPLACE PROCEDURE InsertarMazo (CodMazo VARCHAR2,nombre VARCHAR2,TotalCartasMontruo INT,TotalCartasMagica INT,
											TotalCartasTrampa INT,codJugador VARCHAR2)
AS
BEGIN
	INSERT INTO Mazo VALUES (CodMazo,nombre,TotalCartasMontruo,TotalCartasMagica,TotalCartasTrampa,codJugador);
end;
/


CREATE OR REPLACE PROCEDURE InsertarDuelo (IdDuelo VARCHAR2,CodJugador1 VARCHAR2,CodJugador2 VARCHAR2,CodMazoJ1 VARCHAR2,
											CodMazoJ2 VARCHAR2,fechaDuelo DATE,duracion INT,descripcion VARCHAR2)
AS
BEGIN
	INSERT INTO Duelo VALUES (IdDuelo,CodJugador1,CodJugador2,CodMazoJ1,CodMazoJ2,fechaDuelo,duracion,descripcion);
end;
/

CREATE OR REPLACE PROCEDURE InsertarCarta (IdCarta VARCHAR2,nombre VARCHAR2,edicion VARCHAR2,codigoSerie VARCHAR2,efecto VARCHAR2,
											tipoCarta VARCHAR2,CodMazo VARCHAR2)
AS
BEGIN
	INSERT INTO Carta VALUES (IdCarta,nombre,edicion,codigoSerie,efecto,tipoCarta,CodMazo);
end;
/


CREATE OR REPLACE PROCEDURE InsertarCartaMonstruo (idCartaM VARCHAR2,Atributo VARCHAR2,tipo VARCHAR2,Nivel INT,PuntosAtaque INT,PuntosDefensa INT)
AS
BEGIN
	/*EN EL ENUNCIADO APARECE MONSTRUO Y DEBE RESPETARSE EL ENUNCIADO*/
	INSERT INTO CartaMostruo VALUES (idCartaM,Atributo,tipo,Nivel,PuntosAtaque,PuntosDefensa);
end;
/

CREATE OR REPLACE PROCEDURE InsertarCartaMagica (idCartaMa VARCHAR2,efectoEspecial VARCHAR2,TIpodeMagia VARCHAR2)
AS
BEGIN
	INSERT INTO CartaMagica VALUES (idCartaMa,efectoEspecial,TIpodeMagia);
end;
/

CREATE OR REPLACE PROCEDURE InsertarCartaTrampa (idCartaT VARCHAR2,TipodeTrampa VARCHAR2)
AS
BEGIN
	INSERT INTO CartaTrampa VALUES (idCartaT,TipodeTrampa);
end;
/

CREATE OR REPLACE PROCEDURE InsertarPaqueteColeccionable (CodigoUnico varchar2,nombre varchar2,descripcion varchar2,
    													fechaLanzamiento date,Generacion int,TotalCartas int,tipopaquete varchar2,
    													fechaCompraJugador date,CodJugador varchar2)
AS
BEGIN
	INSERT INTO PaqueteColeccionable VALUES (CodigoUnico,nombre,descripcion,fechaLanzamiento,Generacion,TotalCartas,tipopaquete,fechaCompraJugador,CodJugador);
end;
/

CREATE OR REPLACE PROCEDURE InsertarBarajaInicio (IdPaqueteInicio varchar2,CantidadCartasComunes int,CantidadCartasUltraRaras int,CantidadCartasSuperRaras int)
AS
BEGIN
	INSERT INTO BarajaInicio VALUES (IdPaqueteInicio,CantidadCartasComunes,CantidadCartasUltraRaras,CantidadCartasSuperRaras);
end;
/

CREATE OR REPLACE PROCEDURE InsertarSobreExpansion (IdSobreExpansion varchar2,CantidadCartasComunes int,CantidadCartasRaras int,CantidadCartasRarasSecretas int,
    												CantidadCartasUltraRaras int,CartasSuperRaras int,CartasUltrararas int)
AS
BEGIN
	INSERT INTO SobreExpansion VALUES (IdSobreExpansion,CantidadCartasComunes,CantidadCartasRaras,CantidadCartasRarasSecretas,CantidadCartasUltraRaras,CartasSuperRaras,CartasUltrararas);
end;
/

CREATE OR REPLACE PROCEDURE InsertarTurno (IdTurno VARCHAR2,IdDuelo VARCHAR2,CodJugador VARCHAR2,IdCartaMostruoJugador VARCHAR2,
                                            IdCartaMagicaJugador VARCHAR2,IdCartaTrampaJugador VARCHAR2,IdCartaTrampaRival VARCHAR2,
                                            posicion VARCHAR2,LPJugador INT,LPRival INT)
AS
BEGIN
	INSERT INTO Turno VALUES (IdTurno,IdDuelo,CodJugador,IdCartaMostruoJugador,IdCartaMagicaJugador,IdCartaTrampaJugador,IdCartaTrampaRival,posicion,LPJugador,LPRival);
end;
/

CREATE OR REPLACE PROCEDURE InsertarHistorialDuelos (IdDuelo varchar2,ganador varchar2,CantidadTurnosGanados int)
AS
BEGIN
	INSERT INTO HistorialDuelos VALUES (IdDuelo,ganador,CantidadTurnosGanados);
end;
/
show errors;