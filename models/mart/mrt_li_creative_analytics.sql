select
    date,
    account_id,
    account_name,
    creative_id,
    creative_name,
    campaign_id,
    campaign_name,
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

    from {{ref("fct_li_creative_analytics")}}
    where campaign_name like '%host:Sweeplift%'