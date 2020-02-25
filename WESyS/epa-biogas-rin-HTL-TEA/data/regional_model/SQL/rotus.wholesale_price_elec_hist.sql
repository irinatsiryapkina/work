CREATE OR REPLACE VIEW "rotus"."wholesale_price_elec_hist" AS (
  SELECT EXTRACT(YEAR FROM "trade_date")                                                                                                     AS "trade_year"
       , AVG("wtd_avg_price_dol_mwh" * (1.0 / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'MWh' AND "to_unit" = 'GGE'))) AS "wtd_avg_price_dol_gge"  -- Convert from MWh to GGE. 1 MWh is equal to 31 GGE. Source https://epact.energy.gov/fuel-conversion-factors
  FROM "eia"."ice_electric"
  WHERE "price_hub" NOT IN ('NP 15 EZ Gen DA LMP Peak'
                          , 'NP15 EZ Gen DA LMP Peak'
                          , 'SP15 EZ Gen DA LMP Peak'
                          , 'SP-15 Gen DA LMP Peak')
  GROUP BY 1
);

COMMENT ON VIEW "rotus"."wholesale_price_elec_hist" IS '';
