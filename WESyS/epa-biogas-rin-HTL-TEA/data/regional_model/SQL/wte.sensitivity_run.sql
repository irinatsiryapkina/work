DROP   TABLE IF EXISTS "wte"."sensitivity_run" CASCADE;
CREATE TABLE           "wte"."sensitivity_run" (
    "gid"           SERIAL NOT NULL PRIMARY KEY
  , "run_id"        INT    NOT NULL DEFAULT 1
  , "model_run_gid" INT    NOT NULL REFERENCES "wte"."model_run" ("gid")
);
COMMENT ON TABLE "wte"."sensitivity_run" IS 'Sensitivity run metadata';
