-- Definicja typów na poziomie bazy danych
CREATE OR REPLACE TYPE t_reservation AS OBJECT (
  reservation_id INT,
  trip_id INT,
  person_id INT,
  status CHAR
);

CREATE OR REPLACE TYPE t_reservation_tab AS TABLE OF t_reservation;


-- Funkcja zwracająca listę uczestników wskazanej wycieczki
CREATE OR REPLACE FUNCTION f_trip_participants(p_trip_id INT)
RETURN t_reservation_tab PIPELINED AS
BEGIN
  FOR r IN (SELECT * FROM reservation WHERE trip_id = p_trip_id) LOOP
    PIPE ROW(t_reservation(r.reservation_id, r.trip_id, r.person_id, r.status));
  END LOOP;
  RETURN;
END;


-- Funkcja zwracająca listę rezerwacji danej osoby
CREATE OR REPLACE FUNCTION f_person_reservations(p_person_id INT)
RETURN t_reservation_tab PIPELINED AS
BEGIN
  FOR r IN (SELECT * FROM reservation WHERE person_id = p_person_id) LOOP
    PIPE ROW(t_reservation(r.reservation_id, r.trip_id, r.person_id, r.status));
  END LOOP;
  RETURN;
END;


-- Funkcja zwracająca listę wycieczek do wskazanego kraju, dostępnych w zadanym okresie czasu
CREATE OR REPLACE FUNCTION f_available_trips_to(p_country VARCHAR2, p_date_from DATE, p_date_to DATE)
RETURN SYS_REFCURSOR AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT * FROM trip
  WHERE country = p_country AND trip_date BETWEEN p_date_from AND p_date_to;
  RETURN v_cursor;
END;

-- test funkcji
select * from table(f_person_reservations(1))

