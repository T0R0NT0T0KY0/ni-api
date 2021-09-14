create table comments
(
    id          serial primary key
        constraint comments_id_pk,
    owner_id    int     not null
        references user (id),
    object_type text    not null,
    object_id   integer not null,
    text        text,
    check ( object_type = 'photo' or object_type = 'video' or object_type = 'discussion')
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
