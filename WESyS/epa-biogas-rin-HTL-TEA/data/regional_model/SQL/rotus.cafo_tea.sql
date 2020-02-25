CREATE OR REPLACE VIEW "rotus"."cafo_tea" AS (
  SELECT * FROM "national"."cafo_tea"
);

COMMENT ON VIEW "rotus"."cafo_tea" IS 'Collects TEA data for ROTUS CAFOs by CAFOSize (CAFOSmall, CAFOMed, CAFOLarge), CaptureStatus (NoCapture, HaveCapture), CAFOType (Beef, Swine, Dairy), WTEConfig (Elec, CNG, PNG, TCFuel, BCFuel- currently no data for HTL or FT). Corresponds to variables CAFO.Expected Op Cost, CAFO.ExpectedFCI, and CAFO.Coproduct Sales Rev Input. To get these variables, just select the appropriate column from cafo_tea. We do not have data for CAFOs with CaptureStatus of HaveCapture all of these values should be set to 1e9'
;
