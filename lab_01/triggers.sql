-- Trigger obsługujący dodanie rezerwacji
CREATE OR REPLACE TRIGGER tr_add_reservation
AFTER INSERT ON reservation
FOR EACH ROW
BEGIN
  INSERT INTO log (reservation_id, log_date, status) VALUES (:new.reservation_id, SYSDATE, :new.status);
END;
/

-- Trigger obsługujący zmianę statusu
CREATE OR REPLACE TRIGGER tr_modify_reservation_status
AFTER UPDATE OF status ON reservation
FOR EACH ROW
BEGIN
  INSERT INTO log (reservation_id, log_date, status) VALUES (:new.reservation_id, SYSDATE, :new.status);
END;
/

-- Trigger zabraniający usunięcia rezerwacji
CREATE OR REPLACE TRIGGER tr_delete_reservation
BEFORE DELETE ON reservation
FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20007, 'Nie można usunąć rezerwacji');
END;
/

-- Trigger obsługujący dodanie rezerwacji
CREATE OR REPLACE TRIGGER tr_add_reservation_5
BEFORE INSERT ON reservation
FOR EACH ROW
DECLARE
  v_max_no_places NUMBER;
  v_reserved_places NUMBER;
BEGIN
  SELECT max_no_places INTO v_max_no_places FROM trip WHERE trip_id = :new.trip_id;
  SELECT COUNT(*) INTO v_reserved_places FROM reservation WHERE trip_id = :new.trip_id AND status IN ('N', 'P');

  IF v_max_no_places <= v_reserved_places THEN
    RAISE_APPLICATION_ERROR(-20001, 'Brak wolnych miejsc na wycieczkę');
  END IF;
END;
/

-- Trigger obsługujący zmianę statusu
CREATE OR REPLACE TRIGGER tr_modify_reservation_status_5
BEFORE UPDATE OF status ON reservation
FOR EACH ROW
DECLARE
  v_max_no_places NUMBER;
  v_reserved_places NUMBER;
BEGIN
  IF :old.status = 'C' AND :new.status = 'N' THEN
    SELECT max_no_places INTO v_max_no_places FROM trip WHERE trip_id = :new.trip_id;
    SELECT COUNT(*) INTO v_reserved_places FROM reservation WHERE trip_id = :new.trip_id AND status IN ('N', 'P');

    IF v_max_no_places <= v_reserved_places THEN
      RAISE_APPLICATION_ERROR(-20002, 'Brak wolnych miejsc na wycieczkę');
    END IF;
  END IF;
END;
/
