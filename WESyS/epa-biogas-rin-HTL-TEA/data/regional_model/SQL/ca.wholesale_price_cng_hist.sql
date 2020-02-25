CREATE OR REPLACE VIEW "ca"."wholesale_price_cng_hist" AS (
  SELECT EXTRACT(YEAR FROM "trade_date")               AS "trade_year"
       , AVG("wtd_avg_price_dol_mmbtu" * (1.0 / (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'MMBtu' AND "to_unit" = 'GGE'))) AS "wtd_avg_price_dol_gge"  -- Convert from MMBtu to GGE. 1 MMBtu is equal to 8.77 GGE. Source http://www.nat-g.com/why-cng/cng-units-explained/
  FROM "eia"."ice_natgas"
  WHERE "price_hub" IN ('PG&E - Citygate'
                      , 'Socal-Citygate')
  GROUP BY 1
);

COMMENT ON VIEW "ca"."wholesale_price_cng_hist" IS '';
