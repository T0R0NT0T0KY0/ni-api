create type object_types_like as enum ('photo', 'video', 'comment');

create table likes
(
    id          serial
        constraint likes_id_pk
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
