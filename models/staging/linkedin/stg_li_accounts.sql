with src_accounts as (select * from {{ source("LinkedIn_Ads", "accounts") }})

select
    id as account_id,
    name as account_name,
    type as account_type,
    status,
    date(created) as account_created_at,
    currency

from src_accounts
