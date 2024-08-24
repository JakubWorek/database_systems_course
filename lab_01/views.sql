CREATE VIEW vw_reservation AS
SELECT
    reservation_id,
    country,
    trip_date,
    trip_name,
    firstname,
    lastname,
    status,
    RESERVATION.trip_id,
    RESERVATION.person_id
FROM RESERVATION
JOIN TRIP ON RESERVATION.trip_id = TRIP.trip_id
JOIN PERSON ON RESERVATION.person_id = PERSON.person_id;

CREATE VIEW vw_trip AS
SELECT
    t.trip_id,
    t.country,
    t.trip_date,
    t.trip_name,
    t.max_no_places,
    (t.max_no_places - COUNT(r.status)) AS no_available_places
FROM
    trip t
LEFT JOIN
    reservation r ON t.trip_id = r.trip_id AND r.status IN ('N', 'P')
GROUP BY
    t.trip_id, t.country, t.trip_date, t.trip_name, t.max_no_places;

CREATE VIEW vw_available_trip AS
SELECT
    t.trip_id,
    t.country,
    t.trip_date,
    t.trip_name,
    t.max_no_places,
    (t.max_no_places - COUNT(r.status)) AS no_available_places
FROM
    trip t
LEFT JOIN
    reservation r ON t.trip_id = r.trip_id AND r.status IN ('N', 'P')
WHERE
    t.trip_date > CURRENT_DATE
GROUP BY
    t.trip_id, t.country, t.trip_date, t.trip_name, t.max_no_places
HAVING
    (t.max_no_places - COUNT(r.status)) > 0;


