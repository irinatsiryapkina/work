BEGIN;

SET ROLE "wte-admin";

GRANT USAGE ON SCHEMA "public" TO "wte-ro";

REVOKE ALL PRIVILEGES ON ALL TABLES    IN SCHEMA "public" FROM "public";
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA "public" FROM "public";
REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA "public" FROM "public";

-- SELECT n.nspname as "Schema",
--   pg_catalog.format_type(t.oid, NULL) AS "Name",
--   pg_catalog.obj_description(t.oid, 'pg_type') as "Description"
-- FROM pg_catalog.pg_type t
--      LEFT JOIN pg_catalog.pg_namespace n ON n.oid = t.typnamespace
-- WHERE (t.typrelid = 0 OR (SELECT c.relkind = 'c' FROM pg_catalog.pg_class c WHERE c.oid = t.typrelid))
--   AND NOT EXISTS(SELECT 1 FROM pg_catalog.pg_type el WHERE el.oid = t.typelem AND el.typarray = t.oid)
--   AND pg_catalog.pg_type_is_visible(t.oid)
--   AND n.nspname = 'public'
-- ORDER BY 1, 2;

GRANT USAGE ON TYPE "public"."addbandarg"           TO "wte-ro";
GRANT USAGE ON TYPE "public"."agg_count"            TO "wte-ro";
GRANT USAGE ON TYPE "public"."agg_samealignment"    TO "wte-ro";
GRANT USAGE ON TYPE "public"."box2d"                TO "wte-ro";
GRANT USAGE ON TYPE "public"."box2df"               TO "wte-ro";
GRANT USAGE ON TYPE "public"."box3d"                TO "wte-ro";
GRANT USAGE ON TYPE "public"."dblink_pkey_results"  TO "wte-ro";
GRANT USAGE ON TYPE "public"."geography"            TO "wte-ro";
GRANT USAGE ON TYPE "public"."geometry"             TO "wte-ro";
GRANT USAGE ON TYPE "public"."geometry_dump"        TO "wte-ro";
GRANT USAGE ON TYPE "public"."geomval"              TO "wte-ro";
GRANT USAGE ON TYPE "public"."ghstore"              TO "wte-ro";
GRANT USAGE ON TYPE "public"."gidx"                 TO "wte-ro";
GRANT USAGE ON TYPE "public"."hstore"               TO "wte-ro";
GRANT USAGE ON TYPE "public"."lquery"               TO "wte-ro";
GRANT USAGE ON TYPE "public"."ltree"                TO "wte-ro";
GRANT USAGE ON TYPE "public"."ltree_gist"           TO "wte-ro";
GRANT USAGE ON TYPE "public"."ltxtquery"            TO "wte-ro";
GRANT USAGE ON TYPE "public"."pgis_abs"             TO "wte-ro";
GRANT USAGE ON TYPE "public"."rastbandarg"          TO "wte-ro";
GRANT USAGE ON TYPE "public"."raster"               TO "wte-ro";
GRANT USAGE ON TYPE "public"."reclassarg"           TO "wte-ro";
GRANT USAGE ON TYPE "public"."spheroid"             TO "wte-ro";
GRANT USAGE ON TYPE "public"."summarystats"         TO "wte-ro";
GRANT USAGE ON TYPE "public"."tablefunc_crosstab_2" TO "wte-ro";
GRANT USAGE ON TYPE "public"."tablefunc_crosstab_3" TO "wte-ro";
GRANT USAGE ON TYPE "public"."tablefunc_crosstab_4" TO "wte-ro";
GRANT USAGE ON TYPE "public"."unionarg"             TO "wte-ro";
GRANT USAGE ON TYPE "public"."valid_detail"         TO "wte-ro";

REVOKE ALL PRIVILEGES ON TYPE "public"."addbandarg"           FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."agg_count"            FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."agg_samealignment"    FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."box2d"                FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."box2df"               FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."box3d"                FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."dblink_pkey_results"  FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."geography"            FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."geometry"             FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."geometry_dump"        FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."geomval"              FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."ghstore"              FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."gidx"                 FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."hstore"               FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."lquery"               FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."ltree"                FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."ltree_gist"           FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."ltxtquery"            FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."pgis_abs"             FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."rastbandarg"          FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."raster"               FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."reclassarg"           FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."spheroid"             FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."summarystats"         FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."tablefunc_crosstab_2" FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."tablefunc_crosstab_3" FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."tablefunc_crosstab_4" FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."unionarg"             FROM "public";
REVOKE ALL PRIVILEGES ON TYPE "public"."valid_detail"         FROM "public";

COMMIT;
