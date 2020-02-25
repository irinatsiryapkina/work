DROP   TABLE IF EXISTS "wte"."vignette" CASCADE;
CREATE TABLE           "wte"."vignette" (
    "gid"         SERIAL NOT NULL PRIMARY KEY
  , "schema"      TEXT   NOT NULL
  , "table"       TEXT   NOT NULL
  , "description" TEXT DEFAULT now()
);
COMMENT ON TABLE "wte"."vignette" IS 'Available vignettes';

INSERT INTO "wte"."vignette" ("schema", "table", "description")
VALUES ('pre_vignettes', 'pre_vignettes', 'place holder for runs executed with vignettes')
     , ('vignettes',     'null',          'all NULL values')
     , ('vignettes',     'base',          'all non-regional values ')
     , ('vignettes',     'ca',            'all default CA values')
     , ('vignettes',     'rotus',         'all default ROTUS values')
;
