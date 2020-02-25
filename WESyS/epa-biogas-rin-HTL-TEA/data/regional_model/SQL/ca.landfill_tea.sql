CREATE OR REPLACE VIEW "ca"."landfill_tea" AS (
  SELECT * FROM "national"."landfill_tea"
);

COMMENT ON VIEW "ca"."landfill_tea" IS
'Collects TEA data for landfills
        by LFSize (LFSmall, LFLarge)
        by LFStatus (active, inactive)  active = open; inactive = closed
        by CaptureStatus (NoCapture, HaveCapture)
        by WTEConfig (Elec, CNG, PNG, TCFuel, BCFuel)  currently no data for HTL or FT
 Corresponds to data for the following Stella variables 
       LF.Expected Op Cost
       LF.ExpectedFCI
       LF.Coproduct Sales Rev Input

 TO get these variables, just select the appropriate column from landfill_tea '
;
