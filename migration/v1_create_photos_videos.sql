create type publish_places as enum ('story', 'gallery');


create table photos
(
    id          serial
        constraint photos_id_pk
            primary key,
    link        text not null,
    created_at  timestamp     default now(),
    owner_id    int  not null
        references users (id),
    publish_in  publish_places,
    likes_count int  not null default 0
);

create view view_photos as
select p.id           as photo_id,
       link           as photo_link,
       owner_id,
       likes_count,
       u.id           as user_id,
       u.display_name as user_display_name
from photos p
         join users u on p.owner_id = u.id;


create table videos
(
    id           serial
        constraint videos_id_pk
            primary key,
    link         text not null,
    preview_link text not null,
    created_at   timestamp     default now(),

    owner_id     int  not null
        references users (id),
    text         text,
    publish_in   publish_places,
    likes_count  int  not null default 0
);

create view view_videos as
select v.id           as video_id,
       link           as video_link,
       preview_link,
       owner_id,
       likes_count,
       text,
       u.id           as user_id,
       u.display_name as user_display_name
from videos v
         join users u on v.owner_id = u.id;
