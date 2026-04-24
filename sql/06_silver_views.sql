-- =====================================================================
-- 06_silver_views.sql
-- Silver-layer views over the sales_pipeline star schema.
--
-- Medallion model:
--   Bronze = raw tables (accounts, sales_reps, opportunities)
--   Silver = these views — cleaned, conformed, lightly enriched
--   Gold   = (future) aggregated/reporting views on top of silver
--
-- Star-schema shape:
--   FACT        fact_opportunities   one row per opportunity
--   DIMENSIONS  dim_accounts         customer attributes + geography
--               dim_sales_reps       seller attributes + tenure
--               dim_date             calendar (role-plays 3 times against
--                                    fact_opportunities on created_date,
--                                    expected_close_date, actual_close_date)
--
-- Notes:
--   * common_db is the shared reference database loaded from common-dimensions
--     (geography, dim_date). We read those directly with cross-database joins.
--   * All views are CREATE OR REPLACE so this file is safe to rerun.
-- =====================================================================

USE sales_pipeline;


-- ---------------------------------------------------------------------
-- dim_accounts
--
-- Purpose: customer dimension for the star. Enriched with the full state
-- name and regional grouping from common_db.geography.
--
-- Join key note: (country, state_code) is the natural key in geography
-- because state_code alone is not unique — e.g., 'NL' is Newfoundland
-- & Labrador in Canada and Nuevo Leon in Mexico. Joining on country too
-- avoids ambiguous matches.
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW dim_accounts AS
SELECT
    a.account_id,
    a.account_name,
    a.industry,
    a.segment,                                -- SMB / Mid-Market / Enterprise
    a.country,
    a.state_province           AS state_code,
    g.state_name,                             -- full name, e.g. 'California'
    g.region                   AS state_region,   -- e.g. 'West', 'Prairies'
    a.city,
    a.annual_revenue,
    a.employee_count,
    a.created_at               AS account_created_date
FROM accounts a
LEFT JOIN common_db.geography g
       ON g.state_code = a.state_province
      AND g.country    = a.country;


-- ---------------------------------------------------------------------
-- dim_sales_reps
--
-- Purpose: seller dimension. Adds a full-name convenience column and
-- tenure_days so reports don't have to recompute DATEDIFF everywhere.
--
-- `tenure_days` is computed against CURRENT_DATE, so the value naturally
-- grows over time — no refresh logic needed.
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW dim_sales_reps AS
SELECT
    sales_rep_id,
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name)     AS full_name,
    email,
    region,                                -- rep's sales region
    hire_date,
    is_active,
    DATEDIFF(CURRENT_DATE, hire_date)      AS tenure_days
FROM sales_reps;


-- ---------------------------------------------------------------------
-- dim_date
--
-- Purpose: thin pass-through wrapper around common_db.dim_date so Power BI
-- (and analysts) can see a single "dim_date" inside the sales_pipeline
-- database without having to qualify the source schema.
--
-- Role-playing: this single dimension is joined three times against
-- fact_opportunities — once per date key — using aliases:
--   dim_date_created, dim_date_expected_close, dim_date_actual_close.
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW dim_date AS
SELECT * FROM common_db.dim_date;


-- ---------------------------------------------------------------------
-- fact_opportunities
--
-- Purpose: the central fact at opportunity grain (one row per deal).
--
-- What's added beyond the raw opportunities table:
--   * weighted_amount       amount * probability / 100  (pipeline $ at
--                           current odds; also called "forecast amount")
--   * is_open / is_lost     convenience flags derived from is_closed/is_won
--                           so filters read naturally in BI tools
--   * expected_cycle_days   days between created_date and expected_close_date
--   * actual_cycle_days     days between created_date and actual_close_date
--                           (NULL until the deal closes)
--   * days_open_current     days the deal has been open right now
--                           (NULL for closed deals)
--
-- Nothing is aggregated here — this is the silver grain.
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW fact_opportunities AS
SELECT
    o.opportunity_id,
    o.opportunity_name,

    -- Dimension foreign keys (join targets for the dim_* views)
    o.account_id,
    o.sales_rep_id,
    o.product_id,
    o.created_date,
    o.expected_close_date,
    o.actual_close_date,

    -- Raw measures and attributes
    o.stage,
    o.lead_source,
    o.amount,
    o.quantity,
    o.probability,                             -- stored 0-100
    o.is_closed,
    o.is_won,

    -- Derived measures
    ROUND(o.amount * o.probability / 100, 2)   AS weighted_amount,

    -- Derived flags (mutually exclusive with is_won when is_closed=1)
    CASE WHEN o.is_closed = 0 THEN 1 ELSE 0 END                         AS is_open,
    CASE WHEN o.is_closed = 1 AND o.is_won = 0 THEN 1 ELSE 0 END        AS is_lost,

    -- Cycle-time calculations
    DATEDIFF(o.expected_close_date, o.created_date)                     AS expected_cycle_days,
    DATEDIFF(o.actual_close_date,   o.created_date)                     AS actual_cycle_days,
    CASE
        WHEN o.is_closed = 0
        THEN DATEDIFF(CURRENT_DATE, o.created_date)
        ELSE NULL
    END                                                                 AS days_open_current
FROM opportunities o;


-- ---------------------------------------------------------------------
-- Smoke tests (uncomment to run):
--
-- SELECT COUNT(*) FROM fact_opportunities;         -- expect 50
-- SELECT COUNT(*) FROM dim_accounts;               -- expect 50
-- SELECT COUNT(*) FROM dim_sales_reps;             -- expect 7
-- SELECT COUNT(*) FROM dim_date;                   -- expect common_db row count
--
-- -- A simple star join: pipeline by rep region, weighted
-- SELECT r.region, SUM(f.weighted_amount) AS weighted_pipeline
-- FROM fact_opportunities f
-- JOIN dim_sales_reps     r ON r.sales_rep_id = f.sales_rep_id
-- WHERE f.is_open = 1
-- GROUP BY r.region
-- ORDER BY weighted_pipeline DESC;
--
-- -- Won ARR by account state_region
-- SELECT a.state_region, SUM(f.amount) AS won_amount
-- FROM fact_opportunities f
-- JOIN dim_accounts a ON a.account_id = f.account_id
-- WHERE f.is_won = 1
-- GROUP BY a.state_region
-- ORDER BY won_amount DESC;
--
-- -- Role-played dim_date example: won deals by calendar quarter of close.
-- -- dim_date exposes: DateKey (PK, yyyymmdd-ish), Date, Year, Quarter,
-- -- MonthNum, Month, WeekDay, WeekDayName, IsWeekend, WeekStart, ISOWeekStart.
-- SELECT d.Year, d.Quarter, COUNT(*) AS wins, SUM(f.amount) AS won_amount
-- FROM fact_opportunities f
-- JOIN dim_date d ON d.Date = f.actual_close_date
-- WHERE f.is_won = 1
-- GROUP BY d.Year, d.Quarter
-- ORDER BY d.Year, d.Quarter;
-- ---------------------------------------------------------------------
