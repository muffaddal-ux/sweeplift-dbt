with
    src_page_views as (
        select
            date, campaign_id_extracted, coalesce(creative_id, creat_id) as creative_id,

        from {{ ref("stg_general_tab_us_experiment_data") }}
        where event_name like '%page_viewed%'
    )

select date, campaign_id_extracted, creative_id, count(*) as page_views

from src_page_views
group by date, campaign_id_extracted, creative_id