RESET ROLE;

GRANT SELECT ON "dhetting"."lmopdata_raw_20170417_130034" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "epa"."_lmopdata_20170417" CASCADE;
CREATE TABLE           "epa"."_lmopdata_20170417" (
      "GHGRP ID"                                                TEXT
    , "Landfill ID"                                             TEXT
    , "Landfill Name"                                           TEXT
    , "State"                                                   TEXT
    , "Physical Address"                                        TEXT
    , "City"                                                    TEXT
    , "County"                                                  TEXT
    , "Zip Code"                                                TEXT
    , "Latitude"                                                TEXT
    , "Longitude"                                               TEXT
    , "Ownership Type"                                          TEXT
    , "Landfill Owner Organization(s)"                          TEXT
    , "Year Landfill Opened"                                    TEXT
    , "Landfill Closure Year"                                   TEXT
    , "Current Landfill Status"                                 TEXT
    , "Waste in Place (tons)"                                   TEXT
    , "Waste in Place Year"                                     TEXT
    , "LFG Collection System In Place?"                         TEXT
    , "LFG Collected (mmscfd)"                                  TEXT
    , "LFG Flared (mmscfd)"                                     TEXT
    , "Project ID"                                              TEXT
    , "Current Project Status"                                  TEXT
    , "Project Name"                                            TEXT
    , "Project Start Date"                                      TEXT
    , "Project Shutdown Date"                                   TEXT
    , "LFG Energy Project Type"                                 TEXT
    , "Project Type Category"                                   TEXT
    , "MW Capacity"                                             TEXT
    , "LFG Flow to Project (mmscfd)"                            TEXT
    , "Current Year Emission Reductions (MMTCO2e/yr) - Direct"  TEXT
    , "Current Year Emission Reductions (MMTCO2e/yr) - Avoided" TEXT
);

COMMENT ON TABLE "epa"."_lmopdata_20170417" IS 'EPA Landfill Methane Outreach Program raw data. April 17, 2017. https://www.epa.gov/lmop/landfill-gas-energy-project-data-and-landfill-technical-data.';

COMMENT ON COLUMN "epa"."_lmopdata_20170417"."GHGRP ID"                                                IS 'GHGRP ID corresponds to the 7-digit Facility Identifier assigned to facilities required to report under EPA''s Greenhouse Gas Reporting Program';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Landfill ID"                                             IS 'Unique identifying number for each landfill';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Landfill Name"                                           IS 'Landfill name';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."State"                                                   IS 'State landfill is located in';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Physical Address"                                        IS 'Physical address of landfill';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."City"                                                    IS 'City landfill is located in or near';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."County"                                                  IS 'County landfill is located in';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Zip Code"                                                IS 'Zip code for the landfill';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Latitude"                                                IS 'Latitude coordinate (decimal) for the landfill';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Longitude"                                               IS 'Longitude coordinate (decimal) for the landfill';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Ownership Type"                                          IS 'Indicates if landfill is publicly owned, privately owned, or co-owned by public and private entities';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Landfill Owner Organization(s)"                          IS 'Organization that owns the landfill';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Year Landfill Opened"                                    IS 'Year landfill opened or began accepting waste (YYYY)';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Landfill Closure Year"                                   IS 'Year landfill stopped accepting waste or is expected to stop accepting waste  or year landfill closed or is expected to close (YYYY)';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Current Landfill Status"                                 IS 'Open/Closed status of landfill';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Waste in Place (tons)"                                   IS 'Waste-in-place at the landfill in short tons';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Waste in Place Year"                                     IS 'Year corresponding to the waste-in-place at the landfill (YYYY)';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."LFG Collection System In Place?"                         IS 'Is there a landfill gas collection system in place? ''Yes'' for an active GCCS; ''No'' if landfill has no gas collection system, is passively venting/flaring, or has perimeter gas wells.';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."LFG Collected (mmscfd)"                                  IS 'Amount of landfill gas being collected in million standard cubic feet per day';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."LFG Flared (mmscfd)"                                     IS 'Amount of landfill gas flared (if project is operational, amount of landfill gas flared in back-up flare(s)) in million standard cubic feet per day';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Project ID"                                              IS 'Unique identifying number combination for "parent" project and "expansion" number';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Current Project Status"                                  IS 'Current project status (Operational, Construction, Planned, Shutdown, Candidate, Potential, Other)';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Project Name"                                            IS 'Specific project name (if applicable)';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Project Start Date"                                      IS 'Date project became operational (MM/DD/YYYY)';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Project Shutdown Date"                                   IS 'Date project shut down (MM/DD/YYYY)';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."LFG Energy Project Type"                                 IS 'Specific type of LFG energy project technology';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Project Type Category"                                   IS 'Category of LFG energy project type (Electricity, Direct, Upgraded LFG)';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."MW Capacity"                                             IS 'Capacity in megawatts for electricity-generating projects';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."LFG Flow to Project (mmscfd)"                            IS 'Amount of landfill gas flowing to project or that will flow to the project when it becomes operational in million standard cubic feet per day';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Current Year Emission Reductions (MMTCO2e/yr) - Direct"  IS 'Direct methane reductions by the energy project for the current year';
COMMENT ON COLUMN "epa"."_lmopdata_20170417"."Current Year Emission Reductions (MMTCO2e/yr) - Avoided" IS 'Avoided carbon dioxide emission reductions by the energy project for the current year';

INSERT INTO "epa"."_lmopdata_20170417" ("GHGRP ID"
                                      , "Landfill ID"
                                      , "Landfill Name"
                                      , "State"
                                      , "Physical Address"
                                      , "City"
                                      , "County"
                                      , "Zip Code"
                                      , "Latitude"
                                      , "Longitude"
                                      , "Ownership Type"
                                      , "Landfill Owner Organization(s)"
                                      , "Year Landfill Opened"
                                      , "Landfill Closure Year"
                                      , "Current Landfill Status"
                                      , "Waste in Place (tons)"
                                      , "Waste in Place Year"
                                      , "LFG Collection System In Place?"
                                      , "LFG Collected (mmscfd)"
                                      , "LFG Flared (mmscfd)"
                                      , "Project ID"
                                      , "Current Project Status"
                                      , "Project Name"
                                      , "Project Start Date"
                                      , "Project Shutdown Date"
                                      , "LFG Energy Project Type"
                                      , "Project Type Category"
                                      , "MW Capacity"
                                      , "LFG Flow to Project (mmscfd)"
                                      , "Current Year Emission Reductions (MMTCO2e/yr) - Direct"
                                      , "Current Year Emission Reductions (MMTCO2e/yr) - Avoided"
)
SELECT "GHGRP ID"
     , "Landfill ID"
     , "Landfill Name"
     , "State"
     , "Physical Address"
     , "City"
     , "County"
     , "Zip Code"
     , "Latitude"
     , "Longitude"
     , "Ownership Type"
     , "Landfill Owner Organization(s)"
     , "Year Landfill Opened"
     , "Landfill Closure Year"
     , "Current Landfill Status"
     , "Waste in Place (tons)"
     , "Waste in Place Year"
     , "LFG Collection System In Place?"
     , "LFG Collected (mmscfd)"
     , "LFG Flared (mmscfd)"
     , "Project ID"
     , "Current Project Status"
     , "Project Name"
     , "Project Start Date"
     , "Project Shutdown Date"
     , "LFG Energy Project Type"
     , "Project Type Category"
     , "MW Capacity"
     , "LFG Flow to Project (mmscfd)"
     , "Current Year Emission Reductions (MMTCO2e/yr) - Direct"
     , "Current Year Emission Reductions (MMTCO2e/yr) - Avoided"
FROM "dhetting"."lmopdata_20170417_130034"
ORDER BY "Landfill ID"
       , "Project ID"
;


-- clean copy
DROP   TABLE IF EXISTS "epa"."lmopdata_20170417" CASCADE;
CREATE TABLE           "epa"."lmopdata_20170417" AS
SELECT
      NULLIF("GHGRP ID", '')::NUMERIC::INT                                           AS "ghgrp_id"
    , NULLIF("Landfill ID", '')::NUMERIC::INT                                        AS "landfill_id"
    , NULLIF("Landfill Name", '')                                                    AS "landfill_name"
    , NULLIF("State", '')                                                            AS "state_abbr"
    , NULLIF("Physical Address", '')                                                 AS "physical_address"
    , NULLIF("City", '')                                                             AS "city"
    , NULLIF("County", '')                                                           AS "county"
    , LPAD(NULLIF("Zip Code", ''), 5, '0'::TEXT)                                     AS "zip_code"
    , NULLIF("Latitude", '')::NUMERIC                                                AS "latitude"
    , NULLIF("Longitude", '')::NUMERIC                                               AS "longitude"
    , NULLIF("Ownership Type", '')                                                   AS "ownership_type"
    , NULLIF("Landfill Owner Organization(s)", '')                                   AS "landfill_owner_organization"
    , TO_DATE(NULLIF("Year Landfill Opened",  ''), 'YYYY-MM-DD')                     AS "landfill_open_year"
    , TO_DATE(NULLIF("Landfill Closure Year", ''), 'YYYY')                           AS "landfill_closure_year"
    , LOWER(NULLIF("Current Landfill Status", ''))                                   AS "landfill_current_status"
    , NULLIF("Waste in Place (tons)", '')::NUMERIC                                   AS "waste_in_place_tons"
    , TO_DATE(NULLIF("Waste in Place Year", ''), 'YYYY')                             AS "waste_in_place_year"
    , CASE WHEN NULLIF("LFG Collection System In Place?", '') = 'No'      THEN FALSE
           WHEN NULLIF("LFG Collection System In Place?", '') = 'Yes'     THEN TRUE
           WHEN NULLIF("LFG Collection System In Place?", '') = 'Unknown' THEN NULL
      END::BOOLEAN                                                                   AS "lfg_collection_system_in_place"
    , NULLIF("LFG Collected (mmscfd)", '')::NUMERIC                                  AS "lfg_collected_mmscfd"
    , NULLIF("LFG Flared (mmscfd)", '')::NUMERIC                                     AS "lfg_flared_mmscfd"
    , NULLIF("Project ID", '')                                                       AS "project_id"
    , LOWER(NULLIF("Current Project Status", ''))                                    AS "project_current_status"
    , NULLIF("Project Name", '')                                                     AS "project_name"
    , TO_DATE(NULLIF("Project Start Date",    ''), 'YYYY-MM-DD')                     AS "project_start_date"
    , TO_DATE(NULLIF("Project Shutdown Date", ''), 'YYYY-MM-DD')                     AS "project_shutdown_date"
    , CASE WHEN NULLIF("LFG Energy Project Type", '') = 'Unknown' THEN NULL
      ELSE NULLIF ("LFG Energy Project Type", '')
      END                                                                            AS "lfg_energy_project_type"
    , CASE WHEN NULLIF("Project Type Category", '') = 'Unknown' THEN NULL
      ELSE LOWER(NULLIF("Project Type Category", ''))
      END                                                                            AS "project_type_category"
    , NULLIF("MW Capacity", '')::NUMERIC                                             AS "project_capacity_mw"
    , NULLIF("LFG Flow to Project (mmscfd)", '')::NUMERIC                            AS "project_lfg_inflow_mmscfd"
    , NULLIF("Current Year Emission Reductions (MMTCO2e/yr) - Direct", '')::NUMERIC  AS "current_year_emissions_reductions_direct_mmtco2e_yr"
    , NULLIF("Current Year Emission Reductions (MMTCO2e/yr) - Avoided", '')::NUMERIC AS "current_year_emissions_reductions_avoided_mmtco2e_yr"
    , ST_SetSRID(public.ST_MakePoint(NULLIF("Longitude", '')::FLOAT8
                                   , NULLIF("Latitude", '')::FLOAT8), 4326)          AS "the_geom_4326"
FROM "epa"."_lmopdata_20170417";

CREATE INDEX "idx_lmopdata_20170417_the_geom_4326" ON "epa"."lmopdata_20170417" USING GIST("the_geom_4326");

ALTER TABLE "epa"."lmopdata_20170417" ADD CONSTRAINT "pkey_lmopdata_20170417" PRIMARY KEY ("landfill_id", "project_id");
ALTER TABLE "epa"."lmopdata_20170417" CLUSTER ON "idx_lmopdata_20170417_the_geom_4326";

COMMENT ON TABLE  "epa"."lmopdata_20170417" IS 'EPA Landfill Methane Outreach Program cleaned data. April 17, 2017. https://www.epa.gov/lmop/landfill-gas-energy-project-data-and-landfill-technical-data.';


COMMENT ON COLUMN "epa"."lmopdata_20170417"."GHGRP ID"                                                IS 'GHGRP ID corresponds to the 7-digit Facility Identifier assigned to facilities required to report under EPA''s Greenhouse Gas Reporting Program';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Landfill ID"                                             IS 'Unique identifying number for each landfill';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Landfill Name"                                           IS 'Landfill name';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."State"                                                   IS 'State landfill is located in';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Physical Address"                                        IS 'Physical address of landfill';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."City"                                                    IS 'City landfill is located in or near';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."County"                                                  IS 'County landfill is located in';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Zip Code"                                                IS 'Zip code for the landfill';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Latitude"                                                IS 'Latitude coordinate (decimal) for the landfill';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Longitude"                                               IS 'Longitude coordinate (decimal) for the landfill';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Ownership Type"                                          IS 'Indicates if landfill is publicly owned, privately owned, or co-owned by public and private entities';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Landfill Owner Organization(s)"                          IS 'Organization that owns the landfill';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Year Landfill Opened"                                    IS 'Year landfill opened or began accepting waste (YYYY)';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Landfill Closure Year"                                   IS 'Year landfill stopped accepting waste or is expected to stop accepting waste  or year landfill closed or is expected to close (YYYY)';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Current Landfill Status"                                 IS 'Open/Closed status of landfill';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Waste in Place (tons)"                                   IS 'Waste-in-place at the landfill in short tons';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Waste in Place Year"                                     IS 'Year corresponding to the waste-in-place at the landfill (YYYY)';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."LFG Collection System In Place?"                         IS 'Is there a landfill gas collection system in place? ''Yes'' for an active GCCS; ''No'' if landfill has no gas collection system, is passively venting/flaring, or has perimeter gas wells.';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."LFG Collected (mmscfd)"                                  IS 'Amount of landfill gas being collected in million standard cubic feet per day';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."LFG Flared (mmscfd)"                                     IS 'Amount of landfill gas flared (if project is operational, amount of landfill gas flared in back-up flare(s)) in million standard cubic feet per day';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Project ID"                                              IS 'Unique identifying number combination for "parent" project and "expansion" number';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Current Project Status"                                  IS 'Current project status (Operational, Construction, Planned, Shutdown, Candidate, Potential, Other)';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Project Name"                                            IS 'Specific project name (if applicable)';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Project Start Date"                                      IS 'Date project became operational (MM/DD/YYYY)';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Project Shutdown Date"                                   IS 'Date project shut down (MM/DD/YYYY)';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."LFG Energy Project Type"                                 IS 'Specific type of LFG energy project technology';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Project Type Category"                                   IS 'Category of LFG energy project type (Electricity, Direct, Upgraded LFG)';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."MW Capacity"                                             IS 'Capacity in megawatts for electricity-generating projects';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."LFG Flow to Project (mmscfd)"                            IS 'Amount of landfill gas flowing to project or that will flow to the project when it becomes operational in million standard cubic feet per day';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Current Year Emission Reductions (MMTCO2e/yr) - Direct"  IS 'Direct methane reductions by the energy project for the current year';
COMMENT ON COLUMN "epa"."lmopdata_20170417"."Current Year Emission Reductions (MMTCO2e/yr) - Avoided" IS 'Avoided carbon dioxide emission reductions by the energy project for the current year';

-- DROP TABLE "epa"."lmopdata_raw_20170417_130034";

DROP              VIEW IF EXISTS "epa"."lmop_data";
CREATE OR REPLACE VIEW           "epa"."lmop_data" AS
SELECT "landfill_id"
     , "project_id"
     , "lfg_collection_system_in_place"
     , "lfg_collected_mmscfd"
     , "lfg_flared_mmscfd"
     , "project_current_status"
     , "project_start_date"
     , "project_shutdown_date"
     , "lfg_energy_project_type"
     , "project_type_category"
     , "project_capacity_mw"
     , "project_lfg_inflow_mmscfd"
FROM "epa"."lmopdata_20170417";

COMMIT;

--SELECT * FROM "epa"."_lmopdata_20170417";

RESET ROLE;
