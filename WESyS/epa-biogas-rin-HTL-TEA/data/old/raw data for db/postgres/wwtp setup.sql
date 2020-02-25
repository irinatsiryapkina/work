CREATE SCHEMA wwtp
  AUTHORIZATION "wte-rw";

GRANT ALL ON SCHEMA wwtp TO "wte-rw";
GRANT USAGE ON SCHEMA wwtp TO "wte-ro";

ALTER DEFAULT PRIVILEGES IN SCHEMA wwtp
    GRANT SELECT ON TABLES
    TO public;

CREATE TABLE wwtp.sludge_by_state
(
  state character varying(50),
  count integer,
  primary_tpy numeric,
  secondary_tpy numeric,
  total_tpy numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE wwtp.sludge_by_state
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE wwtp.sludge_by_state TO public;
GRANT ALL ON TABLE wwtp.sludge_by_state TO "wte-rw";
GRANT SELECT ON TABLE wwtp.sludge_by_state TO "wte-ro";

COPY wwtp.sludge_by_state
(
state ,
  count ,
  primary_tpy ,
  secondary_tpy ,
  total_tpy,
  load_date
)
FROM '/home/enewes/sludge_by_state.csv'
WITH CSV;

drop TABLE wwtp.sludge_by_site
CREATE TABLE wwtp.sludge_by_site
(
  data_year integer, 
  uid numeric,
  state character varying(50),
  city character varying(50),
  dd_lat numeric,
    dd_long numeric,
  avg_daily_flow_mgd numeric,
  prim_solids_tons_day numeric,
  sec_solids_tons_day numeric,
    total_solids_tons_day numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE wwtp.sludge_by_site
  OWNER TO "wte-rw";
GRANT SELECT ON TABLE wwtp.sludge_by_site TO public;
GRANT ALL ON TABLE wwtp.sludge_by_site TO "wte-rw";
GRANT SELECT ON TABLE wwtp.sludge_by_site TO "wte-ro";

COPY wwtp.sludge_by_site
(
data_year , 
  uid ,
  state ,
  city ,
  dd_lat ,
    dd_long ,
  avg_daily_flow_mgd ,
  prim_solids_tons_day ,
  sec_solids_tons_day ,
    total_solids_tons_day,
  load_date
)
FROM '/home/enewes/sludge_by_site.csv'
WITH CSV;
