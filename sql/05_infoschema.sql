use common_db;

create or replace view dictionary as

with col as(
  -- column metadata cte
select 
  table_schema,
  table_name,
  column_name,
  ordinal_position,
  data_type,
  column_type,
  column_key

  from information_schema.columns
  ),

  tbl as (
    -- used to filter later on the join
  select distinct table_schema from information_schema.tables
  where table_schema not in ( 'information_schema', 'mysql', 'performance_schema', 'sys')
  
  )  
  select c.*
  from tbl as t
  -- join filters out all of the columns we don't want to include.
  join col as c on c.table_schema = t.table_schema
  order by t.table_schema, c.table_name, c.ordinal_position
  ;

  



