SELECT     *
FROM
    dim_date;

with advancedcalendar as 
(
select 
DateKey, -- primary key of the table

-- complete categories are enough to uniquely identify the time period.
Date, -- 2019-01-01 
Year, -- 2019
CONCAT(CONCAT('Q','',Quarter),' ',Year) as Quarter, -- Q1 2019 sorts as text
CONCAT(month,' ',year) as Month, -- Jan 2019, sorts as text
CONCAT(CONCAT('W','',WEEK(Date,3)),' ',YEAR(Date)) as Week, -- W1 2019 sorts as text

-- partial categories that are not enough to uniquely identify the time period alone.
Quarter as QuarterOfYear, 
Month as MonthOfYear, 
MOD(MonthNum - 1, 3) +1 as MonthOfQuarter, 
WEEK(Date,3) as WeekOfYear, 
FLOOR(DATEDIFF(Date, 
    STR_TO_DATE(CONCAT(YEAR(Date), '-', (QUARTER(Date) - 1) * 3 + 1, '-01'), '%Y-%m-%d')
) / 7) + 1  as WeekOfQuarter, 
FLOOR((DAY(Date) - 1) / 7) + 1 as WeekOfMonth, 
DAYOFYEAR(Date) as DayOfYear,
DATEDIFF(
    Date, 
    STR_TO_DATE(CONCAT(YEAR(Date), '-', (QUARTER(Date) - 1) * 3 + 1, '-01'), '%Y-%m-%d')
) + 1 as DayOfQuarter,	
DAYOFMONTH(Date) as DayOfMonth,
WeekDay as DayOfWeek,
WeekDayName as DayOfWeekName,

-- "sort as" columns for Power BI to properly sort text labels 
STR_TO_DATE(CONCAT(YEAR(Date),'-', (QUARTER(date) - 1) * 3 + 1,'-01'), '%Y-%m-%d') as QuarterStartDate, 
DATE_SUB(Date, INTERVAL (DAY(Date) - 1) DAY) AS MonthStartDate,
ISOWeekStart as WeekStartDate
from dim_date

)

select * from advancedcalendar;