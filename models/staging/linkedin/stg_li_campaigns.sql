with src_campaigns as (select * from {{ source("LinkedIn_Ads", "campaigns") }})

select
    id as campaign_id,
    name as campaign_name,
    status as campaign_status,
    cast(split(account, ':')[safe_offset(3)] as int64) as account_id,
    cast(split(campaigngroup, ':')[safe_offset(3)] as int64) as campaign_group_id,
    objectivetype as campaign_objective,

from src_campaigns
