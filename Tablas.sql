DROP TABLE Mazo;
DROP TABLE Carta;
DROP TABLE Turno;
DROP TABLE Duelo;
DROP TABLE Jugador;
DROP TABLE CartaMostruo;
DROP TABLE CartaMagica;
DROP TABLE CartaTrampa;

CREATE TABLE Jugador(
	CodJugador VARCHAR2(30),
	nombreCompleto VARCHAR2(30),
	genero CHAR,
	fechaNacimiento DATE,
	estatura INT,
	DuelosParticipado INT,
	DuelosGanados INT,
	CONSTRAINT PK_Jugador PRIMARY KEY (CodJugador)
);

CREATE TABLE Mazo(
	CodMazo VARCHAR2(30),
	nombre VARCHAR2(30),
	TotalCartasMontruo INT,
	TotalCartasMagica INT,
	TotalCartasTrampa INT,
        codJugador VARCHAR2(30), 
	CONSTRAINT PK_Mazo PRIMARY KEY (CodMazo),
	CONSTRAINT FK_codJugadorM FOREIGN KEY (codJugador) REFERENCES Jugador(CodJugador)
);

CREATE TABLE Duelo(
	IdDuelo VARCHAR2(30),
	CodJugador1 VARCHAR2(30),
	CodJugador2 VARCHAR2(30),
        CodMazoJ1 VARCHAR2(30),
	CodMazoJ2 VARCHAR2(30),
	fechaDuelo DATE,
	duracion INT,
	descripcion VARCHAR2(100),
	CONSTRAINT PK_Duelo PRIMARY KEY (IdDuelo),
	CONSTRAINT FK_CodJugador1 FOREIGN KEY (CodJugador1) REFERENCES Jugador(CodJugador),
	CONSTRAINT FK_CodJugador2 FOREIGN KEY (CodJugador2) REFERENCES Jugador(CodJugador),
	CONSTRAINT FK_CodMazoJ2 FOREIGN KEY (CodMazoJ2) REFERENCES Mazo(CodMazo),
	CONSTRAINT FK_CodMazoJ1 FOREIGN KEY (CodMazoJ1) REFERENCES Mazo(CodMazo)
);

CREATE TABLE Carta(
	IdCarta VARCHAR2(30),
	nombre VARCHAR2(30),
	edicion VARCHAR2(30),
	codigoSerie VARCHAR2(30),
	efecto VARCHAR2(30),
	tipoCarta VARCHAR2(30),
	CodMazo VARCHAR2(30),
	CONSTRAINT PK_Trampa PRIMARY KEY (IdCarta),
	CONSTRAINT FK_CodMazo FOREIGN KEY (CodMazo) REFERENCES Mazo(CodMazo)
);

CREATE TABLE CartaMostruo(
        idCartaM VARCHAR2(30),
	Atributo VARCHAR2(30),
	tipo VARCHAR2(30),
	Nivel INT,
	PuntosAtaque INT,
	PuntosDefensa INT,
	CONSTRAINT PK_CartaMostruo PRIMARY KEY (idCartaM)
	CONSTRAINT FK_idCartaM FOREIGN KEY (idCartaM) REFERENCES Carta(IdCarta)
);

CREATE TABLE CartaMagica(
	idCartaMa VARCHAR2(30),
	efectoEspecial VARCHAR2(30),
	TIpodeMagia VARCHAR2(30),
	CONSTRAINT PK_CartaMagica PRIMARY KEY (idCartaMa)
	CONSTRAINT FK_idCartaMa FOREIGN KEY (idCartaMa) REFERENCES Carta(IdCarta)
);

CREATE TABLE CartaTrampa(
	idCartaT VARCHAR2(30),
	TipodeTrampa VARCHAR2(30),
	CONSTRAINT PK_CartaTrampa PRIMARY KEY (idCartaT)
	CONSTRAINT FK_idCartaT FOREIGN KEY (idCartaT) REFERENCES Carta(IdCarta)
);

CREATE TABLE Turno(
	IdTurno VARCHAR2(30),
	IdDuelo VARCHAR2(30),
	CodJugador VARCHAR2(30),
	IdCartaMostruoJugador VARCHAR2(30),
	IdCartaMagicaJugador VARCHAR2(30),
	IdCartaTrampaJugador VARCHAR2(30),
	IdCartaTrampaRival VARCHAR2(30),
	posicion VARCHAR2(30),
	LPJugador INT,
	LPRival INT,
	CONSTRAINT PK_Turno PRIMARY KEY (IdTurno, IdDuelo),
	CONSTRAINT FK_IdDuelo FOREIGN KEY (IdDuelo) REFERENCES Duelo(IdDuelo),
	CONSTRAINT FK_CodJugadorT FOREIGN KEY (CodJugador) REFERENCES Jugador(CodJugador),
	CONSTRAINT FK_IdCartaMostruoJugador FOREIGN KEY (IdCartaMostruoJugador) REFERENCES CartaMostruo(idCartaM),
	CONSTRAINT FK_IdCartaMagicaJugador FOREIGN KEY (IdCartaMagicaJugador) REFERENCES CartaMagica(idCartaMa),
	CONSTRAINT FK_IdCartaTrampaJugador FOREIGN KEY (IdCartaTrampaJugador) REFERENCES CartaTrampa(idCartaT),
	CONSTRAINT FK_IdCartaTrampaRival FOREIGN KEY (IdCartaTrampaRival) REFERENCES CartaTrampa(idCartaT)
);

/* Hello */
