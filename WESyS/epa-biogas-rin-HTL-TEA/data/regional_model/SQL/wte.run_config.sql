DROP   VIEW IF EXISTS "wte"."run_config" CASCADE;
CREATE VIEW           "wte"."run_config" AS
SELECT a."gid"         AS "config_gid"
     , b."commit"      AS "model_commit"
     , b."description" AS "model_description"
     , c."description" AS "scenario_description"
     , d."description" AS "design_description"
FROM      "wte"."config"                  a
LEFT JOIN "wte"."model"                   b ON a."model_gid"           = b."gid"
LEFT JOIN "wte"."scenario"                c ON a."scenario_gid"        = c."gid"
LEFT JOIN "wte"."design_config"         d ON a."design_config_gid" = d."gid"
LEFT JOIN "wte"."design_config_summary" e ON a."design_config_gid" = e."design_config_gid"
;
COMMENT ON VIEW "wte"."run_config" IS 'Configurations for model executions with expanded descriptions';
