DROP   TABLE IF EXISTS "wte"."dimension_dimension_value";
CREATE TABLE           "wte"."dimension_dimension_value" (
    "dimension_gid"       INT NOT NULL REFERENCES "wte"."dimension"       ("gid")
  , "dimension_value_gid" INT NOT NULL REFERENCES "wte"."dimension_value" ("gid")
  , CONSTRAINT "dimension_dimension_value_pkey" PRIMARY KEY ("dimension_gid", "dimension_value_gid")
);
COMMENT ON TABLE "wte"."dimension_dimension_value" IS 'Dimension values belonging to a dimension';

INSERT INTO "wte"."dimension_dimension_value" ("dimension_gid", "dimension_value_gid")
VALUES ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'AlgalTech'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Pond'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'AlgalTech'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'PBR'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'AlgalTech'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Element_3'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'AnnualCrop'),        (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Corn'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'AnnualCrop'),        (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Soy'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'AnnualCrop'),        (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Wheat'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'AnnualCrop'),        (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Other_Grains'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'AnnualCrop'),        (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Cotton'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CAFOSize'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'CAFOSmall'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CAFOSize'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'CAFOMed'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CAFOSize'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'CAFOLarge'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CAFOType'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Beef'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CAFOType'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Dairy'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CAFOType'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Swine'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CaptureStatus'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'NoCapture'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CaptureStatus'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'HaveCapture'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Car_v_Truck'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Car'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Car_v_Truck'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Truck'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CelluloseType'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Res'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CelluloseType'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Herb'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CelluloseType'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Wood'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CelluloseType'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Forest'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CelluloseType'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Urban'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'ConversionPolicy'),  (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Price'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'ConversionPolicy'),  (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Feedstock'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'ConversionPolicy'),  (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'FCI'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'ConversionPolicy'),  (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Loan'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CtoATech'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'BC'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CtoATech'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'TC'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CtoATech'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Combo'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CtoRRTech'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'FP'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CtoRRTech'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'FT'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CtoRRTech'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'MTG'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CtoRRTech'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'CP'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CtoRRTech'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'F'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'CtoRRTech'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'APR'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'GasPriceScenario'),  (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'GAS_AEO_REF'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'GasPriceScenario'),  (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'GAS_AEO_HM'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'GasPriceScenario'),  (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'GAS_AEO_LM'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'GasPriceScenario'),  (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'GAS_AEO_HP'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'GasPriceScenario'),  (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'GAS_AEO_LP'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'GasPriceScenario'),  (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'GAS_AD_HOC_1'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'GasPriceScenario'),  (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'GAS_AD_HOC_2'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'GasPriceScenario'),  (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'GAS_USER'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'LCFS_Standard'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Gasoline'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'LCFS_Standard'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Diesel'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'LFSize'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'LFSmall'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'LFSize'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'LFLarge'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'LFStatus'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Inactive'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'LFStatus'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Active'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'LogisticsMaturity'), (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Conventional'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'LogisticsMaturity'), (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Pioneer'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'LogisticsMaturity'), (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Advanced'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'OilCropTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'SoyBean'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'OilCropTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'OtherOC'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Owner'),             (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'OilOwned'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Owner'),             (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'BrandIndep'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Owner'),             (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'UnbrandIndep'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Owner'),             (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'HMart'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'PECrop'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Herbaceous'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'PECrop'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Woody'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Policy'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'FCI'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Policy'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Loan'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'RefineryProduct'),   (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'gasoline'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'RefineryProduct'),   (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'diesel'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'RefineryProduct'),   (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'JetFuel'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'RefineryProduct'),   (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'AllOther'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Region'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'NE'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Region'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'A'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Region'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'SE'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Region'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'DS'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Region'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'CB'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Region'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'LS'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Region'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'NP'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Region'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'SP'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Region'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'M'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Region'),            (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'P'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Scenario'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'base'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Scenario'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Lo'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Scenario'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Med'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Scenario'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Hi'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Scenario'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'AEO2009'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Scenario'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'EISA2007'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'TechAttribute'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'ProcessYield'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'TechAttribute'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'PSuccess'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'TechAttribute'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'InputCap'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'TechAttribute'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'CapitalCost'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'TechAttribute'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Risk'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'TechAttribute'),     (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'DebtFrac'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Technology'),        (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'S'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Technology'),        (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'SPlus'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Technology'),        (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'BC'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Technology'),        (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'TC'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'Technology'),        (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Combo'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'VehicleTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Gas'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'VehicleTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Diesel'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'VehicleTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'PlugInElectric'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'VehicleTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Hydrogen'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'VehicleTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'CNG'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'VehicleTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'FFV'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'VehicleTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'GasHev'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'VehicleTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'GasPhev'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'VehicleTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'MethanolPropane'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'VehicleTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'RSPV'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'VehicleTech'),       (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Scenario'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WTEConfig'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'NoWTE'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WTEConfig'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'CF'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WTEConfig'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'Elec'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WTEConfig'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'CNG'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WTEConfig'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'PNG'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WTEConfig'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'BCFuel'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WTEConfig'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'TCFUEL'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WTEConfig'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'HTL'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WTEConfig'),         (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'FT'))

     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WWTPSize'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'WWTP0to1'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WWTPSize'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'WWTP1to10'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WWTPSize'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'WWTP10to100'))
     , ((SELECT "gid" FROM "wte"."dimension" WHERE "name" = 'WWTPSize'),          (SELECT "gid" FROM "wte"."dimension_value" WHERE "name" = 'WWTP100Up'))
;
