DROP   VIEW IF EXISTS "wte"."study_design" CASCADE;
CREATE VIEW           "wte"."study_design" AS
SELECT b."design_config_gid"
     , a."design_setting_gid"
     , b."variable"
     , a."run_id"
     , a."value"
FROM      "wte"."design_value"   a
LEFT JOIN "wte"."design_setting" b ON a."design_setting_gid" = b."gid";
COMMENT ON VIEW "wte"."study_design" IS 'Sensitivity study design, including all variables for all runs';
