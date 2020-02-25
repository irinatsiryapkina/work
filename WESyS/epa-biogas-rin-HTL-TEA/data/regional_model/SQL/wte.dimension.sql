DROP   TABLE IF EXISTS "wte"."dimension" CASCADE;
CREATE TABLE           "wte"."dimension" (
    "gid"  SERIAL NOT NULL PRIMARY KEY
  , "name" TEXT   NOT NULL UNIQUE
);
COMMENT ON TABLE "wte"."dimension" IS 'Available model dimensions';

INSERT INTO "wte"."dimension" ("name")
VALUES ('AlgalTech')
     , ('AnnualCrop')
     , ('CAFOSize')
     , ('CAFOType')
     , ('CaptureStatus')
     , ('Car_v_Truck')
     , ('CelluloseType')
     , ('CohortSlot')
     , ('ConversionPolicy')
     , ('CtoATech')
     , ('CtoRRTech')
     , ('GasPriceScenario')
     , ('LCFS_Standard')
     , ('LFSize')
     , ('LFStatus')
     , ('LogisticsMaturity')
     , ('OilCropTech')
     , ('Owner')
     , ('PECrop')
     , ('Policy')
     , ('ProdnYear')
     , ('RefineryProduct')
     , ('Region')
     , ('Scenario')
     , ('TechAttribute')
     , ('Technology')
     , ('VehicleTech')
     , ('WTEConfig')
     , ('WWTPSize')
;
