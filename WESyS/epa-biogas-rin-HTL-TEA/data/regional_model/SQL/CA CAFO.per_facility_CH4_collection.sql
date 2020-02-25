-- WITH  "CAFOSize" AS (SELECT UNNEST('{CAFOSmall, CAFOMed, CAFOLarge}'::TEXT[]) AS "val")
--     , "CAFOType" AS (SELECT UNNEST('{Beef, Swine, Dairy}'::TEXT[])            AS "val")
-- SELECT '    SELECT ''CA CAFO.per_facility_CH4_collection[' || a."val" || ', ' || b."val" || ']'' AS "variable", COALESCE((SELECT "avg_methane_m3_yr_op" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = ''' || a."val" || ''' AND "CAFOSize" = ''' || b."val" || '''), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL' AS "column_select"
-- FROM       "CAFOType" a
-- CROSS JOIN "CAFOSize" b
-- ORDER BY 1;

CREATE OR REPLACE VIEW "CA CAFO"."per_facility_CH4_collection" AS (
  SELECT 'CA CAFO.per_facility_CH4_collection[Beef, CAFOLarge]'  AS "variable", COALESCE((SELECT "avg_methane_m3_yr_op" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Beef'  AND "CAFOSize" = 'CAFOLarge'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.per_facility_CH4_collection[Beef, CAFOMed]'    AS "variable", COALESCE((SELECT "avg_methane_m3_yr_op" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Beef'  AND "CAFOSize" = 'CAFOMed'),   0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.per_facility_CH4_collection[Beef, CAFOSmall]'  AS "variable", COALESCE((SELECT "avg_methane_m3_yr_op" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Beef'  AND "CAFOSize" = 'CAFOSmall'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.per_facility_CH4_collection[Dairy, CAFOLarge]' AS "variable", COALESCE((SELECT "avg_methane_m3_yr_op" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Dairy' AND "CAFOSize" = 'CAFOLarge'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.per_facility_CH4_collection[Dairy, CAFOMed]'   AS "variable", COALESCE((SELECT "avg_methane_m3_yr_op" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Dairy' AND "CAFOSize" = 'CAFOMed'),   0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.per_facility_CH4_collection[Dairy, CAFOSmall]' AS "variable", COALESCE((SELECT "avg_methane_m3_yr_op" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Dairy' AND "CAFOSize" = 'CAFOSmall'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.per_facility_CH4_collection[Swine, CAFOLarge]' AS "variable", COALESCE((SELECT "avg_methane_m3_yr_op" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Swine' AND "CAFOSize" = 'CAFOLarge'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.per_facility_CH4_collection[Swine, CAFOMed]'   AS "variable", COALESCE((SELECT "avg_methane_m3_yr_op" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Swine' AND "CAFOSize" = 'CAFOMed'),   0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.per_facility_CH4_collection[Swine, CAFOSmall]' AS "variable", COALESCE((SELECT "avg_methane_m3_yr_op" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Swine' AND "CAFOSize" = 'CAFOSmall'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040"
);
