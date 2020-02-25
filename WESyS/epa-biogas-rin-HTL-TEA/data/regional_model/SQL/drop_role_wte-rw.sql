REASSIGN OWNED BY "wte-rw" TO "wte-admin";

REVOKE ALL PRIVILEGES ON DATABASE "wte" FROM "wte-rw";

DROP ROLE "wte-rw";
