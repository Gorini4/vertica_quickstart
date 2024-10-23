select * from projections where projection_schema != 'SBX';

create external table if not exists athlete_external (
    ID int,
    Name varchar(255),
    Sex varchar(1),
    Age int,
    Height int,
    Weight int,
    Team varchar(255),
    NOC varchar(255),
    Games varchar(255),
    Year int,
    Season varchar(255),
    City varchar(255),
    Sport varchar(255),
    Event varchar(255),
    Medal varchar(255)
) as copy from '/tmp/input/athlete.snappy.parquet' parquet;


select * from athlete_external limit 100;

create table athlete1 as select * from athlete_external;
select * from storage_containers;

select * from athlete1;

explain select * from athlete1 a1 join athlete1 a2 on a1.Name = a2.Name;

-- create table athlete2 as select * from athlete_external;

create table athlete2 (
    ID int,
    Name varchar(255),
    Sex varchar(1),
    Age int,
    Height int,
    Weight int,
    Team varchar(255),
    NOC varchar(255),
    Games varchar(255),
    Year int,
    Season varchar(255),
    City varchar(255),
    Sport varchar(255),
    Event varchar(255),
    Medal varchar(255))
order by Name
segmented by hash(ID) all nodes;

insert into athlete2 select * from athlete1;

explain select * from athlete2 a1 join athlete2 a2 on a1.Name = a2.Name;

explain select * from athlete1 a1 join athlete1 a2 on a1.Games = a2.Games;

explain select * from athlete2 a1 join athlete2 a2 on a1.Games = a2.Games;

create projection athlete2_games as select * from athlete2 order by Games;
select start_refresh();
select refresh('athlete2');

drop table athlete_external;
drop table athlete1;
drop table athlete2 cascade;