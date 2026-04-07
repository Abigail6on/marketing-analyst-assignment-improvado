-- =========================================================
-- QA CHECKS FOR RAW TABLES, UNIFIED TABLE, AND REPORTING VIEW
-- =========================================================

-- 1. Raw table row counts
select 'facebook_ads_raw' as table_name, count(*) as row_count from facebook_ads_raw
union all
select 'google_ads_raw' as table_name, count(*) as row_count from google_ads_raw
union all
select 'tiktok_ads_raw' as table_name, count(*) as row_count from tiktok_ads_raw;

-- 110 rows in each raw table


-- 2. Unified table total row count
select
    count(*) as unified_row_count
from ads_performance_unified;

-- 330 rows total


-- 3. Unified table row counts by platform
select
    platform,
    count(*) as row_count
from ads_performance_unified
group by platform
order by platform;

-- facebook = 110
-- google   = 110
-- tiktok   = 110


-- 4. Null check for critical fields in unified table
select
    sum(case when date is null then 1 else 0 end) as null_date,
    sum(case when platform is null then 1 else 0 end) as null_platform,
    sum(case when campaign_id is null then 1 else 0 end) as null_campaign_id,
    sum(case when campaign_name is null then 1 else 0 end) as null_campaign_name,
    sum(case when ad_group_id is null then 1 else 0 end) as null_ad_group_id,
    sum(case when ad_group_name is null then 1 else 0 end) as null_ad_group_name,
    sum(case when impressions is null then 1 else 0 end) as null_impressions,
    sum(case when clicks is null then 1 else 0 end) as null_clicks,
    sum(case when spend is null then 1 else 0 end) as null_spend,
    sum(case when conversions is null then 1 else 0 end) as null_conversions
from ads_performance_unified;

-- all zeros


-- 5. Check for negative values in key metrics
select
    sum(case when impressions < 0 then 1 else 0 end) as negative_impressions,
    sum(case when clicks < 0 then 1 else 0 end) as negative_clicks,
    sum(case when spend < 0 then 1 else 0 end) as negative_spend,
    sum(case when conversions < 0 then 1 else 0 end) as negative_conversions
from ads_performance_unified;

-- all zeros


-- 6. Check date range
select
    min(date) as min_date,
    max(date) as max_date
from ads_performance_unified;

-- valid reporting range with no parsing issues


-- 7. Validate distinct platforms
select distinct
    platform
from ads_performance_unified
order by platform;

-- facebook
-- google
-- tiktok


-- 8. Check duplicate grain in unified table
-- Assumption: one row per date + platform + campaign_id + ad_group_id
select
    date,
    platform,
    campaign_id,
    ad_group_id,
    count(*) as duplicate_count
from ads_performance_unified
group by
    date,
    platform,
    campaign_id,
    ad_group_id
having count(*) > 1
order by duplicate_count desc;

-- no rows returned


-- 9. Validate reporting view row count
select
    count(*) as reporting_view_row_count
from ads_performance_reporting;

-- 330 rows


-- 10. Validate calculated KPI fields in reporting view
select
    sum(case when calc_ctr is null and impressions <> 0 then 1 else 0 end) as unexpected_null_calc_ctr,
    sum(case when calc_cpc is null and clicks <> 0 then 1 else 0 end) as unexpected_null_calc_cpc,
    sum(case when calc_cpa is null and conversions <> 0 then 1 else 0 end) as unexpected_null_calc_cpa
from ads_performance_reporting;

-- all zeros


-- 11. Compare source totals vs unified totals by platform
select 'facebook_raw' as source_name, round(sum(spend), 2) as total_spend from facebook_ads_raw
union all
select 'google_raw' as source_name, round(sum(cost), 2) as total_spend from google_ads_raw
union all
select 'tiktok_raw' as source_name, round(sum(cost), 2) as total_spend from tiktok_ads_raw
union all
select 'facebook_unified' as source_name, round(sum(spend), 2) as total_spend
from ads_performance_unified
where platform = 'facebook'
union all
select 'google_unified' as source_name, round(sum(spend), 2) as total_spend
from ads_performance_unified
where platform = 'google'
union all
select 'tiktok_unified' as source_name, round(sum(spend), 2) as total_spend
from ads_performance_unified
where platform = 'tiktok';

-- facebook_raw = facebook_unified
-- google_raw   = google_unified
-- tiktok_raw   = tiktok_unified