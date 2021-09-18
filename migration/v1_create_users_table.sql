create table users
(
    id           serial not null
        constraint users_id_pk
            primary key,
    name         text   not null,
    display_name text   not null
        constraint usersx_display_name_unique
            unique,
    country_id integer references cities(id),
    phone        text   not null
        unique,
    email        text   not null unique
);

