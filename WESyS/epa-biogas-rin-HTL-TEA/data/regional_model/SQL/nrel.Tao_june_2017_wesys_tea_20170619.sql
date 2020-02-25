RESET ROLE;

GRANT SELECT ON "dhetting"."Tao_june_2017_wesys_tea" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "nrel"."_Tao_june_2017_wesys_tea_20170619";
CREATE TABLE           "nrel"."_Tao_june_2017_wesys_tea_20170619" AS
      SELECT * FROM "dhetting"."Tao_june_2017_wesys_tea"
;
COMMENT ON TABLE "nrel"."_Tao_june_2017_wesys_tea_20170619" IS 'spreadsheet from Ling Tao at NREL. May 19, 2017.';


-- clean copy
DROP   TABLE IF EXISTS "nrel"."Tao_june_2017_wesys_tea_20170619";
CREATE TABLE           "nrel"."Tao_june_2017_wesys_tea_20170619" (
       "gid"                                                          SERIAL PRIMARY KEY
     , "wesys_module"                                                 TEXT
     , "type"                                                         TEXT
     , "size"                                                         TEXT
     , "status"                                                       TEXT
     , "size_range"                                                   TEXT
     , "anaerobic_digestion_system"                                   TEXT
     , "technology"                                                   TEXT
     , "total_capex_dol_op"                                           NUMERIC
     , "total_opex_dol_yr_op"                                         NUMERIC
     , "total_methane_collection_m3_op_yr"                            NUMERIC
     , "co_product_revenue_dol_yr_op"                                 NUMERIC
     , "methane_collection_m3_op_yr_cafo_and_wwtp_or_m3_ton_yr_landf" NUMERIC
     , "methane_collection_m3_op_yr"                                  NUMERIC
     , "methan_collection_mmbtu_op_yr"                                NUMERIC
     , "ad_capex_dol_op"                                              NUMERIC
     , "ad_capex_dol_op_calc"                                         NUMERIC
     , "ad_opex_dol_yr_op"                                            NUMERIC
     , "ad_post_digestion_solids_opex_dol_yr_op"                      NUMERIC
     , "total_ad_fixed_costs_dol_yr_op"                               NUMERIC
     , "gas_collection_capex_dol_op"                                  NUMERIC
     , "gas_collection_capex_dol_op_calc"                             NUMERIC
     , "conditioning_unit_capex_dol_op"                               NUMERIC
     , "conditioning_unit_capex_dol_op_calc"                          NUMERIC
     , "compressor_unit_capex_dol_op"                                 NUMERIC
     , "compressor_unit_capex_dol_op_calc"                            NUMERIC
     , "fuel_conversion_capex_dol_op"                                 NUMERIC
     , "fuel_conversion_capex_dol_op_calc"                            NUMERIC
     , "pipeline_transmission_capex_dol_op"                           NUMERIC
     , "total_non_ad_fci_dol_op"                                      NUMERIC
     , "gas_collection_opex_dol_yr_op"                                NUMERIC
     , "conditioning_unit_opex_dol_yr_op"                             NUMERIC
     , "compressor_unit_opex_dol_yr_op"                               NUMERIC
     , "pipeline_transmission_opex_dol_yr_op"                         NUMERIC
     , "pipeline_transmission_opex_dol_yr_op_calc"                    NUMERIC
     , "fuel_conversion_opex_dol_yr_op"                               NUMERIC
     , "utility_costs_dol_yr_op"                                      NUMERIC
     , "total_non_ad_fixed_operating_costs_dol_yr_op"                 NUMERIC
);

INSERT INTO "nrel"."Tao_june_2017_wesys_tea_20170619" (
     "wesys_module"
   , "type"
   , "size"
   , "status"
   , "size_range"
   , "anaerobic_digestion_system"
   , "technology"
   , "total_capex_dol_op"
   , "total_opex_dol_yr_op"
   , "total_methane_collection_m3_op_yr"
   , "co_product_revenue_dol_yr_op"
   , "methane_collection_m3_op_yr_cafo_and_wwtp_or_m3_ton_yr_landf"
   , "methane_collection_m3_op_yr"
   , "methan_collection_mmbtu_op_yr"
   , "ad_capex_dol_op"
   , "ad_capex_dol_op_calc"
   , "ad_opex_dol_yr_op"
   , "ad_post_digestion_solids_opex_dol_yr_op"
   , "total_ad_fixed_costs_dol_yr_op"
   , "gas_collection_capex_dol_op"
   , "gas_collection_capex_dol_op_calc"
   , "conditioning_unit_capex_dol_op"
   , "conditioning_unit_capex_dol_op_calc"
   , "compressor_unit_capex_dol_op"
   , "compressor_unit_capex_dol_op_calc"
   , "fuel_conversion_capex_dol_op"
   , "fuel_conversion_capex_dol_op_calc"
   , "pipeline_transmission_capex_dol_op"
   , "total_non_ad_fci_dol_op"
   , "gas_collection_opex_dol_yr_op"
   , "conditioning_unit_opex_dol_yr_op"
   , "compressor_unit_opex_dol_yr_op"
   , "pipeline_transmission_opex_dol_yr_op"
   , "pipeline_transmission_opex_dol_yr_op_calc"
   , "fuel_conversion_opex_dol_yr_op"
   , "utility_costs_dol_yr_op"
   , "total_non_ad_fixed_operating_costs_dol_yr_op"

)
SELECT DISTINCT
       NULLIF(regexp_replace("WESyS Module", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Type", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Size", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Status", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Size Range", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Anaerobic Digestion System", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Technology", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Total CAPEX $/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Total OPEX $/yr/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Total methane collection m3/op/yr", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Co-product revenue $/yr/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("methane collection m3/op/yr (CAFO and WWTP) or m3/ton/yr (landf", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("methane collection m3/op/yr", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("methan collection MMBTU/op/yr", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("AD CAPEX $/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("AD CAPEX $/op (Calc)", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("AD OPEX $/yr/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("AD post-digestion solids OPEX $/yr/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Total AD Fixed Costs $/yr/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Gas collection CAPEX $/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Gas collection CAPEX $/op (Calc)", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Conditioning unit CAPEX $/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Conditioning unit CAPEX $/op (Calc)", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Compressor unit CAPEX $/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Compressor unit CAPEX $/op (Calc)", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Fuel conversion CAPEX $/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Fuel conversion CAPEX $/op (Calc)", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Pipeline transmission CAPEX $/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Total Non-AD FCI $/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Gas collection OPEX $/yr/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Conditioning unit OPEX $/yr/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Compressor Unit OPEX $/yr/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Pipeline transmission OPEX $/yr/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Pipeline transmission OPEX $/yr/op (Calc)", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Fuel conversion OPEX $/yr/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Utility costs $/yr/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Total non-AD fixed operating costs $/yr/op", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
FROM "nrel"."_Tao_june_2017_wesys_tea_20170619"
ORDER BY 1, 2, 3, 4, 5, 6, 7
;
COMMENT ON TABLE "nrel"."Tao_june_2017_wesys_tea_20170619" IS 'spreadsheet from Ling Tao at NREL. May 19, 2017.';

--SELECT * FROM "nrel"."Tao_june_2017_wesys_tea_20170619";

RESET ROLE;
