DROP   VIEW IF EXISTS "wte"."sensitivity_run_model_run" CASCADE;
CREATE VIEW           "wte"."sensitivity_run_model_run" AS
SELECT d."description" AS "config"
     , f."description" AS "model"
     , f."description" AS "model_commit"
     , e."description" AS "design_config"
     , a."run_id"      AS "sensitivity_run_id"
     , c."schema"      AS "output_schema"
     , c."table"       AS "output_table"
FROM      "wte"."sensitivity_run" a
LEFT JOIN "wte"."model_run"       b ON a."model_run_gid"     = b."gid"
LEFT JOIN "wte"."output_table"    c ON b."output_gid"        = c."gid"
LEFT JOIN "wte"."config"          d ON b."config_gid"        = d."gid"
LEFT JOIN "wte"."design_config"   e ON d."design_config_gid" = e."gid"
LEFT JOIN "wte"."model"           f ON d."model_gid"         = f."gid"
;
COMMENT ON VIEW "wte"."sensitivity_run_model_run" IS 'Sensitivity run metadata with expanded descriptions';
