DROP   VIEW IF EXISTS "wte"."design_config_design_setting" CASCADE;
CREATE VIEW           "wte"."design_config_design_setting" AS
SELECT a."gid" AS "design_config_gid"
     , b."gid" AS "design_setting_gid"
     , b."set"
     , b."variable"
     , b."min_value"
     , b."max_value"
     , b."model_value"
FROM      "wte"."design_config" a
LEFT JOIN "wte"."design_setting"  b ON b."design_config_gid" = a."gid";
COMMENT ON VIEW "wte"."design_config_design_setting" IS 'Sensitivity study settings assigned to study scenarios, arranged by the controlling scenario';

