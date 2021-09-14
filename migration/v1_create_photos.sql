create table  photos
(
    id           serial primary key
        constraint photos_id_pk,
    link         text not null,
    created_at   time_stamp default now(),
    owner_id    int  not null
        references user (id),
    publish_in text not null,
    publisher text not null,
    check ( publish_in = 'story' or publish_in = 'gallery'),
    check ( publisher = 'group' or publisher = 'person')
)