-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0030" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0030" (CONSTRAINT "output_table_0030_run_config_check" CHECK ("run_config" = 30)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0030" ADD CONSTRAINT "pkey_output_table_0030" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0030_factor_btree" ON "sensitivity_runs"."output_table_0030" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0030_run_id_btree" ON "sensitivity_runs"."output_table_0030" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0030_brin_time"    ON "sensitivity_runs"."output_table_0030" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0030_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0030_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0030"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0030_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0030_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0030"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0030_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0030_progress" AS (
    WITH x AS (
        SELECT      1 AS "start_index",  36000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >=      1 AND "run_id" <  36001 UNION ALL
        SELECT  36001 AS "start_index",  72000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >=  36001 AND "run_id" <  72001 UNION ALL
        SELECT  72001 AS "start_index", 108000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >=  72001 AND "run_id" < 108001 UNION ALL
        SELECT 108001 AS "start_index", 144000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 108001 AND "run_id" < 144001 UNION ALL
        SELECT 144001 AS "start_index", 180000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 144001 AND "run_id" < 180001 UNION ALL
        SELECT 180001 AS "start_index", 216000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 180001 AND "run_id" < 216001 UNION ALL
        SELECT 216001 AS "start_index", 252000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 216001 AND "run_id" < 252001 UNION ALL
        SELECT 252001 AS "start_index", 288000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 252001 AND "run_id" < 288001 UNION ALL
        SELECT 288001 AS "start_index", 324000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 288001 AND "run_id" < 324001 UNION ALL
        SELECT 324001 AS "start_index", 360000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 324001 AND "run_id" < 360001 UNION ALL
        SELECT 360001 AS "start_index", 396000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 360001 AND "run_id" < 396001 UNION ALL
        SELECT 396001 AS "start_index", 432000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 396001 AND "run_id" < 432001 UNION ALL
        SELECT 432001 AS "start_index", 468000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 432001 AND "run_id" < 468001 UNION ALL
        SELECT 468001 AS "start_index", 504000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 468001 AND "run_id" < 504001 UNION ALL
        SELECT 504001 AS "start_index", 540000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 504001 AND "run_id" < 540001 UNION ALL
        SELECT 540001 AS "start_index", 576000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 540001 AND "run_id" < 576001 UNION ALL
        SELECT 576001 AS "start_index", 612000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 576001 AND "run_id" < 612001 UNION ALL
        SELECT 612001 AS "start_index", 648000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 612001 AND "run_id" < 648001 UNION ALL
        SELECT 648001 AS "start_index", 684000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 648001 AND "run_id" < 684001 UNION ALL
        SELECT 684001 AS "start_index", 720000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0030_run_id" WHERE "run_id" >= 684001 AND "run_id" < 720001
	)
	SELECT x.*
         ,  x."end_index" - x."start_index" - x."num_runs_completed" + 1 AS "num_runs_remaining"
         ,  ROUND((x."end_index"
                 - x."start_index"
                 - x."num_runs_completed"
                 + 1)::NUMERIC
                 / (x."end_index"
                  - x."start_index"
                  + 1)
                , 2) * 100                                               AS "pct_runs_remaining"
	FROM x
    ORDER BY "start_index" ASC
);


-- check for missing runs
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0030_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0030_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0030_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0030_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0030";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0030_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0030_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0030_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0030_missing_run_ids";

-- 1-pct table
DROP TABLE IF EXISTS sensitivity_runs.run_id_1pct_720000 CASCADE;
CREATE TABLE sensitivity_runs.run_id_1pct_720000 AS (SELECT generate_series(0, 720000) AS run_id ORDER BY RANDOM() LIMIT 720000 / 100.0);
DROP VIEW IF EXISTS sensitivity_runs.output_table_0030_1pct;
CREATE VIEW sensitivity_runs.output_table_0030_1pct AS SELECT a.* FROM sensitivity_runs.output_table_0030 a RIGHT JOIN sensitivity_runs.run_id_1pct_720000 b ON a.run_id = b.run_id;
--\COPY sensitivity_runs.output_table_0030_1pct to 'sensitivity_runs.output_table_0030_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0029_1pct.zip sensitivity_runs.output_table_0030_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0030_1pct.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0030_1pct.csv.zip
