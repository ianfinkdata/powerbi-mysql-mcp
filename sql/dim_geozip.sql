-- Drop the table if it exists so you can rerun this cleanly
DROP TABLE IF EXISTS dim_geozip;

-- Create the table, set the Primary Key upfront, and load the data
CREATE TABLE dim_geozip (
    PRIMARY KEY (zip_index)
) AS
SELECT 
    CAST(z.zip AS UNSIGNED) AS zip_index,
    z.zip,
    z.primary_city AS city,
    z.state AS state_code,
    g.state_name AS state,
    z.country
FROM zip_code AS z
LEFT JOIN geography AS g 
    ON z.state = g.state_code AND g.country = 'United States';
    
select * from dim_geozip as z;