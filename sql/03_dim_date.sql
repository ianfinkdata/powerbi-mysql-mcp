-- Step 1: Raise the recursion limit for the 13-year loop
SET SESSION cte_max_recursion_depth = 5000;

-- Step 2: Drop the table if it exists so this script can be run cleanly anytime
DROP TABLE IF EXISTS dim_date;

-- Step 3: Create the table and populate the data (Without the DateKey)
CREATE TABLE dim_date AS
WITH RECURSIVE DateEngine AS (  
    -- Anchor
    SELECT CAST('2019-01-01' AS DATE) AS CalendarDate  
    UNION ALL  
    -- Loop
    SELECT DATE_ADD(CalendarDate, INTERVAL 1 DAY)  
    FROM DateEngine  
    -- Brakes
    WHERE CalendarDate < CAST('2031-12-31' AS DATE)
)
SELECT 
    CalendarDate AS Date,
    YEAR(CalendarDate) AS Year,
    MONTH(CalendarDate) AS MonthNum,
    LEFT(MONTHNAME(CalendarDate), 3) AS Month,
    QUARTER(CalendarDate) AS Quarter,
    WEEKDAY(CalendarDate) AS WeekDay,
    DATE_FORMAT(CalendarDate, '%a') AS WeekDayName,
    CASE WHEN WEEKDAY(CalendarDate) >= 5 THEN 1 ELSE 0 END AS IsWeekend,
    
    -- Baking the WeekStart math directly into the creation step
    DATE_SUB(CalendarDate, INTERVAL (DAYOFWEEK(CalendarDate) - 1) DAY) AS WeekStart,
    DATE_SUB(CalendarDate, INTERVAL WEEKDAY(CalendarDate) DAY) AS ISOWeekStart

FROM DateEngine;

-- Step 4: Alter the table to add the Smart Primary Key
-- Because the table and the 'Date' column now exist, MySQL calculates this instantly.
ALTER TABLE dim_date
ADD COLUMN DateKey INT GENERATED ALWAYS AS (CAST(Date AS UNSIGNED)) STORED PRIMARY KEY FIRST;

select * from dim_date;