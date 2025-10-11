with
    creative_analytics as (
        select
            date,
            shares,
            comments,
            reactions,
            total_engagements,
            company_page_clicks,
            landing_page_clicks,
            website_conversions,
            website_post_view_conversions,
            website_post_click_conversions,
            impressions,
            clicks,
            cost_usd,
            cost_local,
            safe_cast(creative_id as int64) as creative_id,
            talent_leads,
            one_click_leads,
            viral_one_click_leads,
            valid_work_email_leads,
            one_click_lead_form_opens

        from {{ ref("stg_li_creatives_analytics") }}
    ),

    creatives as (
        select distinct
            safe_cast(creative_id as int64) as creative_id,
            creative_name,
            safe_cast(account_id as int64) as account_id,
            safe_cast(campaign_id as int64) as campaign_id

        from {{ ref("stg_li_creatives") }}
    ),

    campaigns as (
        select distinct
            safe_cast(campaign_id as int64) as campaign_id,
            campaign_name,
            campaign_objective
        from {{ ref("stg_li_campaigns") }}
    ),

    accounts as (
        select distinct safe_cast(account_id as int64) as account_id, account_name
        from {{ ref("stg_li_accounts") }}
    )

select
    date,
    coalesce(cr.account_id, ac.account_id) as account_id,
    ac.account_name,
    coalesce(cra.creative_id, cr.creative_id) as creative_id,
    cr.creative_name,
    coalesce(cr.campaign_id, camp.campaign_id) as campaign_id,
    camp.campaign_name,
    shares,
    comments,
    reactions,
    total_engagements,
    company_page_clicks,
    landing_page_clicks,
    website_conversions,
    website_post_view_conversions,
    website_post_click_conversions,
    impressions,
    clicks,
    cost_usd,
    cost_local,
    talent_leads,
    one_click_leads,
    viral_one_click_leads,
    valid_work_email_leads,
    one_click_lead_form_opens

from creative_analytics as cra
left join
    creatives as cr
    on safe_cast(cra.creative_id as int64) = safe_cast(cr.creative_id as int64)
left join
    campaigns as camp
    on safe_cast(cr.campaign_id as int64) = safe_cast(camp.campaign_id as int64)
left join
    accounts as ac
    on safe_cast(ac.account_id as int64) = safe_cast(cr.account_id as int64)

    -- Campaign name should contain sweeplift
    
