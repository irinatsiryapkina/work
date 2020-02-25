ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "cafo" REVOKE ALL PRIVILEGES                                   ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "cafo" REVOKE ALL PRIVILEGES                                   ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "cafo" REVOKE ALL PRIVILEGES                                   ON FUNCTIONS FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "cafo" REVOKE ALL PRIVILEGES                                   ON TYPES     FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "cafo" GRANT  SELECT                                           ON TABLES    TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "cafo" GRANT  SELECT                                           ON SEQUENCES TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "cafo" GRANT  USAGE                                            ON TYPES     TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "cafo" GRANT  INSERT, UPDATE, DELETE                           ON TABLES    TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "cafo" GRANT  USAGE                                            ON SEQUENCES TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "cafo" GRANT  EXECUTE                                          ON FUNCTIONS TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "cafo" GRANT  TRUNCATE, REFERENCES, TRIGGER, REFERENCES        ON TABLES    TO   "amilbrandt";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "cafo" GRANT  UPDATE                                           ON SEQUENCES TO   "amilbrandt";

ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fog" REVOKE ALL PRIVILEGES                                    ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fog" REVOKE ALL PRIVILEGES                                    ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fog" REVOKE ALL PRIVILEGES                                    ON FUNCTIONS FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fog" REVOKE ALL PRIVILEGES                                    ON TYPES     FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fog" GRANT  SELECT                                            ON TABLES    TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fog" GRANT  SELECT                                            ON SEQUENCES TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fog" GRANT  USAGE                                             ON TYPES     TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fog" GRANT  INSERT, UPDATE, DELETE                            ON TABLES    TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fog" GRANT  USAGE                                             ON SEQUENCES TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fog" GRANT  EXECUTE                                           ON FUNCTIONS TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fog" GRANT  TRUNCATE, REFERENCES, TRIGGER, REFERENCES         ON TABLES    TO   "amilbrandt";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fog" GRANT  UPDATE                                            ON SEQUENCES TO   "amilbrandt";

ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "food_waste" REVOKE ALL PRIVILEGES                             ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "food_waste" REVOKE ALL PRIVILEGES                             ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "food_waste" REVOKE ALL PRIVILEGES                             ON FUNCTIONS FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "food_waste" REVOKE ALL PRIVILEGES                             ON TYPES     FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "food_waste" GRANT  SELECT                                     ON TABLES    TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "food_waste" GRANT  SELECT                                     ON SEQUENCES TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "food_waste" GRANT  USAGE                                      ON TYPES     TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "food_waste" GRANT  INSERT, UPDATE, DELETE                     ON TABLES    TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "food_waste" GRANT  USAGE                                      ON SEQUENCES TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "food_waste" GRANT  EXECUTE                                    ON FUNCTIONS TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "food_waste" GRANT  TRUNCATE, REFERENCES, TRIGGER, REFERENCES  ON TABLES    TO   "amilbrandt";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "food_waste" GRANT  UPDATE                                     ON SEQUENCES TO   "amilbrandt";

ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fuel_prices" REVOKE ALL PRIVILEGES                            ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fuel_prices" REVOKE ALL PRIVILEGES                            ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fuel_prices" REVOKE ALL PRIVILEGES                            ON FUNCTIONS FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fuel_prices" REVOKE ALL PRIVILEGES                            ON TYPES     FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fuel_prices" GRANT  SELECT                                    ON TABLES    TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fuel_prices" GRANT  SELECT                                    ON SEQUENCES TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fuel_prices" GRANT  USAGE                                     ON TYPES     TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fuel_prices" GRANT  INSERT, UPDATE, DELETE                    ON TABLES    TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fuel_prices" GRANT  USAGE                                     ON SEQUENCES TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fuel_prices" GRANT  EXECUTE                                   ON FUNCTIONS TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fuel_prices" GRANT  TRUNCATE, REFERENCES, TRIGGER, REFERENCES ON TABLES    TO   "amilbrandt";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "fuel_prices" GRANT  UPDATE                                    ON SEQUENCES TO   "amilbrandt";

ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "lmop" REVOKE ALL PRIVILEGES                                   ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "lmop" REVOKE ALL PRIVILEGES                                   ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "lmop" REVOKE ALL PRIVILEGES                                   ON FUNCTIONS FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "lmop" REVOKE ALL PRIVILEGES                                   ON TYPES     FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "lmop" GRANT  SELECT                                           ON TABLES    TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "lmop" GRANT  SELECT                                           ON SEQUENCES TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "lmop" GRANT  USAGE                                            ON TYPES     TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "lmop" GRANT  INSERT, UPDATE, DELETE                           ON TABLES    TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "lmop" GRANT  USAGE                                            ON SEQUENCES TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "lmop" GRANT  EXECUTE                                          ON FUNCTIONS TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "lmop" GRANT  TRUNCATE, REFERENCES, TRIGGER, REFERENCES        ON TABLES    TO   "amilbrandt";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "lmop" GRANT  UPDATE                                           ON SEQUENCES TO   "amilbrandt";

ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "rins" REVOKE ALL PRIVILEGES                                   ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "rins" REVOKE ALL PRIVILEGES                                   ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "rins" REVOKE ALL PRIVILEGES                                   ON FUNCTIONS FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "rins" REVOKE ALL PRIVILEGES                                   ON TYPES     FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "rins" GRANT  SELECT                                           ON TABLES    TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "rins" GRANT  SELECT                                           ON SEQUENCES TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "rins" GRANT  USAGE                                            ON TYPES     TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "rins" GRANT  INSERT, UPDATE, DELETE                           ON TABLES    TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "rins" GRANT  USAGE                                            ON SEQUENCES TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "rins" GRANT  EXECUTE                                          ON FUNCTIONS TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "rins" GRANT  TRUNCATE, REFERENCES, TRIGGER, REFERENCES        ON TABLES    TO   "amilbrandt";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "rins" GRANT  UPDATE                                           ON SEQUENCES TO   "amilbrandt";

ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "wwtp" REVOKE ALL PRIVILEGES                                   ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "wwtp" REVOKE ALL PRIVILEGES                                   ON TABLES    FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "wwtp" REVOKE ALL PRIVILEGES                                   ON FUNCTIONS FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "wwtp" REVOKE ALL PRIVILEGES                                   ON TYPES     FROM "public";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "wwtp" GRANT  SELECT                                           ON TABLES    TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "wwtp" GRANT  SELECT                                           ON SEQUENCES TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "wwtp" GRANT  USAGE                                            ON TYPES     TO   "wte-ro";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "wwtp" GRANT  INSERT, UPDATE, DELETE                           ON TABLES    TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "wwtp" GRANT  USAGE                                            ON SEQUENCES TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "wwtp" GRANT  EXECUTE                                          ON FUNCTIONS TO   "wte-rw";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "wwtp" GRANT  TRUNCATE, REFERENCES, TRIGGER, REFERENCES        ON TABLES    TO   "amilbrandt";
ALTER DEFAULT PRIVILEGES FOR ROLE "amilbrandt" IN SCHEMA "wwtp" GRANT  UPDATE                                           ON SEQUENCES TO   "amilbrandt";
