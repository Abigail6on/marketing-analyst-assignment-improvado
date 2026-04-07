drop view if exists ads_performance_reporting;

create view ads_performance_reporting as
select
    date,
    platform,
    campaign_id,
    campaign_name,
    ad_group_id,
    ad_group_name,
    impressions,
    clicks,
    spend,
    conversions,
    conversion_value,
    ctr,
    avg_cpc,
    engagement_rate,
    reach,
    frequency,
    quality_score,
    search_impression_share,
    video_views,
    video_watch_25,
    video_watch_50,
    video_watch_75,
    video_watch_100,
    likes,
    shares,
    comments,

    -- Calculated KPIs for consistent cross-channel reporting
    round(clicks::numeric / nullif(impressions, 0), 4) as calc_ctr,
    round(spend / nullif(clicks, 0), 2) as calc_cpc,
    round(spend / nullif(conversions, 0), 2) as calc_cpa

from ads_performance_unified;