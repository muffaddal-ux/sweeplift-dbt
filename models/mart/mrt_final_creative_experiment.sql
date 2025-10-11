with
    creative_data as (
        select
            date,
            account_id,
            account_name,
            creative_id,
            creative_name,
            campaign_id,
            campaign_name,
            total_engagements,
            impressions,
            clicks,
            cost_usd,
            cost_local

        from {{ ref("mrt_li_creative_analytics") }}
    ),

    experiments as (
        select
            date,
            campaign_id,
            creative_id,
            sum(leads_generated) as leads_generated,
            sum(page_views) as page_views,
            sum(quiz_started) as quiz_started

        from {{ ref("mrt_general_tab_us_experiment_data") }}
        group by date, campaign_id, creative_id
    )

select
    coalesce(cd.date,ex.date) as date,
    account_id,
    account_name,
    coalesce(safe_cast(cd.creative_id as int64),safe_cast(ex.creative_id as int64)) as creative_id,
    creative_name,
    coalesce(safe_cast(cd.campaign_id as int64),safe_cast(ex.campaign_id as int64)) as campaign_id,
    campaign_name,
    total_engagements,
    impressions,
    clicks,
    cost_usd,
    cost_local,
    leads_generated,
    quiz_started,
    page_views

from creative_data as cd
full join
    experiments as ex
    on (
        cd.date = ex.date
        and safe_cast(cd.campaign_id as int64) = safe_cast(ex.campaign_id as int64)
        and safe_cast(cd.creative_id as int64) = safe_cast(ex.creative_id as int64)
    )
