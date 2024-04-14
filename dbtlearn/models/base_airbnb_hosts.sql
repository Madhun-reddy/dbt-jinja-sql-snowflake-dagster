with source as (
      select * from {{ source('airbnb', 'hosts') }}
),
renamed as (
    select
        {{ adapter.quote("ID") }},
        {{ adapter.quote("NAME") }},
        {{ adapter.quote("IS_SUPERHOST") }},
        {{ adapter.quote("CREATED_AT") }},
        {{ adapter.quote("UPDATED_AT") }}

    from source
)
select * from renamed
  