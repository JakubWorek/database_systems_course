-- Procedura p_add_reservation
CREATE OR REPLACE PROCEDURE p_add_reservation(p_trip_id IN NUMBER, p_person_id IN NUMBER) AS
  v_max_no_places NUMBER;
  v_reserved_places NUMBER;
BEGIN
  SELECT max_no_places INTO v_max_no_places FROM trip WHERE trip_id = p_trip_id;
  SELECT COUNT(*) INTO v_reserved_places FROM reservation WHERE trip_id = p_trip_id AND status IN ('N', 'P');

  IF v_max_no_places > v_reserved_places THEN
    INSERT INTO reservation (trip_id, person_id, status) VALUES (p_trip_id, p_person_id, 'N');
    INSERT INTO log (reservation_id, log_date, status) VALUES (s_reservation_seq.currval, SYSDATE, 'N');
  ELSE
    RAISE_APPLICATION_ERROR(-20001, 'Brak wolnych miejsc na wycieczkę');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, 'Nie znaleziono wycieczki');
END;
/

-- Procedura p_modify_reservation_status
CREATE OR REPLACE PROCEDURE p_modify_reservation_status(p_reservation_id IN NUMBER, p_status IN CHAR) AS
  v_status CHAR(1);
BEGIN
  SELECT status INTO v_status FROM reservation WHERE reservation_id = p_reservation_id;

  IF v_status != 'C' OR (v_status = 'C' AND p_status != 'N') THEN
    UPDATE reservation SET status = p_status WHERE reservation_id = p_reservation_id;
    INSERT INTO log (reservation_id, log_date, status) VALUES (p_reservation_id, SYSDATE, p_status);
  ELSE
    RAISE_APPLICATION_ERROR(-20003, 'Nie można zmienić statusu anulowanej rezerwacji');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20004, 'Nie znaleziono rezerwacji');
END;
/

-- Procedura p_modify_max_no_places
CREATE OR REPLACE PROCEDURE p_modify_max_no_places(p_trip_id IN NUMBER, p_max_no_places IN NUMBER) AS
  v_reserved_places NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_reserved_places FROM reservation WHERE trip_id = p_trip_id AND status IN ('N', 'P');

  IF p_max_no_places >= v_reserved_places THEN
    UPDATE trip SET max_no_places = p_max_no_places WHERE trip_id = p_trip_id;
  ELSE
    RAISE_APPLICATION_ERROR(-20005, 'Nie można zmniejszyć liczby miejsc poniżej liczby zarezerwowanych miejsc');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20006, 'Nie znaleziono wycieczki');
END;
/

-- Procedura p_add_reservation_4
CREATE OR REPLACE PROCEDURE p_add_reservation_4(p_trip_id IN NUMBER, p_person_id IN NUMBER) AS
  v_max_no_places NUMBER;
  v_reserved_places NUMBER;
BEGIN
  SELECT max_no_places INTO v_max_no_places FROM trip WHERE trip_id = p_trip_id;
  SELECT COUNT(*) INTO v_reserved_places FROM reservation WHERE trip_id = p_trip_id AND status IN ('N', 'P');

  IF v_max_no_places > v_reserved_places THEN
    INSERT INTO reservation (trip_id, person_id, status) VALUES (p_trip_id, p_person_id, 'N');
  ELSE
    RAISE_APPLICATION_ERROR(-20001, 'Brak wolnych miejsc na wycieczkę');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, 'Nie znaleziono wycieczki');
END;
/

-- Procedura p_modify_reservation_status_4
CREATE OR REPLACE PROCEDURE p_modify_reservation_status_4(p_reservation_id IN NUMBER, p_status IN CHAR) AS
  v_status CHAR(1);
BEGIN
  SELECT status INTO v_status FROM reservation WHERE reservation_id = p_reservation_id;

  IF v_status != 'C' OR (v_status = 'C' AND p_status != 'N') THEN
    UPDATE reservation SET status = p_status WHERE reservation_id = p_reservation_id;
  ELSE
    RAISE_APPLICATION_ERROR(-20003, 'Nie można zmienić statusu anulowanej rezerwacji');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20004, 'Nie znaleziono rezerwacji');
END;
/

-- Procedura p_add_reservation_5
CREATE OR REPLACE PROCEDURE p_add_reservation_5(p_trip_id IN NUMBER, p_person_id IN NUMBER) AS
BEGIN
  INSERT INTO reservation (trip_id, person_id, status) VALUES (p_trip_id, p_person_id, 'N');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20003, 'Nie znaleziono wycieczki');
END;
/

-- Procedura p_modify_reservation_status_5
CREATE OR REPLACE PROCEDURE p_modify_reservation_status_5(p_reservation_id IN NUMBER, p_status IN CHAR) AS
BEGIN
  UPDATE reservation SET status = p_status WHERE reservation_id = p_reservation_id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20004, 'Nie znaleziono rezerwacji');
END;
/