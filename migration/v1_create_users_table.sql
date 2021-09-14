create table users
(
    id           serial not null primary key
        constraint users_id_pk,
    name         text   not null,
    display_name text   not null
        constraint users_display_name_unique
            unique,
    country_id   integer
        constraint users_country_id_fkey,
    phone text not null
    unique,
    email text not null
    unique
)