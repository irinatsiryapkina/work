CREATE SCHEMA fog
  AUTHORIZATION "wte-rw";

GRANT ALL ON SCHEMA fog TO "wte-rw";
GRANT USAGE ON SCHEMA fog TO "wte-ro";

ALTER DEFAULT PRIVILEGES IN SCHEMA fog
    GRANT SELECT ON TABLES
    TO public;

CREATE TABLE fog.grease_production
(
  urban_area character varying(100),
  urban_area_cluster character varying(500),
  yellow_grease_tons numeric,
    brown_grease_tons numeric,
    state character varying(50),
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fog.grease_production
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE fog.grease_production TO public;
GRANT ALL ON TABLE fog.grease_production TO "wte-rw";
GRANT SELECT ON TABLE fog.grease_production TO "wte-ro";

COPY fog.grease_production
(
urban_area ,
  urban_area_cluster ,
  yellow_grease_tons ,
    brown_grease_tons ,
    state ,
  load_date
)
FROM '/home/enewes/grease_production.csv'
WITH CSV;


CREATE TABLE fog.animal_fats_production
(
  state_name character varying(100),
   inedible_fats_tons numeric,
    load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fog.animal_fats_production
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE fog.animal_fats_production TO public;
GRANT ALL ON TABLE fog.animal_fats_production TO "wte-rw";
GRANT SELECT ON TABLE fog.animal_fats_production TO "wte-ro";

COPY fog.animal_fats_production
(
state_name ,
   inedible_fats_tons ,
  load_date
)
FROM '/home/enewes/animal_fats_production.csv'
WITH CSV;
