CREATE OR REPLACE VIEW "rotus"."landfill_capacity_by_size" AS (
  WITH "lmop_landfill_data" AS (SELECT "lmop_landfill_data"."landfill_id"
                                      , "lmop_landfill_data"."state_abbr"
                                      , "lmop_landfill_data"."landfill_open_year"
                                      , "lmop_landfill_data"."landfill_closure_year"
                                      , "lmop_landfill_data"."landfill_current_status"
                                      , "lmop_landfill_data"."landfill_design_capacity_tons"
                                      , "lmop_landfill_data"."landfill_design_area_acres"
                                      , "lmop_landfill_data"."landfill_design_depth_feet"
                                      , "lmop_landfill_data"."landfill_current_area_acres"
                                      , "lmop_landfill_data"."landfill_current_depth_feet"
                                      , "lmop_landfill_data"."waste_in_place_tons"
                                      , "lmop_landfill_data"."waste_in_place_year"
                                      , "lmop_landfill_data"."lfg_generated_mmscfd"
                                      , "lmop_landfill_data"."lfg_collection_system_in_place"
                                      , "lmop_landfill_data"."lfg_collected_mmscfd"
                                      , "lmop_landfill_data"."lfg_collected_year"
                                      , "lmop_landfill_data"."lfg_percent_methane"
                                      , "lmop_landfill_data"."flares_in_place"
                                      , "lmop_landfill_data"."lfg_flared_mmscfd"
                                      , "lmop_landfill_data"."lfg_flared_year"
                                      , "lmop_landfill_data"."gas_collection_system_comments"
                                 FROM "epa"."lmop_landfill_data"
                                 WHERE "lmop_landfill_data"."state_abbr" != 'CA')
    , "lmop_data" AS (SELECT "lmop_data"."landfill_id"
                            , "lmop_data"."project_id"
                            , "lmop_data"."state_abbr"
                            , "lmop_data"."lfg_collection_system_in_place"
                            , "lmop_data"."lfg_collected_mmscfd"
                            , "lmop_data"."lfg_flared_mmscfd"
                            , "lmop_data"."project_current_status"
                            , "lmop_data"."project_start_date"
                            , "lmop_data"."project_shutdown_date"
                            , "lmop_data"."lfg_energy_project_type"
                            , "lmop_data"."project_type_category"
                            , "lmop_data"."project_capacity_mw"
                            , "lmop_data"."project_lfg_inflow_mmscfd"
                       FROM "epa"."lmop_data"
                       WHERE "lmop_data"."state_abbr" != 'CA')
    , "landfill_size_classifier" AS (SELECT "landfill_id"
                                         , ("landfill_design_area_acres"    * (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'acre'       AND "to_unit" = 'square feet') * "landfill_design_depth_feet" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'cubic meter' AND "to_unit" = 'cubic feet')) >= 2500000.0 AS "large_volume"
                                         , ("landfill_design_capacity_tons" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton'))                                                                                                                                                  >= 2500000.0 AS "large_capacity"
                                         , ("waste_in_place_tons"           / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton'))                                                                                                                                                  >= 2500000.0 AS "large_waste_in_place"
                                         , ("landfill_design_area_acres"    * (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'acre'       AND "to_unit" = 'square feet') * "landfill_design_depth_feet" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'cubic meter' AND "to_unit" = 'cubic feet')) <  2500000.0 AS "small_volume"
                                         , ("landfill_design_capacity_tons" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton'))                                                                                                                                                  <  2500000.0 AS "small_capacity"
                                         , ("waste_in_place_tons"           / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton'))                                                                                                                                                  <  2500000.0 AS "small_waste_in_place"
                                         , "landfill_design_area_acres"     IS NULL OR "landfill_design_depth_feet" IS NULL                                                                                                                                                                                                                        AS "null_volume"
                                         , "landfill_design_capacity_tons"  IS NULL                                                                                                                                                                                                                                                                AS "null_capacity"
                                         , "waste_in_place_tons"            IS NULL                                                                                                                                                                                                                                                                AS "null_waste_in_place"
                                     FROM "lmop_landfill_data")
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
                                          , CASE WHEN "b_1"."null_volume"  IS TRUE AND "b_1"."null_capacity" IS TRUE THEN NULL::TEXT
                                                 WHEN "b_1"."large_volume" IS TRUE OR "b_1"."large_capacity" IS TRUE THEN 'large'::TEXT
                                                 ELSE 'small'::TEXT
                                            END AS "landfill_design_size_category"
                                          , "a_1"."waste_in_place_tons"
                                     FROM      "lmop_landfill_data"       "a_1"
                                     LEFT JOIN "landfill_size_classifier" "b_1" ON "a_1"."landfill_id" = "b_1"."landfill_id"
                                     LEFT JOIN "lmop_data"                "c_1" ON "c_1"."landfill_id" = "a_1"."landfill_id")
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

COMMENT ON VIEW "rotus"."landfill_capacity_by_size" IS 'Computes average landfill capacity for ROTUS from LMOP data by size (small vs. large) and status (open (''active'') vs. closed (''inactive'')). Corresponds to data for model variables: Avg_landfill_capacity_by_size and INIT_per_LF_loading.'
;

-- TO get INIT_per_LF_loading (only by size, not status)
-- SELECT   ROUND(AVG(avg_waste_in_place_tonnes), 2) -- convert tons to tonnes --
--        , landfill_design_size_category
-- FROM     aeberle.landfill_capacity_by_size
-- GROUP BY aeberle.landfill_design_size_category
