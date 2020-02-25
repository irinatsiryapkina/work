CREATE OR REPLACE VIEW "national"."wwtp_tea" AS (
  SELECT CASE WHEN "size" IN ('0-1', '1-5')                                  THEN 'WWTP0to1'::TEXT
              WHEN "size" IN ('1-10', '5-10')                                THEN 'WWTP1to10'::TEXT
              WHEN "size" IN ('10-100', '10-20', '20-50', '50-75', '75-100') THEN 'WWTP10to100'::TEXT
              WHEN "size" IN ('>100', '100-200', '>200')                     THEN 'WWTP100Up'::TEXT
              ELSE NULL
         END AS "WWTPSize"
       , CASE WHEN type = 'Existing flare' THEN 'HaveCapture'::TEXT
              WHEN type = 'No flare'       THEN 'NoCapture'::TEXT
              ELSE NULL
         END AS "CaptureStatus"
       , CASE WHEN technology = 'HTL to biocrude'  THEN 'HTL'::TEXT
              WHEN technology = 'CHP'              THEN 'Elec'::TEXT
              WHEN technology = 'Biochem. Fuel'    THEN 'BCFuel'::TEXT
              WHEN technology = 'Thermochem. Fuel' THEN 'TCFuel'::TEXT
              ELSE technology
         END AS "WTEConfig"
       , "type"
       , AVG(total_capex_dol_op)                AS "total_capex_dol_op_avg"
       , AVG(total_opex_dol_yr_op)              AS "total_opex_dol_yr_op_avg"
       , AVG(total_methane_collection_m3_op_yr) AS "total_methane_collection_m3_op_yr_avg"
       , AVG(co_product_revenue_dol_yr_op)      AS "co_product_revenue_dol_yr_op_avg"
  FROM "nrel"."tea"
  WHERE "wesys_module"                = 'WWTP'
    AND "anaerobic_digestion_system"  = 'CM'
    AND    "technology"                 != 'Digester Only'
    AND    "technology"                 != 'HTL to biofuel'
  GROUP BY "WWTPSize"
         , "CaptureStatus"
         , "WTEConfig"
         , "type"
  ORDER BY "CaptureStatus"
         , "WWTPSize"
         , "WTEConfig"
         , "type"
);

COMMENT ON VIEW "national"."wwtp_tea" IS
'Collects TEA data for WWTPs
    by WWTPSize (WWTP0to1, WWTP1to10, WWTP10to100, WWTP100Up) 
    by CaptureStatus (NoCapture, HaveCapture)
    by WTEConfig (Elec, CNG, PNG, TCFuel, BCFuel, HTL, FT) 
Corresponds to data for the following Stella variables 
    WWTP.Expected Op Cost
    WWTP.ExpectedFCI
    WWTP.Coproduct Sales Rev Input
    
To get these variables, just select the appropriate column from wwtp_tea 
'
;
