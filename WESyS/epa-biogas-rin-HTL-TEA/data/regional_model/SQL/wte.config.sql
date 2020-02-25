DROP   TABLE IF EXISTS "wte"."config" CASCADE;
CREATE TABLE           "wte"."config" (
    "gid"               SERIAL NOT NULL PRIMARY KEY
  , "model_gid"         INT    NOT NULL REFERENCES "wte"."model"         ("gid")
  , "scenario_gid"      INT    NOT NULL REFERENCES "wte"."scenario"      ("gid")
  , "design_config_gid" INT        NULL REFERENCES "wte"."design_config" ("gid")
  , "description"       TEXT       NULL DEFAULT now()
  , CONSTRAINT "config_unq" UNIQUE ("model_gid", "scenario_gid", "design_config_gid")
);
COMMENT ON TABLE "wte"."config" IS 'Configurations for model executions (combinations of a model and scenario with an optional study design config for sensitivity studies';

INSERT INTO "wte"."config" ("model_gid", "scenario_gid", "design_config_gid", "description")
VALUES ((SELECT "gid" FROM "wte"."model"         WHERE "commit" = '2e28c6bb0c1fe975a4dbefcd4c098a5dcb275548')                                                               AS "model_gid"
      , (SELECT "gid" FROM "wte"."scenario"      WHERE "name"   = 'no_vignette_ca')                                                                                         AS "scenario_gid"
      , (SELECT "gid" FROM "wte"."design_config" WHERE "name"   = '~/epa-biogas-rin/studies/FY18/sensitivity/src/ee/designs/ca.ee.test_ca_25traj_4jan2017.csv')             AS "design_config_gid"

    ), ((SELECT "gid" FROM "wte"."model"         WHERE "commit" = 'abf00ca4d0d3c679a02c2e80a35ea48ee14dcd55')                                                               AS "model_gid"
      , (SELECT "gid" FROM "wte"."scenario"      WHERE "name"   = 'no_vignette_ca')                                                                                         AS "scenario_gid"
      , (SELECT "gid" FROM "wte"."design_config" WHERE "name"   = '~/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/input.settings/vbsa.sludge.ca.10jan.csv')             AS "design_config_gid"

    ), ((SELECT "gid" FROM "wte"."model"         WHERE "commit" = '28a6095016613c29289034268020d3b051e44f25')                                                               AS "model_gid"
      , (SELECT "gid" FROM "wte"."scenario"      WHERE "name"   = 'no_vignette_ca')                                                                                         AS "scenario_gid"
      , (SELECT "gid" FROM "wte"."design_config" WHERE "name"   = '~/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design_configs/vbsa.biogas.ca.20jan.csv')               AS "design_config_gid"

    ), ((SELECT "gid" FROM "wte"."model"         WHERE "commit" = '/Box Sync/WESyS Project/Study_Designs/FY18/rotus_wesys/WESyS_rotus_2jan2017.STMX')                       AS "model_gid"
      , (SELECT "gid" FROM "wte"."scenario"      WHERE "name"   = 'no_vignette_rotus')                                                                                      AS "scenario_gid"
      , (SELECT "gid" FROM "wte"."design_config" WHERE "name"   = '~/src/epa-biogas-rin/studies/FY18/sensitivity/src/ee/designs/rotus.ee.test_rotus_25traj_2jan2017.csv')   AS "design_config_gid"

    ), ((SELECT "gid" FROM "wte"."model"         WHERE "commit" = '/Box Sync/WESyS Project/Study_Designs/FY18/rotus_wesys/WESyS_rotus_2jan2017.STMX')                       AS "model_gid"
      , (SELECT "gid" FROM "wte"."scenario"      WHERE "name"   = 'no_vignette_rotus')                                                                                      AS "scenario_gid"
      , (SELECT "gid" FROM "wte"."design_config" WHERE "name"   = '~/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design_configs/vbsa.sludge.rotus.5feb.csv')             AS "design_config_gid"

    ), ((SELECT "gid" FROM "wte"."model"         WHERE "commit" = '/Box Sync/WESyS Project/Study_Designs/FY18/rotus_wesys/WESyS_rotus_2jan2017.STMX')                       AS "model_gid"
      , (SELECT "gid" FROM "wte"."scenario"      WHERE "name"   = 'no_vignette_rotus')                                                                                      AS "scenario_gid"
      , (SELECT "gid" FROM "wte"."design_config" WHERE "name"   = '~/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design_configs/vbsa.biogas.rotus.6feb.csv')             AS "design_config_gid"

    ), ((SELECT "gid" FROM "wte"."model"         WHERE "commit" = '/Box Sync/WESyS Project/Study_Designs/FY18/rotus_wesys/WESyS_rotus_2jan2017.STMX')                       AS "model_gid"
      , (SELECT "gid" FROM "wte"."scenario"      WHERE "name"   = 'no_vignette_rotus')                                                                                      AS "scenario_gid"
      , (SELECT "gid" FROM "wte"."design_config" WHERE "name"   = '~/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design_configs/vbsa.biogas.rotus.6feb.csv')             AS "design_config_gid"
);
