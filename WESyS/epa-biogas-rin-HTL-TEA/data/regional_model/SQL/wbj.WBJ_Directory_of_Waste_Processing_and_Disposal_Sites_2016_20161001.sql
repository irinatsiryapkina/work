RESET ROLE;

GRANT SELECT ON TABLE "dhetting"."WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "wbj"."_WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016_20161001";
CREATE TABLE           "wbj"."_WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016_20161001" (
      "Code"                           TEXT
    , "Type"                           TEXT
    , "Group"                          TEXT
    , "Facility Name"                  TEXT
    , "Permit"                         TEXT
    , "Map Label"                      TEXT
    , "Location"                       TEXT
    , "City "                          TEXT
    , "County"                         TEXT
    , "State"                          TEXT
    , "Zip"                            TEXT
    , "Longitude"                      TEXT
    , "Latitude"                       TEXT
    , "Access"                         TEXT
    , "Waste Shed"                     TEXT
    , "Operating Days & Hours"         TEXT
    , "Days /Year"                     TEXT
    , "Acres"                          TEXT
    , "Total of All Wastes (tons/day)" TEXT
    , "Volume Description"             TEXT
    , "Principal Waste (tons/day)"     TEXT
    , "Principal Waste Description"    TEXT
    , "$/ Ton"                         TEXT
    , "Tip Fee Description"            TEXT
    , "Remaining Capacity (tons)"      TEXT
    , "Start Date"                     TEXT
    , "Close Date"                     TEXT
    , "Ownership"                      TEXT
    , "Owner Entity"                   TEXT
    , "Owner Code"                     TEXT
    , "Owner Contact"                  TEXT
    , "Owner Title"                    TEXT
    , "Owner Department"               TEXT
    , "Owner Address 1"                TEXT
    , "Owner Address 2"                TEXT
    , "Owner Phone"                    TEXT
    , "Owner Fax"                      TEXT
    , "Owner Email"                    TEXT
    , "Operation"                      TEXT
    , "Operator Entity"                TEXT
    , "Operator Code"                  TEXT
    , "Operator Contact"               TEXT
    , "Operator Title"                 TEXT
    , "Operator Department"            TEXT
    , "Operator Address 1"             TEXT
    , "Operator Address 2"             TEXT
    , "Operator Phone"                 TEXT
    , "Operator Fax"                   TEXT
    , "Operator Email"                 TEXT
    , "Waste Types Accepted"           TEXT
);
COMMENT ON TABLE "wbj"."_WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016_20161001" IS 'Waste Business Journal. FY2016.';

INSERT INTO "wbj"."_WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016_20161001" SELECT * FROM "dhetting"."WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016";


-- clean copy
DROP   TABLE IF EXISTS "wbj"."WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016_20161001";
CREATE TABLE           "wbj"."WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016_20161001" (
       "gid"                          SERIAL PRIMARY KEY
     , "code"                         TEXT
     , "type"                         TEXT
     , "group"                        TEXT
     , "facility_name"                TEXT
     , "permit"                       TEXT
     , "map_label"                    TEXT
     , "location"                     TEXT
     , "city"                         TEXT
     , "county"                       TEXT
     , "state"                        TEXT
     , "zip"                          TEXT
     , "longitude"                    TEXT
     , "latitude"                     TEXT
     , "access"                       TEXT
     , "waste_shed"                   TEXT
     , "operating_days_&_hours"       TEXT
     , "days_year"                    INT
     , "acres"                        NUMERIC
     , "total_of_all_wastes_tons_day" NUMERIC
     , "volume_tpd"                   NUMERIC
     , "volume_description"           TEXT
     , "principal_waste_tons_day"     NUMERIC
     , "principal_waste_description"  TEXT
     , "dol_ton"                      NUMERIC
     , "tip_fee_description"          TEXT
     , "remaining_capacity_tons"      NUMERIC
     , "start_date"                   DATE
     , "close_date"                   DATE
     , "ownership"                    TEXT
     , "owner_entity"                 TEXT
     , "owner_code"                   TEXT
     , "owner_contact"                TEXT
     , "owner_title"                  TEXT
     , "owner_department"             TEXT
     , "owner_address_1"              TEXT
     , "owner_address_2"              TEXT
     , "owner_phone"                  TEXT
     , "owner_fax"                    TEXT
     , "owner_email"                  TEXT
     , "operation"                    TEXT
     , "operator_entity"              TEXT
     , "operator_code"                TEXT
     , "operator_contact"             TEXT
     , "operator_title"               TEXT
     , "operator_department"          TEXT
     , "operator_address_1"           TEXT
     , "operator_address_2"           TEXT
     , "operator_phone"               TEXT
     , "operator_fax"                 TEXT
     , "operator_email"               TEXT
     , "waste_types_accepted"         TEXT
     , "the_geom_4326"                GEOMETRY(Point, 4326)
    , CONSTRAINT "unq_WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016_20161001" UNIQUE ("code")
);

COMMENT ON TABLE "wbj"."WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016_20161001" IS 'Waste Business Journal. FY2016.';

INSERT INTO "wbj"."WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016_20161001" (
     "code"
   , "type"
   , "group"
   , "facility_name"
   , "permit"
   , "map_label"
   , "location"
   , "city"
   , "county"
   , "state"
   , "zip"
   , "longitude"
   , "latitude"
   , "access"
   , "waste_shed"
   , "operating_days_&_hours"
   , "days_year"
   , "acres"
   , "total_of_all_wastes_tons_day"
   , "volume_description"
   , "principal_waste_tons_day"
   , "principal_waste_description"
   , "dol_ton"
   , "tip_fee_description"
   , "remaining_capacity_tons"
   , "start_date"
   , "close_date"
   , "ownership"
   , "owner_entity"
   , "owner_code"
   , "owner_contact"
   , "owner_title"
   , "owner_department"
   , "owner_address_1"
   , "owner_address_2"
   , "owner_phone"
   , "owner_fax"
   , "owner_email"
   , "operation"
   , "operator_entity"
   , "operator_code"
   , "operator_contact"
   , "operator_title"
   , "operator_department"
   , "operator_address_1"
   , "operator_address_2"
   , "operator_phone"
   , "operator_fax"
   , "operator_email"
   , "waste_types_accepted"
   , "volume_tpd"
   , "the_geom_4326"
)
SELECT DISTINCT
       NULLIF(regexp_replace("Code", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Type", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Group", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Facility Name", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Permit", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Map Label", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Location", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("City ", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("County", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("State", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Zip", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Longitude", '^\s+|\s+$|NA|\|,?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Latitude", '^\s+|\s+$|NA|\?|,', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Access", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Waste Shed", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Operating Days & Hours", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Days /Year", '^\s+|\s+$|NA|\?|.0|,', '', 'g'), '')::INT
     , NULLIF(regexp_replace("Acres", '^\s+|\s+$|NA|\?|,', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Total of All Wastes (tons/day)", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Volume Description", '^\s+|\s+$|NA|TPD|,\?|,', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Principal Waste (tons/day)", '^\s+|\s+$|NA|\?|,', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Principal Waste Description", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("$/ Ton", '^\s+|\s+$|NA|\?|,', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Tip Fee Description", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Remaining Capacity (tons)", '^\s+|\s+$|NA|\?|,', '', 'g'), '')::NUMERIC
     , "Start Date"::DATE
     , "Close Date"::DATE
     , NULLIF(regexp_replace("Ownership", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Owner Entity", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Owner Code", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Owner Contact", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Owner Title", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Owner Department", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Owner Address 1", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Owner Address 2", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Owner Phone", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Owner Fax", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Owner Email", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Operation", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Operator Entity", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Operator Code", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Operator Contact", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Operator Title", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Operator Department", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Operator Address 1", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Operator Address 2", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Operator Phone", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Operator Fax", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Operator Email", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Waste Types Accepted", '^\s+|\s+$|NA|\?', '', 'g'), '')
     , NULLIF(regexp_replace("Volume Description", '^\s+|\s+$|NA|TPD|\?|,', '', 'g'), '')::NUMERIC
     , ST_SetSRID(ST_MakePoint(NULLIF(regexp_replace("Longitude", '^\s+|\s+$|NA|\?|,', '', 'g'), '')::NUMERIC, NULLIF(regexp_replace("Latitude", '^\s+|\s+$|NA|\?|,', '', 'g'), '')::NUMERIC), 4326)
FROM "wbj"."_WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016_20161001"
ORDER BY 1, 2, 3, 4, 5
;

--SELECT * FROM "wbj"."WBJ_Directory_of_Waste_Processing_and_Disposal_Sites_2016_20161001_20161001";

RESET ROLE;
