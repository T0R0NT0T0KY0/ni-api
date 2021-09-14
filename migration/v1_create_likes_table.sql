create table likes
(
    id          serial primary key
        constraint likes_id_pk,
    owner_id    int  not null
        references user (id),
    object_type text not null,
    object_id integer not null,
    check ( object_type = 'photo' or object_type = 'video' or object_type = 'comment')
);
CREATE INDEX ON likes (object_type,object_id);

create view view_likes as
select  l.id as like_id,
        l.object_type,
        l.object_id,
        l.owner_id,
        u.name,
        u.display_name
from likes l
         join users u on l.owner_id = u.id;
