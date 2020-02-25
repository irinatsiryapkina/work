-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0053" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0053" (CONSTRAINT "output_table_0053_run_config_check" CHECK ("run_config" = 53)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0053" ADD CONSTRAINT "pkey_output_table_0053" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0053_factor_btree" ON "sensitivity_runs"."output_table_0053" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0053_run_id_btree" ON "sensitivity_runs"."output_table_0053" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0053_brin_time"    ON "sensitivity_runs"."output_table_0053" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0053_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0053_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0053"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0053_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0053_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0053"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0053_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0053_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  40500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >=      1 AND "run_id" <  40501 UNION ALL
        SELECT  40501 AS "start_index",  81000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >=  40501 AND "run_id" <  81001 UNION ALL
        SELECT  81001 AS "start_index", 121500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >=  81001 AND "run_id" < 121501 UNION ALL
        SELECT 121501 AS "start_index", 162000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 121501 AND "run_id" < 162001 UNION ALL
        SELECT 162001 AS "start_index", 202500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 162001 AND "run_id" < 202501 UNION ALL
        SELECT 202501 AS "start_index", 243000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 202501 AND "run_id" < 243001 UNION ALL
        SELECT 243001 AS "start_index", 283500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 243001 AND "run_id" < 283501 UNION ALL
        SELECT 283501 AS "start_index", 324000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 283501 AND "run_id" < 324001 UNION ALL
        SELECT 324001 AS "start_index", 364500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 324001 AND "run_id" < 364501 UNION ALL
        SELECT 364501 AS "start_index", 405000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 364501 AND "run_id" < 405001 UNION ALL
        SELECT 405001 AS "start_index", 445500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 405001 AND "run_id" < 445501 UNION ALL
        SELECT 445501 AS "start_index", 486000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 445501 AND "run_id" < 486001 UNION ALL
        SELECT 486001 AS "start_index", 526500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 486001 AND "run_id" < 526501 UNION ALL
        SELECT 526501 AS "start_index", 567000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 526501 AND "run_id" < 567001 UNION ALL
        SELECT 567001 AS "start_index", 607500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 567001 AND "run_id" < 607501 UNION ALL
        SELECT 607501 AS "start_index", 648000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 607501 AND "run_id" < 648001 UNION ALL
        SELECT 648001 AS "start_index", 688500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 648001 AND "run_id" < 688501 UNION ALL
        SELECT 688501 AS "start_index", 729000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 688501 AND "run_id" < 729001 UNION ALL
        SELECT 729001 AS "start_index", 769500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 729001 AND "run_id" < 769501 UNION ALL
        SELECT 769501 AS "start_index", 810000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0053_run_id" WHERE "run_id" >= 769501 AND "run_id" < 810001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0053_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0053_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0053_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0053_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0053";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0053_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0053_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0053_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0053_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0053_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0053" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0053_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0053_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0053_1pct") TO 'sensitivity_runs.output_table_0053_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0053_1pct.zip sensitivity_runs.output_table_0053_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0053_1pct.csv.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0053_1pct.csv.zip
