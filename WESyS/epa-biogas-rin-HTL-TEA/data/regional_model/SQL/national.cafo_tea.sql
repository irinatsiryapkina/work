CREATE OR REPLACE VIEW "national"."cafo_tea" AS (
  SELECT"size" AS "CAFOSize"
      , "type" AS "CAFOType"
      , 'NoCapture' AS "CaptureStatus"
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
  WHERE "wesys_module"  = 'CAFO'
    AND "technology"   != 'Digester Only'
    AND "technology"   != 'HTL to biofuel'
  ORDER BY "CaptureStatus"
         , "CAFOSize"
         , "WTEConfig"
);

COMMENT ON VIEW "national"."cafo_tea" IS
'Collects TEA data for CAFOs
    by CAFOSize (CAFOSmall, CAFOMed, CAFOLarge)
    by CaptureStatus (NoCapture, HaveCapture)
    by CAFOType (
    by WTEConfig (Elec, CNG, PNG, TCFuel, BCFuel)  currently no data for HTL or FT
Corresponds to data for the following Stella variables
    CAFO.Expected Op Cost
    CAFO.ExpectedFCI
    CAFO.Coproduct Sales Rev Input

To get these variables, just select the appropriate column from cafo_tea

We do not have data for CAFOs with CaptureStatus of HaveCapture all of these values should be set to 1e9
';
