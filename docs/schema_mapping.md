# Schema Mapping

## Purpose

This document defines how raw source fields from Facebook Ads, Google Ads, and TikTok Ads are standardized into a unified reporting table for cross-channel marketing analysis.

The goal of the unified schema is to:

- standardize shared dimensions and metrics across platforms
- preserve platform-specific fields where useful
- support scalable SQL transformation and BI reporting
- document assumptions clearly for QA and reproducibility

---

## Standardization Rules

### 1. Platform Identifier

A new field named `platform` will be added during transformation.

| Source       | Standard Value |
| ------------ | -------------- |
| Facebook Ads | `facebook`     |
| Google Ads   | `google`       |
| TikTok Ads   | `tiktok`       |

### 2. Spend Standardization

Different platforms use different names for spend-related fields.

| Source Column | Standard Column |
| ------------- | --------------- |
| `spend`       | `spend`         |
| `cost`        | `spend`         |

### 3. Ad Group Standardization

Different platforms use different naming conventions for ad group level fields.

| Source Column   | Standard Column |
| --------------- | --------------- |
| `ad_set_id`     | `ad_group_id`   |
| `ad_set_name`   | `ad_group_name` |
| `ad_group_id`   | `ad_group_id`   |
| `ad_group_name` | `ad_group_name` |
| `adgroup_id`    | `ad_group_id`   |
| `adgroup_name`  | `ad_group_name` |

### 4. Missing Fields

If a field is not available in a given source, it will be populated as `NULL` in the unified table.

### 5. KPI Consistency

For reporting consistency, key dashboard KPIs such as CTR, CPC, and CPA should be calculated from standardized base metrics where possible rather than relying only on source-provided ratios.

Examples:

- `CTR = clicks / impressions`
- `CPC = spend / clicks`
- `CPA = spend / conversions`

---

## Source-to-Target Mapping

### Facebook Ads Mapping

| Source Column     | Target Column     | Notes                    |
| ----------------- | ----------------- | ------------------------ |
| `date`            | `date`            | Direct mapping           |
| `campaign_id`     | `campaign_id`     | Direct mapping           |
| `campaign_name`   | `campaign_name`   | Direct mapping           |
| `ad_set_id`       | `ad_group_id`     | Standardized naming      |
| `ad_set_name`     | `ad_group_name`   | Standardized naming      |
| `impressions`     | `impressions`     | Direct mapping           |
| `clicks`          | `clicks`          | Direct mapping           |
| `spend`           | `spend`           | Direct mapping           |
| `conversions`     | `conversions`     | Direct mapping           |
| `video_views`     | `video_views`     | Platform-specific metric |
| `engagement_rate` | `engagement_rate` | Platform-specific metric |
| `reach`           | `reach`           | Platform-specific metric |
| `frequency`       | `frequency`       | Platform-specific metric |

Fields not available in Facebook will be set to `NULL`:

- `conversion_value`
- `ctr`
- `avg_cpc`
- `quality_score`
- `search_impression_share`
- `video_watch_25`
- `video_watch_50`
- `video_watch_75`
- `video_watch_100`
- `likes`
- `shares`
- `comments`

---

### Google Ads Mapping

| Source Column             | Target Column             | Notes                    |
| ------------------------- | ------------------------- | ------------------------ |
| `date`                    | `date`                    | Direct mapping           |
| `campaign_id`             | `campaign_id`             | Direct mapping           |
| `campaign_name`           | `campaign_name`           | Direct mapping           |
| `ad_group_id`             | `ad_group_id`             | Direct mapping           |
| `ad_group_name`           | `ad_group_name`           | Direct mapping           |
| `impressions`             | `impressions`             | Direct mapping           |
| `clicks`                  | `clicks`                  | Direct mapping           |
| `cost`                    | `spend`                   | Standardized spend field |
| `conversions`             | `conversions`             | Direct mapping           |
| `conversion_value`        | `conversion_value`        | Platform-specific metric |
| `ctr`                     | `ctr`                     | Source-provided KPI      |
| `avg_cpc`                 | `avg_cpc`                 | Source-provided KPI      |
| `quality_score`           | `quality_score`           | Platform-specific metric |
| `search_impression_share` | `search_impression_share` | Platform-specific metric |

Fields not available in Google will be set to `NULL`:

- `video_views`
- `engagement_rate`
- `reach`
- `frequency`
- `video_watch_25`
- `video_watch_50`
- `video_watch_75`
- `video_watch_100`
- `likes`
- `shares`
- `comments`

---

### TikTok Ads Mapping

| Source Column     | Target Column     | Notes                    |
| ----------------- | ----------------- | ------------------------ |
| `date`            | `date`            | Direct mapping           |
| `campaign_id`     | `campaign_id`     | Direct mapping           |
| `campaign_name`   | `campaign_name`   | Direct mapping           |
| `adgroup_id`      | `ad_group_id`     | Standardized naming      |
| `adgroup_name`    | `ad_group_name`   | Standardized naming      |
| `impressions`     | `impressions`     | Direct mapping           |
| `clicks`          | `clicks`          | Direct mapping           |
| `cost`            | `spend`           | Standardized spend field |
| `conversions`     | `conversions`     | Direct mapping           |
| `video_views`     | `video_views`     | Platform-specific metric |
| `video_watch_25`  | `video_watch_25`  | Platform-specific metric |
| `video_watch_50`  | `video_watch_50`  | Platform-specific metric |
| `video_watch_75`  | `video_watch_75`  | Platform-specific metric |
| `video_watch_100` | `video_watch_100` | Platform-specific metric |
| `likes`           | `likes`           | Platform-specific metric |
| `shares`          | `shares`          | Platform-specific metric |
| `comments`        | `comments`        | Platform-specific metric |

Fields not available in TikTok will be set to `NULL`:

- `conversion_value`
- `ctr`
- `avg_cpc`
- `engagement_rate`
- `reach`
- `frequency`
- `quality_score`
- `search_impression_share`

---

## Final Unified Table Columns

The unified reporting table will contain the following columns:

### Core Fields

- `date`
- `platform`
- `campaign_id`
- `campaign_name`
- `ad_group_id`
- `ad_group_name`
- `impressions`
- `clicks`
- `spend`
- `conversions`

### Extended Fields

- `conversion_value`
- `ctr`
- `avg_cpc`
- `engagement_rate`
- `reach`
- `frequency`
- `quality_score`
- `search_impression_share`
- `video_views`
- `video_watch_25`
- `video_watch_50`
- `video_watch_75`
- `video_watch_100`
- `likes`
- `shares`
- `comments`

---

## Notes for Transformation

- All raw source tables should be preserved separately before unification.
- The unified table is intended for reporting and dashboarding use cases.
- Platform-specific fields are retained to support richer analysis without losing source-level context.
- Null handling should be explicit in SQL transformations.
- Final business KPIs in Tableau should be calculated from standardized base metrics whenever possible.
