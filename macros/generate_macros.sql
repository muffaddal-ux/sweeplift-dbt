{% macro extract_linkedin_id(column_name) %}
    CAST(SPLIT({{ column_name }}, ':')[SAFE_OFFSET(3)] AS INT64)
{% endmacro %}