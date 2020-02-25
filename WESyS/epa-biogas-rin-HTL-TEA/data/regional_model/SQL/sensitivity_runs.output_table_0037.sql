-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0037" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0037" (CONSTRAINT "output_table_0037_run_config_check" CHECK ("run_config" = 37)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0037" ADD CONSTRAINT "pkey_output_table_0037" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0037_factor_btree" ON "sensitivity_runs"."output_table_0037" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0037_run_id_btree" ON "sensitivity_runs"."output_table_0037" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0037_brin_time"    ON "sensitivity_runs"."output_table_0037" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0037_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0037_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0037"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0037_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0037_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0037"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0037_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0037_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  34500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >=      1 AND "run_id" <  34501 UNION ALL
        SELECT  34501 AS "start_index",  69000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >=  34501 AND "run_id" <  69001 UNION ALL
        SELECT  69001 AS "start_index", 103500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >=  69001 AND "run_id" < 103501 UNION ALL
        SELECT 103501 AS "start_index", 138000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 103501 AND "run_id" < 138001 UNION ALL
        SELECT 138001 AS "start_index", 172500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 138001 AND "run_id" < 172501 UNION ALL
        SELECT 172501 AS "start_index", 207000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 172501 AND "run_id" < 207001 UNION ALL
        SELECT 207001 AS "start_index", 241500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 207001 AND "run_id" < 241501 UNION ALL
        SELECT 241501 AS "start_index", 276000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 241501 AND "run_id" < 276001 UNION ALL
        SELECT 276001 AS "start_index", 310500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 276001 AND "run_id" < 310501 UNION ALL
        SELECT 310501 AS "start_index", 345000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 310501 AND "run_id" < 345001 UNION ALL
        SELECT 345001 AS "start_index", 379500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 345001 AND "run_id" < 379501 UNION ALL
        SELECT 379501 AS "start_index", 414000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 379501 AND "run_id" < 414001 UNION ALL
        SELECT 414001 AS "start_index", 448500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 414001 AND "run_id" < 448501 UNION ALL
        SELECT 448501 AS "start_index", 483000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 448501 AND "run_id" < 483001 UNION ALL
        SELECT 483001 AS "start_index", 517500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 483001 AND "run_id" < 517501 UNION ALL
        SELECT 517501 AS "start_index", 552000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 517501 AND "run_id" < 552001 UNION ALL
        SELECT 552001 AS "start_index", 586500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 552001 AND "run_id" < 586501 UNION ALL
        SELECT 586501 AS "start_index", 621000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 586501 AND "run_id" < 621001 UNION ALL
        SELECT 621001 AS "start_index", 655500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 621001 AND "run_id" < 655501 UNION ALL
        SELECT 655501 AS "start_index", 690000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0037_run_id" WHERE "run_id" >= 655501 AND "run_id" < 690001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0037_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0037_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0037_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0037_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0037";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0037_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0037_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0037_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0037_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0037_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0037" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0037_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0037_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0037_1pct") TO 'sensitivity_runs.output_table_0037_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0037_1pct.zip sensitivity_runs.output_table_0037_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0037_1pct.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0037_1pct.csv.zip
