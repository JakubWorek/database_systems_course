-- Procedura p_add_reservation_6b
CREATE OR REPLACE PROCEDURE p_add_reservation_6b(p_trip_id IN NUMBER, p_person_id IN NUMBER) AS
BEGIN
  INSERT INTO reservation (trip_id, person_id, status) VALUES (p_trip_id, p_person_id, 'N');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Nie znaleziono wycieczki');
END;
/

-- Procedura p_modify_reservation_status_6b
CREATE OR REPLACE PROCEDURE p_modify_reservation_status_6b(p_reservation_id IN NUMBER, p_status IN CHAR) AS
BEGIN
  UPDATE reservation SET status = p_status WHERE reservation_id = p_reservation_id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, 'Nie znaleziono rezerwacji');
END;
/