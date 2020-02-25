DROP   TABLE IF EXISTS "wte"."model_run" CASCADE;
CREATE TABLE           "wte"."model_run" (
    "gid"         SERIAL NOT NULL PRIMARY KEY
  , "config_gid"  INT    NOT NULL REFERENCES "wte"."config"       ("gid")
  , "output_gid"  INT    NOT NULL REFERENCES "wte"."output_table" ("gid")
  , "log_gid"     INT        NULL REFERENCES "wte"."log"          ("gid")
  , "description" TEXT DEFAULT now()
);
COMMENT ON TABLE "wte"."model_run" IS 'Model execution metadata';
