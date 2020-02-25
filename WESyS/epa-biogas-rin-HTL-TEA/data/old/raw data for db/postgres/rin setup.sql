CREATE SCHEMA rins
  AUTHORIZATION "wte-rw";

GRANT ALL ON SCHEMA rins TO "wte-rw";
GRANT USAGE ON SCHEMA rins TO "wte-ro";

ALTER DEFAULT PRIVILEGES IN SCHEMA rins
    GRANT SELECT ON TABLES
    TO public;

CREATE ROLE "wte-proprietary"
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
COMMENT ON ROLE "wte-proprietary" IS 'wte proprietary data DO NOT SHARE';

GRANT "wte-proprietary" TO aeberle;

CREATE TABLE rins.available_rins
(
  rin_year integer,
  fuel_d_code character varying(50) NOT NULL,
  assignment character varying(20),
  total_generated numeric,
  total_retired numeric,
  total_locked numeric,
  total_available numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE rins.available_rins
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE rins.available_rins TO public;
GRANT ALL ON TABLE rins.available_rins TO "wte-rw";
GRANT SELECT ON TABLE rins.available_rins TO "wte-ro";

COPY rins.available_rins
(
rin_year,
  fuel_d_code,
  assignment,
  total_generated,
  total_retired,
  total_locked,
  total_available,
  load_date
)
FROM '/home/enewes/available_rins.csv'
WITH CSV;

drop table rins.cellulosic_waiver_credits
CREATE TABLE rins.cellulosic_waiver_credits
(
  rin_year integer,
  credit_price numeric,
  cwcs_purchased numeric,
  comments character varying(500),
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE rins.cellulosic_waiver_credits
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE rins.cellulosic_waiver_credits TO public;
GRANT ALL ON TABLE rins.cellulosic_waiver_credits TO "wte-rw";
GRANT SELECT ON TABLE rins.cellulosic_waiver_credits TO "wte-ro";

COPY rins.cellulosic_waiver_credits
(
rin_year,
 credit_price ,
  cwcs_purchased ,
  comments,
  load_date
)
FROM '/home/enewes/cellulosic_waiver_credits.csv'
WITH CSV;

CREATE TABLE rins.rin_quantity_volume
(
  fuel_code integer, 
  rin_year integer,
  production_month integer,
  rin_quantity numeric,
  batch_volume numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE rins.rin_quantity_volume
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE rins.rin_quantity_volume TO public;
GRANT ALL ON TABLE rins.rin_quantity_volume TO "wte-rw";
GRANT SELECT ON TABLE rins.rin_quantity_volume TO "wte-ro";

COPY rins.rin_quantity_volume
(
fuel_code,
rin_year,
production_month ,
  rin_quantity ,
  batch_volume,
  load_date
)
FROM '/home/enewes/RIN_quantity_volume.csv'
WITH CSV;

CREATE TABLE rins.rin_retirement
(
  rin_year integer,
    fuel_code integer, 
    fuel_code_description character varying(100),
  ret_reason_cd integer,
  ret_reason_cd_description character varying(500),
  rin_quantity numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE rins.rin_retirement
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE rins.rin_retirement TO public;
GRANT ALL ON TABLE rins.rin_retirement TO "wte-rw";
GRANT SELECT ON TABLE rins.rin_retirement TO "wte-ro";

COPY rins.rin_retirement
(
rin_year,
fuel_code,
fuel_code_description ,
  ret_reason_cd ,
  ret_reason_cd_description ,
  rin_quantity,
  load_date
)
FROM '/home/enewes/rin_retirement.csv'
WITH CSV;

drop table rins.rin_rvo
CREATE TABLE rins.rin_rvo
(
  rin_year integer,
    cellulosic_biofuel_mm_gal numeric, 
    biomass_diesel_b_gal numeric,
  advanced_biofuel_b_gal numeric,
  renewable_fuel_b_gal numeric,
  source character varying(200),
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE rins.rin_rvo
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE rins.rin_rvo TO public;
GRANT ALL ON TABLE rins.rin_rvo TO "wte-rw";
GRANT SELECT ON TABLE rins.rin_rvo TO "wte-ro";

COPY rins.rin_rvo
(
rin_year,
cellulosic_biofuel_mm_gal , 
    biomass_diesel_b_gal ,
  advanced_biofuel_b_gal ,
  renewable_fuel_b_gal ,
  source,
  load_date
)
FROM '/home/enewes/rin_rvo.csv'
WITH CSV;

CREATE TABLE rins.rin_separation
(
  rin_year integer,
    fuel_code integer, 
    fuel_code_description character varying(100),
  sep_reason_cd integer,
  sep_reason_cd_description character varying(500),
  rin_quantity numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE rins.rin_separation
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE rins.rin_separation TO public;
GRANT ALL ON TABLE rins.rin_separation TO "wte-rw";
GRANT SELECT ON TABLE rins.rin_separation TO "wte-ro";

COPY rins.rin_separation
(
rin_year,
fuel_code,
fuel_code_description ,
  sep_reason_cd ,
  sep_reason_cd_description ,
  rin_quantity,
  load_date
)
FROM '/home/enewes/rin_separation.csv'
WITH CSV;

CREATE TABLE rins.PROPRIETARY_opis_rin_prices
(
   product_name character varying(50),
   period character varying(50),
  vintage integer,
  publication_date date,
  price_type character varying(50),
    price numeric, 
    year_id integer,
    month_id integer,
     day_id integer,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE rins.PROPRIETARY_opis_rin_prices
  OWNER TO "wte-proprietary";
GRANT SELECT ON TABLE rins.rin_separation TO "wte-proprietary";

COPY rins.PROPRIETARY_opis_rin_prices
(
product_name ,
   period ,
  vintage ,
  publication_date ,
  price_type ,
    price , 
    year_id ,
    month_id ,
     day_id,
  load_date
)
FROM '/home/enewes/PROPRIETARY_opis_rin_price.csv'
WITH CSV;