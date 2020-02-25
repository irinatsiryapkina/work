CREATE OR REPLACE VIEW "national"."landfill_tea" AS (
  SELECT "size" AS "LFSize"
       , "status" AS "LFStatus"
       , CASE WHEN "type" = 'Existing flare' THEN 'HaveCapture'::TEXT
              WHEN "type" = 'No flare'       THEN 'NoCapture'::TEXT
              ELSE NULL
         END AS "CaptureStatus"
       , CASE WHEN "technology" = 'HTL to biocrude'  THEN 'HTL'::TEXT
              WHEN "technology" = 'CHP'              THEN 'Elec'::TEXT
              WHEN "technology" = 'Biochem. Fuel'    THEN 'BCFuel'::TEXT
              WHEN "technology" = 'Thermochem. Fuel' THEN 'TCFuel'::TEXT
              ELSE "technology"
          END AS "WTEConfig"
       , "total_capex_dol_op"
       , "total_opex_dol_yr_op"
       , "total_methane_collection_m3_op_yr"
       , "co_product_revenue_dol_yr_op"
  FROM "nrel"."tea"
  WHERE "wesys_module"  = 'Landfill' 
    AND "technology"   != 'Digester Only' 
    AND "technology"   != 'HTL to biofuel'
  ORDER BY "LFStatus"
         , "CaptureStatus"
         , "LFSize"
         , "WTEConfig"
);

COMMENT ON VIEW "national"."landfill_tea" IS
'Collects TEA data for landfills
    by LFSize (LFSmall, LFLarge)
    by LFStatus (active, inactive)  active = open; inactive = closed
    by CaptureStatus (NoCapture, HaveCapture)
    by WTEConfig (Elec, CNG, PNG, TCFuel, BCFuel)  currently no data for HTL or FT
Corresponds to data for the following Stella variables
    Landfill.Expected Op Cost
    Landfill.ExpectedFCI
    Landfill.Coproduct Sales Rev Input

To get these variables, just select the appropriate column from landfill_tea'
;
