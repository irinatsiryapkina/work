-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0049" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0049" (CONSTRAINT "output_table_0049_run_config_check" CHECK ("run_config" = 49)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0049" ADD CONSTRAINT "pkey_output_table_0049" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0049_factor_btree" ON "sensitivity_runs"."output_table_0049" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0049_run_id_btree" ON "sensitivity_runs"."output_table_0049" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0049_brin_time"    ON "sensitivity_runs"."output_table_0049" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0049_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0049_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0049"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0049_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0049_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0049"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0049_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0049_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  46500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >=      1 AND "run_id" <  46501 UNION ALL
        SELECT  46501 AS "start_index",  93000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >=  46501 AND "run_id" <  93001 UNION ALL
        SELECT  93001 AS "start_index", 139500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >=  93001 AND "run_id" < 139501 UNION ALL
        SELECT 139501 AS "start_index", 186000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 139501 AND "run_id" < 186001 UNION ALL
        SELECT 186001 AS "start_index", 232500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 186001 AND "run_id" < 232501 UNION ALL
        SELECT 232501 AS "start_index", 279000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 232501 AND "run_id" < 279001 UNION ALL
        SELECT 279001 AS "start_index", 325500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 279001 AND "run_id" < 325501 UNION ALL
        SELECT 325501 AS "start_index", 372000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 325501 AND "run_id" < 372001 UNION ALL
        SELECT 372001 AS "start_index", 418500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 372001 AND "run_id" < 418501 UNION ALL
        SELECT 418501 AS "start_index", 465000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 418501 AND "run_id" < 465001 UNION ALL
        SELECT 465001 AS "start_index", 511500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 465001 AND "run_id" < 511501 UNION ALL
        SELECT 511501 AS "start_index", 558000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 511501 AND "run_id" < 558001 UNION ALL
        SELECT 558001 AS "start_index", 604500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 558001 AND "run_id" < 604501 UNION ALL
        SELECT 604501 AS "start_index", 651000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 604501 AND "run_id" < 651001 UNION ALL
        SELECT 651001 AS "start_index", 697500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 651001 AND "run_id" < 697501 UNION ALL
        SELECT 697501 AS "start_index", 744000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 697501 AND "run_id" < 744001 UNION ALL
        SELECT 744001 AS "start_index", 790500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 744001 AND "run_id" < 790501 UNION ALL
        SELECT 790501 AS "start_index", 837000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 790501 AND "run_id" < 837001 UNION ALL
        SELECT 837001 AS "start_index", 883500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 837001 AND "run_id" < 883501 UNION ALL
        SELECT 883501 AS "start_index", 930000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0049_run_id" WHERE "run_id" >= 883501 AND "run_id" < 930001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0049_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0049_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0049_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0049_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0049";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0049_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0049_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0049_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0049_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0049_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0049" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0049_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0049_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0049_1pct") TO 'sensitivity_runs.output_table_0049_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0049_1pct.zip sensitivity_runs.output_table_0049_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0049_1pct.csv.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0049_1pct.csv.zip
