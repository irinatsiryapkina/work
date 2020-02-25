CREATE TABLE fuel_prices.retail_cng_hist
(
  survey_start_date date,
  gasoline numeric,
  e85 numeric,
  cng numeric,
  propane numeric,
  diesel numeric,
  b2_b5 numeric,
  b99_b100 numeric,
  electricity numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fuel_prices.retail_cng_hist
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE fuel_prices.retail_cng_hist TO public;
GRANT ALL ON TABLE fuel_prices.retail_cng_hist TO "wte-rw";
GRANT SELECT ON TABLE fuel_prices.retail_cng_hist TO "wte-ro";
COMMENT ON TABLE fuel_prices.retail_cng_hist
  IS 'Average U.S. Retail Fuel Prices per Gasoline Gallon Equivalent (GGE); source Alternative Fuels Data Center';

CREATE TABLE fuel_prices.retail_cng_proj
(
  cng numeric,
  year numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fuel_prices.retail_cng_proj
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE fuel_prices.retail_cng_proj TO public;
GRANT ALL ON TABLE fuel_prices.retail_cng_proj TO "wte-rw";
GRANT SELECT ON TABLE fuel_prices.retail_cng_proj TO "wte-ro";
COMMENT ON TABLE fuel_prices.retail_cng_proj
  IS 'values were projected based on AEO growth rate AEO 2015 Growth Rate = 0.003974';

  CREATE TABLE fuel_prices.retail_elec_hist
(
  provider character varying(50),
  year numeric,
  residential numeric,
  commercial numeric,
  transportation numeric,
  total numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fuel_prices.retail_elec_hist
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE fuel_prices.retail_elec_hist TO public;
GRANT ALL ON TABLE fuel_prices.retail_elec_hist TO "wte-rw";
GRANT SELECT ON TABLE fuel_prices.retail_elec_hist TO "wte-ro";
COMMENT ON TABLE fuel_prices.retail_elec_hist
  IS 'Table 2.4. Average Price of Electricity to Ultimate Customers by End-Use Sectors (Cents per kilowatthour)'

CREATE TABLE fuel_prices.retail_elec_proj
(
  year numeric,
  residential_ref numeric,
  residential_ref_no_cpp numeric,
  commercial_ref numeric,
  commercial_ref_no_cpp numeric,
  industrial_ref numeric,
  industrial_ref_no_cpp numeric,
  transportation_ref numeric,
  transportation_ref_no_cpp numeric,
  all_sectors_ref numeric,
  all_sectors_ref_no_cpp numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fuel_prices.retail_elec_proj
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE fuel_prices.retail_elec_proj TO public;
GRANT ALL ON TABLE fuel_prices.retail_elec_proj TO "wte-rw";
GRANT SELECT ON TABLE fuel_prices.retail_elec_proj TO "wte-ro";
COMMENT ON TABLE fuel_prices.retail_elec_proj
  IS 'Electricity End-Use Prices U.S. EIA AEO 2015 cents per kWh'

CREATE TABLE fuel_prices.retail_ng_hist
(
  year numeric,
  wellhead numeric,
  ng_imports numeric,
  ng_pipeline_imports numeric,
  lng_imports numeric,
  ng_exports numeric,
  ng_exports_pipeline numeric,
  lng_exports numeric,
  pipeline_dist_use numeric,
  ng_citygate numeric,
  residential numeric,
   pct_residential numeric,
   commercial numeric,
   pct_commercial numeric,
     industrial numeric,
   pct_industrial numeric,
    ng_vehicle numeric,
    ng_elec_power numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fuel_prices.retail_ng_hist
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE fuel_prices.retail_ng_hist TO public;
GRANT ALL ON TABLE fuel_prices.retail_ng_hist TO "wte-rw";
GRANT SELECT ON TABLE fuel_prices.retail_ng_hist TO "wte-ro";
COMMENT ON TABLE fuel_prices.retail_ng_hist
  IS 'EIA Data 1: U.S. Natural Gas Prices, dollars per thousand cubic feet'

CREATE TABLE fuel_prices.retail_ng_proj
(
  year numeric,
  residential_ref numeric,
  residential_ref_no_cpp numeric,
  commercial_ref numeric,
  commercial_ref_no_cpp numeric,
  industrial_ref numeric,
  industrial_ref_no_cpp numeric,
  transportation_ref numeric,
  transportation_ref_no_cpp numeric,
  all_sectors_ref numeric,
  all_sectors_ref_no_cpp numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date232160
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fuel_prices.retail_ng_proj
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE fuel_prices.retail_ng_proj TO public;
GRANT ALL ON TABLE fuel_prices.retail_ng_proj TO "wte-rw";
GRANT SELECT ON TABLE fuel_prices.retail_ng_proj TO "wte-ro";
COMMENT ON TABLE fuel_prices.retail_ng_proj
  IS 'Natural Gas Delivered Prices U.S. EIA AEO 2015 dollars per Mcf'