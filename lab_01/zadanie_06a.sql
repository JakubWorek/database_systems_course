-- Procedura p_add_reservation_6a
CREATE OR REPLACE PROCEDURE p_add_reservation_6a(p_trip_id IN NUMBER, p_person_id IN NUMBER) AS
  v_max_no_places NUMBER;
BEGIN
  SELECT no_available_places INTO v_max_no_places FROM trip WHERE trip_id = p_trip_id;

  IF v_max_no_places <= 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Brak wolnych miejsc na wycieczkę');
  END IF;

  INSERT INTO reservation (trip_id, person_id, status) VALUES (p_trip_id, p_person_id, 'N');
  UPDATE trip SET no_available_places = v_max_no_places - 1 WHERE trip_id = p_trip_id;

  INSERT INTO log (reservation_id, log_date, status) VALUES (s_reservation_seq.currval, SYSDATE, 'N');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, 'Nie znaleziono wycieczki');
END;
/

-- Procedura p_modify_reservation_status_6a
CREATE OR REPLACE PROCEDURE p_modify_reservation_status_6a(p_reservation_id IN NUMBER, p_status IN CHAR) AS
  v_status CHAR(1);
  v_trip_id NUMBER;
  v_max_no_places NUMBER;
BEGIN
  SELECT status, trip_id INTO v_status, v_trip_id FROM reservation WHERE reservation_id = p_reservation_id;

  IF v_status != 'C' AND p_status = 'C' THEN
    SELECT no_available_places INTO v_max_no_places FROM trip WHERE trip_id = v_trip_id;
    UPDATE trip SET no_available_places = v_max_no_places + 1 WHERE trip_id = v_trip_id;
  ELSIF v_status = 'C' AND p_status != 'C' THEN
    SELECT no_available_places INTO v_max_no_places FROM trip WHERE trip_id = v_trip_id;

    IF v_max_no_places <= 0 THEN
      RAISE_APPLICATION_ERROR(-20003, 'Brak wolnych miejsc na wycieczkę');
    END IF;

    UPDATE trip SET no_available_places = v_max_no_places - 1 WHERE trip_id = v_trip_id;
  END IF;

  UPDATE reservation SET status = p_status WHERE reservation_id = p_reservation_id;

  INSERT INTO log (reservation_id, log_date, status) VALUES (p_reservation_id, SYSDATE, p_status);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20004, 'Nie znaleziono rezerwacji');
END;
/

--ALTER TRIGGER tr_add_reservation_6_before_insert DISABLE;
--ALTER TRIGGER tr_add_reservation_6_after_insert DISABLE;
--ALTER TRIGGER tr_modify_reservation_status_6_before_update DISABLE;
--ALTER TRIGGER tr_modify_reservation_status_6_after_update DISABLE;

-- Widok vw_trip
CREATE OR REPLACE VIEW vw_trip_6a AS
SELECT
    trip_id,
    country,
    trip_date,
    trip_name,
    max_no_places,
    no_available_places
FROM
    trip;

-- Widok vw_available_trip
CREATE OR REPLACE VIEW vw_available_trip_6a AS
SELECT
    trip_id,
    country,
    trip_date,
    trip_name,
    max_no_places,
    no_available_places
FROM
    trip
WHERE
    trip_date > CURRENT_DATE AND no_available_places > 0;