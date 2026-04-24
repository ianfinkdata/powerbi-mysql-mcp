-- =====================================================================
-- 02_populate_tables.sql
-- Seeds the sales_pipeline database with sample data.
--
-- Run AFTER 02_create_tables.sql.
--
-- Conventions:
--   * state_province uses the two-letter codes from common-dimensions
--     geography.sql (USA states, Canadian provinces/territories,
--     Mexican states). All rows are in North America.
--   * This script is rerunnable: it clears each table before inserting.
-- =====================================================================

USE sales_pipeline;

-- Disable FK checks so we can wipe tables in any order during reseeding.
SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM opportunities;
DELETE FROM accounts;
DELETE FROM sales_reps;
DELETE FROM products;

ALTER TABLE opportunities AUTO_INCREMENT = 1;
ALTER TABLE accounts      AUTO_INCREMENT = 1;
ALTER TABLE sales_reps    AUTO_INCREMENT = 1;
ALTER TABLE products      AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------------------
-- accounts (50 rows, North America only)
-- ---------------------------------------------------------------------
INSERT INTO accounts
    (account_name, industry, segment, country, state_province, city,
     annual_revenue, employee_count, created_at)
VALUES
    -- United States (30)
    ('Atlas Logistics Group',       'Transportation',        'Enterprise',  'United States', 'NY', 'New York',        1850000000.00, 6200, '2022-03-14'),
    ('Brightwave Analytics',        'Technology',            'Mid-Market',  'United States', 'CA', 'San Francisco',    142000000.00,  620, '2023-07-02'),
    ('Cedar Ridge Capital',         'Financial Services',    'Enterprise',  'United States', 'NY', 'New York',        2740000000.00, 4100, '2022-01-22'),
    ('Denali Health Partners',      'Healthcare',            'Mid-Market',  'United States', 'WA', 'Seattle',          318000000.00,  940, '2023-02-11'),
    ('Evergreen Retail Co',         'Retail',                'SMB',         'United States', 'OR', 'Portland',          24500000.00,   85, '2024-05-06'),
    ('Falcon Manufacturing',        'Manufacturing',         'Mid-Market',  'United States', 'MI', 'Detroit',          276000000.00,  820, '2022-09-18'),
    ('Granite State Energy',        'Energy',                'SMB',         'United States', 'NH', 'Concord',           41200000.00,  140, '2024-01-29'),
    ('Horizon Media Works',         'Media',                 'SMB',         'United States', 'IL', 'Chicago',           18900000.00,   72, '2024-08-03'),
    ('Ironclad Security',           'Technology',            'SMB',         'United States', 'TX', 'Austin',            33500000.00,  110, '2023-11-15'),
    ('Juniper Biotech',             'Healthcare',            'Enterprise',  'United States', 'MA', 'Boston',          1120000000.00, 3300, '2022-06-08'),
    ('Keystone Financial',          'Financial Services',    'Mid-Market',  'United States', 'PA', 'Philadelphia',     412000000.00, 1180, '2022-11-30'),
    ('Lakeside Consumer Brands',    'Consumer Goods',        'Mid-Market',  'United States', 'MN', 'Minneapolis',      268000000.00,  760, '2023-04-17'),
    ('Magnolia Hospitality',        'Hospitality',           'SMB',         'United States', 'GA', 'Atlanta',           27800000.00,   95, '2024-02-20'),
    ('Nautilus Software',           'Technology',            'Enterprise',  'United States', 'CA', 'San Diego',        890000000.00, 2650, '2022-05-03'),
    ('Oakwood Realty',              'Real Estate',           'SMB',         'United States', 'NC', 'Charlotte',         12400000.00,   48, '2024-09-11'),
    ('Phoenix Telecom',             'Telecommunications',    'Mid-Market',  'United States', 'AZ', 'Phoenix',          356000000.00,  980, '2023-01-24'),
    ('Quantum Robotics',            'Manufacturing',         'Enterprise',  'United States', 'CA', 'Palo Alto',        640000000.00, 1820, '2022-08-12'),
    ('Redwood Professional Services','Professional Services','Mid-Market',  'United States', 'CA', 'Los Angeles',      198000000.00,  540, '2023-06-28'),
    ('Sapphire Education Group',    'Education',             'SMB',         'United States', 'MA', 'Cambridge',         16700000.00,   60, '2024-04-09'),
    ('Tidewater Shipping',          'Transportation',        'Mid-Market',  'United States', 'VA', 'Norfolk',          234000000.00,  690, '2023-09-05'),
    ('Unity Foods',                 'Consumer Goods',        'Enterprise',  'United States', 'OH', 'Columbus',        1450000000.00, 4300, '2022-02-17'),
    ('Valley Vintners',             'Consumer Goods',        'SMB',         'United States', 'CA', 'Napa',              22300000.00,   78, '2024-07-22'),
    ('Westbrook Industries',        'Manufacturing',         'Mid-Market',  'United States', 'WI', 'Milwaukee',        182000000.00,  520, '2023-05-14'),
    ('Yellowstone Outfitters',      'Retail',                'SMB',         'United States', 'MT', 'Bozeman',            9800000.00,   36, '2024-10-01'),
    ('Zenith Cloud Systems',        'Technology',            'Mid-Market',  'United States', 'CO', 'Denver',           287000000.00,  790, '2023-03-19'),
    ('Apex Payments',               'Financial Services',    'Mid-Market',  'United States', 'FL', 'Miami',            168000000.00,  460, '2023-08-26'),
    ('Bayou Petrochemical',         'Energy',                'Enterprise',  'United States', 'LA', 'Baton Rouge',     1980000000.00, 5700, '2022-04-07'),
    ('Copper Canyon Mining',        'Energy',                'Mid-Market',  'United States', 'NV', 'Reno',             298000000.00,  840, '2023-10-10'),
    ('Delta Health Systems',        'Healthcare',            'Enterprise',  'United States', 'TN', 'Nashville',       1340000000.00, 3900, '2022-07-25'),
    ('Empire State Broadcasting',   'Media',                 'Mid-Market',  'United States', 'NY', 'Albany',           124000000.00,  380, '2023-12-12'),

    -- Canada (12)
    ('Aurora Analytics',            'Technology',            'Mid-Market',  'Canada',        'ON', 'Toronto',          216000000.00,  610, '2023-02-28'),
    ('Bluewave Maritime',           'Transportation',        'SMB',         'Canada',        'NS', 'Halifax',           31400000.00,  118, '2024-06-15'),
    ('CanWest Energy Corp',         'Energy',                'Enterprise',  'Canada',        'AB', 'Calgary',         2210000000.00, 6400, '2022-02-03'),
    ('Dominion Telecom',            'Telecommunications',    'Enterprise',  'Canada',        'QC', 'Montreal',        1680000000.00, 4800, '2022-10-19'),
    ('Emerald Isle Foods',          'Consumer Goods',        'SMB',         'Canada',        'PE', 'Charlottetown',     14600000.00,   52, '2024-03-07'),
    ('Fraser Valley Agribusiness',  'Consumer Goods',        'Mid-Market',  'Canada',        'BC', 'Vancouver',        176000000.00,  490, '2023-05-30'),
    ('Great Plains Insurance',      'Financial Services',    'Mid-Market',  'Canada',        'MB', 'Winnipeg',         244000000.00,  680, '2023-07-18'),
    ('Highland Timber',             'Manufacturing',         'SMB',         'Canada',        'NB', 'Fredericton',       28700000.00,  102, '2024-04-25'),
    ('Ivanhoe Retail Holdings',     'Retail',                'Enterprise',  'Canada',        'ON', 'Ottawa',           920000000.00, 2740, '2022-06-21'),
    ('Jasper Pharmaceuticals',      'Healthcare',            'Mid-Market',  'Canada',        'AB', 'Edmonton',         302000000.00,  860, '2023-09-14'),
    ('Kootenay Software',           'Technology',            'SMB',         'Canada',        'BC', 'Victoria',          19800000.00,   74, '2024-08-19'),
    ('Laurentian Media',            'Media',                 'SMB',         'Canada',        'QC', 'Quebec City',       21600000.00,   81, '2024-11-04'),

    -- Mexico (8)
    ('Aztec Tech Solutions',        'Technology',            'Mid-Market',  'Mexico',        'CX', 'Ciudad de Mexico', 188000000.00,  540, '2023-04-04'),
    ('Baja Resorts',                'Hospitality',           'Mid-Market',  'Mexico',        'BS', 'La Paz',           134000000.00,  420, '2023-11-22'),
    ('Cordillera Mining SA',        'Energy',                'Enterprise',  'Mexico',        'CH', 'Chihuahua',       1520000000.00, 4500, '2022-03-29'),
    ('Del Sol Agricultural',        'Consumer Goods',        'Mid-Market',  'Mexico',        'JA', 'Guadalajara',      162000000.00,  470, '2023-06-12'),
    ('El Norte Manufacturing',      'Manufacturing',         'Enterprise',  'Mexico',        'NL', 'Monterrey',        980000000.00, 2900, '2022-09-02'),
    ('Maya Hospitality Group',      'Hospitality',           'Mid-Market',  'Mexico',        'QR', 'Cancun',           216000000.00,  720, '2023-01-16'),
    ('Puerto Financial',            'Financial Services',    'SMB',         'Mexico',        'VE', 'Veracruz',          26400000.00,   92, '2024-05-28'),
    ('Sonora Telecommunications',   'Telecommunications',    'SMB',         'Mexico',        'SO', 'Hermosillo',        38900000.00,  134, '2024-07-08');

-- ---------------------------------------------------------------------
-- sales_reps (7 rows)
-- 5 US reps (one per geography.sql US region: Northeast, Midwest, South,
-- West), with West getting two reps (Pacific vs Mountain split) since
-- it has the largest account count. Plus 1 Canada and 1 Mexico rep,
-- both hired shortly before the first opportunity in their country.
-- ---------------------------------------------------------------------
INSERT INTO sales_reps
    (first_name, last_name, email, region, hire_date, is_active)
VALUES
    ('Sarah',   'Johnson',   'sarah.johnson@example.com',   'Northeast', '2022-03-15', 1),
    ('Jessica', 'Ramirez',   'jessica.ramirez@example.com', 'Midwest',   '2023-01-10', 1),
    ('Michael', 'Chen',      'michael.chen@example.com',    'South',     '2022-08-20', 1),
    ('Emily',   'Carter',    'emily.carter@example.com',    'West',      '2021-05-18', 1),
    ('Jacob',   'Reynolds',  'jacob.reynolds@example.com',  'West',      '2023-09-06', 1),
    ('Liam',    'MacDonald', 'liam.macdonald@example.com',  'Canada',    '2025-04-22', 1),
    ('Sofia',   'Hernandez', 'sofia.hernandez@example.com', 'Mexico',    '2025-05-30', 1);

-- ---------------------------------------------------------------------
-- opportunities (50 rows, one per account)
--   Sarah (1)   -> US Northeast    Jessica (2) -> US Midwest
--   Michael (3) -> US South        Emily (4)   -> West Pacific (CA/WA/OR)
--   Jacob (5)   -> West Mountain   Liam (6)    -> Canada
--   Sofia (7)   -> Mexico
-- US dates: 2025-01-01 .. 2026-04-30. Canada/Mexico: >= 2025-06-01.
-- Probability map: Prospecting=10, Qualification=25, Proposal=50,
--                  Negotiation=75, Closed Won=100, Closed Lost=0.
-- ---------------------------------------------------------------------
INSERT INTO opportunities
    (opportunity_name, account_id, sales_rep_id, product_id, stage,
     amount, quantity, probability, lead_source,
     created_date, expected_close_date, actual_close_date,
     is_closed, is_won)
VALUES
    -- United States (30)
    ('Atlas Logistics - Platform Implementation',       1, 1, NULL, 'Closed Won',     850000.00, 12, 100.00, 'Referral',  '2025-01-15', '2025-05-15', '2025-05-08', 1, 1),
    ('Brightwave Analytics - Annual Subscription',      2, 4, NULL, 'Closed Won',     120000.00,  8, 100.00, 'Web',       '2025-02-10', '2025-04-10', '2025-04-14', 1, 1),
    ('Cedar Ridge Capital - Enterprise Agreement',      3, 1, NULL, 'Closed Lost',   1200000.00, 20,   0.00, 'Outbound',  '2025-02-28', '2025-07-01', '2025-06-22', 1, 0),
    ('Denali Health Partners - Pilot Program',          4, 4, NULL, 'Closed Won',     340000.00,  6, 100.00, 'Event',     '2025-03-18', '2025-06-18', '2025-06-10', 1, 1),
    ('Evergreen Retail - Starter Package',              5, 4, NULL, 'Closed Won',      32000.00,  3, 100.00, 'Web',       '2025-04-02', '2025-05-16', '2025-05-20', 1, 1),
    ('Falcon Manufacturing - Expansion Deal',           6, 2, NULL, 'Closed Lost',    280000.00, 10,   0.00, 'Partner',   '2025-04-20', '2025-07-20', '2025-07-12', 1, 0),
    ('Granite State Energy - Annual Subscription',      7, 1, NULL, 'Closed Won',      45000.00,  4, 100.00, 'Inbound',   '2025-05-14', '2025-07-01', '2025-06-28', 1, 1),
    ('Horizon Media Works - Services Engagement',       8, 2, NULL, 'Closed Won',      22000.00,  2, 100.00, 'Referral',  '2025-06-08', '2025-07-15', '2025-07-18', 1, 1),
    ('Ironclad Security - Platform Deal',               9, 3, NULL, 'Closed Lost',     40000.00,  3,   0.00, 'Cold Call', '2025-06-25', '2025-09-01', '2025-08-24', 1, 0),
    ('Juniper Biotech - Enterprise License',           10, 1, NULL, 'Closed Won',    1400000.00, 25, 100.00, 'Event',     '2025-07-15', '2025-12-01', '2025-11-22', 1, 1),
    ('Keystone Financial - Platform Renewal',          11, 1, NULL, 'Closed Won',     380000.00, 14, 100.00, 'Referral',  '2025-08-02', '2025-10-15', '2025-10-20', 1, 1),
    ('Lakeside Consumer Brands - Expansion',           12, 2, NULL, 'Closed Won',     250000.00,  9, 100.00, 'Outbound',  '2025-08-28', '2025-11-15', '2025-11-08', 1, 1),
    ('Magnolia Hospitality - Pilot Program',           13, 3, NULL, 'Closed Lost',     28000.00,  2,   0.00, 'Web',       '2025-09-10', '2025-11-01', '2025-10-25', 1, 0),
    ('Nautilus Software - Enterprise Agreement',       14, 4, NULL, 'Closed Won',     920000.00, 18, 100.00, 'Partner',   '2025-09-22', '2026-01-15', '2026-01-09', 1, 1),
    ('Oakwood Realty - Starter Package',               15, 3, NULL, 'Closed Won',      15000.00,  1, 100.00, 'Inbound',   '2025-10-05', '2025-11-15', '2025-11-12', 1, 1),
    ('Phoenix Telecom - Platform Deal',                16, 5, NULL, 'Closed Lost',    320000.00, 11,   0.00, 'Outbound',  '2025-10-18', '2026-01-20', '2026-01-14', 1, 0),
    ('Quantum Robotics - Enterprise License',          17, 4, NULL, 'Closed Won',     680000.00, 16, 100.00, 'Event',     '2025-11-03', '2026-02-15', '2026-02-07', 1, 1),
    ('Redwood Professional - Services Engagement',     18, 4, NULL, 'Negotiation',    200000.00,  8,  75.00, 'Referral',  '2025-11-20', '2026-05-01', NULL,         0, 0),
    ('Sapphire Education Group - Annual Subscription', 19, 1, NULL, 'Closed Won',      18000.00,  2, 100.00, 'Web',       '2025-12-02', '2026-01-20', '2026-01-17', 1, 1),
    ('Tidewater Shipping - Platform Expansion',        20, 3, NULL, 'Negotiation',    240000.00,  9,  75.00, 'Partner',   '2025-12-15', '2026-05-15', NULL,         0, 0),
    ('Unity Foods - Enterprise Agreement',             21, 2, NULL, 'Closed Won',    1500000.00, 22, 100.00, 'Outbound',  '2026-01-08', '2026-04-15', '2026-04-04', 1, 1),
    ('Valley Vintners - Starter Package',              22, 4, NULL, 'Negotiation',     25000.00,  2,  75.00, 'Web',       '2026-01-22', '2026-05-01', NULL,         0, 0),
    ('Westbrook Industries - Expansion Deal',          23, 2, NULL, 'Proposal',       185000.00,  7,  50.00, 'Referral',  '2026-02-05', '2026-06-01', NULL,         0, 0),
    ('Yellowstone Outfitters - Annual Subscription',   24, 5, NULL, 'Proposal',        12000.00,  1,  50.00, 'Inbound',   '2026-02-18', '2026-04-30', NULL,         0, 0),
    ('Zenith Cloud Systems - Platform Deal',           25, 5, NULL, 'Negotiation',    290000.00, 10,  75.00, 'Event',     '2026-03-03', '2026-06-15', NULL,         0, 0),
    ('Apex Payments - Services Engagement',            26, 3, NULL, 'Proposal',       160000.00,  6,  50.00, 'Partner',   '2026-03-15', '2026-07-01', NULL,         0, 0),
    ('Bayou Petrochemical - Enterprise License',       27, 3, NULL, 'Negotiation',   2000000.00, 30,  75.00, 'Outbound',  '2026-03-28', '2026-08-15', NULL,         0, 0),
    ('Copper Canyon Mining - Expansion Deal',          28, 5, NULL, 'Qualification',  280000.00, 10,  25.00, 'Referral',  '2026-04-05', '2026-08-01', NULL,         0, 0),
    ('Delta Health Systems - Enterprise Agreement',    29, 3, NULL, 'Qualification', 1300000.00, 20,  25.00, 'Event',     '2026-04-12', '2026-09-30', NULL,         0, 0),
    ('Empire State Broadcasting - Platform Deal',      30, 1, NULL, 'Prospecting',    120000.00,  5,  10.00, 'Cold Call', '2026-04-20', '2026-09-15', NULL,         0, 0),

    -- Canada (12)
    ('Aurora Analytics - Platform Implementation',     31, 6, NULL, 'Closed Won',     210000.00,  8, 100.00, 'Referral',  '2025-06-15', '2025-10-01', '2025-09-24', 1, 1),
    ('Bluewave Maritime - Annual Subscription',        32, 6, NULL, 'Closed Lost',     30000.00,  2,   0.00, 'Web',       '2025-07-20', '2025-09-15', '2025-09-09', 1, 0),
    ('CanWest Energy - Enterprise Agreement',          33, 6, NULL, 'Closed Won',    2200000.00, 28, 100.00, 'Outbound',  '2025-08-10', '2025-12-20', '2025-12-15', 1, 1),
    ('Dominion Telecom - Enterprise License',          34, 6, NULL, 'Closed Won',    1650000.00, 24, 100.00, 'Partner',   '2025-09-25', '2026-02-15', '2026-02-10', 1, 1),
    ('Emerald Isle Foods - Starter Package',           35, 6, NULL, 'Closed Lost',     14000.00,  1,   0.00, 'Inbound',   '2025-10-15', '2025-12-01', '2025-11-28', 1, 0),
    ('Fraser Valley Agribusiness - Expansion Deal',    36, 6, NULL, 'Closed Won',     175000.00,  6, 100.00, 'Event',     '2025-11-08', '2026-02-28', '2026-02-20', 1, 1),
    ('Great Plains Insurance - Platform Deal',         37, 6, NULL, 'Closed Won',     240000.00,  8, 100.00, 'Referral',  '2025-12-01', '2026-03-15', '2026-03-10', 1, 1),
    ('Highland Timber - Annual Subscription',          38, 6, NULL, 'Negotiation',     28000.00,  2,  75.00, 'Web',       '2026-01-15', '2026-05-01', NULL,         0, 0),
    ('Ivanhoe Retail Holdings - Enterprise Agreement', 39, 6, NULL, 'Proposal',       900000.00, 18,  50.00, 'Outbound',  '2026-02-03', '2026-07-15', NULL,         0, 0),
    ('Jasper Pharmaceuticals - Platform Expansion',    40, 6, NULL, 'Negotiation',    300000.00, 10,  75.00, 'Event',     '2026-02-25', '2026-06-15', NULL,         0, 0),
    ('Kootenay Software - Starter Package',            41, 6, NULL, 'Qualification',   20000.00,  2,  25.00, 'Web',       '2026-03-20', '2026-06-30', NULL,         0, 0),
    ('Laurentian Media - Services Engagement',         42, 6, NULL, 'Prospecting',     22000.00,  2,  10.00, 'Cold Call', '2026-04-10', '2026-08-30', NULL,         0, 0),

    -- Mexico (8)
    ('Aztec Tech Solutions - Platform Implementation', 43, 7, NULL, 'Closed Won',     190000.00,  7, 100.00, 'Partner',   '2025-07-05', '2025-11-01', '2025-10-27', 1, 1),
    ('Baja Resorts - Enterprise License',              44, 7, NULL, 'Closed Lost',    135000.00,  5,   0.00, 'Outbound',  '2025-08-22', '2025-11-30', '2025-11-22', 1, 0),
    ('Cordillera Mining - Enterprise Agreement',       45, 7, NULL, 'Closed Won',    1530000.00, 22, 100.00, 'Event',     '2025-10-12', '2026-02-28', '2026-02-18', 1, 1),
    ('Del Sol Agricultural - Expansion Deal',          46, 7, NULL, 'Closed Won',     165000.00,  6, 100.00, 'Referral',  '2025-11-25', '2026-03-15', '2026-03-11', 1, 1),
    ('El Norte Manufacturing - Platform Deal',         47, 7, NULL, 'Closed Lost',    970000.00, 17,   0.00, 'Outbound',  '2026-01-10', '2026-04-15', '2026-04-08', 1, 0),
    ('Maya Hospitality - Services Engagement',         48, 7, NULL, 'Qualification',  220000.00,  8,  25.00, 'Web',       '2026-02-14', '2026-06-30', NULL,         0, 0),
    ('Puerto Financial - Starter Package',             49, 7, NULL, 'Proposal',        25000.00,  2,  50.00, 'Inbound',   '2026-03-08', '2026-05-31', NULL,         0, 0),
    ('Sonora Telecommunications - Platform Deal',      50, 7, NULL, 'Qualification',   38000.00,  3,  25.00, 'Cold Call', '2026-04-05', '2026-08-15', NULL,         0, 0);

-- ---------------------------------------------------------------------
-- Sanity-check queries (uncomment to run):
--
-- SELECT COUNT(*) FROM accounts;         -- expect 50
-- SELECT COUNT(*) FROM sales_reps;       -- expect 7
-- SELECT COUNT(*) FROM opportunities;    -- expect 50
--
-- SELECT stage, COUNT(*) FROM opportunities GROUP BY stage ORDER BY 2 DESC;
--
-- -- Canada/Mexico opps should all be >= 2025-06-01
-- SELECT a.country, MIN(o.created_date), MAX(o.created_date)
-- FROM opportunities o JOIN accounts a USING (account_id)
-- GROUP BY a.country;
--
-- -- Rep workload
-- SELECT r.first_name, r.last_name, r.region, COUNT(*) AS opps, SUM(o.amount) AS pipeline
-- FROM opportunities o JOIN sales_reps r USING (sales_rep_id)
-- GROUP BY r.sales_rep_id ORDER BY pipeline DESC;
-- ---------------------------------------------------------------------
