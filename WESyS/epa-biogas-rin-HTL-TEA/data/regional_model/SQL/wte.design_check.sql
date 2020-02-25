DROP   VIEW IF EXISTS "wte"."design_check" CASCADE;
CREATE VIEW           "wte"."design_check" AS
SELECT a."design_config_gid"
     , a."design_setting_gid"
     , b."run_id"
     , a."variable"
     , a."min_value"
     , b."value"
     , a."max_value"
FROM      "wte"."design_config_design_setting" a
FULL JOIN "wte"."design"                       b ON a."design_setting_gid" = b."design_setting_gid"
ORDER BY a."design_config_gid" DESC
       , b."run_id"
       , COALESCE(a."variable", b."variable")
;
COMMENT ON VIEW "wte"."design_check" IS 'Sensitivity study data integrity checks';
