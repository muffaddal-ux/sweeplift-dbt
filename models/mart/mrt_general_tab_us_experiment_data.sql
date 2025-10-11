with
    leads as (
        select date, campaign_id_extracted, creative_id, leads_generated
        from {{ ref("fct_general_table_us_experiment_data_leads") }}
    ),

    pages as (
        select date, campaign_id_extracted, creative_id, page_views
        from {{ ref("fct_general_table_us_experiment_data_page_view") }}
    ),

    quiz as (
        select date, campaign_id_extracted, creative_id, quiz_started
        from {{ ref("fct_general_table_us_experiment_data_quiz_started") }}
    ),

    data_join as (
        select
            coalesce(pg.date, le.date, qz.date) as date,
            coalesce(
                pg.campaign_id_extracted,
                le.campaign_id_extracted,
                qz.campaign_id_extracted
            ) as campaign_id,
            coalesce(pg.creative_id, le.creative_id, qz.creative_id) as creative_id,
            leads_generated,
            page_views,
            quiz_started

        from pages as pg
        full join leads as le on (le.date = pg.date and le.creative_id = pg.creative_id)
        full join quiz as qz on (pg.date = qz.date and pg.creative_id = qz.creative_id)
    ),

    sweeplift_camps as (
        select distinct campaign_id

        from {{ ref("fct_li_creative_analytics") }}
        where campaign_name like '%host:Sweeplift%'
    )

select date, dj.campaign_id, creative_id, leads_generated, page_views, quiz_started

from data_join as dj
inner join
    sweeplift_camps as sc
    on safe_cast(dj.campaign_id as int64) = safe_cast(sc.campaign_id as int64)
