RESET ROLE;

GRANT SELECT ON "dhetting"."Seiple_et_al_2017_PNNL_sludge_20170321a_Site" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
CREATE TABLE "pnnl"."_Seiple_et_al_2017_PNNL_sludge_by_site_state_region_20170321a_Site" (
      "DataYear"               TEXT
     , "UID"                   TEXT
     , "STATE"                 TEXT
     , "CITY"                  TEXT
     , "dd_LAT"                TEXT
     , "dd_LONG"               TEXT
     , "AVG_FLOW_MGD"          TEXT
     , "PRIM SOLIDS KG_DAY"    TEXT
     , "PRIM SOLIDS KG_YR"     TEXT
     , "PRIM SOLIDS TONS_DAY"  TEXT
     , "PRIM SOLIDS TONS_YR"   TEXT
     , "SEC SOLIDS KG_DAY"     TEXT
     , "SEC SOLIDS KG_YR"      TEXT
     , "SEC SOLIDS TONS_DAY"   TEXT
     , "SEC SOLIDS TONS_YR"    TEXT
     , "TOTAL SOLIDS KG_DAY"   TEXT
     , "TOTAL SOLIDS KG_YR"    TEXT
     , "TOTAL SOLIDS TONS_DAY" TEXT
     , "TOTAL SOLIDS TONS_YR"  TEXT
     , "TOTAL AFDW KG_DAY"     TEXT
     , "TOTAL AFDW KG_YR"      TEXT
     , "TOTAL AFDW TONS_DAY"   TEXT
     , "TOTAL AFDW TONS_YR"    TEXT
);

COMMENT ON TABLE "pnnl"."_Seiple_et_al_2017_PNNL_sludge_by_site_state_region_20170321a_Site" IS 'Sludge by site. March 21, 2017. Annika Eberle via email from Anelia Milbrandt.';

INSERT INTO "pnnl"."_Seiple_et_al_2017_PNNL_sludge_by_site_state_region_20170321a_Site" SELECT * FROM "dhetting"."Seiple_et_al_2017_PNNL_sludge_20170321a_Site";


-- clean copy
CREATE TABLE "pnnl"."Seiple_et_al_2017_PNNL_sludge_by_site_state_region_20170321a_Site" (
       "gid"                        SERIAL PRIMARY KEY
     , "uid"                        BIGINT
     , "data_year"                  DATE
     , "state_abbr"                 TEXT
     , "city"                       TEXT
     , "latitude"                   TEXT
     , "longitude"                  TEXT
     , "avg_flow_mgd"               NUMERIC
     , "primary_solids_kg_day"      NUMERIC
     , "primary_solids_kg_year"     NUMERIC
     , "primary_solids_tons_day"    NUMERIC
     , "primary_solids_tons_year"   NUMERIC
     , "secondary_solids_kg_day"    NUMERIC
     , "secondary_solids_kg_year"   NUMERIC
     , "secondary_solids_tons_day"  NUMERIC
     , "secondary_solids_tons_year" NUMERIC
     , "total_solids_kg_day"        NUMERIC
     , "total_solids_kg_year"       NUMERIC
     , "total_solids_tons_day"      NUMERIC
     , "total_solids_tons_year"     NUMERIC
     , "total_afdw_kg_day"          NUMERIC
     , "total_afdw_kg_year"         NUMERIC
     , "total_afdw_tons_day"        NUMERIC
     , "total_afdw_tons_year"       TEXT
     , "the_geom_4326"              GEOMETRY(Point, 4326)
     , CONSTRAINT "unq_Seiple_et_al_2017_PNNL_sludge_by_site_state_region_20170321a_Site_uid" UNIQUE ("uid")
);

COMMENT ON TABLE "pnnl"."Seiple_et_al_2017_PNNL_sludge_by_site_state_region_20170321a_Site" IS 'Sludge by site. March 21, 2017. Annika Eberle via email from Anelia Milbrandt.';

INSERT INTO "pnnl"."Seiple_et_al_2017_PNNL_sludge_by_site_state_region_20170321a_Site" ("uid", "data_year", "state_abbr", "city", "latitude", "longitude", "avg_flow_mgd", "primary_solids_kg_day", "primary_solids_kg_year", "primary_solids_tons_day", "primary_solids_tons_year", "secondary_solids_kg_day", "secondary_solids_kg_year", "secondary_solids_tons_day", "secondary_solids_tons_year", "total_solids_kg_day", "total_solids_kg_year", "total_solids_tons_day", "total_solids_tons_year", "total_afdw_kg_day", "total_afdw_kg_year", "total_afdw_tons_day", "total_afdw_tons_year", "the_geom_4326")
SELECT
       "UID"::BIGINT
     , TO_DATE(NULLIF(REPLACE("DataYear", '.0', ''), ''), 'yyyy')
     , NULLIF("STATE", '')::TEXT
     , NULLIF("CITY", '')::TEXT
     , NULLIF("dd_LAT", '')::NUMERIC
     , NULLIF("dd_LONG", '')::NUMERIC
     , NULLIF("AVG_FLOW_MGD", '')::NUMERIC
     , NULLIF("PRIM SOLIDS KG_DAY", '')::NUMERIC
     , NULLIF("PRIM SOLIDS KG_YR", '')::NUMERIC
     , NULLIF("PRIM SOLIDS TONS_DAY", '')::NUMERIC
     , NULLIF("PRIM SOLIDS TONS_YR", '')::NUMERIC
     , NULLIF("SEC SOLIDS KG_DAY", '')::NUMERIC
     , NULLIF("SEC SOLIDS KG_YR", '')::NUMERIC
     , NULLIF("SEC SOLIDS TONS_DAY", '')::NUMERIC
     , NULLIF("SEC SOLIDS TONS_YR", '')::NUMERIC
     , NULLIF("TOTAL SOLIDS KG_DAY", '')::NUMERIC
     , NULLIF("TOTAL SOLIDS KG_YR", '')::NUMERIC
     , NULLIF("TOTAL SOLIDS TONS_DAY", '')::NUMERIC
     , NULLIF("TOTAL SOLIDS TONS_YR", '')::NUMERIC
     , NULLIF("TOTAL AFDW KG_DAY", '')::NUMERIC
     , NULLIF("TOTAL AFDW KG_YR", '')::NUMERIC
     , NULLIF("TOTAL AFDW TONS_DAY", '')::NUMERIC
     , NULLIF("TOTAL AFDW TONS_YR", '')::NUMERIC
     , ST_SetSRID(ST_MakePoint(NULLIF("dd_LONG", '')::NUMERIC, NULLIF("dd_LAT", '')::NUMERIC), 4326)
FROM "pnnl"."_Seiple_et_al_2017_PNNL_sludge_by_site_state_region_20170321a_Site"
ORDER BY "UID" ASC, "DataYear" ASC, "STATE" ASC, "CITY" ASC, "dd_LAT" ASC, "dd_LONG" ASC, "AVG_FLOW_MGD" DESC
;

--SELECT * FROM "pnnl"."Seiple_et_al_2017_PNNL_sludge_by_site_state_region_20170321a_Site";

RESET ROLE;
