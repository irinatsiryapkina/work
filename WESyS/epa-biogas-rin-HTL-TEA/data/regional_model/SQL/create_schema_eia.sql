CREATE SCHEMA "eia";

COMMENT ON SCHEMA "eia" IS 'Raw data from the Energy Information Agency.';

REVOKE USAGE  ON SCHEMA "eia" FROM "public";
GRANT  USAGE  ON SCHEMA "eia" TO   "wte-ro";
GRANT  CREATE ON SCHEMA "eia" TO   "wte-admin";

ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "eia" REVOKE ALL PRIVILEGES                            ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "eia" REVOKE ALL PRIVILEGES                            ON SEQUENCES FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "eia" REVOKE ALL PRIVILEGES                            ON FUNCTIONS FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "eia" REVOKE ALL PRIVILEGES                            ON TYPES     FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "eia" GRANT  SELECT                                    ON TABLES    TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "eia" GRANT  SELECT                                    ON SEQUENCES TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "eia" GRANT  USAGE                                     ON TYPES     TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "eia" GRANT  INSERT, UPDATE, DELETE                    ON TABLES    TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "eia" GRANT  USAGE                                     ON SEQUENCES TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "eia" GRANT  EXECUTE                                   ON FUNCTIONS TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "eia" GRANT  TRUNCATE, REFERENCES, TRIGGER, REFERENCES ON TABLES    TO   "wte-admin";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "eia" GRANT  UPDATE                                    ON SEQUENCES TO   "wte-admin";

ALTER SCHEMA "eia" OWNER TO "wte-admin";
