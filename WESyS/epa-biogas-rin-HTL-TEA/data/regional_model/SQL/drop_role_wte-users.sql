REASSIGN OWNED BY "wte-users" TO "wte-admin";

REVOKE ALL ON DATABASE "wte" FROM "wte-users";

DROP ROLE "wte-users";
