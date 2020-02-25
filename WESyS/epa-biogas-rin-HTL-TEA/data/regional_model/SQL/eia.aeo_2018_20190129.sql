RESET ROLE;

GRANT SELECT ON TABLE "dhetting"."np2014_d1" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "eia"."_aeo_2018_20190129";
CREATE TABLE           "eia"."_aeo_2018_20190129" AS
SELECT * FROM "dhetting"."aeo_2018"
;
COMMENT ON TABLE "eia"."_aeo_2018_20190129" IS 'EIA AEO 2018 projections: AEO.2018.HIGHPRICE.PRCE_NA_ELEP_NA_GEN_NA_USA_Y13CNTPKWH.A, AEO.2018.LOWPRICE.PRCE_NA_ELEP_NA_GEN_NA_USA_Y13CNTPKWH.A, AEO.2018.REF2018.PRCE_NA_ELEP_NA_GEN_NA_USA_Y13CNTPKWH.A, AEO.2018.HIGHPRICE.PRCE_NA_COMM_NA_EDU_NA_USA_Y13CNTPKWH.A, AEO.2018.LOWPRICE.PRCE_NA_COMM_NA_EDU_NA_USA_Y13CNTPKWH.A, AEO.2018.REF2018.PRCE_NA_COMM_NA_EDU_NA_USA_Y13CNTPKWH.A, AEO.2018.HIGHPRICE.PRCE_NA_COMM_NA_NG_NA_USA_Y13DLRPMCF.A, AEO.2018.LOWPRICE.PRCE_NA_COMM_NA_NG_NA_USA_Y13DLRPMCF.A, AEO.2018.REF2018.PRCE_NA_COMM_NA_NG_NA_USA_Y13DLRPMCF.A, AEO.2018.HIGHPRICE.PRCE_NA_NA_NA_CR_NA_L48_Y13DLRPBBL.A, AEO.2018.LOWPRICE.PRCE_NA_NA_NA_CR_NA_L48_Y13DLRPBBL.A, AEO.2018.REF2018.PRCE_NA_NA_NA_CR_NA_L48_Y13DLRPBBL.A, AEO.2018.HIGHPRICE.PRCE_NA_TRN_NA_DFU_NA_USA_Y13DLRPGLN.A, AEO.2018.LOWPRICE.PRCE_NA_TRN_NA_DFU_NA_USA_Y13DLRPGLN.A, AEO.2018.REF2018.PRCE_NA_TRN_NA_DFU_NA_USA_Y13DLRPGLN.A, AEO.2018.HIGHPRICE.PRCE_NA_TRN_NA_MGS_NA_USA_Y13DLRPGLN.A, AEO.2018.LOWPRICE.PRCE_NA_TRN_NA_MGS_NA_USA_Y13DLRPGLN.A, AEO.2018.REF2018.PRCE_NA_TRN_NA_MGS_NA_USA_Y13DLRPGLN.A, AEO.2018.HIGHPRICE.PRCE_NA_NA_NA_NG_NA_USA_Y13DLRPMCF.A, AEO.2018.LOWPRICE.PRCE_NA_NA_NA_NG_NA_USA_Y13DLRPMCF.A, AEO.2018.REF2018.PRCE_NA_NA_NA_NG_NA_USA_Y13DLRPMCF.A';
ANALYZE          "eia"."_aeo_2018_20190129";

-- clean copy
DROP   TABLE IF EXISTS "eia"."aeo_2018_20190129";
CREATE TABLE           "eia"."aeo_2018_20190129" (
    "year"                             INT     NOT NULL PRIMARY KEY
  , "generation_electricity_high"      NUMERIC NOT NULL
  , "generation_electricity_low"       NUMERIC NOT NULL
  , "generation_electricity_reference" NUMERIC NOT NULL
  , "commercial_electricity_high"      NUMERIC NOT NULL
  , "commercial_electricity_low"       NUMERIC NOT NULL
  , "commercial_electricity_reference" NUMERIC NOT NULL
  , "commercial_nat_gas_high"          NUMERIC NOT NULL
  , "commercial_nat_gas_low"           NUMERIC NOT NULL
  , "commercial_nat_gas_reference"     NUMERIC NOT NULL
  , "crude_oil_avg_wellhead_high"      NUMERIC NOT NULL
  , "crude_oil_avg_wellhead_low"       NUMERIC NOT NULL
  , "crude_oil_avg_wellhead_reference" NUMERIC NOT NULL
  , "diesel_fuel_high"                 NUMERIC NOT NULL
  , "diesel_fuel_low"                  NUMERIC NOT NULL
  , "diesel_fuel_reference"            NUMERIC NOT NULL
  , "gasoline_fuel_high"               NUMERIC NOT NULL
  , "gasoline_fuel_low"                NUMERIC NOT NULL
  , "gasoline_fuel_reference"          NUMERIC NOT NULL
  , "avg_delivered_ng_high"            NUMERIC NOT NULL
  , "avg_delivered_ng_low"             NUMERIC NOT NULL
  , "avg_delivered_reference"          NUMERIC NOT NULL
);

COMMENT ON TABLE "eia"."aeo_2018_20190129" IS 'EIA AEO 2018 projections: AEO.2018.HIGHPRICE.PRCE_NA_ELEP_NA_GEN_NA_USA_Y13CNTPKWH.A, AEO.2018.LOWPRICE.PRCE_NA_ELEP_NA_GEN_NA_USA_Y13CNTPKWH.A, AEO.2018.REF2018.PRCE_NA_ELEP_NA_GEN_NA_USA_Y13CNTPKWH.A, AEO.2018.HIGHPRICE.PRCE_NA_COMM_NA_EDU_NA_USA_Y13CNTPKWH.A, AEO.2018.LOWPRICE.PRCE_NA_COMM_NA_EDU_NA_USA_Y13CNTPKWH.A, AEO.2018.REF2018.PRCE_NA_COMM_NA_EDU_NA_USA_Y13CNTPKWH.A, AEO.2018.HIGHPRICE.PRCE_NA_COMM_NA_NG_NA_USA_Y13DLRPMCF.A, AEO.2018.LOWPRICE.PRCE_NA_COMM_NA_NG_NA_USA_Y13DLRPMCF.A, AEO.2018.REF2018.PRCE_NA_COMM_NA_NG_NA_USA_Y13DLRPMCF.A, AEO.2018.HIGHPRICE.PRCE_NA_NA_NA_CR_NA_L48_Y13DLRPBBL.A, AEO.2018.LOWPRICE.PRCE_NA_NA_NA_CR_NA_L48_Y13DLRPBBL.A, AEO.2018.REF2018.PRCE_NA_NA_NA_CR_NA_L48_Y13DLRPBBL.A, AEO.2018.HIGHPRICE.PRCE_NA_TRN_NA_DFU_NA_USA_Y13DLRPGLN.A, AEO.2018.LOWPRICE.PRCE_NA_TRN_NA_DFU_NA_USA_Y13DLRPGLN.A, AEO.2018.REF2018.PRCE_NA_TRN_NA_DFU_NA_USA_Y13DLRPGLN.A, AEO.2018.HIGHPRICE.PRCE_NA_TRN_NA_MGS_NA_USA_Y13DLRPGLN.A, AEO.2018.LOWPRICE.PRCE_NA_TRN_NA_MGS_NA_USA_Y13DLRPGLN.A, AEO.2018.REF2018.PRCE_NA_TRN_NA_MGS_NA_USA_Y13DLRPGLN.A, AEO.2018.HIGHPRICE.PRCE_NA_NA_NA_NG_NA_USA_Y13DLRPMCF.A, AEO.2018.LOWPRICE.PRCE_NA_NA_NA_NG_NA_USA_Y13DLRPMCF.A, AEO.2018.REF2018.PRCE_NA_NA_NA_NG_NA_USA_Y13DLRPMCF.A';

INSERT INTO "eia"."aeo_2018_20190129" ("year"
                                     , "generation_electricity_high"
                                     , "generation_electricity_low"
                                     , "generation_electricity_reference"
                                     , "commercial_electricity_high"
                                     , "commercial_electricity_low"
                                     , "commercial_electricity_reference"
                                     , "commercial_nat_gas_high"
                                     , "commercial_nat_gas_low"
                                     , "commercial_nat_gas_reference"
                                     , "crude_oil_avg_wellhead_high"
                                     , "crude_oil_avg_wellhead_low"
                                     , "crude_oil_avg_wellhead_reference"
                                     , "diesel_fuel_high"
                                     , "diesel_fuel_low"
                                     , "diesel_fuel_reference"
                                     , "gasoline_fuel_high"
                                     , "gasoline_fuel_low"
                                     , "gasoline_fuel_reference"
                                     , "avg_delivered_ng_high"
                                     , "avg_delivered_ng_low"
                                     , "avg_delivered_reference")
SELECT "year"
     , "generation_electricity_high"
     , "generation_electricity_low"
     , "generation_electricity_reference"
     , "commercial_electricity_high"
     , "commercial_electricity_low"
     , "commercial_electricity_reference"
     , "commercial_nat_gas_high"
     , "commercial_nat_gas_low"
     , "commercial_nat_gas_reference"
     , "crude_oil_avg_wellhead_high"
     , "crude_oil_avg_wellhead_low"
     , "crude_oil_avg_wellhead_reference"
     , "diesel_fuel_high"
     , "diesel_fuel_low"
     , "diesel_fuel_reference"
     , "gasoline_fuel_high"
     , "gasoline_fuel_low"
     , "gasoline_fuel_reference"
     , "avg_delivered_ng_high"
     , "avg_delivered_ng_low"
     , "avg_delivered_reference"
FROM "eia"."aeo_2018_20190129"
ORDER BY "year"
;

RESET ROLE;
