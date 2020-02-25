CREATE SCHEMA "admin";

COMMENT ON SCHEMA "admin" IS 'Closed schema for WTE functions and administrative tables. Privileges by wte-ro, wte-rw, and wte-admin. Not publicly accessible.';

REVOKE USAGE  ON SCHEMA "admin" FROM "public";
GRANT  USAGE  ON SCHEMA "admin" TO   "wte-ro";
GRANT  CREATE ON SCHEMA "admin" TO   "wte-admin";

ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "admin" REVOKE ALL PRIVILEGES                            ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "admin" REVOKE ALL PRIVILEGES                            ON SEQUENCES FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "admin" REVOKE ALL PRIVILEGES                            ON FUNCTIONS FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "admin" REVOKE ALL PRIVILEGES                            ON TYPES     FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "admin" GRANT  SELECT                                    ON TABLES    TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "admin" GRANT  SELECT                                    ON SEQUENCES TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "admin" GRANT  USAGE                                     ON TYPES     TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "admin" GRANT  INSERT, UPDATE, DELETE                    ON TABLES    TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "admin" GRANT  USAGE                                     ON SEQUENCES TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "admin" GRANT  EXECUTE                                   ON FUNCTIONS TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "admin" GRANT  TRUNCATE, REFERENCES, TRIGGER, REFERENCES ON TABLES    TO   "wte-admin";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "admin" GRANT  UPDATE                                    ON SEQUENCES TO   "wte-admin";

ALTER SCHEMA "admin" OWNER TO "wte-admin";
