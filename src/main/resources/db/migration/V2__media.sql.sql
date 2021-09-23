create type publish_places as enum ('history', 'gallery');

create table photos
(
    id         serial
        primary key,
    link       text not null,
    created_at timestamp default now(),
    owner_id   int  not null
        references users (id),
    publish_in publish_places
);

create view view_photos as
select p.id           as photo_id,
       link           as photo_link,
       owner_id,
       u.id           as user_id,
       u.display_name as user_display_name
from photos p
         join users u on p.owner_id = u.id;


create table videos
(
    id           serial
        primary key,
    link         text not null,
    preview_link text not null,
    created_at   timestamp default now(),

    owner_id     int  not null
        references users (id),
    text         text,
    publish_in   publish_places
);

create view view_videos as
select v.id           as video_id,
       link           as video_link,
       preview_link,
       owner_id,
       text,
       u.id           as user_id,
       u.display_name as user_display_name
from videos v
         join users u on v.owner_id = u.id;


create type object_types_like as enum ('photo', 'video', 'comment');

create table likes
(
    id          serial
        primary key,
    owner_id    int     not null
        references users (id),
    object_id   integer not null,
    object_type object_types_like
);

CREATE INDEX ON likes (object_type, object_id);

create view view_likes as
select l.id as like_id,
       l.object_type,
       l.object_id,
       l.owner_id,
       u.name,
       u.display_name
from likes l
         join users u on l.owner_id = u.id;


create type comment_object_types as enum ('photo', 'video', 'discussion');


create table comments
(
    id          serial
        constraint comments_id_pk
            primary key,
    owner_id    int     not null
        references users (id),
    object_type comment_object_types,
    object_id   integer not null,
    text        text
);

create view view_comments as
select c.id as comment_id,
       c.object_type,
       c.object_id,
       c.owner_id,
       c.text,
       u.name,
       u.display_name
from comments c
         join users u on c.owner_id = u.id;