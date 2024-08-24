alter table trip add
    no_available_places int null;

CREATE OR REPLACE PROCEDURE p_calculate_no_available_places AS
BEGIN
  FOR t IN (SELECT trip_id, max_no_places FROM trip) LOOP
    UPDATE trip SET no_available_places = t.max_no_places - NVL((SELECT COUNT(*) FROM reservation WHERE trip_id = t.trip_id AND status IN ('N', 'P')), 0) WHERE trip_id = t.trip_id;
  END LOOP;
END;
/

begin p_calculate_no_available_places(); end;

-- Triggery obsługujący dodanie rezerwacji
CREATE OR REPLACE TRIGGER tr_add_reservation_6_before_insert
BEFORE INSERT ON reservation
FOR EACH ROW
DECLARE
  v_max_no_places NUMBER;
BEGIN
  SELECT no_available_places INTO v_max_no_places FROM trip WHERE trip_id = :new.trip_id;

  IF v_max_no_places <= 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Brak wolnych miejsc na wycieczkę');
  END IF;

  UPDATE trip SET no_available_places = no_available_places - 1 WHERE trip_id = :new.trip_id;
END;
/

CREATE OR REPLACE TRIGGER tr_add_reservation_6_after_insert
AFTER INSERT ON reservation
FOR EACH ROW
BEGIN
  INSERT INTO log (reservation_id, log_date, status) VALUES (:new.reservation_id, SYSDATE, :new.status);
END;
/

-- Triggery obsługujący zmianę statusu
CREATE OR REPLACE TRIGGER tr_modify_reservation_status_6_before_update
BEFORE UPDATE OF status ON reservation
FOR EACH ROW
DECLARE
  v_max_no_places NUMBER;
BEGIN
  IF :old.status = 'C' AND :new.status = 'N' THEN
    SELECT no_available_places INTO v_max_no_places FROM trip WHERE trip_id = :new.trip_id;

    IF v_max_no_places <= 0 THEN
      RAISE_APPLICATION_ERROR(-20002, 'Brak wolnych miejsc na wycieczkę');
    END IF;

    UPDATE trip SET no_available_places = no_available_places - 1 WHERE trip_id = :new.trip_id;
  ELSIF :old.status IN ('N', 'P') AND :new.status = 'C' THEN
    UPDATE trip SET no_available_places = no_available_places + 1 WHERE trip_id = :new.trip_id;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_modify_reservation_status_6_after_update
AFTER UPDATE OF status ON reservation
FOR EACH ROW
BEGIN
  INSERT INTO log (reservation_id, log_date, status) VALUES (:new.reservation_id, SYSDATE, :new.status);
END;
/

-- Procedura p_add_reservation_6
CREATE OR REPLACE PROCEDURE p_add_reservation_6(p_trip_id IN NUMBER, p_person_id IN NUMBER) AS
BEGIN
  INSERT INTO reservation (trip_id, person_id, status) VALUES (p_trip_id, p_person_id, 'N');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20003, 'Nie znaleziono wycieczki');
END;
/

-- Procedura p_modify_reservation_status_6
CREATE OR REPLACE PROCEDURE p_modify_reservation_status_6(p_reservation_id IN NUMBER, p_status IN CHAR) AS
BEGIN
  UPDATE reservation SET status = p_status WHERE reservation_id = p_reservation_id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20004, 'Nie znaleziono rezerwacji');
END;
/