/*

CREATE TABLE IF NOT EXISTS bronze_accounts as
select 
  a.account_id, 
  a.account_name, 
  a.industry, 
  a.country, 
  a.state_province, 
  a.city,
  a.created_at
from accounts as a
;


select * from bronze_accounts;
*/
with total_sales_by_state as (
select 
  a.state_province, 
  a.country, 
  count(*) as clients,
  coalesce(sum(o.amount),0) as total_revenue
  from bronze_accounts as a
  left join opportunities as o on a.account_id = o.account_id 
    and o.stage = 'Closed Won'
  group by 
  a.state_province, 
  a.country
  
)

-- select * from accounts;

select * from total_sales_by_state order by total_revenue desc 
;




