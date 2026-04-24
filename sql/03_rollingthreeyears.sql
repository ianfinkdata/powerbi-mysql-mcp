create or replace view dynamiccalendar as
-- Rolling three year calendar is the default 

select * 
from dim_date as cal
where 
year(cal.date) 
    between  year(CURRENT_DATE) - 3 
    and  year(CURRENT_DATE)
;