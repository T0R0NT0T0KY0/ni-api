create type world_parts as enum ('australia', 'asia', 'america', 'antarctica', 'africa', 'europe');


create table countries
(
    id serial
        constraint countries_id_pk
            primary key,
    name text not null,
    iso_id int not null unique,
    world_part world_parts
);


create table cities
(
    id         serial
        constraint cities_id_pk
            primary key,
    name       text not null,
    country_id int  not null
        references countries(id),
    unique (name, country_id)
);

create view view_cities as
 select ci.id as city_id,
        ci.name as city,
        co.name as country,
        co.world_part as world_part,
        co.iso_id as iso_id
from cities ci
join countries co on ci.country_id = co.id