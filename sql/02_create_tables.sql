-- =====================================================================
-- 02_create_tables.sql
-- Creates the tables for the sales_pipeline database.
--
-- Schema overview (simple star layout for Power BI):
--   Dimensions: accounts, sales_reps, products
--   Fact:       opportunities
-- =====================================================================

USE sales_pipeline;

-- ---------------------------------------------------------------------
-- Dimension: sales_reps
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS opportunities;
DROP TABLE IF EXISTS sales_reps;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS products;

CREATE TABLE sales_reps (
    sales_rep_id    INT             NOT NULL AUTO_INCREMENT,
    first_name      VARCHAR(50)     NOT NULL,
    last_name       VARCHAR(50)     NOT NULL,
    email           VARCHAR(150)    NOT NULL,
    region          VARCHAR(50)     NOT NULL,       -- e.g., North, South, EMEA, APAC
    hire_date       DATE            NOT NULL,
    is_active       TINYINT(1)      NOT NULL DEFAULT 1,
    PRIMARY KEY (sales_rep_id),
    UNIQUE KEY uk_sales_reps_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Dimension: accounts (customer companies)
-- ---------------------------------------------------------------------
CREATE TABLE accounts (
    account_id      INT             NOT NULL AUTO_INCREMENT,
    account_name    VARCHAR(150)    NOT NULL,
    industry        VARCHAR(75)     NULL,           -- e.g., Technology, Healthcare, Retail
    segment         VARCHAR(25)     NOT NULL,       -- SMB, Mid-Market, Enterprise
    country         VARCHAR(75)     NOT NULL,
    state_province  VARCHAR(75)     NULL,
    city            VARCHAR(75)     NULL,
    annual_revenue  DECIMAL(15,2)   NULL,           -- account's reported annual revenue
    employee_count  INT             NULL,
    created_at      DATE            NOT NULL,
    PRIMARY KEY (account_id),
    KEY ix_accounts_segment (segment),
    KEY ix_accounts_industry (industry),
    CONSTRAINT chk_accounts_segment
        CHECK (segment IN ('SMB','Mid-Market','Enterprise'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Dimension: products
-- ---------------------------------------------------------------------
CREATE TABLE products (
    product_id      INT             NOT NULL AUTO_INCREMENT,
    product_name    VARCHAR(100)    NOT NULL,
    product_family  VARCHAR(50)     NOT NULL,       -- e.g., Platform, Add-On, Services
    list_price      DECIMAL(12,2)   NOT NULL,       -- price per unit / per license
    billing_cycle   VARCHAR(20)     NOT NULL,       -- One-Time, Monthly, Annual
    is_active       TINYINT(1)      NOT NULL DEFAULT 1,
    PRIMARY KEY (product_id),
    UNIQUE KEY uk_products_name (product_name),
    CONSTRAINT chk_products_billing
        CHECK (billing_cycle IN ('One-Time','Monthly','Annual'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Fact: opportunities
-- One row per opportunity. Stage is stored as text (with CHECK) so
-- Power BI can slice it directly without an extra join.
-- ---------------------------------------------------------------------
CREATE TABLE opportunities (
    opportunity_id      INT             NOT NULL AUTO_INCREMENT,
    opportunity_name    VARCHAR(200)    NOT NULL,
    account_id          INT             NOT NULL,
    sales_rep_id        INT             NOT NULL,
    product_id          INT             NOT NULL,
    stage               VARCHAR(25)     NOT NULL,
    amount              DECIMAL(12,2)   NOT NULL,   -- total deal value
    quantity            INT             NOT NULL DEFAULT 1,
    probability         DECIMAL(5,2)    NOT NULL,   -- 0.00 to 100.00
    lead_source         VARCHAR(40)     NULL,       -- e.g., Web, Referral, Event, Outbound
    created_date        DATE            NOT NULL,
    expected_close_date DATE            NOT NULL,
    actual_close_date   DATE            NULL,       -- NULL while open
    is_closed           TINYINT(1)      NOT NULL DEFAULT 0,
    is_won              TINYINT(1)      NOT NULL DEFAULT 0,
    PRIMARY KEY (opportunity_id),
    KEY ix_opps_account  (account_id),
    KEY ix_opps_rep      (sales_rep_id),
    KEY ix_opps_product  (product_id),
    KEY ix_opps_stage    (stage),
    KEY ix_opps_close    (expected_close_date),
    CONSTRAINT fk_opps_account
        FOREIGN KEY (account_id)    REFERENCES accounts(account_id),
    CONSTRAINT fk_opps_rep
        FOREIGN KEY (sales_rep_id)  REFERENCES sales_reps(sales_rep_id),
    CONSTRAINT fk_opps_product
        FOREIGN KEY (product_id)    REFERENCES products(product_id),
    CONSTRAINT chk_opps_stage
        CHECK (stage IN (
            'Prospecting',
            'Qualification',
            'Proposal',
            'Negotiation',
            'Closed Won',
            'Closed Lost'
        )),
    CONSTRAINT chk_opps_probability
        CHECK (probability BETWEEN 0 AND 100),
    CONSTRAINT chk_opps_amount
        CHECK (amount >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
