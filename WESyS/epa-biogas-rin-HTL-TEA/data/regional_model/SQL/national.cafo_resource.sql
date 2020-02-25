CREATE OR REPLACE VIEW "national"."cafo_resource" AS (
  WITH "type_table" AS (SELECT "gid"
                             , CASE WHEN "head_beef"  != 0.0 THEN 'Beef'
                                    WHEN "head_swine" != 0.0 THEN 'Swine'
                                    WHEN "head_dairy" != 0.0 THEN 'Dairy'
                                    ELSE NULL
                               END AS "CAFOType"
                        FROM "pnnl"."seiple_2016_manure"
  ) ,  "size_table" AS (SELECT a."gid"
                             , CASE WHEN b."CAFOType" = 'Beef'  AND a."head_beef"  <  500                          THEN 'tooSmall'
                                    WHEN b."CAFOType" = 'Swine' AND a."head_swine" <  500                          THEN 'tooSmall'
                                    WHEN b."CAFOType" = 'Dairy' AND a."head_dairy" <  500                          THEN 'tooSmall'
                                    WHEN b."CAFOType" = 'Beef'  AND a."head_beef"  >= 500  AND "head_beef"  < 1000 THEN 'CAFOSmall'
                                    WHEN b."CAFOType" = 'Beef'  AND a."head_beef"  >= 1000 AND "head_beef"  < 2000 THEN 'CAFOMed'
                                    WHEN b."CAFOType" = 'Beef'  AND a."head_beef"  >  2000                         THEN 'CAFOLarge'
                                    WHEN b."CAFOType" = 'Swine' AND a."head_swine" >= 500  AND "head_swine" < 1000 THEN 'CAFOSmall'
                                    WHEN b."CAFOType" = 'Swine' AND a."head_swine" >= 1000 AND "head_swine" < 2000 THEN 'CAFOMed'
                                    WHEN b."CAFOType" = 'Swine' AND a."head_swine" >  2000                         THEN 'CAFOLarge'
                                    WHEN b."CAFOType" = 'Dairy' AND a."head_dairy" >= 500  AND "head_dairy" < 1000 THEN 'CAFOSmall'
                                    WHEN b."CAFOType" = 'Dairy' AND a."head_dairy" >= 1000 AND "head_dairy" < 2000 THEN 'CAFOMed'
                                    WHEN b."CAFOType" = 'Dairy' AND a."head_dairy" >  2000                         THEN 'CAFOLarge'
                                    ELSE NULL
                               END AS "CAFOSize"
                          FROM      "pnnl"."seiple_2016_manure" a
                          LEFT JOIN "type_table"                b ON b."gid" = a."gid"
  )
  SELECT b."CAFOType"
       , c."CAFOSize"
       , COUNT(DISTINCT c."gid") AS "number_facilities"
       , CASE WHEN "CAFOType" = 'Beef'  THEN ROUND(AVG(a."head_beef"),  2)
              WHEN "CAFOType" = 'Swine' THEN ROUND(AVG(a."head_swine"), 2)
              WHEN "CAFOType" = 'Dairy' THEN ROUND(AVG(a."head_dairy"), 2)
              ELSE NULL
         END AS "avg_head"
       , CASE WHEN "CAFOType" = 'Beef'  THEN ROUND(AVG(a."head_beef"  * (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'head cattle' AND "to_unit" = 'cubic meters methane')), 2)
              WHEN "CAFOType" = 'Swine' THEN ROUND(AVG(a."head_swine" * (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'head pig'    AND "to_unit" = 'cubic meters methane')), 2)
              WHEN "CAFOType" = 'Dairy' THEN ROUND(AVG(a."head_dairy" * (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'head cow'    AND "to_unit" = 'cubic meters methane')), 2)
              ELSE NULL
         END AS "avg_methane_m3_yr_op"
  FROM "pnnl"."seiple_2016_manure" a
  LEFT JOIN "type_table"           b ON b."gid" = a."gid"
  LEFT JOIN "size_table"           c ON c."gid" = a."gid"
  WHERE c."CAFOSize" != 'tooSmall'
  GROUP BY b."CAFOType"
         , c."CAFOSize"
  ORDER BY b."CAFOType"
         , c."CAFOSize"
);

COMMENT ON VIEW "national"."cafo_resource" IS 'Collects resource data for National CAFOs, CAFOSize (CAFOSmall, CAFOMed, CAFOLarge), CaptureStatus (NoCapture, HaveCapture), and CAFOType (Beef, Swine, Dairy). Corresponds to data for variables CAFO.Initial_WTE_Distribution (number_facilities column) and CAFO.per_facility_CH4_collection (avg_methane column). To get these variables, just select the appropriate column from the ca.cafo_distribution table.';
