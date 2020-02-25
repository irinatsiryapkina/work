CREATE OR REPLACE VIEW "wbj"."waste_processing_and_disposal_sites" AS (
  SELECT * FROM "wbj"."WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016_20161001"
);

COMMENT ON VIEW "wbj"."waste_processing_and_disposal_sites" IS '';
