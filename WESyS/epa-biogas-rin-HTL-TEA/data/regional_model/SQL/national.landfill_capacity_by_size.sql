CREATE OR REPLACE VIEW "national"."landfill_capacity_by_size" AS (
  WITH "landfill_size_classifier" AS (SELECT "landfill_id"
                                           , ("landfill_design_area_acres"    * (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'acre'       AND "to_unit" = 'square feet') * "landfill_design_depth_feet" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'cubic meter' AND "to_unit" = 'cubic feet')) >= 2500000.0 AS "large_volume"
                                           , ("landfill_design_capacity_tons" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton'))                                                                                                                                                   >= 2500000.0 AS "large_capacity"
                                           , ("waste_in_place_tons"           / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton'))                                                                                                                                                   >= 2500000.0 AS "large_waste_in_place"
                                           , ("landfill_design_area_acres"    * (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'acre'       AND "to_unit" = 'square feet') * "landfill_design_depth_feet" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'cubic meter' AND "to_unit" = 'cubic feet'))  < 2500000.0 AS "small_volume"
                                           , ("landfill_design_capacity_tons" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton'))                                                                                                                                                    < 2500000.0 AS "small_capacity"
                                           , ("waste_in_place_tons"           / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton'))                                                                                                                                                    < 2500000.0 AS "small_waste_in_place"
                                           , "landfill_design_area_acres"     IS NULL OR "landfill_design_depth_feet" IS NULL                                                                                                                                                                                                                          AS "null_volume"
                                           , "landfill_design_capacity_tons"  IS NULL                                                                                                                                                                                                                                                                  AS "null_capacity"
                                           , "waste_in_place_tons"            IS NULL                                                                                                                                                                                                                                                                  AS "null_waste_in_place"
                                      FROM "epa"."lmop_landfill_data")
     , "project_landfill_summary" AS (SELECT "a_1"."landfill_design_area_acres"
                                           , "a_1"."landfill_design_depth_feet"
                                           , "a_1"."landfill_design_capacity_tons"
                                           , "a_1"."landfill_current_status"
                                           , "b_1"."null_volume"
                                           , "b_1"."null_capacity"
                                           , "b_1"."large_volume"
                                           , "b_1"."large_capacity"
                                           , "b_1"."small_volume"
                                           , "b_1"."small_capacity"
                                           , "c_1"."project_type_category"
                                           , CASE WHEN "b_1"."null_volume"  IS TRUE AND "b_1"."null_capacity" IS TRUE THEN NULL :: TEXT
                                                  WHEN "b_1"."large_volume" IS TRUE OR "b_1"."large_capacity" IS TRUE THEN 'large' :: TEXT
                                                  ELSE 'small' :: TEXT
                                             END AS "landfill_design_size_category"
                                           , "a_1"."waste_in_place_tons"
                                      FROM      "epa"."lmop_landfill_data" "a_1"
                                      LEFT JOIN "landfill_size_classifier" "b_1" ON "a_1"."landfill_id" = "b_1"."landfill_id"
                                      LEFT JOIN "epa"."lmop_data"          "c_1" ON "c_1"."landfill_id" = "a_1"."landfill_id")
  SELECT ROUND(AVG("project_landfill_summary"."waste_in_place_tons" * (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'US ton' AND "to_unit" = 'metric ton')), 2) AS "avg_waste_in_place_tons"
       , "project_landfill_summary"."landfill_current_status"
       , "project_landfill_summary"."landfill_design_size_category"
  FROM "project_landfill_summary"
  WHERE "project_landfill_summary"."landfill_design_size_category" IS NOT NULL
  GROUP BY "project_landfill_summary"."landfill_design_size_category"
         , "project_landfill_summary"."landfill_current_status"
  ORDER BY "project_landfill_summary"."landfill_current_status"
         , "project_landfill_summary"."landfill_design_size_category"
);

COMMENT ON VIEW "national"."landfill_capacity_by_size" IS 'Computes average landfill capacity from LMOP data by size (small vs. large) and status (open (''active'') vs. closed (''inactive'')). Corresponds to data for model variables: Avg_landfill_capacity_by_size and INIT_per_LF_loading.'
;

-- TO get INIT_per_LF_loading (only by size, not status)
-- SELECT   ROUND(AVG(avg_waste_in_place_tonnes), 2) -- convert tons to tonnes --
--        , landfill_design_size_category
-- FROM     aeberle.landfill_capacity_by_size
-- GROUP BY aeberle.landfill_design_size_category
