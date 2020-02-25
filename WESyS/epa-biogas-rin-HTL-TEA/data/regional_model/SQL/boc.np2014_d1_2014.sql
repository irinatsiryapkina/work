RESET ROLE;

GRANT SELECT ON TABLE "dhetting"."np2014_d1" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "boc"."_np2014_d1_2014";
CREATE TABLE           "boc"."_np2014_d1_2014" AS
SELECT * FROM "dhetting"."np2014_d1"
;
COMMENT ON TABLE "boc"."_np2014_d1_2014" IS '2014 Total population data for U.S. https://www.census.gov/data/datasets/2014/demo/popproj/2014-popproj.html';


-- clean copy
DROP   TABLE IF EXISTS "boc"."np2014_d1_2014";
CREATE TABLE           "boc"."np2014_d1_2014" (
       "gid"       SERIAL PRIMARY KEY
     , "origin"    INT NOT NULL
     , "race"      INT NOT NULL
     , "sex"       INT NOT NULL
     , "year"      INT NOT NULL
     , "total_pop" INT NOT NULL
     , "pop_0"     INT NOT NULL
     , "pop_1"     INT NOT NULL
     , "pop_2"     INT NOT NULL
     , "pop_3"     INT NOT NULL
     , "pop_4"     INT NOT NULL
     , "pop_5"     INT NOT NULL
     , "pop_6"     INT NOT NULL
     , "pop_7"     INT NOT NULL
     , "pop_8"     INT NOT NULL
     , "pop_9"     INT NOT NULL
     , "pop_10"    INT NOT NULL
     , "pop_11"    INT NOT NULL
     , "pop_12"    INT NOT NULL
     , "pop_13"    INT NOT NULL
     , "pop_14"    INT NOT NULL
     , "pop_15"    INT NOT NULL
     , "pop_16"    INT NOT NULL
     , "pop_17"    INT NOT NULL
     , "pop_18"    INT NOT NULL
     , "pop_19"    INT NOT NULL
     , "pop_20"    INT NOT NULL
     , "pop_21"    INT NOT NULL
     , "pop_22"    INT NOT NULL
     , "pop_23"    INT NOT NULL
     , "pop_24"    INT NOT NULL
     , "pop_25"    INT NOT NULL
     , "pop_26"    INT NOT NULL
     , "pop_27"    INT NOT NULL
     , "pop_28"    INT NOT NULL
     , "pop_29"    INT NOT NULL
     , "pop_30"    INT NOT NULL
     , "pop_31"    INT NOT NULL
     , "pop_32"    INT NOT NULL
     , "pop_33"    INT NOT NULL
     , "pop_34"    INT NOT NULL
     , "pop_35"    INT NOT NULL
     , "pop_36"    INT NOT NULL
     , "pop_37"    INT NOT NULL
     , "pop_38"    INT NOT NULL
     , "pop_39"    INT NOT NULL
     , "pop_40"    INT NOT NULL
     , "pop_41"    INT NOT NULL
     , "pop_42"    INT NOT NULL
     , "pop_43"    INT NOT NULL
     , "pop_44"    INT NOT NULL
     , "pop_45"    INT NOT NULL
     , "pop_46"    INT NOT NULL
     , "pop_47"    INT NOT NULL
     , "pop_48"    INT NOT NULL
     , "pop_49"    INT NOT NULL
     , "pop_50"    INT NOT NULL
     , "pop_51"    INT NOT NULL
     , "pop_52"    INT NOT NULL
     , "pop_53"    INT NOT NULL
     , "pop_54"    INT NOT NULL
     , "pop_55"    INT NOT NULL
     , "pop_56"    INT NOT NULL
     , "pop_57"    INT NOT NULL
     , "pop_58"    INT NOT NULL
     , "pop_59"    INT NOT NULL
     , "pop_60"    INT NOT NULL
     , "pop_61"    INT NOT NULL
     , "pop_62"    INT NOT NULL
     , "pop_63"    INT NOT NULL
     , "pop_64"    INT NOT NULL
     , "pop_65"    INT NOT NULL
     , "pop_66"    INT NOT NULL
     , "pop_67"    INT NOT NULL
     , "pop_68"    INT NOT NULL
     , "pop_69"    INT NOT NULL
     , "pop_70"    INT NOT NULL
     , "pop_71"    INT NOT NULL
     , "pop_72"    INT NOT NULL
     , "pop_73"    INT NOT NULL
     , "pop_74"    INT NOT NULL
     , "pop_75"    INT NOT NULL
     , "pop_76"    INT NOT NULL
     , "pop_77"    INT NOT NULL
     , "pop_78"    INT NOT NULL
     , "pop_79"    INT NOT NULL
     , "pop_80"    INT NOT NULL
     , "pop_81"    INT NOT NULL
     , "pop_82"    INT NOT NULL
     , "pop_83"    INT NOT NULL
     , "pop_84"    INT NOT NULL
     , "pop_85"    INT NOT NULL
     , "pop_86"    INT NOT NULL
     , "pop_87"    INT NOT NULL
     , "pop_88"    INT NOT NULL
     , "pop_89"    INT NOT NULL
     , "pop_90"    INT NOT NULL
     , "pop_91"    INT NOT NULL
     , "pop_92"    INT NOT NULL
     , "pop_93"    INT NOT NULL
     , "pop_94"    INT NOT NULL
     , "pop_95"    INT NOT NULL
     , "pop_96"    INT NOT NULL
     , "pop_97"    INT NOT NULL
     , "pop_98"    INT NOT NULL
     , "pop_99"    INT NOT NULL
     , "pop_100"   INT NOT NULL
     , CONSTRAINT "unq_np2014_d1_2014" UNIQUE ("origin", "race", "sex", "year")
);
COMMENT ON TABLE "boc"."np2014_d1_2014" IS '2014 Total population data for U.S. https://www.census.gov/data/datasets/2014/demo/popproj/2014-popproj.html';

INSERT INTO "boc"."np2014_d1_2014" (
     "origin"
   , "race"
   , "sex"
   , "year"
   , "total_pop"
   , "pop_0"
   , "pop_1"
   , "pop_2"
   , "pop_3"
   , "pop_4"
   , "pop_5"
   , "pop_6"
   , "pop_7"
   , "pop_8"
   , "pop_9"
   , "pop_10"
   , "pop_11"
   , "pop_12"
   , "pop_13"
   , "pop_14"
   , "pop_15"
   , "pop_16"
   , "pop_17"
   , "pop_18"
   , "pop_19"
   , "pop_20"
   , "pop_21"
   , "pop_22"
   , "pop_23"
   , "pop_24"
   , "pop_25"
   , "pop_26"
   , "pop_27"
   , "pop_28"
   , "pop_29"
   , "pop_30"
   , "pop_31"
   , "pop_32"
   , "pop_33"
   , "pop_34"
   , "pop_35"
   , "pop_36"
   , "pop_37"
   , "pop_38"
   , "pop_39"
   , "pop_40"
   , "pop_41"
   , "pop_42"
   , "pop_43"
   , "pop_44"
   , "pop_45"
   , "pop_46"
   , "pop_47"
   , "pop_48"
   , "pop_49"
   , "pop_50"
   , "pop_51"
   , "pop_52"
   , "pop_53"
   , "pop_54"
   , "pop_55"
   , "pop_56"
   , "pop_57"
   , "pop_58"
   , "pop_59"
   , "pop_60"
   , "pop_61"
   , "pop_62"
   , "pop_63"
   , "pop_64"
   , "pop_65"
   , "pop_66"
   , "pop_67"
   , "pop_68"
   , "pop_69"
   , "pop_70"
   , "pop_71"
   , "pop_72"
   , "pop_73"
   , "pop_74"
   , "pop_75"
   , "pop_76"
   , "pop_77"
   , "pop_78"
   , "pop_79"
   , "pop_80"
   , "pop_81"
   , "pop_82"
   , "pop_83"
   , "pop_84"
   , "pop_85"
   , "pop_86"
   , "pop_87"
   , "pop_88"
   , "pop_89"
   , "pop_90"
   , "pop_91"
   , "pop_92"
   , "pop_93"
   , "pop_94"
   , "pop_95"
   , "pop_96"
   , "pop_97"
   , "pop_98"
   , "pop_99"
   , "pop_100"
)
SELECT DISTINCT
       "origin"::INT
     , "race"::INT
     , "sex"::INT
     , "year"::INT
     , "total_pop"::INT
     , "pop_0"::INT
     , "pop_1"::INT
     , "pop_2"::INT
     , "pop_3"::INT
     , "pop_4"::INT
     , "pop_5"::INT
     , "pop_6"::INT
     , "pop_7"::INT
     , "pop_8"::INT
     , "pop_9"::INT
     , "pop_10"::INT
     , "pop_11"::INT
     , "pop_12"::INT
     , "pop_13"::INT
     , "pop_14"::INT
     , "pop_15"::INT
     , "pop_16"::INT
     , "pop_17"::INT
     , "pop_18"::INT
     , "pop_19"::INT
     , "pop_20"::INT
     , "pop_21"::INT
     , "pop_22"::INT
     , "pop_23"::INT
     , "pop_24"::INT
     , "pop_25"::INT
     , "pop_26"::INT
     , "pop_27"::INT
     , "pop_28"::INT
     , "pop_29"::INT
     , "pop_30"::INT
     , "pop_31"::INT
     , "pop_32"::INT
     , "pop_33"::INT
     , "pop_34"::INT
     , "pop_35"::INT
     , "pop_36"::INT
     , "pop_37"::INT
     , "pop_38"::INT
     , "pop_39"::INT
     , "pop_40"::INT
     , "pop_41"::INT
     , "pop_42"::INT
     , "pop_43"::INT
     , "pop_44"::INT
     , "pop_45"::INT
     , "pop_46"::INT
     , "pop_47"::INT
     , "pop_48"::INT
     , "pop_49"::INT
     , "pop_50"::INT
     , "pop_51"::INT
     , "pop_52"::INT
     , "pop_53"::INT
     , "pop_54"::INT
     , "pop_55"::INT
     , "pop_56"::INT
     , "pop_57"::INT
     , "pop_58"::INT
     , "pop_59"::INT
     , "pop_60"::INT
     , "pop_61"::INT
     , "pop_62"::INT
     , "pop_63"::INT
     , "pop_64"::INT
     , "pop_65"::INT
     , "pop_66"::INT
     , "pop_67"::INT
     , "pop_68"::INT
     , "pop_69"::INT
     , "pop_70"::INT
     , "pop_71"::INT
     , "pop_72"::INT
     , "pop_73"::INT
     , "pop_74"::INT
     , "pop_75"::INT
     , "pop_76"::INT
     , "pop_77"::INT
     , "pop_78"::INT
     , "pop_79"::INT
     , "pop_80"::INT
     , "pop_81"::INT
     , "pop_82"::INT
     , "pop_83"::INT
     , "pop_84"::INT
     , "pop_85"::INT
     , "pop_86"::INT
     , "pop_87"::INT
     , "pop_88"::INT
     , "pop_89"::INT
     , "pop_90"::INT
     , "pop_91"::INT
     , "pop_92"::INT
     , "pop_93"::INT
     , "pop_94"::INT
     , "pop_95"::INT
     , "pop_96"::INT
     , "pop_97"::INT
     , "pop_98"::INT
     , "pop_99"::INT
     , "pop_100"::INT
FROM "boc"."_np2014_d1_2014"
ORDER BY 4, 3, 2, 1
;

--SELECT * FROM "boc"."np2014_d1_2014";

RESET ROLE;
