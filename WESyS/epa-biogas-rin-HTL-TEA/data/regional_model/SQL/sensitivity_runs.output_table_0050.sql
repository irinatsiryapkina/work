-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0050" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0050" (CONSTRAINT "output_table_0050_run_config_check" CHECK ("run_config" = 50)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0050" ADD CONSTRAINT "pkey_output_table_0050" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0050_factor_btree" ON "sensitivity_runs"."output_table_0050" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0050_run_id_btree" ON "sensitivity_runs"."output_table_0050" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0050_brin_time"    ON "sensitivity_runs"."output_table_0050" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0050_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0050_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0050"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0050_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0050_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0050"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0050_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0050_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  48750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >=      1 AND "run_id" <  48751 UNION ALL
        SELECT  48751 AS "start_index",  97500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >=  48751 AND "run_id" <  97501 UNION ALL
        SELECT  97501 AS "start_index", 146250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >=  97501 AND "run_id" < 146251 UNION ALL
        SELECT 146251 AS "start_index", 195000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 146251 AND "run_id" < 195001 UNION ALL
        SELECT 195001 AS "start_index", 243750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 195001 AND "run_id" < 243751 UNION ALL
        SELECT 243751 AS "start_index", 292500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 243751 AND "run_id" < 292501 UNION ALL
        SELECT 292501 AS "start_index", 341250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 292501 AND "run_id" < 341251 UNION ALL
        SELECT 341251 AS "start_index", 390000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 341251 AND "run_id" < 390001 UNION ALL
        SELECT 390001 AS "start_index", 438750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 390001 AND "run_id" < 438751 UNION ALL
        SELECT 438751 AS "start_index", 487500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 438751 AND "run_id" < 487501 UNION ALL
        SELECT 487501 AS "start_index", 536250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 487501 AND "run_id" < 536251 UNION ALL
        SELECT 536251 AS "start_index", 585000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 536251 AND "run_id" < 585001 UNION ALL
        SELECT 585001 AS "start_index", 633750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 585001 AND "run_id" < 633751 UNION ALL
        SELECT 633751 AS "start_index", 682500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 633751 AND "run_id" < 682501 UNION ALL
        SELECT 682501 AS "start_index", 731250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 682501 AND "run_id" < 731251 UNION ALL
        SELECT 731251 AS "start_index", 780000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 731251 AND "run_id" < 780001 UNION ALL
        SELECT 780001 AS "start_index", 828750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 780001 AND "run_id" < 828751 UNION ALL
        SELECT 828751 AS "start_index", 877500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 828751 AND "run_id" < 877501 UNION ALL
        SELECT 877501 AS "start_index", 926250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 877501 AND "run_id" < 926251 UNION ALL
        SELECT 926251 AS "start_index", 975000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0050_run_id" WHERE "run_id" >= 926251 AND "run_id" < 975001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0050_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0050_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0050_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0050_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0050";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0050_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0050_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0050_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0050_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0050_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0050" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0050_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0050_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0050_1pct") TO 'sensitivity_runs.output_table_0050_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0050_1pct.zip sensitivity_runs.output_table_0050_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0050_1pct.csv.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0050_1pct.csv.zip
