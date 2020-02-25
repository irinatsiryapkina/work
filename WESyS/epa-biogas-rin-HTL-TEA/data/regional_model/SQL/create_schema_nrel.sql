CREATE SCHEMA "nrel";

COMMENT ON SCHEMA "nrel" IS 'Raw data from NREL.';

REVOKE USAGE  ON SCHEMA "nrel" FROM "public";
GRANT  USAGE  ON SCHEMA "nrel" TO   "wte-ro";
GRANT  CREATE ON SCHEMA "nrel" TO   "wte-admin";

ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "nrel" REVOKE ALL PRIVILEGES                            ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "nrel" REVOKE ALL PRIVILEGES                            ON SEQUENCES FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "nrel" REVOKE ALL PRIVILEGES                            ON FUNCTIONS FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "nrel" REVOKE ALL PRIVILEGES                            ON TYPES     FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "nrel" GRANT  SELECT                                    ON TABLES    TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "nrel" GRANT  SELECT                                    ON SEQUENCES TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "nrel" GRANT  USAGE                                     ON TYPES     TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "nrel" GRANT  INSERT, UPDATE, DELETE                    ON TABLES    TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "nrel" GRANT  USAGE                                     ON SEQUENCES TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "nrel" GRANT  EXECUTE                                   ON FUNCTIONS TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "nrel" GRANT  TRUNCATE, REFERENCES, TRIGGER, REFERENCES ON TABLES    TO   "wte-admin";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "nrel" GRANT  UPDATE                                    ON SEQUENCES TO   "wte-admin";

ALTER SCHEMA "nrel" OWNER TO "wte-admin";
