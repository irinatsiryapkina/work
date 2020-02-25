DROP   TABLE IF EXISTS "wte"."model" CASCADE;
CREATE TABLE           "wte"."model" (
    "gid"         SERIAL NOT NULL PRIMARY KEY
  , "commit"      TEXT       NULL UNIQUE
  , "description" TEXT       NULL DEFAULT now()
);
COMMENT ON TABLE "wte"."model" IS 'Model version described by git commit value and text description';

INSERT INTO "wte"."model" ("commit", "description")
VALUES ('2e28c6bb0c1fe975a4dbefcd4c098a5dcb275548',                                         'jan 4 version')
     , ('/Box Sync/WESyS Project/Study_Designs/FY18/rotus_wesys/WESyS_rotus_2jan2017.STMX', 'ROTUS')
     , ('abf00ca4d0d3c679a02c2e80a35ea48ee14dcd55',                                         'jan 10 version')
     , ('28a6095016613c29289034268020d3b051e44f25',                                         'jan 24 version')
     , ('/Box Sync/WESyS Project/Study_Designs/FY18/rotus_wesys/WESyS_rotus_2jan2017.STMX', 'ROTUS')
;
