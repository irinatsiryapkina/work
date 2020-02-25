CREATE OR REPLACE VIEW "pnnl"."seiple_2017_sludge" AS (
  SELECT "uid"
       , "data_year"
       , "state_abbr"
       , "avg_flow_mgd"
  FROM "pnnl"."Seiple_et_al_2017_PNNL_sludge_by_site_state_region_20170321a_Si"
);
