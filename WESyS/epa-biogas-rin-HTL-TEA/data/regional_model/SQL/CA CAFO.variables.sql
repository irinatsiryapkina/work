CREATE OR REPLACE VIEW "CA CAFO"."variables" AS
SELECT "ids"."id"
     , "a"."CAFO.conversion_efficiencies[BCFuel]"
     , "a"."CAFO.conversion_efficiencies[TCFuel]"
     , "a"."CAFO.conversion_efficiencies[CF]"
     , "a"."CAFO.conversion_efficiencies[Elec]"
     , "a"."CAFO.conversion_efficiencies[CNG]"
     , "a"."CAFO.conversion_efficiencies[PNG]"
     , "a"."CAFO.conversion_efficiencies[HTL]"
     , "a"."CAFO.conversion_efficiencies[FT]"
     , "a"."CAFO.conversion_efficiencies[NoWTE]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOLarge,BCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOLarge,CF]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOLarge,CNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOLarge,Elec]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOLarge,FT]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOLarge,HTL]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOLarge,NoWTE]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOLarge,PNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOLarge,TCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOMed,BCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOMed,CF]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOMed,CNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOMed,Elec]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOMed,FT]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOMed,HTL]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOMed,NoWTE]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOMed,PNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOMed,TCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOSmall,BCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOSmall,CF]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOSmall,CNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOSmall,Elec]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOSmall,FT]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOSmall,HTL]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOSmall,NoWTE]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOSmall,PNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Beef,CAFOSmall,TCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOLarge,BCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOLarge,CF]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOLarge,CNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOLarge,Elec]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOLarge,FT]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOLarge,HTL]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOLarge,NoWTE]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOLarge,PNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOLarge,TCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOMed,BCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOMed,CF]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOMed,CNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOMed,Elec]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOMed,FT]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOMed,HTL]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOMed,NoWTE]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOMed,PNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOMed,TCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOSmall,BCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOSmall,CF]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOSmall,CNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOSmall,Elec]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOSmall,FT]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOSmall,HTL]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOSmall,NoWTE]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOSmall,PNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Dairy,CAFOSmall,TCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOLarge,BCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOLarge,CF]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOLarge,CNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOLarge,Elec]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOLarge,FT]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOLarge,HTL]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOLarge,NoWTE]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOLarge,PNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOLarge,TCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOMed,BCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOMed,CF]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOMed,CNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOMed,Elec]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOMed,FT]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOMed,HTL]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOMed,NoWTE]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOMed,PNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOMed,TCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOSmall,BCFuel]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOSmall,CF]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOSmall,CNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOSmall,Elec]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOSmall,FT]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOSmall,HTL]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOSmall,NoWTE]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOSmall,PNG]"
     , "b"."CAFO.ExpectedFCI[HaveCapture,Swine,CAFOSmall,TCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOLarge,BCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOLarge,CF]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOLarge,CNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOLarge,Elec]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOLarge,FT]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOLarge,HTL]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOLarge,NoWTE]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOLarge,PNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOLarge,TCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOMed,BCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOMed,CF]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOMed,CNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOMed,Elec]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOMed,FT]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOMed,HTL]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOMed,NoWTE]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOMed,PNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOMed,TCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOSmall,BCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOSmall,CF]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOSmall,CNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOSmall,Elec]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOSmall,FT]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOSmall,HTL]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOSmall,NoWTE]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOSmall,PNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Beef,CAFOSmall,TCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOLarge,BCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOLarge,CF]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOLarge,CNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOLarge,Elec]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOLarge,FT]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOLarge,HTL]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOLarge,NoWTE]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOLarge,PNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOLarge,TCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOMed,BCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOMed,CF]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOMed,CNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOMed,Elec]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOMed,FT]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOMed,HTL]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOMed,NoWTE]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOMed,PNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOMed,TCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOSmall,BCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOSmall,CF]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOSmall,CNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOSmall,Elec]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOSmall,FT]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOSmall,HTL]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOSmall,NoWTE]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOSmall,PNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Dairy,CAFOSmall,TCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOLarge,BCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOLarge,CF]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOLarge,CNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOLarge,Elec]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOLarge,FT]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOLarge,HTL]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOLarge,NoWTE]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOLarge,PNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOLarge,TCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOMed,BCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOMed,CF]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOMed,CNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOMed,Elec]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOMed,FT]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOMed,HTL]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOMed,NoWTE]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOMed,PNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOMed,TCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOSmall,BCFuel]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOSmall,CF]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOSmall,CNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOSmall,Elec]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOSmall,FT]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOSmall,HTL]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOSmall,NoWTE]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOSmall,PNG]"
     , "b"."CAFO.ExpectedFCI[NoCapture,Swine,CAFOSmall,TCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOLarge, BCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOLarge, CF]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOLarge, CNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOLarge, Elec]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOLarge, FT]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOLarge, HTL]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOLarge, NoWTE]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOLarge, PNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOLarge, TCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOMed, BCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOMed, CF]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOMed, CNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOMed, Elec]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOMed, FT]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOMed, HTL]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOMed, NoWTE]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOMed, PNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOMed, TCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOSmall, BCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOSmall, CF]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOSmall, CNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOSmall, Elec]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOSmall, FT]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOSmall, HTL]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOSmall, NoWTE]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOSmall, PNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Beef, CAFOSmall, TCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOLarge, BCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOLarge, CF]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOLarge, CNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOLarge, Elec]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOLarge, FT]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOLarge, HTL]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOLarge, NoWTE]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOLarge, PNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOLarge, TCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOMed, BCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOMed, CF]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOMed, CNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOMed, Elec]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOMed, FT]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOMed, HTL]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOMed, NoWTE]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOMed, PNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOMed, TCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOSmall, BCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOSmall, CF]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOSmall, CNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOSmall, Elec]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOSmall, FT]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOSmall, HTL]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOSmall, NoWTE]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOSmall, PNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Dairy, CAFOSmall, TCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOLarge, BCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOLarge, CF]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOLarge, CNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOLarge, Elec]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOLarge, FT]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOLarge, HTL]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOLarge, NoWTE]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOLarge, PNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOLarge, TCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOMed, BCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOMed, CF]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOMed, CNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOMed, Elec]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOMed, FT]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOMed, HTL]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOMed, NoWTE]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOMed, PNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOMed, TCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOSmall, BCFuel]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOSmall, CF]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOSmall, CNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOSmall, Elec]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOSmall, FT]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOSmall, HTL]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOSmall, NoWTE]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOSmall, PNG]"
     , "c"."CAFO.Expected Op Cost[HaveCapture, Swine, CAFOSmall, TCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOLarge, BCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOLarge, CF]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOLarge, CNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOLarge, Elec]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOLarge, FT]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOLarge, HTL]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOLarge, NoWTE]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOLarge, PNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOLarge, TCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOMed, BCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOMed, CF]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOMed, CNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOMed, Elec]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOMed, FT]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOMed, HTL]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOMed, NoWTE]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOMed, PNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOMed, TCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOSmall, BCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOSmall, CF]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOSmall, CNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOSmall, Elec]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOSmall, FT]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOSmall, HTL]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOSmall, NoWTE]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOSmall, PNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Beef, CAFOSmall, TCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOLarge, BCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOLarge, CF]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOLarge, CNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOLarge, Elec]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOLarge, FT]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOLarge, HTL]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOLarge, NoWTE]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOLarge, PNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOLarge, TCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOMed, BCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOMed, CF]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOMed, CNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOMed, Elec]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOMed, FT]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOMed, HTL]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOMed, NoWTE]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOMed, PNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOMed, TCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOSmall, BCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOSmall, CF]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOSmall, CNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOSmall, Elec]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOSmall, FT]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOSmall, HTL]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOSmall, NoWTE]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOSmall, PNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Dairy, CAFOSmall, TCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOLarge, BCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOLarge, CF]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOLarge, CNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOLarge, Elec]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOLarge, FT]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOLarge, HTL]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOLarge, NoWTE]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOLarge, PNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOLarge, TCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOMed, BCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOMed, CF]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOMed, CNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOMed, Elec]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOMed, FT]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOMed, HTL]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOMed, NoWTE]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOMed, PNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOMed, TCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOSmall, BCFuel]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOSmall, CF]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOSmall, CNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOSmall, Elec]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOSmall, FT]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOSmall, HTL]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOSmall, NoWTE]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOSmall, PNG]"
     , "c"."CAFO.Expected Op Cost[NoCapture, Swine, CAFOSmall, TCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOLarge, BCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOLarge, CF]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOLarge, CNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOLarge, Elec]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOLarge, FT]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOLarge, HTL]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOLarge, NoWTE]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOLarge, PNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOLarge, TCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOMed, BCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOMed, CF]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOMed, CNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOMed, Elec]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOMed, FT]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOMed, HTL]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOMed, NoWTE]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOMed, PNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOMed, TCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOSmall, BCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOSmall, CF]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOSmall, CNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOSmall, Elec]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOSmall, FT]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOSmall, HTL]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOSmall, NoWTE]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOSmall, PNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Beef, CAFOSmall, TCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOLarge, BCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOLarge, CF]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOLarge, CNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOLarge, Elec]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOLarge, FT]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOLarge, HTL]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOLarge, NoWTE]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOLarge, PNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOLarge, TCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOMed, BCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOMed, CF]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOMed, CNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOMed, Elec]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOMed, FT]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOMed, HTL]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOMed, NoWTE]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOMed, PNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOMed, TCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOSmall, BCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOSmall, CF]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOSmall, CNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOSmall, Elec]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOSmall, FT]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOSmall, HTL]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOSmall, NoWTE]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOSmall, PNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Dairy, CAFOSmall, TCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOLarge, BCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOLarge, CF]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOLarge, CNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOLarge, Elec]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOLarge, FT]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOLarge, HTL]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOLarge, NoWTE]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOLarge, PNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOLarge, TCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOMed, BCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOMed, CF]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOMed, CNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOMed, Elec]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOMed, FT]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOMed, HTL]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOMed, NoWTE]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOMed, PNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOMed, TCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOSmall, BCFuel]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOSmall, CF]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOSmall, CNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOSmall, Elec]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOSmall, FT]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOSmall, HTL]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOSmall, NoWTE]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOSmall, PNG]"
     , "d"."CAFO.Initial_WTE_Distribution[Swine, CAFOSmall, TCFuel]"
     , "e"."CAFO.per_facility_CH4_collection[Beef, CAFOLarge]"
     , "e"."CAFO.per_facility_CH4_collection[Beef, CAFOMed]"
     , "e"."CAFO.per_facility_CH4_collection[Beef, CAFOSmall]"
     , "e"."CAFO.per_facility_CH4_collection[Dairy, CAFOLarge]"
     , "e"."CAFO.per_facility_CH4_collection[Dairy, CAFOMed]"
     , "e"."CAFO.per_facility_CH4_collection[Dairy, CAFOSmall]"
     , "e"."CAFO.per_facility_CH4_collection[Swine, CAFOLarge]"
     , "e"."CAFO.per_facility_CH4_collection[Swine, CAFOMed]"
     , "e"."CAFO.per_facility_CH4_collection[Swine, CAFOSmall]"
     , "f"."CAFO.per tonne tipping fee"
     , "g"."CAFO.Unit Price Scenario[NoWTE]"
     , "g"."CAFO.Unit Price Scenario[CF]"
     , "g"."CAFO.Unit Price Scenario[Elec]"
     , "g"."CAFO.Unit Price Scenario[CNG]"
     , "g"."CAFO.Unit Price Scenario[PNG]"
     , "g"."CAFO.Unit Price Scenario[BCFuel]"
     , "g"."CAFO.Unit Price Scenario[TCFUEL]"
     , "g"."CAFO.Unit Price Scenario[HTL]"
     , "g"."CAFO.Unit Price Scenario[FT]"
FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15), (16), (17), (18), (19), (20), (21), (22), (23), (24), (25), (26), (27), (28), (29), (30), (31), (32), (33), (34), (35), (36), (37), (38), (39), (40), (41)) "ids" ("id")
FULL JOIN "CA CAFO"."conversion_efficiencies"     "a" ON "ids"."id" = "a"."id"
FULL JOIN "CA CAFO"."ExpectedFCI"                 "b" ON "ids"."id" = "b"."id"
FULL JOIN "CA CAFO"."Expected Op Cost"            "c" ON "ids"."id" = "c"."id"
FULL JOIN "CA CAFO"."Initial_WTE_Distribution"    "d" ON "ids"."id" = "d"."id"
FULL JOIN "CA CAFO"."per_facility_CH4_collection" "e" ON "ids"."id" = "e"."id"
FULL JOIN "CA CAFO"."per_tonne_tipping_fee"       "f" ON "ids"."id" = "f"."id"
FULL JOIN "CA CAFO"."Unit_Price_Scenario"         "g" ON "ids"."id" = "g"."id"
ORDER BY "ids"."id";