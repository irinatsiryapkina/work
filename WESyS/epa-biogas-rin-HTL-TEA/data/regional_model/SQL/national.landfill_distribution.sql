CREATE OR REPLACE VIEW "national"."landfill_distribution" AS (
  WITH "landfill_size_classifier" AS (SELECT a."landfill_id"
                                           , (a."landfill_design_area_acres"    * (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'acre'       AND "to_unit" = 'square feet') * a."landfill_design_depth_feet" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'cubic meter' AND "to_unit" = 'cubic feet' )) >= 2500000 AS "large_volume"
                                           , (a."landfill_design_capacity_tons" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton')    )                                                                                                                                                  >= 2500000 AS "large_capacity"
                                           , (a."waste_in_place_tons"           / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton')    )                                                                                                                                                  >= 2500000 AS "large_waste_in_place"
                                           , (a."landfill_design_area_acres"    * (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'acre'       AND "to_unit" = 'square feet') * a."landfill_design_depth_feet" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'cubic meter' AND "to_unit" = 'cubic feet' ))  < 2500000 AS "small_volume"
                                           , (a."landfill_design_capacity_tons" / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton')    )                                                                                                                                                   < 2500000 AS "small_capacity"
                                           , (a."waste_in_place_tons"           / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton' AND "to_unit" = 'US ton')    )                                                                                                                                                   < 2500000 AS "small_waste_in_place"
                                           , (a."landfill_design_area_acres"    IS NULL OR a."landfill_design_depth_feet" IS NULL)                                                                                                                                                                                                                        AS "null_volume"
                                           , a."landfill_design_capacity_tons"  IS NULL                                                                                                                                                                                                                                                                   AS "null_capacity"
                                           , a."waste_in_place_tons"            IS NULL                                                                                                                                                                                                                                                                   AS "null_waste_in_place"
                                      FROM "epa"."lmop_landfill_data" a)
     , "project_landfill_summary" AS (SELECT a."landfill_design_area_acres"
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
                                           , a."flares_in_place"
                                           , c."project_current_status"
                                           , CASE WHEN b."null_volume"  IS TRUE AND b."null_capacity"  IS TRUE AND b."null_waste_in_place"  IS TRUE THEN NULL
                                                  WHEN b."large_volume" IS TRUE OR  b."large_capacity" IS TRUE OR  b."large_waste_in_place" IS TRUE THEN 'large'
                                                  ELSE 'small'
                                             END AS "landfill_design_size_category"
                                           , a."waste_in_place_tons"
                                      FROM      "epa"."lmop_landfill_data" a
                                      LEFT JOIN "landfill_size_classifier" b ON b."landfill_id" = a."landfill_id"
                                      LEFT JOIN "epa"."lmop_data"          c ON c."landfill_id" = a."landfill_id")
  SELECT COUNT(DISTINCT a."waste_in_place_tons") AS "number_landfills"
       , a."landfill_current_status"
       , a."landfill_design_size_category"
       , a."project_current_status"
       , CASE WHEN a."project_type_category" IS NOT NULL                                  THEN a."project_type_category"
              WHEN a."project_type_category" IS     NULL AND a."flares_in_place" IS TRUE  THEN 'CF'
              WHEN a."project_type_category" IS     NULL AND a."flares_in_place" IS FALSE THEN 'NoWTE'
              ELSE 'NoWTE'
         END AS "project_type"
  FROM "project_landfill_summary" a
  WHERE a."landfill_design_size_category" IS NOT NULL
    AND a."landfill_current_status"       != 'unknown'
  GROUP BY a."landfill_current_status"
         , a."landfill_design_size_category"
         , a."project_current_status"
         , "project_type"
  ORDER BY a."landfill_current_status"
         , a."landfill_design_size_category"
         , "project_type"
         , a."project_current_status"
);

COMMENT ON VIEW "national"."landfill_distribution" IS
'Computes number of landfills from LMOP data
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
         filter landfill_distribution by project_current_status = ''potential'' OR project_current_status = ''candidate'' (sum over these two project statuses)
         and sum over project type (e.g., electricity)

 TO get Landfill.Initial_WTE_Distribution
         filter landfill_distribution by project_current_status = ''operational''
';
