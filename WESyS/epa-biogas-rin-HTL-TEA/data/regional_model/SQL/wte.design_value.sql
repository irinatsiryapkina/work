DROP   TABLE IF EXISTS "wte"."design_value" CASCADE;
CREATE TABLE           "wte"."design_value" (
    "gid"                SERIAL  NOT NULL PRIMARY KEY
  , "design_setting_gid" INT         NULL REFERENCES "wte"."design_setting" ("gid")
  , "run_id"             INT     NOT NULL DEFAULT 1
  , "value"              NUMERIC NOT NULL
);
COMMENT ON TABLE "wte"."design_value" IS 'Sensitivity study values assigned to a study setting';
