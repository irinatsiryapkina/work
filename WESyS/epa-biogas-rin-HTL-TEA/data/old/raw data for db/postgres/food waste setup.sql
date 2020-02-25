CREATE SCHEMA food_waste
  AUTHORIZATION "wte-rw";

GRANT ALL ON SCHEMA food_waste TO "wte-rw";
GRANT USAGE ON SCHEMA food_waste TO "wte-ro";

ALTER DEFAULT PRIVILEGES IN SCHEMA food_waste
    GRANT SELECT ON TABLES
    TO public;

CREATE TABLE food_waste.food_waste_production
(
  county_name character varying(100),
  state_name character varying(100),
  state_fips character varying(20), 
  cnty_fips character varying(20), 
  fips character varying(20),
  food_waste_wet_tons numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE food_waste.food_waste_production
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE food_waste.food_waste_production TO public;
GRANT ALL ON TABLE food_waste.food_waste_production TO "wte-rw";
GRANT SELECT ON TABLE food_waste.food_waste_production TO "wte-ro";

COPY food_waste.food_waste_production
(
county_name ,
  state_name ,
  state_fips , 
  cnty_fips , 
  fips ,
  food_waste_wet_tons ,
  load_date
)
FROM '/home/enewes/food_waste_production.csv'
WITH CSV;
