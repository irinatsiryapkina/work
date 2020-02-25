REASSIGN OWNED BY "wte-client" TO "wte-admin";

REVOKE ALL ON DATABASE "wte" FROM "wte-client";

DROP ROLE "wte-client";
