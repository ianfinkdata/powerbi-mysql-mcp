-- =====================================================================
-- eda_industry_timeseries.sql
-- Exploratory queries to extend total_sales_by_state analysis with:
--   1. Revenue by industry (with country breakdown)
--   2. Monthly closed-won revenue time series (with country breakdown)
--   3. Quarterly rollup + running YTD
--
-- Depends on: silver views in sales_pipeline
--   dim_accounts, fact_opportunities, dim_date
-- =====================================================================

USE sales_pipeline;


-- ---------------------------------------------------------------------
-- 1. Revenue by Industry
--
-- One row per (industry, country).
-- win_rate_pct  = accounts with ≥1 Closed Won / total accounts
-- avg_deal_size = total revenue / won deal count (deal-level average,
--                 not account-level)
-- ---------------------------------------------------------------------
with industry_summary as (
    select
        a.industry,
        a.country,
        count(distinct a.account_id)                                            as total_clients,
        count(distinct case when f.is_won = 1 then a.account_id end)            as won_clients,
        coalesce(sum(case when f.is_won = 1 then f.amount else 0 end), 0)       as total_revenue,
        count(case when f.is_won = 1 then 1 end)                                as won_deals,
        count(case when f.is_closed = 0 then 1 end)                             as open_deals
    from dim_accounts a
    left join fact_opportunities f on a.account_id = f.account_id
    group by
        a.industry,
        a.country
)

select
    industry,
    country,
    total_clients,
    won_clients,
    round(won_clients / nullif(total_clients, 0) * 100, 1)  as win_rate_pct,
    total_revenue,
    won_deals,
    open_deals,
    round(total_revenue / nullif(won_deals, 0), 0)          as avg_deal_size
from industry_summary
order by total_revenue desc
;


-- ---------------------------------------------------------------------
-- 2. Monthly Closed-Won Revenue (with country breakdown)
--
-- Joins fact_opportunities → dim_date on actual_close_date so every row
-- is a deal that actually closed. Month names + numbers come from dim_date
-- to avoid re-deriving calendar logic.
-- ---------------------------------------------------------------------
with monthly_revenue as (
    select
        d.Year          as close_year,
        d.MonthNum      as close_month_num,
        d.Month         as close_month,
        a.country,
        count(*)        as won_deals,
        sum(f.amount)   as total_revenue
    from fact_opportunities f
    join dim_accounts a on a.account_id = f.account_id
    join dim_date     d on d.Date = f.actual_close_date
    where f.is_won = 1
    group by
        d.Year,
        d.MonthNum,
        d.Month,
        a.country
)

select
    close_year,
    close_month_num,
    close_month,
    country,
    won_deals,
    total_revenue
from monthly_revenue
order by close_year, close_month_num, country
;


-- ---------------------------------------------------------------------
-- 3. Quarterly Rollup + Running YTD by Country
--
-- ytd_revenue accumulates within each (year, country) partition so
-- you can plot a calendar-year progress line per country.
-- ---------------------------------------------------------------------
with quarterly_base as (
    select
        d.Year          as close_year,
        d.Quarter       as close_quarter,
        a.country,
        count(*)        as won_deals,
        sum(f.amount)   as total_revenue
    from fact_opportunities f
    join dim_accounts a on a.account_id = f.account_id
    join dim_date     d on d.Date = f.actual_close_date
    where f.is_won = 1
    group by
        d.Year,
        d.Quarter,
        a.country
)

select
    close_year,
    close_quarter,
    country,
    won_deals,
    total_revenue,
    sum(total_revenue) over (
        partition by close_year, country
        order by close_quarter
        rows between unbounded preceding and current row
    )                   as ytd_revenue
from quarterly_base
order by close_year, close_quarter, country
;
