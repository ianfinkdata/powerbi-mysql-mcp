use common_db;
 
CREATE TABLE geography (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    state_code VARCHAR(10) NOT NULL,
    state_name VARCHAR(100) NOT NULL,
    region VARCHAR(50),
    country VARCHAR(50) NOT NULL
) AUTO_INCREMENT = 1001;


-- Canada
INSERT INTO geography (state_code, state_name, region, country) VALUES
	-- Provinces
('AB', 'Alberta', 'Prairies', 'Canada'),
('BC', 'British Columbia', 'West Coast', 'Canada'),
('MB', 'Manitoba', 'Prairies', 'Canada'),
('NB', 'New Brunswick', 'Atlantic', 'Canada'),
('NL', 'Newfoundland and Labrador', 'Atlantic', 'Canada'),
('NS', 'Nova Scotia', 'Atlantic', 'Canada'),
('ON', 'Ontario', 'Central', 'Canada'),
('PE', 'Prince Edward Island', 'Atlantic', 'Canada'),
('QC', 'Quebec', 'Central', 'Canada'),
('SK', 'Saskatchewan', 'Prairies', 'Canada'),

	-- Territories
('NT', 'Northwest Territories', 'Northern', 'Canada'),
('NU', 'Nunavut', 'Northern', 'Canada'),
('YT', 'Yukon', 'Northern', 'Canada');

-- Mexico
INSERT INTO geography (state_code, state_name, region, country) VALUES
('AG', 'Aguascalientes', 'North-Central', 'Mexico'),
('BC', 'Baja California', 'Northwest', 'Mexico'),
('BS', 'Baja California Sur', 'Northwest', 'Mexico'),
('CM', 'Campeche', 'Southeast', 'Mexico'),
('CS', 'Chiapas', 'South', 'Mexico'),
('CH', 'Chihuahua', 'Northwest', 'Mexico'),
('CX', 'Ciudad de México', 'Central', 'Mexico'),
('CO', 'Coahuila', 'Northeast', 'Mexico'),
('CL', 'Colima', 'Western', 'Mexico'),
('DG', 'Durango', 'Northwest', 'Mexico'),
('EM', 'Estado de México', 'Central', 'Mexico'),
('GT', 'Guanajuato', 'North-Central', 'Mexico'),
('GR', 'Guerrero', 'South', 'Mexico'),
('HG', 'Hidalgo', 'Eastern', 'Mexico'),
('JA', 'Jalisco', 'Western', 'Mexico'),
('MI', 'Michoacán', 'Western', 'Mexico'),
('MO', 'Morelos', 'Central', 'Mexico'),
('NA', 'Nayarit', 'Western', 'Mexico'),
('NL', 'Nuevo León', 'Northeast', 'Mexico'),
('OA', 'Oaxaca', 'South', 'Mexico'),
('PU', 'Puebla', 'Eastern', 'Mexico'),
('QE', 'Querétaro', 'North-Central', 'Mexico'),
('QR', 'Quintana Roo', 'Southeast', 'Mexico'),
('SL', 'San Luis Potosí', 'North-Central', 'Mexico'),
('SI', 'Sinaloa', 'Northwest', 'Mexico'),
('SO', 'Sonora', 'Northwest', 'Mexico'),
('TB', 'Tabasco', 'Southeast', 'Mexico'),
('TM', 'Tamaulipas', 'Northeast', 'Mexico'),
('TL', 'Tlaxcala', 'Eastern', 'Mexico'),
('VE', 'Veracruz', 'Eastern', 'Mexico'),
('YU', 'Yucatán', 'Southeast', 'Mexico'),
('ZA', 'Zacatecas', 'North-Central', 'Mexico');


-- USA
INSERT INTO geography (state_code, state_name, region, country) VALUES
	-- States
('AL', 'Alabama', 'South', 'United States'),
('AK', 'Alaska', 'West', 'United States'),
('AZ', 'Arizona', 'West', 'United States'),
('AR', 'Arkansas', 'South', 'United States'),
('CA', 'California', 'West', 'United States'),
('CO', 'Colorado', 'West', 'United States'),
('CT', 'Connecticut', 'Northeast', 'United States'),
('DE', 'Delaware', 'South', 'United States'),
('FL', 'Florida', 'South', 'United States'),
('GA', 'Georgia', 'South', 'United States'),
('HI', 'Hawaii', 'West', 'United States'),
('ID', 'Idaho', 'West', 'United States'),
('IL', 'Illinois', 'Midwest', 'United States'),
('IN', 'Indiana', 'Midwest', 'United States'),
('IA', 'Iowa', 'Midwest', 'United States'),
('KS', 'Kansas', 'Midwest', 'United States'),
('KY', 'Kentucky', 'South', 'United States'),
('LA', 'Louisiana', 'South', 'United States'),
('ME', 'Maine', 'Northeast', 'United States'),
('MD', 'Maryland', 'South', 'United States'),
('MA', 'Massachusetts', 'Northeast', 'United States'),
('MI', 'Michigan', 'Midwest', 'United States'),
('MN', 'Minnesota', 'Midwest', 'United States'),
('MS', 'Mississippi', 'South', 'United States'),
('MO', 'Missouri', 'Midwest', 'United States'),
('MT', 'Montana', 'West', 'United States'),
('NE', 'Nebraska', 'Midwest', 'United States'),
('NV', 'Nevada', 'West', 'United States'),
('NH', 'New Hampshire', 'Northeast', 'United States'),
('NJ', 'New Jersey', 'Northeast', 'United States'),
('NM', 'New Mexico', 'West', 'United States'),
('NY', 'New York', 'Northeast', 'United States'),
('NC', 'North Carolina', 'South', 'United States'),
('ND', 'North Dakota', 'Midwest', 'United States'),
('OH', 'Ohio', 'Midwest', 'United States'),
('OK', 'Oklahoma', 'South', 'United States'),
('OR', 'Oregon', 'West', 'United States'),
('PA', 'Pennsylvania', 'Northeast', 'United States'),
('RI', 'Rhode Island', 'Northeast', 'United States'),
('SC', 'South Carolina', 'South', 'United States'),
('SD', 'South Dakota', 'Midwest', 'United States'),
('TN', 'Tennessee', 'South', 'United States'),
('TX', 'Texas', 'South', 'United States'),
('UT', 'Utah', 'West', 'United States'),
('VT', 'Vermont', 'Northeast', 'United States'),
('VA', 'Virginia', 'South', 'United States'),
('WA', 'Washington', 'West', 'United States'),
('WV', 'West Virginia', 'South', 'United States'),
('WI', 'Wisconsin', 'Midwest', 'United States'),
('WY', 'Wyoming', 'West', 'United States'),

	-- Federal District
('DC', 'District of Columbia', 'South', 'United States'),

	-- Territories
('AS', 'American Samoa', 'Territory', 'United States'),
('GU', 'Guam', 'Territory', 'United States'),
('MP', 'Northern Mariana Islands', 'Territory', 'United States'),
('PR', 'Puerto Rico', 'Territory', 'United States'),
('VI', 'U.S. Virgin Islands', 'Territory', 'United States');