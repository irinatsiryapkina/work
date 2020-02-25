CREATE OR REPLACE VIEW "ca"."landfill_distribution" AS (
  WITH "lmop_landfill_data"       AS (SELECT * FROM "epa"."lmop_landfill_data" a WHERE a."state_abbr" = 'CA')
     , "lmop_data"                AS (SELECT * FROM "epa"."lmop_data"          a WHERE a."state_abbr" = 'CA')
     , "landfill_size_classifier" AS (SELECT "landfill_id"
                                          , ("landfill_design_area_acres"    * (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'acre'       AND "to_unit" = 'square feet') * "landfill_design_depth_feet" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'cubic meter' AND "to_unit" = 'cubic feet' )) >= 2500000 AS "large_volume"
                                          , ("landfill_design_capacity_tons" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton')    )                                                                                                                                                >= 2500000 AS "large_capacity"
                                          , ("waste_in_place_tons"           / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton')    )                                                                                                                                                >= 2500000 AS "large_waste_in_place"
                                          , ("landfill_design_area_acres"    * (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'acre'       AND "to_unit" = 'square feet') * "landfill_design_depth_feet" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'cubic meter' AND "to_unit" = 'cubic feet' ))  < 2500000 AS "small_volume"
                                          , ("landfill_design_capacity_tons" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton')    )                                                                                                                                                 < 2500000 AS "small_capacity"
                                          , ("waste_in_place_tons"           / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton')    )                                                                                                                                                 < 2500000 AS "small_waste_in_place"
                                          , ("landfill_design_area_acres"   IS NULL OR "landfill_design_depth_feet" IS NULL)                                                                                                                                                                                                                         AS "null_volume"
                                          , "landfill_design_capacity_tons" IS NULL                                                                                                                                                                                                                                                                  AS "null_capacity"
                                          , "waste_in_place_tons"           IS NULL                                                                                                                                                                                                                                                                  AS "null_waste_in_place"
                                      FROM "lmop_landfill_data")
     , "project_landfill_summary" AS (SELECT a."landfill_id"
                                           , a."landfill_design_area_acres"
                                           , a."landfill_design_depth_feet"
                                           , a."landfill_design_capacity_tons"
                                           , a."landfill_current_status"
                                           , b."null_volume"
                                           , b."null_capacity"
                                           , b."large_volume"
                                           , b."large_capacity"
                                           , b."small_volume"
                                           , b."small_capacity"
                                           , c."project_type_category"
                                           , CASE WHEN c."project_type_category" IS NOT NULL                                  THEN c."project_type_category"
                                                  WHEN c."project_type_category" IS     NULL AND a."flares_in_place" IS TRUE  THEN 'CF'
                                                  WHEN c."project_type_category" IS     NULL AND a."flares_in_place" IS FALSE THEN 'NoWTE'
                                                  ELSE 'NoWTE'
                                             END AS "project_type"
                                           , a."flares_in_place"
                                           , c."project_current_status"
                                           , CASE WHEN b."null_volume"  IS TRUE AND b."null_capacity"  IS TRUE AND b."null_waste_in_place"  IS TRUE THEN NULL
                                                  WHEN b."large_volume" IS TRUE OR  b."large_capacity" IS TRUE OR  b."large_waste_in_place" IS TRUE THEN 'large'
                                                  ELSE 'small'
                                             END AS "landfill_design_size_category"
                                           , a."waste_in_place_tons"
                                      FROM      "lmop_landfill_data"       a
                                      LEFT JOIN "landfill_size_classifier" b ON b."landfill_id" = a."landfill_id"
                                      LEFT JOIN "lmop_data"                c ON c."landfill_id" = a."landfill_id")
     , "landfill_ids"             AS (SELECT DISTINCT ON ("landfill_id") * FROM "project_landfill_summary")
     , "operational_facilities"   AS (SELECT COUNT("landfill_id") AS "number_landfills"
                                           , "landfill_current_status"
                                           , "project_type"
                                           , "landfill_design_size_category"
                                           , 'initial_dist'::TEXT AS "project_current_status"
                                      FROM "landfill_ids"
                                      WHERE "landfill_design_size_category" IS NOT NULL AND "landfill_current_status" <> 'unknown' AND "project_current_status" = 'operational'
                                      GROUP BY "landfill_current_status", "project_type", "landfill_design_size_category")
     , "nowte_facilities"         AS (SELECT COUNT("landfill_id") AS "number_landfills"
                                           , "landfill_current_status"
                                           , 'NoWTE'::TEXT        AS "project_type"
                                           , "landfill_design_size_category"
                                           , 'initial_dist'::TEXT AS "project_current_status"
                                      FROM "landfill_ids"
                                      WHERE "landfill_design_size_category" IS NOT NULL AND "landfill_current_status" <> 'unknown' AND "project_current_status" != 'operational' AND "project_current_status" != 'potential' AND "project_type" != 'CF'
                                      GROUP BY "landfill_current_status", "landfill_design_size_category")
     , "cf_facilities"            AS (SELECT COUNT("landfill_id") AS "number_landfills"
                                           , "landfill_current_status"
                                           , "project_type"
                                           , "landfill_design_size_category"
                                           , 'initial_dist'::TEXT AS "project_current_status"
                                      FROM "landfill_ids"
                                      WHERE "landfill_design_size_category" IS NOT NULL AND "landfill_current_status" <> 'unknown' AND "project_current_status" != 'operational' AND "project_current_status" != 'potential' AND "project_type" = 'CF'
                                      GROUP BY "landfill_current_status", "landfill_design_size_category", "project_type")
     , "initial_distribution"     AS (SELECT a.* FROM "operational_facilities" a
                                      UNION ALL
                                      SELECT b.* FROM "nowte_facilities" b
                                      UNION ALL
                                      SELECT c.* FROM "cf_facilities" c)
     , "potential_distribution"   AS (SELECT COUNT("landfill_id")   AS "number_landfills"
                                           , "landfill_current_status"
                                           , 'NoWTE'::TEXT          AS "project_type"
                                           , "landfill_design_size_category"
                                           , 'potential_dist'::TEXT AS "project_current_status"
                                      FROM "landfill_ids"
                                      WHERE "landfill_design_size_category" IS NOT NULL AND "landfill_current_status" <> 'unknown' AND "project_current_status" = 'potential'
                                      GROUP BY "landfill_current_status", "landfill_design_size_category")
  SELECT "number_landfills"
        , "landfill_current_status"
        , "landfill_design_size_category"
        , "project_current_status"
        , "project_type"
  FROM "initial_distribution"
  UNION ALL
  SELECT "number_landfills"
        , "landfill_current_status"
        , "landfill_design_size_category"
        , "project_current_status"
        , "project_type"
  FROM "potential_distribution"
  ORDER BY "landfill_current_status"
         , "landfill_design_size_category"
         , "project_type"
);

COMMENT ON VIEW "ca"."landfill_distribution" IS
'Computes number of landfills for CA from LMOP data
        by size (small vs. large)
        by status (open (''active'') vs. closed (''inactive''))
    by project status (e.g., candidate)
        by project type (e.g., electricity)
 Corresponds to data for the following Stella variables
        1) Landfill.Initial_Potential_Distribution[LFStatus, LFSize]
        2) Landfill.Initial_WTE_Distribution [LFStatus, LFSize, WTEConfig]

                WHERE LFStatus  = (Inactive, Active)  inactive = closed; active = open
                      LFSize    = (LFSmall, LFLarge)
                      WTEConfig = (NoWTE, CF, Elec, CNG, PNG, BCFuel, TCFuel, HTL, FT)]

 TO get Landfill.Initial_Potential_Distribution
        filter landfill_distribution by project_current_status = ''potential_dist''
        and sum over project type (e.g., electricity)

 TO get Landfill.Initial_WTE_Distribution
        filter landfill_distribution by project_current_status = ''initial_dist''
';


--ERROR:  could not determine which collation to use for view column "project_current_status"
--HINT:  Use the COLLATE clause to set the collation explicitly.