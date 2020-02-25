DROP   TABLE IF EXISTS "admin"."conversions";
CREATE TABLE           "admin"."conversions" (
    "from_unit" TEXT
  , "to_unit"   TEXT
  , "factor"    NUMERIC
  , "source"    TEXT
);
ALTER TABLE "admin"."conversions" ADD CONSTRAINT "pkey_conversion" PRIMARY KEY ("from_unit", "to_unit");

COMMENT ON TABLE "admin"."conversions" IS 'frequently used conversion factors';

GRANT SELECT ON "admin"."conversions" TO "wte-users";

INSERT INTO "admin"."conversions" ("from_unit", "factor", "to_unit", "source") VALUES
    ('US ton',         0.907185,     'metric ton',           NULL)
  , ('acre',           43560.0,      'square feet',          NULL)
  , ('GGE',            11400.0,      'Btu',                  NULL)
  , ('cubic meter',    35.3147,      'cubic feet',           NULL)
  , ('GJ',             947817.0,     'MMBtu',                NULL)
  , ('MWh',            3.412e+6,     'Btu',                  NULL)
  , ('MMBtu',          8.77,         'GGE',                  'Source http://www.nat-g.com/why-cng/cng-units-explained/')
  , ('MWh',            31.0,         'GGE',                  'Source http://www.nat-g.com/why-cng/cng-units-explained/')

  , ('metric ton',     1.0/0.907185, 'US ton',               NULL)
  , ('Btu',            1.0/11400.0,  'GGE',                  NULL)
  , ('MMBtu',          1.0/947817.0, 'GJ',                   NULL)
  , ('square feet',    1.0/43560,    'acre',                 NULL)
  , ('cubic feet',     1.0/35.3147,  'cubic meter',          NULL)
  , ('Btu',            1.0/3.412e+6, 'MWh',                  NULL)
  , ('GGE',            1.0/8.77,     'MMBtu',                'Source http://www.nat-g.com/why-cng/cng-units-explained/')
  , ('GGE',            1.0/31.0,     'MWh',                  'Source http://www.nat-g.com/why-cng/cng-units-explained/')
  , ('head cattle',    136.0,        'cubic meters methane', NULL)
  , ('head pig',       247.29,       'cubic meters methane', NULL)
  , ('head cow',       690.25,       'cubic meters methane', NULL)
  , ('gallon',         42,           'barrel',               NULL)
  , ('gallon crude',   1.1298,       'GGE',                  '120476 Btu/gallon gasoline; 136 119 btu/gallon crude -> 1.1298 gge/gallon crude')
  , ('kWh',            33.7,         'GGE',                  'https://www.afdc.energy.gov/fuels/fuel_comparison_chart.pdf')
  , ('cubic feet CNG', 123.57,       'GGE',                  'https://www.afdc.energy.gov/fuels/fuel_comparison_chart.pdf')
  , ('gallon diesel',  1.13,         'GGE',                  'https://www.afdc.energy.gov/fuels/fuel_comparison_chart.pdf')

;


-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'acre'        AND "to_unit" = 'square feet'         ) -- 43560
-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'metric ton'  AND "to_unit" = 'US ton'              ) -- 1.10231
-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'cubic meter' AND "to_unit" = 'cubic feet'          ) -- 35.3147
-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'US ton'      AND "to_unit" = 'metric ton'          ) -- 0.907185
-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'MMBtu'       AND "to_unit" = 'GGE'                 ) -- 8.77
-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'MWh'         AND "to_unit" = 'GGE'                 ) -- 31.0
--
-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'head cattle' AND "to_unit" = 'cubic meters methane') -- 136.0
-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'head pig'    AND "to_unit" = 'cubic meters methane') -- 247.29
-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'head cow'    AND "to_unit" = 'cubic meters methane') -- 690.25

-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'gallon'         AND "to_unit" = 'barrel') -- 42
-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'gallon crude'   AND "to_unit" = 'GGE'   ) -- 1.1298
-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'kWh'            AND "to_unit" = 'GGE'   ) -- 33.7
-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'cubic feet CNG' AND "to_unit" = 'GGE'   ) -- 123.57
-- (SELECT "factor" FROM "admin"."conversions" WHERE "from_unit" = 'gallon diesel'  AND "to_unit" = 'GGE') -- 1.13