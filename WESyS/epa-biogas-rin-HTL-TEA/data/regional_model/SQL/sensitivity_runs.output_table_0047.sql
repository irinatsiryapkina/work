-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0047" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0047" (CONSTRAINT "output_table_0047_run_config_check" CHECK ("run_config" = 47)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0047" ADD CONSTRAINT "pkey_output_table_0047" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0047_factor_btree" ON "sensitivity_runs"."output_table_0047" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0047_run_id_btree" ON "sensitivity_runs"."output_table_0047" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0047_brin_time"    ON "sensitivity_runs"."output_table_0047" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0047_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0047_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0047"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0047_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0047_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0047"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0047_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0047_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  47250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >=      1 AND "run_id" <  47251 UNION ALL
        SELECT  47251 AS "start_index",  94500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >=  47251 AND "run_id" <  94501 UNION ALL
        SELECT  94501 AS "start_index", 141750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >=  94501 AND "run_id" < 141751 UNION ALL
        SELECT 141751 AS "start_index", 189000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 141751 AND "run_id" < 189001 UNION ALL
        SELECT 189001 AS "start_index", 236250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 189001 AND "run_id" < 236251 UNION ALL
        SELECT 236251 AS "start_index", 283500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 236251 AND "run_id" < 283501 UNION ALL
        SELECT 283501 AS "start_index", 330750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 283501 AND "run_id" < 330751 UNION ALL
        SELECT 330751 AS "start_index", 378000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 330751 AND "run_id" < 378001 UNION ALL
        SELECT 378001 AS "start_index", 425250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 378001 AND "run_id" < 425251 UNION ALL
        SELECT 425251 AS "start_index", 472500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 425251 AND "run_id" < 472501 UNION ALL
        SELECT 472501 AS "start_index", 519750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 472501 AND "run_id" < 519751 UNION ALL
        SELECT 519751 AS "start_index", 567000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 519751 AND "run_id" < 567001 UNION ALL
        SELECT 567001 AS "start_index", 614250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 567001 AND "run_id" < 614251 UNION ALL
        SELECT 614251 AS "start_index", 661500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 614251 AND "run_id" < 661501 UNION ALL
        SELECT 661501 AS "start_index", 708750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 661501 AND "run_id" < 708751 UNION ALL
        SELECT 708751 AS "start_index", 756000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 708751 AND "run_id" < 756001 UNION ALL
        SELECT 756001 AS "start_index", 803250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 756001 AND "run_id" < 803251 UNION ALL
        SELECT 803251 AS "start_index", 850500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 803251 AND "run_id" < 850501 UNION ALL
        SELECT 850501 AS "start_index", 897750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 850501 AND "run_id" < 897751 UNION ALL
        SELECT 897751 AS "start_index", 945000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0047_run_id" WHERE "run_id" >= 897751 AND "run_id" < 945001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0047_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0047_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0047_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0047_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0047";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0047_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0047_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0047_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0047_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0047_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0047" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0047_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0047_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0047_1pct") TO 'sensitivity_runs.output_table_0047_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0047_1pct.zip sensitivity_runs.output_table_0047_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0047_1pct.csv.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0047_1pct.csv.zip
