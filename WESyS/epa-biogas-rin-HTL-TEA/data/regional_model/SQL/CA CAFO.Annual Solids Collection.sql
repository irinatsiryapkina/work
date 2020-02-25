CREATE OR REPLACE VIEW "CA CAFO"."Annual Solids Collection" AS (
  SELECT 'CA CAFO.Annual Solids Collection[Beef, CAFOLarge]'  AS "variable", COALESCE((SELECT "avg_manure" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Beef'  AND "CAFOSize" = 'CAFOLarge'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.Annual Solids Collection[Beef, CAFOMed]'    AS "variable", COALESCE((SELECT "avg_manure" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Beef'  AND "CAFOSize" = 'CAFOMed'),   0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.Annual Solids Collection[Beef, CAFOSmall]'  AS "variable", COALESCE((SELECT "avg_manure" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Beef'  AND "CAFOSize" = 'CAFOSmall'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.Annual Solids Collection[Dairy, CAFOLarge]' AS "variable", COALESCE((SELECT "avg_manure" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Dairy' AND "CAFOSize" = 'CAFOLarge'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.Annual Solids Collection[Dairy, CAFOMed]'   AS "variable", COALESCE((SELECT "avg_manure" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Dairy' AND "CAFOSize" = 'CAFOMed'),   0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.Annual Solids Collection[Dairy, CAFOSmall]' AS "variable", COALESCE((SELECT "avg_manure" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Dairy' AND "CAFOSize" = 'CAFOSmall'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.Annual Solids Collection[Swine, CAFOLarge]' AS "variable", COALESCE((SELECT "avg_manure" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Swine' AND "CAFOSize" = 'CAFOLarge'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.Annual Solids Collection[Swine, CAFOMed]'   AS "variable", COALESCE((SELECT "avg_manure" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Swine' AND "CAFOSize" = 'CAFOMed'),   0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'CA CAFO.Annual Solids Collection[Swine, CAFOSmall]' AS "variable", COALESCE((SELECT "avg_manure" AS "val" FROM "ca"."cafo_resource" WHERE "CAFOType" = 'Swine' AND "CAFOSize" = 'CAFOSmall'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040"
);
