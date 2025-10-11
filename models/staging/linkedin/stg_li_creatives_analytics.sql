with
    src_campaigns as (
        select * from {{ source("LinkedIn_Ads", "ad_creative_analytics") }}
    )

select
    end_date as date,
    shares,
    comments,
    reactions,
    totalengagements as total_engagements,
    companypageclicks as company_page_clicks,
    landingpageclicks as landing_page_clicks,
    externalwebsiteconversions as website_conversions,
    externalwebsitepostviewconversions as website_post_view_conversions,
    externalwebsitepostclickconversions as website_post_click_conversions,
    impressions,
    clicks,
    costinusd as cost_usd,
    costinlocalcurrency as cost_local,
    sponsoredCreative as creative_id,
    talentleads as talent_leads,
    oneclickleads as one_click_leads,
    viraloneclickleads as viral_one_click_leads,
    validworkemailleads as valid_work_email_leads,
    oneclickleadformopens as one_click_lead_form_opens

from src_campaigns
