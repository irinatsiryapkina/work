REVOKE "wte-admin" FROM "aeberle";

REVOKE "wte-rw"    FROM "wte-client";

REVOKE "wte-ro"    FROM "amilbrandt";
REVOKE "wte-ro"    FROM "dinman";
REVOKE "wte-ro"    FROM "dstright";
REVOKE "wte-ro"    FROM "enewes";

REVOKE "wte-ro"    FROM "wte-users";

REVOKE "wte-users" FROM "aeberle";
REVOKE "wte-users" FROM "amilbrandt";
REVOKE "wte-users" FROM "dhetting";
REVOKE "wte-users" FROM "dinman";
REVOKE "wte-users" FROM "dstright";
REVOKE "wte-users" FROM "enewes";

REVOKE "aeberle"    FROM "wte-admin";
REVOKE "amilbrandt" FROM "wte-admin";
REVOKE "dhetting"   FROM "wte-admin";
REVOKE "dinman"     FROM "wte-admin";
REVOKE "dstright"   FROM "wte-admin";
REVOKE "enewes"     FROM "wte-admin";

REVOKE "wte-ro"    FROM "wte-rw";
REVOKE "wte-rw"    FROM "wte-admin";

REVOKE "wte-admin" FROM "dhetting";
