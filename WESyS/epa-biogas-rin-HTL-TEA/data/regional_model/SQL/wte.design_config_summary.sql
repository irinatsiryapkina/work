DROP   VIEW IF EXISTS "wte"."design_config_summary" CASCADE;
CREATE VIEW           "wte"."design_config_summary" AS
SELECT "design_config_gid"
     , COUNT(DISTINCT "variable") AS "variable_count"
     , COUNT(DISTINCT "run_id")   AS "run_id_count"
FROM "wte"."design"
GROUP BY "design_config_gid";
COMMENT ON VIEW "wte"."design_config_summary" IS 'Sensitivity study summary statistics';
