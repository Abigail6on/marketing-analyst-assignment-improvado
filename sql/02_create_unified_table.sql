drop table if exists ads_performance_unified;

create table ads_performance_unified as

select
    date,
    'facebook' as platform,
    campaign_id,
    campaign_name,
    ad_set_id as ad_group_id,
    ad_set_name as ad_group_name,
    impressions,
    clicks,
    spend,
    conversions,
    cast(null as numeric(12,2)) as conversion_value,
    cast(null as numeric(10,4)) as ctr,
    cast(null as numeric(12,2)) as avg_cpc,
    engagement_rate,
    reach,
    frequency,
    cast(null as integer) as quality_score,
    cast(null as numeric(10,4)) as search_impression_share,
    video_views,
    cast(null as integer) as video_watch_25,
    cast(null as integer) as video_watch_50,
    cast(null as integer) as video_watch_75,
    cast(null as integer) as video_watch_100,
    cast(null as integer) as likes,
    cast(null as integer) as shares,
    cast(null as integer) as comments
from facebook_ads_raw

union all

select
    date,
    'google' as platform,
    campaign_id,
    campaign_name,
    ad_group_id,
    ad_group_name,
    impressions,
    clicks,
    cost as spend,
    conversions,
    conversion_value,
    ctr,
    avg_cpc,
    cast(null as numeric(10,4)) as engagement_rate,
    cast(null as integer) as reach,
    cast(null as numeric(10,2)) as frequency,
    quality_score,
    search_impression_share,
    cast(null as integer) as video_views,
    cast(null as integer) as video_watch_25,
    cast(null as integer) as video_watch_50,
    cast(null as integer) as video_watch_75,
    cast(null as integer) as video_watch_100,
    cast(null as integer) as likes,
    cast(null as integer) as shares,
    cast(null as integer) as comments
from google_ads_raw

union all

select
    date,
    'tiktok' as platform,
    campaign_id,
    campaign_name,
    adgroup_id as ad_group_id,
    adgroup_name as ad_group_name,
    impressions,
    clicks,
    cost as spend,
    conversions,
    cast(null as numeric(12,2)) as conversion_value,
    cast(null as numeric(10,4)) as ctr,
    cast(null as numeric(12,2)) as avg_cpc,
    cast(null as numeric(10,4)) as engagement_rate,
    cast(null as integer) as reach,
    cast(null as numeric(10,2)) as frequency,
    cast(null as integer) as quality_score,
    cast(null as numeric(10,4)) as search_impression_share,
    video_views,
    video_watch_25,
    video_watch_50,
    video_watch_75,
    video_watch_100,
    likes,
    shares,
    comments
from tiktok_ads_raw;