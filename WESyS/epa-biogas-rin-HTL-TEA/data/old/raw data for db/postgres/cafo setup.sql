CREATE SCHEMA cafo
  AUTHORIZATION "wte-rw";

GRANT ALL ON SCHEMA cafo TO "wte-rw";
GRANT USAGE ON SCHEMA cafo TO "wte-ro";

ALTER DEFAULT PRIVILEGES IN SCHEMA cafo
    GRANT SELECT ON TABLES
    TO public;

CREATE TABLE cafo.PROPRIETARY_confined_manure_by_site
(
  state character varying(50),
  latitude numeric,
    longitude numeric,
    pct_beef numeric,
   pct_dairy numeric,
  pct_swine numeric,
  head_beef numeric,
  head_dairy numeric,
  head_swine numeric,
  manure_beef numeric,
  manure_dairy numeric, 
  manure_swine numeric,
  load_date date NOT NULL DEFAULT ('now'::text)::date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cafo.PROPRIETARY_confined_manure_by_site
  OWNER TO "wte-proprietary";
GRANT SELECT ON TABLE cafo.PROPRIETARY_confined_manure_by_site TO "wte-proprietary";

COPY cafo.PROPRIETARY_confined_manure_by_site
(
state ,
  latitude ,
    longitude ,
    pct_beef ,
   pct_dairy ,
  pct_swine ,
  head_beef ,
  head_dairy ,
  head_swine ,
  manure_beef ,
  manure_dairy , 
  manure_swine ,
  load_date
)
FROM '/home/enewes/PROPRIETARY_confined_manure_by_site.csv'
WITH CSV;


