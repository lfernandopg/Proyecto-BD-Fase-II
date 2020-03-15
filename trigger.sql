CREATE OR REPLACE TRIGGER ActualizarHistorial
  AFTER INSERT ON Turno
  FOR EACH ROW WHEN(new.LPRival=0)
  
  DECLARE
  Cant int;   
  BEGIN 
  
    SELECT COUNT(IdTurno) INTO Cant FROM Turno  WHERE IdDuelo=:NEW.IdDuelo;
    INSERT INTO HistorialDuelos (IdDuelo,ganador,CantidadTurnosJugados) VALUES (:NEW.IdDuelo,:NEW.CodJugador,Cant);   

end;
/
show errors;