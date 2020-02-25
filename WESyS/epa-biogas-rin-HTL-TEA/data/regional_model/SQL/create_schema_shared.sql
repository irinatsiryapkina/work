CREATE SCHEMA "shared";

COMMENT ON SCHEMA "shared" IS 'Open schema for temporarily sharing data. Tables are viewable and editable by all WTE users. Not publically accessible.';

REVOKE USAGE, CREATE ON SCHEMA "shared" FROM "public";
GRANT  USAGE, CREATE ON SCHEMA "shared" TO   "wte-users";

ALTER DEFAULT PRIVILEGES FOR ROLE "aeberle"   IN SCHEMA "shared" GRANT  SELECT         ON TABLES    TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "aeberle"   IN SCHEMA "shared" GRANT  USAGE          ON SEQUENCES TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "aeberle"   IN SCHEMA "shared" GRANT  EXECUTE        ON FUNCTIONS TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "aeberle"   IN SCHEMA "shared" GRANT  USAGE          ON TYPES     TO   "wte-users";

ALTER DEFAULT PRIVILEGES FOR ROLE "aeberle"   IN SCHEMA "shared" GRANT  SELECT         ON TABLES    TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "aeberle"   IN SCHEMA "shared" GRANT  USAGE          ON SEQUENCES TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "aeberle"   IN SCHEMA "shared" GRANT  EXECUTE        ON FUNCTIONS TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "aeberle"   IN SCHEMA "shared" GRANT  USAGE          ON TYPES     TO   "wte-users";

ALTER DEFAULT PRIVILEGES FOR ROLE "dhetting"  IN SCHEMA "shared" GRANT  SELECT         ON TABLES    TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "dhetting"  IN SCHEMA "shared" GRANT  USAGE          ON SEQUENCES TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "dhetting"  IN SCHEMA "shared" GRANT  EXECUTE        ON FUNCTIONS TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "dhetting"  IN SCHEMA "shared" GRANT  USAGE          ON TYPES     TO   "wte-users";

ALTER DEFAULT PRIVILEGES FOR ROLE "dinman"    IN SCHEMA "shared" GRANT  SELECT         ON TABLES    TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "dinman"    IN SCHEMA "shared" GRANT  USAGE          ON SEQUENCES TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "dinman"    IN SCHEMA "shared" GRANT  EXECUTE        ON FUNCTIONS TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "dinman"    IN SCHEMA "shared" GRANT  USAGE          ON TYPES     TO   "wte-users";

ALTER DEFAULT PRIVILEGES FOR ROLE "dstright"  IN SCHEMA "shared" GRANT  SELECT         ON TABLES    TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "dstright"  IN SCHEMA "shared" GRANT  USAGE          ON SEQUENCES TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "dstright"  IN SCHEMA "shared" GRANT  EXECUTE        ON FUNCTIONS TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "dstright"  IN SCHEMA "shared" GRANT  USAGE          ON TYPES     TO   "wte-users";

ALTER DEFAULT PRIVILEGES FOR ROLE "enewes"    IN SCHEMA "shared" GRANT  SELECT         ON TABLES    TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "enewes"    IN SCHEMA "shared" GRANT  USAGE          ON SEQUENCES TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "enewes"    IN SCHEMA "shared" GRANT  EXECUTE        ON FUNCTIONS TO   "wte-users";
ALTER DEFAULT PRIVILEGES FOR ROLE "enewes"    IN SCHEMA "shared" GRANT  USAGE          ON TYPES     TO   "wte-users";

ALTER SCHEMA "shared" OWNER TO "wte-admin";
