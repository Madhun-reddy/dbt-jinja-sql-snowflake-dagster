{{
  config(
    materialized = 'incremental',
    on_schema_change = 'fail' 
    )
}}

with src_reviews as (
    SELECT * FROM {{ ref('src_reviews') }}
)
select 
    {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id
    ,*
from src_reviews
where review_text is not null
{% if is_incremental() %} 
    {% if var("start_time", false) and var("end_time", false) %}
        {{ log('Loading ' ~ this ~ ' incrementally (start_time: ' ~ var("start_time") ~ ', end_time: ' ~ var("end_time") ~ ')', info=True) }}        
        AND review_date >= '{{ var("start_time") }}'
        AND review_date < '{{ var("end_time") }}'
    {% else %}
        AND review_date > (select max(review_date) from {{this}} )       
        {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info=True)}}
    {% endif %} 
{% endif %}