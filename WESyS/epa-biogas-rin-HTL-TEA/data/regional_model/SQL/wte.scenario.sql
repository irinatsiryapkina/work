DROP   TABLE IF EXISTS "wte"."scenario" CASCADE;
CREATE TABLE           "wte"."scenario" (
    "gid"         SERIAL NOT NULL PRIMARY KEY
  , "name"        TEXT   NOT NULL UNIQUE
  , "description" TEXT   NOT NULL DEFAULT now()
);
COMMENT ON TABLE "wte"."scenario" IS 'Available scenarios (collections of vignettes)';

INSERT INTO "wte"."scenario" ("name", "description")
VALUES ('no_vignette_ca',    'pre-vignette CA')
     , ('no_vignette_rotus', 'pre-vignette ROTUS')
;
