create database market;

create table users
(
    id       integer generated always as identity
        primary key,
    username text not null
);

create table user_email
(
    user_id integer references users,
    email   text not null
        unique
        constraint users_email check ( email )
);

create table shop
(

    id        integer generated always as identity
        primary key,
    shop_name text    not null,
    is_work   boolean not null default true
);

create unique index shop_name_index on shop (shop_name) where is_work = true;

create table workers
(
    id      integer generated always as identity
        primary key,
    user_id integer references users,
    shop_id integer references shop
);
create unique index shop_worker on workers (user_id, shop_id) where (select is_work
                                                                     from shop) = true;

create table cities
(

    id      integer generated always as identity
        primary key,
    name    text not null,
    country text not null
);
create unique index city_name_country_index on cities (name, country);



create table shop_information
(
    shop_id integer not null references shop,
    city_id integer not null references cities,
    about   text
);

create table shop_geo_position
(
    shop_id    integer   not null
        references shop,
    latitude   float8    not null,
    longitude  float8    not null,
    updated_at timestamp not null default now(),
    created_at timestamp not null default now()
);

create view view_shop_workers (shop_id, shop_name, is_work, workers) as
select s.id      as shop_id,
       shop_name,
       is_work,
       case
           when is_work = true then coalesce(
                   (json_agg(json_build_object('worker_id', w.id, 'worker_user_id', user_id))),
                   '[]'::json)
           end as workers
from shop s
         left join workers w on s.id = w.shop_id
group by s.id, shop_name, is_work;


create view view_shop_cities (city_id, city_name, shops) as
select c.id   as city_id,
       c.name as city_name,
       json_agg(json_build_object('shop_id', s.id, 'is_work', s.is_work, 'name', s.shop_name, 'about', si.about))
from shop s
         join shop_information si on s.id = si.shop_id
         right join cities c on si.city_id = c.id
group by c.id, c.name;

create table articles
(
    id   integer generated always as identity
        primary key,
    name text not null
);

create table shop_articles
(

    id         integer generated always as identity
        primary key,
    shop_id    integer references shop,
    article_id integer references articles
);

create table shop_articles_information
(
    id    integer references shop_articles,
    cost  float8 not null,
    count float8 not null,
    constraint shop_articles_information check ( cost > 0 )
);

create view view_shops_articles
            (article_id, article_name, shop_id, article_cost, article_count, shop_name, shop_is_work, shop_latitude,
             shop_longitude, shop_city_id, shop_city_name, shop_country)
as
select a.id as article_id,
       a.name as article_name,
       sa.shop_id,
       sai.cost,
       sai.count,
       s.shop_name,
       s.is_work,
       sgp.latitude,
       sgp.longitude,
       si.city_id,
       c.name,
       c.country
from articles a
         full join shop_articles sa on a.id = sa.article_id
         left join shop_articles_information sai on sa.id = sai.id
         left join shop s on s.id = sa.shop_id
         left join shop_geo_position sgp on s.id = sgp.shop_id
         left join shop_information si on s.id = si.shop_id
         left join cities c on si.city_id = c.id;

