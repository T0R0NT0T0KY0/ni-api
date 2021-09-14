create table videos
(
    id           serial primary key
        constraint videos_id_pk,
    link         text not null,
    preview_link text not null,
    created_at   time_stamp default now(),

    owner_id    int  not null
        references user (id),
    publish_in text not null,
    publisher text not null,
    text text,
    check ( publish_in = 'story' or publish_in = 'gallery'),
    check ( publisher = 'group' or publisher = 'person')
)
