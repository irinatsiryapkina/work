CREATE SCHEMA "ca";

COMMENT ON SCHEMA "ca" IS 'Prepared variable data for the CA region.';

REVOKE USAGE  ON SCHEMA "ca" FROM "public";
GRANT  USAGE  ON SCHEMA "ca" TO   "wte-ro";
GRANT  CREATE ON SCHEMA "ca" TO   "wte-admin";

ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "ca" REVOKE ALL PRIVILEGES                            ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "ca" REVOKE ALL PRIVILEGES                            ON SEQUENCES FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "ca" REVOKE ALL PRIVILEGES                            ON FUNCTIONS FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "ca" REVOKE ALL PRIVILEGES                            ON TYPES     FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "ca" GRANT  SELECT                                    ON TABLES    TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "ca" GRANT  SELECT                                    ON SEQUENCES TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "ca" GRANT  USAGE                                     ON TYPES     TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "ca" GRANT  INSERT, UPDATE, DELETE                    ON TABLES    TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "ca" GRANT  USAGE                                     ON SEQUENCES TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "ca" GRANT  EXECUTE                                   ON FUNCTIONS TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "ca" GRANT  TRUNCATE, REFERENCES, TRIGGER, REFERENCES ON TABLES    TO   "wte-admin";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "ca" GRANT  UPDATE                                    ON SEQUENCES TO   "wte-admin";

ALTER SCHEMA "ca" OWNER TO "wte-admin";
