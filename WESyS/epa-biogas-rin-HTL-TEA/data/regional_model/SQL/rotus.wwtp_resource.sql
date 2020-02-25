CREATE OR REPLACE VIEW "rotus"."wwtp_resource" AS (
  WITH "size_table" AS (SELECT "uid"
                             , CASE WHEN "avg_flow_mgd" <    1                          THEN 'WWTP0to1'
                                    WHEN "avg_flow_mgd" <   10 AND "avg_flow_mgd" >=  1 THEN 'WWTP1to10'
                                    WHEN "avg_flow_mgd" <  100 AND "avg_flow_mgd" >= 10 THEN 'WWTP10to100'
                                    WHEN "avg_flow_mgd" >= 100                          THEN 'WWTP100Up'
                                    ELSE NULL
                               END AS "WWTPSize"
                        FROM "pnnl"."seiple_2017_sludge"
  )
  SELECT b."WWTPSize"
       , COUNT(DISTINCT b.uid)           AS "number_facilities"
       , ROUND(AVG(a."avg_flow_mgd"), 2) AS avg_flow_mgd_avg
       , CASE WHEN b."WWTPSize" = 'WWTP0to1'    THEN ROUND(AVG(a."avg_flow_mgd" * 283.168 * 365 * 0.65 * 0.41), 0) -- 283.168 m3 methane/MG; 365 days/yr; 0.65 = fractional amount of methane in wwtp biogas; x percent relevant facilities
              WHEN b."WWTPSize" = 'WWTP1to10'   THEN ROUND(AVG(a."avg_flow_mgd" * 283.168 * 365 * 0.65 * 0.51), 0) -- 283.168 m3 methane/MG; 365 days/yr; 0.65 = fractional amount of methane in wwtp biogas; x percent relevant facilities
              WHEN b."WWTPSize" = 'WWTP10to100' THEN ROUND(AVG(a."avg_flow_mgd" * 283.168 * 365 * 0.65 * 0.65), 0) -- 283.168 m3 methane/MG; 365 days/yr; 0.65 = fractional amount of methane in wwtp biogas; x percent relevant facilities
              WHEN b."WWTPSize" = 'WWTP100Up'   THEN ROUND(AVG(a."avg_flow_mgd" * 283.168 * 365 * 0.65 * 0.76), 0) -- 283.168 m3 methane/MG; 365 days/yr; 0.65 = fractional amount of methane in wwtp biogas; x percent relevant facilities
              ELSE NULL
      END AS "avg_methane_m3_per_facility_yr"
  FROM      "pnnl"."seiple_2017_sludge" a
  LEFT JOIN "size_table"                b ON b."uid" = a."uid"
  WHERE a."state_abbr" != 'CA'
  GROUP BY b."WWTPSize"
);

COMMENT ON VIEW "rotus"."wwtp_resource" IS
'Collects resource data for ROTUS WWTPs by WWTPSize (WWTP0to1, WWTP1to10, WWTP10to100, WWTP100Up).

Corresponds to data for the following Stella variables
    CA WWTP.Initial_WTE_Distribution (number facilities)
    CA WWTP.per_facility_CH4_collection (avg_methane_m3_per_facility_yr)
    CA WWTP.daily_facility_influx (avg_flow_mgd_avg)

TO get these variables, select the appropriate column from wwtp_resource'
;
