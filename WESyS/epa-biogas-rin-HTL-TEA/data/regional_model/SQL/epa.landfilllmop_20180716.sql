RESET ROLE;

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "epa"."_landfilllmopdata_20180716" CASCADE;
CREATE TABLE           "epa"."_landfilllmopdata_20180716" (
      "GHGRP ID"                        TEXT
    , "Landfill ID"                     TEXT
    , "Landfill Name"                   TEXT
    , "State"                           TEXT
    , "Landfill Alias"                  TEXT
    , "Physical Address"                TEXT
    , "City"                            TEXT
    , "County"                          TEXT
    , "Zip Code"                        TEXT
    , "Latitude"                        TEXT
    , "Longitude"                       TEXT
    , "Ownership Type"                  TEXT
    , "Landfill Owner Organization(s)"  TEXT
    , "Landfill Operator Organization"  TEXT
    , "Year Landfill Opened"            TEXT
    , "Landfill Closure Year"           TEXT
    , "Current Landfill Status"         TEXT
    , "Design Landfill Area (acres)"    TEXT
    , "Current Landfill Area (acres)"   TEXT
    , "Design Landfill Depth (feet)"    TEXT
    , "Current Landfill Depth (feet)"   TEXT
    , "Landfill Design Capacity (tons)" TEXT
    , "Waste in Place (tons)"           TEXT
    , "Waste in Place Year"             TEXT
    , "LFG Generated (mmscfd)"          TEXT
    , "LFG Collection System In Place?" TEXT
    , "LFG Collected (mmscfd)"          TEXT
    , "LFG Collected Year"              TEXT
    , "Percent Methane"                 TEXT
    , "Flares in Place?"                TEXT
    , "Number of Flares"                TEXT
    , "LFG Flared (mmscfd)"             TEXT
    , "LFG Flared Year"                 TEXT
    , "Gas Collection System Comments"  TEXT
);

COMMENT ON TABLE "epa"."_landfilllmopdata_20180716" IS 'EPA Landfill Methane Outreach Program raw data. April 25, 2017. https://www.epa.gov/lmop/landfill-gas-energy-project-data-and-landfill-technical-data.';

COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."GHGRP ID"                        IS 'GHGRP ID corresponds to the 7-digit Facility Identifier assigned to facilities required to report under EPA''s Greenhouse Gas Reporting Program';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Landfill ID"                     IS 'Unique identifying number for each landfill';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Landfill Name"                   IS 'Landfill name';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."State"                           IS 'State landfill is located in';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Landfill Alias"                  IS 'Alternate landfill name';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Physical Address"                IS 'Physical address of landfill';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."City"                            IS 'City landfill is located in or near';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."County"                          IS 'County landfill is located in';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Zip Code"                        IS 'Zip code for the landfill';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Latitude"                        IS 'Latitude coordinate (decimal) for the landfill';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Longitude"                       IS 'Longitude coordinate (decimal) for the landfill';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Ownership Type"                  IS 'Indicates if landfill is publicly owned, privately owned, or co-owned by public and private entities';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Landfill Owner Organization(s)"  IS 'Organization that owns the landfill';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Landfill Operator Organization"  IS 'Organization that operates the landfill';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Year Landfill Opened"            IS 'Year landfill opened or began accepting waste (YYYY)';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Landfill Closure Year"           IS 'Year landfill stopped accepting waste or is expected to stop accepting waste  or year landfill closed or is expected to close (YYYY)';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Current Landfill Status"         IS 'Open/Closed status of landfill';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Design Landfill Area (acres)"    IS 'Design waste mass area of landfill in acres';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Current Landfill Area (acres)"   IS 'Current waste mass area of landfill in acres';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Design Landfill Depth (feet)"    IS 'Design waste mass depth of landfill (maximum or average) in feet';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Current Landfill Depth (feet)"   IS 'Current waste mass depth of landfill (maximum or average) in feet';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Landfill Design Capacity (tons)" IS 'Waste design capacity of landfill in short tons';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Waste in Place (tons)"           IS 'Waste-in-place at the landfill in short tons';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Waste in Place Year"             IS 'Year corresponding to the waste-in-place at the landfill (YYYY)';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."LFG Generated (mmscfd)"          IS 'Estimated amount of landfill gas generated by landfill in million standard cubic feet per day';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."LFG Collection System In Place?" IS 'Is there a landfill gas collection system in place? ''Yes'' for an active GCCS; ''No'' if landfill has no gas collection system, is passively venting/flaring, or has perimeter gas wells.';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."LFG Collected (mmscfd)"          IS 'Amount of landfill gas being collected in million standard cubic feet per day';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."LFG Collected Year"              IS 'Year corresponding to the landfill gas collected at the landfill (YYYY)';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Percent Methane"                 IS 'Percent of landfill gas that is methane (typically 40-50%)';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Flares in Place?"                IS 'Is there one or more flares in place at the landfill?';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Number of Flares"                IS 'Number of flares in place at the landfill';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."LFG Flared (mmscfd)"             IS 'Amount of landfill gas flared (if project is operational, amount of landfill gas flared in back-up flare(s)) in million standard cubic feet per day';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."LFG Flared Year"                 IS 'Year corresponding to the landfill gas flared at the landfill (YYYY)';
COMMENT ON COLUMN "epa"."_landfilllmopdata_20180716"."Gas Collection System Comments"  IS 'Comments regarding the flaring (and gas collection) system at the landfill';

INSERT INTO "epa"."_landfilllmopdata_20180716" ("GHGRP ID"
                                              , "Landfill ID"
                                              , "Landfill Name"
                                              , "State"
                                              , "Landfill Alias"
                                              , "Physical Address"
                                              , "City"
                                              , "County"
                                              , "Zip Code"
                                              , "Latitude"
                                              , "Longitude"
                                              , "Ownership Type"
                                              , "Landfill Owner Organization(s)"
                                              , "Landfill Operator Organization"
                                              , "Year Landfill Opened"
                                              , "Landfill Closure Year"
                                              , "Current Landfill Status"
                                              , "Design Landfill Area (acres)"
                                              , "Current Landfill Area (acres)"
                                              , "Design Landfill Depth (feet)"
                                              , "Current Landfill Depth (feet)"
                                              , "Landfill Design Capacity (tons)"
                                              , "Waste in Place (tons)"
                                              , "Waste in Place Year"
                                              , "LFG Generated (mmscfd)"
                                              , "LFG Collection System In Place?"
                                              , "LFG Collected (mmscfd)"
                                              , "LFG Collected Year"
                                              , "Percent Methane"
                                              , "Flares in Place?"
                                              , "Number of Flares"
                                              , "LFG Flared (mmscfd)"
                                              , "LFG Flared Year"
                                              , "Gas Collection System Comments"
)
SELECT "ghgrp_id"
      , "landfill_id"
      , "landfill_name"
      , "state_abbr"
      , "landfill_alias"
      , "physical_address"
      , "city"
      , "county"
      , "zip_code"
      , "latitude"
      , "longitude"
      , "ownership_type"
      , "landfill_owner_organization"
      , "landfill_operator_organization"
      , "landfill_open_year"
      , "landfill_closure_year"
      , "landfill_current_status"
      , "landfill_design_area_acres"
      , "landfill_current_area_acres"
      , "landfill_design_depth_feet"
      , "landfill_current_depth_feet"
      , "landfill_design_capacity_tons"
      , "waste_in_place_tons"
      , "waste_in_place_year"
      , "lfg_generated_mmscfd"
      , "lfg_collection_system_in_place"
      , "lfg_collected_mmscfd"
      , "lfg_collected_year"
      , "lfg_percent_methane"
      , "flares_in_place"
      , "number_of_flares"
      , "lfg_flared_mmscfd"
      , "lfg_flared_year"
      , "gas_collection_system_comments"
FROM "dhetting"."landfilllmop_20180716"
ORDER BY "landfill_id";

-- clean copy
DROP   TABLE IF EXISTS "epa"."landfilllmopdata_20180716" CASCADE;
CREATE TABLE           "epa"."landfilllmopdata_20180716" AS
SELECT
      REPLACE(NULLIF("GHGRP ID", ''), ',', '')::NUMERIC::INT                         AS "ghgrp_id"
    , REPLACE(NULLIF("Landfill ID", ''), ',', '')::NUMERIC::INT                      AS "landfill_id"
    , NULLIF("Landfill Name", '')                                                    AS "landfill_name"
    , NULLIF("Landfill Alias", '')                                                   AS "landfill_alias"
    , NULLIF("State", '')                                                            AS "state_abbr"
    , NULLIF("Physical Address", '')                                                 AS "physical_address"
    , NULLIF("City", '')                                                             AS "city"
    , NULLIF("County", '')                                                           AS "county"
    , LPAD(NULLIF("Zip Code", ''), 5, '0'::TEXT)                                     AS "zip_code"
    , REPLACE(NULLIF("Latitude", ''), ',', '')::NUMERIC                              AS "latitude"
    , REPLACE(NULLIF("Longitude", ''), ',', '')::NUMERIC                             AS "longitude"
    , NULLIF("Ownership Type", '')                                                   AS "ownership_type"
    , NULLIF("Landfill Owner Organization(s)", '')                                   AS "landfill_owner_organization"
    , NULLIF("Landfill Operator Organization", '')                                   AS "landfill_operator_organization"
    , TO_DATE(NULLIF("Year Landfill Opened",  ''), 'YYYY')                           AS "landfill_open_year"
    , TO_DATE(NULLIF("Landfill Closure Year", ''), 'YYYY')                           AS "landfill_closure_year"
    , LOWER(NULLIF("Current Landfill Status", ''))                                   AS "landfill_current_status"
    , REPLACE(NULLIF("Design Landfill Area (acres)", ''), ',', '')::NUMERIC          AS "landfill_design_area_acres"
    , REPLACE(NULLIF("Current Landfill Area (acres)", ''), ',', '')::NUMERIC         AS "landfill_current_area_acres"
    , REPLACE(NULLIF("Design Landfill Depth (feet)", ''), ',', '')::NUMERIC          AS "landfill_design_depth_feet"
    , REPLACE(NULLIF("Current Landfill Depth (feet)", ''), ',', '')::NUMERIC         AS "landfill_current_depth_feet"
    , REPLACE(NULLIF("Landfill Design Capacity (tons)", ''), ',', '')::NUMERIC       AS "landfill_design_capacity_tons"
    , REPLACE(NULLIF("Waste in Place (tons)", ''), ',', '')::NUMERIC                 AS "waste_in_place_tons"
    , TO_DATE(NULLIF("Waste in Place Year", ''), 'YYYY')                             AS "waste_in_place_year"
    , REPLACE(NULLIF("LFG Generated (mmscfd)", ''), ',', '')::NUMERIC                AS "lfg_generated_mmscfd"
    , CASE WHEN NULLIF("LFG Collection System In Place?", '') = 'No'      THEN FALSE
           WHEN NULLIF("LFG Collection System In Place?", '') = 'Yes'     THEN TRUE
           WHEN NULLIF("LFG Collection System In Place?", '') = 'Unknown' THEN NULL
      END::BOOLEAN                                                                   AS "lfg_collection_system_in_place"
    , REPLACE(NULLIF("LFG Collected (mmscfd)", ''), ',', '')::NUMERIC                AS "lfg_collected_mmscfd"
    , TO_DATE(NULLIF("LFG Collected Year", ''), 'YYYY')                              AS "lfg_collected_year"
    , REPLACE(NULLIF("Percent Methane", ''), ',', '')::NUMERIC                       AS "lfg_percent_methane"
    , CASE WHEN NULLIF("Flares in Place?", '') = 'No'      THEN FALSE
           WHEN NULLIF("Flares in Place?", '') = 'Yes'     THEN TRUE
           WHEN NULLIF("Flares in Place?", '') = 'Unknown' THEN NULL
      END::BOOLEAN                                                                   AS "flares_in_place"
    , REPLACE(NULLIF("Number of Flares", ''), ',', '')::NUMERIC::INT                 AS "number_of_flares"
    , REPLACE(NULLIF("LFG Flared (mmscfd)", ''), ',', '')::NUMERIC                   AS "lfg_flared_mmscfd"
    , TO_DATE(NULLIF("LFG Flared Year", ''), 'YYYY')                                 AS "lfg_flared_year"
    , NULLIF("Gas Collection System Comments", '')                                   AS "gas_collection_system_comments"
    , ST_SetSRID(public.ST_MakePoint(NULLIF("Longitude", '')::FLOAT8
                                   , NULLIF("Latitude", '')::FLOAT8), 4326)          AS "the_geom_4326"
FROM "epa"."_landfilllmopdata_20180716";

CREATE INDEX "idx_landfilllmopdata_20180716_the_geom_4326" ON "epa"."landfilllmopdata_20180716" USING GIST("the_geom_4326");

ALTER TABLE "epa"."landfilllmopdata_20180716" ADD CONSTRAINT "pkey_landfilllmopdata_20180716" PRIMARY KEY ("landfill_id");
ALTER TABLE "epa"."landfilllmopdata_20180716" CLUSTER ON "idx_landfilllmopdata_20180716_the_geom_4326";

COMMENT ON TABLE  "epa"."landfilllmopdata_20180716" IS 'EPA Landfill Methane Outreach Program cleaned data. April 25, 2017. https://www.epa.gov/lmop/landfill-gas-energy-project-data-and-landfill-technical-data.';

COMMENT ON COLUMN "epa"."lmopdata_20180716"."ghgrp_id"                               IS 'GHGRP ID corresponds to the 7-digit Facility Identifier assigned to facilities required to report under EPA''s Greenhouse Gas Reporting Program';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."landfill_id"                            IS 'Unique identifying number for each landfill';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."landfill_name"                          IS 'Landfill name';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."state_abbr"                             IS 'State landfill is located in';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."landfill_alias"                 IS 'Alternate landfill name';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."physical_address"                       IS 'Physical address of landfill';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."city"                                   IS 'City landfill is located in or near';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."county"                                 IS 'County landfill is located in';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."zip_code"                               IS 'Zip code for the landfill';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."latitude"                               IS 'Latitude coordinate (decimal) for the landfill';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."longitude"                              IS 'Longitude coordinate (decimal) for the landfill';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."ownership_type"                         IS 'Indicates if landfill is publicly owned, privately owned, or co-owned by public and private entities';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."landfill_owner_organization"            IS 'Organization that owns the landfill';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."landfill_operator_organization" IS 'Organization that operates the landfill';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."landfill_open_year"                     IS 'Year landfill opened or began accepting waste (YYYY)';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."landfill_closure_year"                  IS 'Year landfill stopped accepting waste or is expected to stop accepting waste  or year landfill closed or is expected to close (YYYY)';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."landfill_current_status"                IS 'Open/Closed status of landfill';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."landfill_design_area_acres"     IS 'Design waste mass area of landfill in acres';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."landfill_current_area_acres"    IS 'Current waste mass area of landfill in acres';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."landfill_design_depth_feet"     IS 'Design waste mass depth of landfill (maximum or average) in feet';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."landfill_current_depth_feet"    IS 'Current waste mass depth of landfill (maximum or average) in feet';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."landfill_design_capacity_tons"  IS 'Waste design capacity of landfill in short tons';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."waste_in_place_tons"                    IS 'Waste-in-place at the landfill in short tons';
COMMENT ON COLUMN "epa"."lmopdata_20180716"."waste_in_place_year"                    IS 'Year corresponding to the waste-in-place at the landfill (YYYY)';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."lfg_generated_mmscfd"           IS 'Estimated amount of landfill gas generated by landfill in million standard cubic feet per day';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."lfg_collection_system_in_place" IS 'Is there a landfill gas collection system in place? ''Yes'' for an active GCCS; ''No'' if landfill has no gas collection system, is passively venting/flaring, or has perimeter gas wells.';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."lfg_collected_mmscfd"           IS 'Amount of landfill gas being collected in million standard cubic feet per day';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."lfg_collected_year"             IS 'Year corresponding to the landfill gas collected at the landfill (YYYY)';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."lfg_percent_methane"            IS 'Percent of landfill gas that is methane (typically 40-50%)';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."flares_in_place"                IS 'Is there one or more flares in place at the landfill?';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."number_of_flares"               IS 'Number of flares in place at the landfill';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."lfg_flared_mmscfd"              IS 'Amount of landfill gas flared (if project is operational, amount of landfill gas flared in back-up flare(s)) in million standard cubic feet per day';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."lfg_flared_year"                IS 'Year corresponding to the landfill gas flared at the landfill (YYYY)';
COMMENT ON COLUMN "epa"."landfilllmopdata_20180716"."gas_collection_system_comments" IS 'Comments regarding the flaring (and gas collection) system at the landfill';

--SELECT * FROM "epa"."landfilllmopdata_20180716";

RESET ROLE;
