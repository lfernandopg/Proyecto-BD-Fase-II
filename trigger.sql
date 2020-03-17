--TRIGGER PARA ACTUALIZAR LA CANTIDAD DE DUELOS GANADOS DE CADA JUGADOR Y LAS INSERCIONES DE HistorialDuelos.
CREATE OR REPLACE TRIGGER ActualizarHistorial
  BEFORE INSERT ON Turno
  FOR EACH ROW WHEN(new.LPRival=0)
  
  DECLARE
  Cant int;   
  BEGIN 
  
    SELECT COUNT(IdTurno) INTO Cant FROM Turno  WHERE IdDuelo=:NEW.IdDuelo;
    Cant := Cant+1;
    INSERT INTO HistorialDuelos (IdDuelo,ganador,CantidadTurnosJugados) VALUES (:NEW.IdDuelo,:NEW.CodJugador,Cant);
    UPDATE Jugador set DuelosGanados=DuelosGanados+1 where CodJugador=:NEW.CodJugador;       

end;
/

/*TRIGGER PARA ACTUALIZAR LA CANTIDAD DE DUELOS POR JUGADOR*/
CREATE OR REPLACE TRIGGER ActualizarDuelosParticipados
  BEFORE INSERT ON Duelo
  FOR EACH ROW
  
  DECLARE
  Cant int;   
  BEGIN
    /*sumamos 1 a cada campo DuelosParticipado.*/
    UPDATE Jugador set DuelosParticipado=DuelosParticipado+1 where CodJugador=:NEW.CodJugador1; 
    UPDATE Jugador set DuelosParticipado=DuelosParticipado+1 where CodJugador=:NEW.CodJugador2;       

end;
/

SELECT * FROM JUGADOR WHERE CODJUGADOR='JUG001';
/*TRIGGER PARA ACTUALIZAR LAS CANTIDADES DE CARTAS EN LOS MAZOS segun su tipo*/
CREATE OR REPLACE TRIGGER ActualizarMazo
  BEFORE INSERT ON Carta
  FOR EACH ROW
  BEGIN
    IF :new.tipoCarta='Monstruo' THEN
        UPDATE Mazo set TotalCartasMontruo=TotalCartasMonstruo+1 where CodMazo=:NEW.CodMazo;
    ELSIF :new.tipoCarta='Magica' THEN
        UPDATE Mazo set TotalCartasMagica=TotalCartasMagica+1 where CodMazo=:NEW.CodMazo;
    ELSIF :new.tipoCarta='Trampa' THEN
        UPDATE Mazo set TotalCartastrampa=TotalCartastrampa+1 where CodMazo=:NEW.CodMazo;
    END IF;   
end;
/
show errors;
