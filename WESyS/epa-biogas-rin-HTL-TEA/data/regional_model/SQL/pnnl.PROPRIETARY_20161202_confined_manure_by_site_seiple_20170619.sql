RESET ROLE;

GRANT SELECT ON TABLE "dhetting"."PROPRIETARY_20161202_confined_manure_by_site_seiple" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "pnnl"."_PROPRIETARY_20161202_confined_manure_by_site_seiple_20170619";
CREATE TABLE           "pnnl"."_PROPRIETARY_20161202_confined_manure_by_site_seiple_20170619" (
      "STATE"       TEXT
    , "LATITUDE"    TEXT
    , "LONGITUDE"   TEXT
    , "pctBEEF"     TEXT
    , "pctDAIRY"    TEXT
    , "pctSWINE"    TEXT
    , "headBEEF"    TEXT
    , "headDAIRY"   TEXT
    , "headSWINE"   TEXT
    , "manureBEEF"  TEXT
    , "manureDAIRY" TEXT
    , "manureSWINE" TEXT
);
COMMENT ON TABLE "pnnl"."_PROPRIETARY_20161202_confined_manure_by_site_seiple_20170619" IS 'spreadsheet from Tim Seiple at PNNL. June 19, 2017.';

INSERT INTO "pnnl"."_PROPRIETARY_20161202_confined_manure_by_site_seiple_20170619" SELECT * FROM "dhetting"."PROPRIETARY_20161202_confined_manure_by_site_seiple";


-- clean copy
DROP   TABLE IF EXISTS "pnnl"."PROPRIETARY_20161202_confined_manure_by_site_seiple_20170619";
CREATE TABLE           "pnnl"."PROPRIETARY_20161202_confined_manure_by_site_seiple_20170619" (
      "gid"           SERIAL PRIMARY KEY
    , "state"         TEXT
    , "latitude"      NUMERIC
    , "longitude"     NUMERIC
    , "pct_beef"      NUMERIC
    , "pct_dairy"     NUMERIC
    , "pct_swine"     NUMERIC
    , "head_beef"     NUMERIC
    , "head_dairy"    NUMERIC
    , "head_swine"    NUMERIC
    , "manure_beef"   NUMERIC
    , "manure_dairy"  NUMERIC 
    , "manure_swine"  NUMERIC
    , "the_geom_4326" GEOMETRY(Point, 4326)
);
COMMENT ON TABLE "pnnl"."PROPRIETARY_20161202_confined_manure_by_site_seiple_20170619" IS 'spreadsheet from Tim Seiple at PNNL. June 19, 2017.';


INSERT INTO "pnnl"."PROPRIETARY_20161202_confined_manure_by_site_seiple_20170619" (
      "state"
    , "latitude"
    , "longitude"
    , "pct_beef"
    , "pct_dairy"
    , "pct_swine"
    , "head_beef"
    , "head_dairy"
    , "head_swine"
    , "manure_beef"
    , "manure_dairy"
    , "manure_swine"
    , "the_geom_4326"
)
SELECT DISTINCT
      NULLIF(regexp_replace("STATE", '^\s+|\s+$|NA|\?', '', 'g'), '')
    , NULLIF(regexp_replace("LATITUDE", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
    , NULLIF(regexp_replace("LONGITUDE", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
    , NULLIF(regexp_replace("pctBEEF", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
    , NULLIF(regexp_replace("pctDAIRY", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
    , NULLIF(regexp_replace("pctSWINE", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
    , NULLIF(regexp_replace("headBEEF", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
    , NULLIF(regexp_replace("headDAIRY", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
    , NULLIF(regexp_replace("headSWINE", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
    , NULLIF(regexp_replace("manureBEEF", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
    , NULLIF(regexp_replace("manureDAIRY", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
    , NULLIF(regexp_replace("manureSWINE", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
    , ST_SetSRID(ST_MakePoint(NULLIF(regexp_replace("LATITUDE", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC, NULLIF(regexp_replace("LONGITUDE", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC), 4326)
FROM "pnnl"."_PROPRIETARY_20161202_confined_manure_by_site_seiple_20170619"
ORDER BY 1, 2, 3
;

--SELECT * FROM "pnnl"."PROPRIETARY_20161202_confined_manure_by_site_seiple_20170619";

RESET ROLE;
