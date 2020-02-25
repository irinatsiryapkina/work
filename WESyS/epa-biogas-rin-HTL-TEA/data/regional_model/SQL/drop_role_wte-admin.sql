REASSIGN OWNED BY "wte-admin" TO "postgres";

REVOKE ALL PRIVILEGES ON DATABASE "wte" FROM "wte-admin";

DROP ROLE "wte-admin";
