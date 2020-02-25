CREATE OR REPLACE VIEW "pnnl"."seiple_2016_manure" AS (
  SELECT * FROM "pnnl"."PROPRIETARY_20161202_confined_manure_by_site_seiple_20170619"
);

COMMENT ON VIEW "pnnl"."seiple_2016_manure" IS '';
