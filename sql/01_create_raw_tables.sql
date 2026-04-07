-- Drop tables if they already exist 
drop table if exists facebook_ads_raw;
drop table if exists google_ads_raw;
drop table if exists tiktok_ads_raw;

-- Facebook raw table
create table facebook_ads_raw (
    date date,
    campaign_id text,
    campaign_name text,
    ad_set_id text,
    ad_set_name text,
    impressions integer,
    clicks integer,
    spend numeric(12,2),
    conversions integer,
    video_views integer,
    engagement_rate numeric(10,4),
    reach integer,
    frequency numeric(10,2)
);

-- Google Ads raw table
create table google_ads_raw (
    date date,
    campaign_id text,
    campaign_name text,
    ad_group_id text,
    ad_group_name text,
    impressions integer,
    clicks integer,
    cost numeric(12,2),
    conversions integer,
    conversion_value numeric(12,2),
    ctr numeric(10,4),
    avg_cpc numeric(12,2),
    quality_score integer,
    search_impression_share numeric(10,4)
);

-- TikTok raw table
create table tiktok_ads_raw (
    date date,
    campaign_id text,
    campaign_name text,
    adgroup_id text,
    adgroup_name text,
    impressions integer,
    clicks integer,
    cost numeric(12,2),
    conversions integer,
    video_views integer,
    video_watch_25 integer,
    video_watch_50 integer,
    video_watch_75 integer,
    video_watch_100 integer,
    likes integer,
    shares integer,
    comments integer
);