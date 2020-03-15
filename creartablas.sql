CREATE TABLE Jugador(
	CodJugador VARCHAR2(30),
	nombreCompleto VARCHAR2(30) NOT NULL,
	genero CHAR,
	fechaNacimiento DATE,
	estatura INT CHECK (estatura>=0),
	DuelosParticipado INT CHECK (DuelosParticipado>=0),
	DuelosGanados INT CHECK (DuelosGanados>=0),
	CONSTRAINT PK_Jugador PRIMARY KEY (CodJugador),
  CONSTRAINT GeneroJugador CHECK (genero IN ('M','F'))
);

CREATE TABLE Mazo(--CHECK (>=0)
	CodMazo VARCHAR2(30),
	nombre VARCHAR2(30) NOT NULL,
	TotalCartasMontruo INT CHECK (TotalCartasMontruo>=0),
	TotalCartasMagica INT CHECK (TotalCartasMagica>=0),
	TotalCartasTrampa INT CHECK (TotalCartasTrampa>=0),
  codJugador VARCHAR2(30), 
	CONSTRAINT PK_Mazo PRIMARY KEY (CodMazo),
	CONSTRAINT FK_codJugadorM FOREIGN KEY (codJugador) REFERENCES Jugador(CodJugador)ON DELETE CASCADE
);

CREATE TABLE Duelo(
	IdDuelo VARCHAR2(30),
	CodJugador1 VARCHAR2(30),
	CodJugador2 VARCHAR2(30),
  CodMazoJ1 VARCHAR2(30),
	CodMazoJ2 VARCHAR2(30),
	fechaDuelo DATE,
	duracion INT CHECK (duracion>=1),
	descripcion VARCHAR2(100),
	CONSTRAINT PK_Duelo PRIMARY KEY (IdDuelo),
	CONSTRAINT FK_CodJugador1 FOREIGN KEY (CodJugador1) REFERENCES Jugador(CodJugador) ON DELETE CASCADE,
	CONSTRAINT FK_CodJugador2 FOREIGN KEY (CodJugador2) REFERENCES Jugador(CodJugador) ON DELETE CASCADE,
	CONSTRAINT FK_CodMazoJ2 FOREIGN KEY (CodMazoJ2) REFERENCES Mazo(CodMazo) ON DELETE CASCADE,
	CONSTRAINT FK_CodMazoJ1 FOREIGN KEY (CodMazoJ1) REFERENCES Mazo(CodMazo) ON DELETE CASCADE
);

CREATE TABLE Carta(
	IdCarta VARCHAR2(30),
	nombre VARCHAR2(30) NOT NULL,
	edicion VARCHAR2(30),
	codigoSerie VARCHAR2(30),
	efecto VARCHAR2(30),
	tipoCarta VARCHAR2(30),
	CodMazo VARCHAR2(30),
	CONSTRAINT PK_Trampa PRIMARY KEY (IdCarta),
	CONSTRAINT FK_CodMazo FOREIGN KEY (CodMazo) REFERENCES Mazo(CodMazo) ON DELETE CASCADE
);

CREATE TABLE CartaMostruo(
  idCartaM VARCHAR2(30),
	Atributo VARCHAR2(30),
	tipo VARCHAR2(30),
	Nivel INT CHECK (Nivel>=0),
	PuntosAtaque INT CHECK (PuntosAtaque>=0),
	PuntosDefensa INT CHECK (PuntosDefensa>=0),
	CONSTRAINT PK_CartaMostruo PRIMARY KEY (idCartaM),
	CONSTRAINT FK_idCartaM FOREIGN KEY (idCartaM) REFERENCES Carta(IdCarta) ON DELETE CASCADE,
  CONSTRAINT AtributoCartaMonstruo CHECK (Atributo IN ('Agua','Fuego','Luz','Oscuridad','Tierra','viento'))
);

CREATE TABLE CartaMagica(
	idCartaMa VARCHAR2(30),
	efectoEspecial VARCHAR2(30),
	TIpodeMagia VARCHAR2(30),
	CONSTRAINT PK_CartaMagica PRIMARY KEY (idCartaMa),
	CONSTRAINT FK_idCartaMa FOREIGN KEY (idCartaMa) REFERENCES Carta(IdCarta) ON DELETE CASCADE,
  CONSTRAINT TipoMagia CHECK (TIpodeMagia IN ('normal','continua','juego rápido','campo','equipo','ritual'))
);

CREATE TABLE CartaTrampa(
	idCartaT VARCHAR2(30),
	TipodeTrampa VARCHAR2(30),
	CONSTRAINT PK_CartaTrampa PRIMARY KEY (idCartaT),
	CONSTRAINT FK_idCartaT FOREIGN KEY (idCartaT) REFERENCES Carta(IdCarta) ON DELETE CASCADE,
  CONSTRAINT TipoTrampa CHECK (TipodeTrampa IN ('normal','continua','contraefecto'))
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
	LPJugador INT CHECK (LPJugador>=0),
	LPRival INT CHECK (LPRival>=0),
	CONSTRAINT PK_Turno PRIMARY KEY (IdTurno, IdDuelo),
	CONSTRAINT FK_IdDuelo FOREIGN KEY (IdDuelo) REFERENCES Duelo(IdDuelo) ON DELETE CASCADE,
	CONSTRAINT FK_CodJugadorT FOREIGN KEY (CodJugador) REFERENCES Jugador(CodJugador) ON DELETE CASCADE,
	CONSTRAINT FK_IdCartaMostruoJugador FOREIGN KEY (IdCartaMostruoJugador) REFERENCES CartaMostruo(idCartaM) ON DELETE CASCADE,
	CONSTRAINT FK_IdCartaMagicaJugador FOREIGN KEY (IdCartaMagicaJugador) REFERENCES CartaMagica(idCartaMa) ON DELETE CASCADE,
	CONSTRAINT FK_IdCartaTrampaJugador FOREIGN KEY (IdCartaTrampaJugador) REFERENCES CartaTrampa(idCartaT) ON DELETE CASCADE,
	CONSTRAINT FK_IdCartaTrampaRival FOREIGN KEY (IdCartaTrampaRival) REFERENCES CartaTrampa(idCartaT) ON DELETE CASCADE,
  CONSTRAINT Posicionturno CHECK (posicion IN ('Ataque','Defensa'))
);

CREATE TABLE PaqueteColeccionable(
    CodigoUnico varchar2(30),
    nombre varchar2(30) NOT NULL,
    descripcion varchar2(100),
    fechaLanzamiento date,
    Generacion int CHECK (Generacion>=0),
    TotalCartas int CHECK (TotalCartas>=0),
    tipopaquete varchar2(30),
    fechaCompraJugador date,
    CodJugador varchar2(30),
    CONSTRAINT PK_PaqueteColeccionable PRIMARY KEY(CodigoUnico),/*falta la ,*/
    CONSTRAINT FK_jugador FOREIGN KEY (CodJugador) REFERENCES Jugador (CodJugador) ON DELETE CASCADE
    );
    
CREATE TABLE BarajaInicio(
    IdPaqueteInicio varchar2(30),
    CantidadCartasComunes int CHECK (CantidadCartasComunes>=1),
    CantidadCartasUltraRaras int CHECK (CantidadCartasUltraRaras>=1),
    CantidadCartasSuperRaras int CHECK (CantidadCartasSuperRaras>=1),
    CONSTRAINT PK_BarajaInicio PRIMARY KEY(IdPaqueteInicio),
    CONSTRAINT FK_PaqueteInicio FOREIGN KEY(IdPaqueteInicio) REFERENCES PaqueteColeccionable (CodigoUnico) ON DELETE CASCADE
    );
    
CREATE TABLE SobreExpansion (
    IdSobreExpansion varchar2(30),
    CantidadCartasComunes int CHECK (CantidadCartasComunes>=1),
    CantidadCartasRaras int CHECK (CantidadCartasRaras>=1),
    CantidadCartasRarasSecretas int CHECK (CantidadCartasRarasSecretas>=1),
    CantidadCartasUltraRaras int CHECK (CantidadCartasUltraRaras>=1),
    CartasSuperRaras int CHECK (CartasSuperRaras>=1),
    CartasUltrararas int CHECK  (CartasUltrararas>=1),
    CONSTRAINT PK_SobreExpansion PRIMARY KEY(IdSobreExpansion),
    CONSTRAINT FK_PaqueteExpansion FOREIGN KEY(IdsobreExpansion) REFERENCES PaqueteColeccionable (CodigoUnico) ON DELETE CASCADE
    );
    
CREATE TABLE HistorialDuelos (
    IdDuelo varchar2(30),
    ganador varchar2(30),
    CantidadTurnosJugados int CHECK  (CantidadTurnosJugados>=1),
    CONSTRAINT PK_HistorialDuelos PRIMARY KEY(IdDuelo,ganador),
    /*FALTAN LAS FOREIGN KEYS*/
    CONSTRAINT FK_TurnoDuelo FOREIGN KEY(IdDuelo) REFERENCES Duelo(IdDuelo) ON DELETE CASCADE,
    CONSTRAINT FK_GanadorDuelo FOREIGN KEY(ganador) REFERENCES JUGADOR(CodJugador) ON DELETE CASCADE
    );
show errors;
    