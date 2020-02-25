DROP   TABLE IF EXISTS "wte"."module" CASCADE;
CREATE TABLE           "wte"."module" (
    "name"        TEXT NOT NULL PRIMARY KEY
  , "description" TEXT     NULL
);
COMMENT ON TABLE "wte"."module" IS 'Available model modules';

INSERT INTO "wte"."module" ("name", "description") VALUES ('CAFO',          'concentrated animal feeding operation');
INSERT INTO "wte"."module" ("name", "description") VALUES ('Global Inputs', 'model-wide constants and variables');
INSERT INTO "wte"."module" ("name", "description") VALUES ('LF',            'landfill');
INSERT INTO "wte"."module" ("name", "description") VALUES ('WWTP',          'waste water treatment plant')
;
