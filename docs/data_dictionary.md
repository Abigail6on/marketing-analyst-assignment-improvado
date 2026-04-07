# Data Dictionary

## Purpose

This document defines the structure and meaning of the unified marketing analytics table. It ensures consistent interpretation of metrics and supports accurate reporting and analysis across platforms.

---

## Table: ads_performance_unified

---

## Core Fields (Cross-Platform)

| Column Name     | Data Type | Description                                                    |
| --------------- | --------- | -------------------------------------------------------------- |
| `date`          | DATE      | Reporting date of the ad performance                           |
| `platform`      | TEXT      | Advertising platform (`facebook`, `google`, `tiktok`)          |
| `campaign_id`   | TEXT      | Unique identifier for the campaign                             |
| `campaign_name` | TEXT      | Name of the campaign                                           |
| `ad_group_id`   | TEXT      | Standardized ad group identifier (ad set / ad group / adgroup) |
| `ad_group_name` | TEXT      | Name of the ad group                                           |
| `impressions`   | INTEGER   | Number of times the ad was displayed                           |
| `clicks`        | INTEGER   | Number of clicks on the ad                                     |
| `spend`         | NUMERIC   | Total advertising cost (standardized from `spend` or `cost`)   |
| `conversions`   | INTEGER   | Number of desired user actions (e.g., purchases, sign-ups)     |

---

## Extended Fields (Platform-Specific Metrics)

| Column Name               | Data Type | Description                                                    |
| ------------------------- | --------- | -------------------------------------------------------------- |
| `conversion_value`        | NUMERIC   | Monetary value of conversions (Google Ads only)                |
| `ctr`                     | NUMERIC   | Click-through rate (clicks / impressions, provided by source)  |
| `avg_cpc`                 | NUMERIC   | Average cost per click                                         |
| `engagement_rate`         | NUMERIC   | Engagement rate for ads (Facebook only)                        |
| `reach`                   | INTEGER   | Number of unique users reached (Facebook only)                 |
| `frequency`               | NUMERIC   | Average number of times each user saw the ad (Facebook only)   |
| `quality_score`           | INTEGER   | Google Ads quality score (1–10)                                |
| `search_impression_share` | NUMERIC   | Share of impressions captured in search auctions (Google only) |
| `video_views`             | INTEGER   | Number of video views                                          |
| `video_watch_25`          | INTEGER   | Number of viewers who watched 25% of video (TikTok only)       |
| `video_watch_50`          | INTEGER   | Number of viewers who watched 50% of video (TikTok only)       |
| `video_watch_75`          | INTEGER   | Number of viewers who watched 75% of video (TikTok only)       |
| `video_watch_100`         | INTEGER   | Number of viewers who watched 100% of video (TikTok only)      |
| `likes`                   | INTEGER   | Number of likes (TikTok only)                                  |
| `shares`                  | INTEGER   | Number of shares (TikTok only)                                 |
| `comments`                | INTEGER   | Number of comments (TikTok only)                               |

---

## Derived Metrics (Calculated in BI Layer)

These metrics should be calculated in Tableau or SQL using standardized base fields for consistency:

| Metric | Formula              | Description                    |
| ------ | -------------------- | ------------------------------ |
| CTR    | clicks / impressions | Measures engagement efficiency |
| CPC    | spend / clicks       | Cost per click                 |
| CPA    | spend / conversions  | Cost per acquisition           |

---

## Notes

- All platform-specific fields will be `NULL` where not applicable.
- Source-provided KPIs (e.g., `ctr`, `avg_cpc`) are retained for reference but may differ slightly from recalculated values.
- Standardized fields (`spend`, `ad_group_id`, etc.) enable consistent cross-channel comparison.
- The unified table is designed for reporting and dashboard use, not raw data storage.

---
