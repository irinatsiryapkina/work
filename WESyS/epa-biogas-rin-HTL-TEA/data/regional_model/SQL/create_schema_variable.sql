CREATE SCHEMA "variable";

COMMENT ON SCHEMA "variable" IS 'Formatted data ready for export, by model variable name';

REVOKE USAGE  ON SCHEMA "variable" FROM "public";
GRANT  USAGE  ON SCHEMA "variable" TO   "wte-ro";
GRANT  CREATE ON SCHEMA "variable" TO   "wte-admin";

ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "variable" REVOKE ALL PRIVILEGES                            ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "variable" REVOKE ALL PRIVILEGES                            ON SEQUENCES FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "variable" REVOKE ALL PRIVILEGES                            ON FUNCTIONS FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "variable" REVOKE ALL PRIVILEGES                            ON TYPES     FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "variable" GRANT  SELECT                                    ON TABLES    TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "variable" GRANT  SELECT                                    ON SEQUENCES TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "variable" GRANT  USAGE                                     ON TYPES     TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "variable" GRANT  INSERT, UPDATE, DELETE                    ON TABLES    TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "variable" GRANT  USAGE                                     ON SEQUENCES TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "variable" GRANT  EXECUTE                                   ON FUNCTIONS TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "variable" GRANT  TRUNCATE, REFERENCES, TRIGGER, REFERENCES ON TABLES    TO   "wte-admin";
ALTER DEFAULT PRIVILEGES FOR ROLE "wte-admin" IN SCHEMA "variable" GRANT  UPDATE                                    ON SEQUENCES TO   "wte-admin";

ALTER SCHEMA "variable" OWNER TO "wte-admin";
