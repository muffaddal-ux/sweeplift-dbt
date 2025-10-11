with
    src_leads as (
        select
            date, campaign_id_extracted, coalesce(creative_id, creat_id) as creative_id,

        from {{ ref("stg_general_tab_us_experiment_data") }}
        where event_name = 'information_submitted'
    )

select date, campaign_id_extracted, creative_id, count(*) as leads_generated

from src_leads
group by date, campaign_id_extracted, creative_id
