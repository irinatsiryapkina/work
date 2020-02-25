DROP   TABLE IF EXISTS "wte"."design_setting" CASCADE;
CREATE TABLE           "wte"."design_setting" (
    "gid"               SERIAL  NOT NULL PRIMARY KEY
  , "design_config_gid" INT     NOT NULL REFERENCES "wte"."design_config" ("gid")
  , "set"               INT         NULL
  , "variable_gid"      INT     NOT NULL REFERENCES "wte"."variable" ("gid")
  , "min_value"         NUMERIC NOT NULL
  , "max_value"         NUMERIC NOT NULL
  , "model_value"       NUMERIC NOT NULL
  , "description"       TEXT        NULL DEFAULT now()
);
COMMENT ON TABLE "wte"."design_setting" IS 'Individual sensitivity study setting belonging to a specific design config, used to generate study design values';

INSERT INTO "wte"."design_setting" ("design_config_gid", "set", "variable_gid", "min_value", "max_value", "model_value", "description")
SELECT (SELECT "gid" FROM "wte"."design_config" WHERE "description" = 'rotus.ee.test_rotus_25traj_2jan2017') AS "design_config_gid"
     , a."set"::INT                                                                                          AS "set"
     , COALESCE(b."gid", -999)                                                                               AS "variable_gid"
     , a."min"::NUMERIC                                                                                      AS "min_value"
     , a."max"::NUMERIC                                                                                      AS "max_value"
     , a."value"::NUMERIC                                                                                    AS "model_value"
     , a."notes"::TEXT                                                                                       AS "description"
FROM      "dhetting"."rotus.ee.test_rotus_25traj_2jan2017" a
LEFT JOIN "wte"."variable"                                 b ON UPPER(a."factor") = UPPER(b."module" || '.' || b."name")
ORDER BY a."set"::INT, a."factor"
;

INSERT INTO "wte"."design_setting" ("design_config_gid", "set", "variable_gid", "min_value", "max_value", "model_value", "description")
SELECT (SELECT "gid" FROM "wte"."design_config" WHERE "description" = 'ca.ee.test_ca_25traj_4jan2017') AS "design_config_gid"
     , a."set"::INT                                                                                    AS "set"
     , COALESCE(b."gid", -999)                                                                         AS "variable_gid"
     , a."min"::NUMERIC                                                                                AS "min_value"
     , a."max"::NUMERIC                                                                                AS "max_value"
     , a."value"::NUMERIC                                                                              AS "model_value"
     , a."notes"::TEXT                                                                                 AS "description"
FROM      "dhetting"."ca.ee.test_ca_25traj_4jan2017" a
LEFT JOIN "wte"."variable"                           b ON UPPER(a."factor") = UPPER(b."module" || '.' || b."name")
ORDER BY a."set"::INT, a."factor"
;

INSERT INTO "wte"."design_setting" ("design_config_gid", "set", "variable_gid", "min_value", "max_value", "model_value", "description")
SELECT (SELECT "gid" FROM "wte"."design_config" WHERE "description" = 'vbsa.sludge.ca.10jan') AS "design_config_gid"
     , a."set"::INT                                                                           AS "set"
     , COALESCE(b."gid", -999)                                                                AS "variable_gid"
     , a."min"::NUMERIC                                                                       AS "min_value"
     , a."max"::NUMERIC                                                                       AS "max_value"
     , a."value"::NUMERIC                                                                     AS "model_value"
     , a."notes"::TEXT                                                                        AS "description"
FROM      "dhetting"."vbsa.sludge.ca.10jan" a
LEFT JOIN "wte"."variable"                  b ON UPPER(a."factor") = UPPER(b."module" || '.' || b."name")
ORDER BY a."set"::INT, a."factor"
;

INSERT INTO "wte"."design_setting" ("design_config_gid", "set", "variable_gid", "min_value", "max_value", "model_value", "description")
SELECT (SELECT "gid" FROM "wte"."design_config" WHERE "description" = 'vbsa.biogas.ca.20jan') AS "design_config_gid"
     , a."set"::INT                                                                           AS "set"
     , COALESCE(b."gid", -999)                                                                AS "variable_gid"
     , a."min"::NUMERIC                                                                       AS "min_value"
     , a."max"::NUMERIC                                                                       AS "max_value"
     , a."value"::NUMERIC                                                                     AS "model_value"
     , a."notes"::TEXT                                                                        AS "description"
FROM      "dhetting"."vbsa.biogas.ca.20jan" a
LEFT JOIN "wte"."variable"                  b ON UPPER(a."factor") = UPPER(b."module" || '.' || b."name")
ORDER BY a."set"::INT, a."factor"
;

INSERT INTO "wte"."design_setting" ("design_config_gid", "set", "variable_gid", "min_value", "max_value", "model_value", "description")
SELECT (SELECT "gid" FROM "wte"."design_config" WHERE "description" = 'vbsa.sludge.rotus.5feb') AS "design_config_gid"
     , a."set"::INT                                                                             AS "set"
     , COALESCE(b."gid", -999)                                                                  AS "variable_gid"
     , a."min"::NUMERIC                                                                         AS "min_value"
     , a."max"::NUMERIC                                                                         AS "max_value"
     , a."value"::NUMERIC                                                                       AS "model_value"
     , a."notes"::TEXT                                                                          AS "description"
FROM      "dhetting"."vbsa.sludge.rotus.5feb" a
LEFT JOIN "wte"."variable"                    b ON UPPER(a."factor") = UPPER(b."module" || '.' || b."name")
ORDER BY a."set"::INT, a."factor"
;

INSERT INTO "wte"."design_setting" ("design_config_gid", "set", "variable_gid", "min_value", "max_value", "model_value", "description")
SELECT (SELECT "gid" FROM "wte"."design_config" WHERE "description" = 'vbsa.biogas.rotus.6feb') AS "design_config_gid"
     , a."set"::INT                                                                             AS "set"
     , COALESCE(b."gid", -999)                                                                  AS "variable_gid"
     , a."min"::NUMERIC                                                                         AS "min_value"
     , a."max"::NUMERIC                                                                         AS "max_value"
     , a."value"::NUMERIC                                                                       AS "model_value"
     , a."notes"::TEXT                                                                          AS "description"
FROM      "dhetting"."vbsa.biogas.rotus.6feb" a
LEFT JOIN "wte"."variable"                    b ON UPPER(a."factor") = UPPER(b."module" || '.' || b."name")
ORDER BY a."set"::INT, a."factor"
;

-- @TODO: need EE design settings
