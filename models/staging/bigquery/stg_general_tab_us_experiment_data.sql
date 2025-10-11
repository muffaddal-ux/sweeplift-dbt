with src_source as (select * from {{ source("General_Table_US", "experiment_data") }})

select
    *,
    date(utc_datetime) as date,
    regexp_extract(page_url, r'hsa_grp=([^&]+)') as campaign_id_extracted,
    regexp_extract(page_url, r'camp_id=([^&]+)') as camp_id,
    regexp_extract(page_url, r'hsa_ad=([^&]+)') as creative_id,
    regexp_extract(page_url, r'creat_id=([^&]+)') as creat_id,
    regexp_extract(page_url, r'AdCampaignId=([^&]+)') as adcampaignid

from src_source
