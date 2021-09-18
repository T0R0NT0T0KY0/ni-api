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