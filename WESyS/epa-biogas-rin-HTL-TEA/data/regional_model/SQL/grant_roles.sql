GRANT "wte-admin" TO "dhetting" WITH ADMIN OPTION;

GRANT "wte-ro"    TO "wte-rw";
GRANT "wte-rw"    TO "wte-admin";

GRANT "wte-admin" TO "aeberle";

GRANT "wte-rw"    TO "wte-client";

GRANT "wte-ro"    TO "amilbrandt";
GRANT "wte-ro"    TO "dinman";
GRANT "wte-ro"    TO "dstright";
GRANT "wte-ro"    TO "enewes";

GRANT "wte-ro"    TO "wte-users";

GRANT "wte-users" TO "aeberle";
GRANT "wte-users" TO "amilbrandt";
GRANT "wte-users" TO "dhetting";
GRANT "wte-users" TO "dinman";
GRANT "wte-users" TO "dstright";
GRANT "wte-users" TO "enewes";

-- GRANT "aeberle"    TO "wte-admin" WITH ADMIN OPTION;
-- GRANT "amilbrandt" TO "wte-admin" WITH ADMIN OPTION;
-- GRANT "dhetting"   TO "wte-admin" WITH ADMIN OPTION;
-- GRANT "dinman"     TO "wte-admin" WITH ADMIN OPTION;
-- GRANT "dstright"   TO "wte-admin" WITH ADMIN OPTION;
-- GRANT "enewes"     TO "wte-admin" WITH ADMIN OPTION;
