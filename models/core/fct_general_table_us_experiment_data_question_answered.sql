select
    date,
    campaign_id_extracted,
    coalesce(creative_id, creat_id) as creative_id,
    (
        select param.scalar_value 
        from unnest(event_data) as param 
        where param.key = 'question_type'
    ) as question_type,
    (
        select param.scalar_value 
        from unnest(event_data) as param 
        where param.key = 'question_text'
    ) as question_text,
    (
        select param.scalar_value 
        from unnest(event_data) as param 
        where param.key = 'question_number'
    ) as question_number,
    (
        select param.scalar_value 
        from unnest(event_data) as param 
        where param.key = 'question_tags'
    ) as question_tags,
    (
        select param.scalar_value 
        from unnest(event_data) as param 
        where param.key = 'answer_text'
    ) as answer_text,
    (
        select param.scalar_value 
        from unnest(event_data) as param 
        where param.key = 'lift_type'
    ) as lift_type,
    (
        select param.value_type 
        from unnest(event_data) as param 
        where param.key = 'question_type'
    ) as question_type_value_type

from {{ ref("stg_general_tab_us_experiment_data") }}
where event_name = 'question_answered'