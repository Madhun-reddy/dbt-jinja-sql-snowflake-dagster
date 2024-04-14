{% macro learn_variables() %}
  
  {% set your_name_jinja = "Madhu N Reddy" %}
  {{ log("Hello " ~ your_name_jinja, info=True) }}
{# (~) we use tilda to concatenate values #}
{# info=True criteria display values in terminal window #}
    {{ log("Hello dbt user " ~ var("user_name","No username is set!!") ~ "!", info=True) }}
{% endmacro %}
