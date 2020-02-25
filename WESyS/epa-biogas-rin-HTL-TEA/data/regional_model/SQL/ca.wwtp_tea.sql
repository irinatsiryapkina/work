CREATE OR REPLACE VIEW "ca"."wwtp_tea" AS (
  SELECT * FROM "national"."wwtp_tea"
);

COMMENT ON VIEW "ca"."wwtp_tea" IS
'Collects CA TEA data for WWTPs
    by WWTPSize (WWTP0to1, WWTP1to10, WWTP10to100, WWTP100Up)
    by CaptureStatus (NoCapture, HaveCapture)
    by WTEConfig (Elec, CNG, PNG, TCFuel, BCFuel, HTL, FT)
Corresponds to data for the following Stella variables
    WWTP.Expected Op Cost
    WWTP.ExpectedFCI
    WWTP.Coproduct Sales Rev Input

To get these variables, just select the appropriate column from wwtp_tea'
;
