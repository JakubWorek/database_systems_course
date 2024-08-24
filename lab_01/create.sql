create sequence s_person_seq
 start with 1
 increment by 1;
create table person
(
 person_id int not null
 constraint pk_person
 primary key,
 firstname varchar(50),
 lastname varchar(50)
)
alter table person
 modify person_id int default s_person_seq.nextval;

create sequence s_trip_seq
 start with 1
 increment by 1;
create table trip
(
 trip_id int not null
 constraint pk_trip
 primary key,
 trip_name varchar(100),
 country varchar(50),
 trip_date date,
 max_no_places int
);
alter table trip
 modify trip_id int default s_trip_seq.nextval;

create sequence s_reservation_seq
 start with 1
 increment by 1;
create table reservation
(
 reservation_id int not null
 constraint pk_reservation
 primary key,
 trip_id int,
 person_id int,
 status char(1)
);
alter table reservation
 modify reservation_id int default s_reservation_seq.nextval;
alter table reservation
add constraint reservation_fk1 foreign key
( person_id ) references person ( person_id );

alter table reservation
add constraint reservation_fk2 foreign key
( trip_id ) references trip ( trip_id );

alter table reservation
add constraint reservation_chk1 check
(status in ('N','P','C'));

create sequence s_log_seq
 start with 1
 increment by 1;
create table log
(
 log_id int not null
 constraint pk_log
 primary key,
 reservation_id int not null,
 log_date date not null,
 status char(1)
);
alter table log
 modify log_id int default s_log_seq.nextval;

alter table log
add constraint log_chk1 check
(status in ('N','P','C')) enable;

alter table log
add constraint log_fk1 foreign key
( reservation_id ) references reservation ( reservation_id );
