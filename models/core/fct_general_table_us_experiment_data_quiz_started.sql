with
    src_quiz_started as (
        select
            date, campaign_id_extracted, coalesce(creative_id, creat_id) as creative_id,

        from {{ ref("stg_general_tab_us_experiment_data") }}
        where event_name = 'quiz_started'
    )

select date, campaign_id_extracted, creative_id, count(*) as quiz_started

from src_quiz_started
group by date, campaign_id_extracted, creative_id