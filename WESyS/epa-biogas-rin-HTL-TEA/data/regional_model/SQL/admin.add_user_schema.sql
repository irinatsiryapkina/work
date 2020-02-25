DROP   FUNCTION IF EXISTS "admin"."add_user_schema"(IN TEXT);
CREATE FUNCTION           "admin"."add_user_schema"(IN TEXT) RETURNS "void" 
    AS $BODY$
        DECLARE
            s TEXT := $1;
          u TEXT := $1;
        BEGIN

            -- SET DATABASE PERMISSIONS
            EXECUTE 'GRANT CONNECT, TEMPORARY ON DATABASE "wte" TO ' || quote_ident(u) || ';';

            -- CREATE SCHEMA IF IT DOES NOT EXIST
            EXECUTE '
                DO $$ BEGIN 
                    IF NOT EXISTS(SELECT "schema_name" FROM "information_schema"."schemata" WHERE "schema_name" = ' || quote_literal(s) || ')
                    THEN CREATE SCHEMA '|| quote_ident(s) || ';
                    END IF;
                END $$;
            ';
 
            -- SET SCHEMA PRIVILEGES
            EXECUTE 'ALTER SCHEMA ' || quote_ident(s) || ' OWNER TO ' || quote_ident(s) || ';';
            EXECUTE 'GRANT ALL PRIVILEGES ON SCHEMA ' || quote_ident(s) || ' TO ' || quote_ident(s) || ' WITH GRANT OPTION;';
            EXECUTE 'GRANT ALL PRIVILEGES ON ALL TABLES    IN SCHEMA ' || quote_ident(s) || ' TO ' || quote_ident(s) || ' WITH GRANT OPTION;';
            EXECUTE 'GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA ' || quote_ident(s) || ' TO ' || quote_ident(s) || ' WITH GRANT OPTION;';
            EXECUTE 'GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA ' || quote_ident(s) || ' TO ' || quote_ident(s) || ' WITH GRANT OPTION;';

            EXECUTE 'REVOKE ALL PRIVILEGES ON SCHEMA ' || quote_ident(s) || ' FROM "wte-ro";';
            EXECUTE 'REVOKE ALL PRIVILEGES ON SCHEMA ' || quote_ident(s) || ' FROM "wte-rw";';
            EXECUTE 'REVOKE ALL PRIVILEGES ON SCHEMA ' || quote_ident(s) || ' FROM "wte-admin";';
            EXECUTE 'REVOKE ALL PRIVILEGES ON SCHEMA ' || quote_ident(s) || ' FROM "wte-client";';

            -- SET DEFAULT PERMISSIONS FOR NEW OBJECTS
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON TABLES    FROM "public";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON SEQUENCES FROM "public";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON FUNCTIONS FROM "public";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON TYPES     FROM "public";';

            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON TABLES    FROM "wte-admin";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON SEQUENCES FROM "wte-admin";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON FUNCTIONS FROM "wte-admin";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON TYPES     FROM "wte-admin";';

            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON TABLES    FROM "wte-rw";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON SEQUENCES FROM "wte-rw";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON FUNCTIONS FROM "wte-rw";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON TYPES     FROM "wte-rw";';

            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON TABLES    FROM "wte-ro";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON SEQUENCES FROM "wte-ro";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON FUNCTIONS FROM "wte-ro";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON TYPES     FROM "wte-ro";';

            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON TABLES    FROM "wte-client";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON SEQUENCES FROM "wte-client";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON FUNCTIONS FROM "wte-client";';
            EXECUTE 'ALTER DEFAULT PRIVILEGES FOR ROLE ' || quote_ident(u) || ' IN SCHEMA ' || quote_ident(s) || ' REVOKE ALL PRIVILEGES ON TYPES     FROM "wte-client";';

  END
    $BODY$
    LANGUAGE plpgsql
    COST 100
    CALLED ON NULL INPUT
    SECURITY INVOKER
    VOLATILE;
