with src_creatives as (select * from {{ source("LinkedIn_Ads", "creatives") }})

select
    {{ extract_linkedin_id('Id') }} as creative_id,
    name as creative_name,
    {{ extract_linkedin_id('account') }} as account_id,
    {{ extract_linkedin_id('campaign') }} as campaign_id

from src_creatives
