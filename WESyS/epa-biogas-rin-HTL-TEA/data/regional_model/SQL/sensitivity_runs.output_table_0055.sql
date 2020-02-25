-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0055" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0055" (CONSTRAINT "output_table_0055_run_config_check" CHECK ("run_config" = 55)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0055" ADD CONSTRAINT "pkey_output_table_0055" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0055_factor_btree" ON "sensitivity_runs"."output_table_0055" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0055_run_id_btree" ON "sensitivity_runs"."output_table_0055" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0055_brin_time"    ON "sensitivity_runs"."output_table_0055" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0055_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0055_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0055"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0055_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0055_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0055"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0055_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0055_progress" AS (
	WITH x AS (
        SELECT   1 AS "start_index",  17 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >=   1 AND "run_id" <  18 UNION ALL
        SELECT  18 AS "start_index",  34 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >=  18 AND "run_id" <  35 UNION ALL
        SELECT  35 AS "start_index",  51 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >=  35 AND "run_id" <  52 UNION ALL
        SELECT  52 AS "start_index",  68 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >=  52 AND "run_id" <  69 UNION ALL
        SELECT  69 AS "start_index",  85 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >=  69 AND "run_id" <  86 UNION ALL
        SELECT  86 AS "start_index", 102 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >=  86 AND "run_id" < 103 UNION ALL
        SELECT 103 AS "start_index", 119 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 103 AND "run_id" < 120 UNION ALL
        SELECT 120 AS "start_index", 136 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 120 AND "run_id" < 137 UNION ALL
        SELECT 137 AS "start_index", 153 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 137 AND "run_id" < 154 UNION ALL
        SELECT 154 AS "start_index", 170 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 154 AND "run_id" < 171 UNION ALL
        SELECT 171 AS "start_index", 187 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 171 AND "run_id" < 188 UNION ALL
        SELECT 188 AS "start_index", 204 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 188 AND "run_id" < 205 UNION ALL
        SELECT 205 AS "start_index", 221 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 205 AND "run_id" < 222 UNION ALL
        SELECT 222 AS "start_index", 238 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 222 AND "run_id" < 239 UNION ALL
        SELECT 239 AS "start_index", 255 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 239 AND "run_id" < 256 UNION ALL
        SELECT 256 AS "start_index", 272 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 256 AND "run_id" < 273 UNION ALL
        SELECT 273 AS "start_index", 289 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 273 AND "run_id" < 290 UNION ALL
        SELECT 290 AS "start_index", 306 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 290 AND "run_id" < 307 UNION ALL
        SELECT 307 AS "start_index", 323 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 307 AND "run_id" < 324 UNION ALL
        SELECT 324 AS "start_index", 340 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0055_run_id" WHERE "run_id" >= 324 AND "run_id" < 341
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0055_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0055_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0055_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0055_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0055";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0055_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0055_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0055_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0055_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0055_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0055" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0055_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0055_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0055_1pct") TO 'sensitivity_runs.output_table_0055_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0055_1pct.zip sensitivity_runs.output_table_0055_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0055_1pct.csv.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0055_1pct.csv.zip
