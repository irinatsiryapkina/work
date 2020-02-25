REASSIGN OWNED BY "wte-ro" TO "wte-rw";

REVOKE ALL PRIVILEGES ON DATABASE "wte" FROM "wte-ro";

DROP ROLE "wte-ro";
