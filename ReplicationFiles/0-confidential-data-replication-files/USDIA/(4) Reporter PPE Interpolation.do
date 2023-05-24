/* Program date:  November 4, 2021 */
/* Program name:  '(4) Reporter PPE Interpolation.do' */
/* Program description:  This program generates a dataset with net PPE interpolated between benchmark years
for U.S. reporters:  interpolate_rep_netppe. */
/* The output dataset from this program is used in SAS at
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(5) Working Data Sets 1982-2016 AER Replication.sas' */

drop _all
# delimit ;
set more 1 ;
set linesize 200 ;
cd "L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Data Sets" ;
log using reporter_ppe_interpolation.log, replace ;

* 1989 ;
odbc load, table("11A89RF") dsn("be11_1989_64bit") ;
gen str12 us_id2=us_id+"      " ;
drop us_id ;
ren us_id2 us_id ;
sort us_id ;
keep us_id nbv_ppe_cy ;
gen nbv_ppe_cy_bm=nbv_ppe_cy ;
gen year=1989 ;
order us_id year nbv_ppe_cy_bm;
save masterdata, replace ;
clear ;

* 1990 ;
odbc load, table("11A90RF") dsn("be11_1990_64bit") ;
gen str12 us_id=PAR_ID_6+"      " ;
gen nbv_ppe_cy_bm=. ;
gen year=1990 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 1991 ;

odbc load, table("11A91RF") dsn("be11_1991_64bit") ;
gen str12 us_id=PAR_ID_6+"      " ;
gen nbv_ppe_cy_bm=. ;
gen year=1991 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 1992 ;

odbc load, table("11A92RF") dsn("be11_1992_64bit") ;
gen str12 us_id=PAR_ID_6+"      " ;
gen nbv_ppe_cy_bm=. ;
gen year=1992 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 1993 ;

odbc load, table("11A93RF") dsn("be11_1993_64bit") ;
gen str12 us_id=PAR_ID_6+"      " ;
gen nbv_ppe_cy_bm=. ;
gen year=1993 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 1994 ;
odbc load, table("dbo_be10_rep_data4") dsn("be11_1994_64bit") ;
ren nbv_ppe_94 nbv_ppe_cy_bm ;
keep us_id nbv_ppe_cy_bm ;
gen year=1994 ;
order us_id year nbv_ppe_cy_bm;
append using masterdata ;
save masterdata, replace ;
clear ;

* 1995 ;

odbc load if (period_year==1995 & version=="r"), table("dbo_be11_reporter") dsn("be11_1995_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=1995 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 1996 ;

odbc load if (period_year==1996 & version=="r"), table("dbo_be11_reporter") dsn("be11_1996_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=1996 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 1997 ;

odbc load if (period_year==1997 & version=="r"), table("dbo_be11_reporter") dsn("be11_1997_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=1997 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 1998 ;

odbc load if (period_year==1998 & version=="r"), table("dbo_be11_reporter") dsn("be11_1998_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=1998 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 1999 ;

odbc load if (period_year==1999 & version=="r"), table("dbo_be10_rep_misc") dsn("be11_1999_64bit") ;
destring nbv_ppe_cy, replace ;
keep us_id nbv_ppe_cy ;
ren nbv_ppe_cy nbv_ppe_cy_bm ;
gen year=1999 ;
order us_id year nbv_ppe_cy_bm;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2000 ;

odbc load if (period_year==2000 & version=="r" & us_id != "0"), table("dbo_be11_reporter") dsn("be11_2000_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2000 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2001 ;

odbc load if (period_year==2001 & version=="r"), table("dbo_be11_reporter") dsn("be11_2001_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2001 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2002 ;

odbc load if (period_year==2002 & version=="r"), table("dbo_be11_reporter") dsn("be11_2002_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2002 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2003 ;

odbc load if (period_year==2003 & version=="r"), table("dbo_be11_reporter") dsn("be11_2003_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2003 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2004 ;

odbc load if (period_year==2004 & version=="r"), table("dbo_be10_rep_misc") dsn("be11_2004_64bit") ;
destring nbv_ppe_cy, replace ;
keep us_id nbv_ppe_cy ;
ren nbv_ppe_cy nbv_ppe_cy_bm ;
gen year=2004 ;
order us_id year nbv_ppe_cy_bm;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2005 ;

odbc load if (period_year==2005 & version=="r"), table("dbo_be11_reporter") dsn("be11_2005_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2005 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2006 ;

odbc load if (period_year==2006 & version=="r"), table("dbo_be11_reporter") dsn("be11_2006_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2006 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2007 ;

odbc load if (period_year==2007 & version=="r"), table("dbo_be11_reporter") dsn("be11_2007_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2007 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2008 ;

odbc load if (period_year==2008 & version=="r"), table("dbo_be11_reporter") dsn("be11_2008_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2008 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2009 ;

odbc load if (period_year==2009 & version=="r"), table("dbo_be10_rep_misc") dsn("be11_2009_64bit") ;
destring nbv_ppe_cy, replace ;
keep us_id nbv_ppe_cy ;
ren nbv_ppe_cy nbv_ppe_cy_bm ;
gen year=2009 ;
order us_id year nbv_ppe_cy_bm;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2010 ;

odbc load if (period_year==2010 & version=="r"), table("dbo_be11_reporter") dsn("be11_2010_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2010 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2011 ;
odbc load if (period_year==2011 & version=="r"), table("dbo_be11_reporter") dsn("be11_2011_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2011 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2012 ;
odbc load if (period_year==2012 & version=="r"), table("dbo_be11_reporter") dsn("be11_2012_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2012 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2013 ;
odbc load if (period_year==2013 & version=="r"), table("dbo_be11_reporter") dsn("be11_2013_64bit") ;

gen str12 us_id2=us_id+"      " ;
drop us_id ;
ren us_id2 us_id ;
sort us_id ;

gen nbv_ppe_cy_bm=. ;
gen year=2013 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2014 ;

odbc load if (period_year==2014 & version=="r"), table("dbo_be10_rep_misc") dsn("be11_2014_64bit") ;
destring nbv_ppe_cy, replace ;
keep us_id nbv_ppe_cy ;
ren nbv_ppe_cy nbv_ppe_cy_bm ;
gen year=2014 ;
order us_id year nbv_ppe_cy_bm;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2015 ;
odbc load if (period_year==2015 & version=="r"), table("dbo_be11_reporter") dsn("be11_2015_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2015 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2016 ;
odbc load if (period_year==2016 & version=="r"), table("dbo_be11_reporter") dsn("be11_2016_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2016 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;
clear ;

* 2017 ;
odbc load if (period_year==2017 & version=="r"), table("dbo_be11_reporter") dsn("be11_2017_64bit") ;
gen nbv_ppe_cy_bm=. ;
gen year=2017 ;
keep us_id year nbv_ppe_cy_bm ;
order us_id year nbv_ppe_cy_bm ;
append using masterdata ;
save masterdata, replace ;

* Interpolate and extrapolate missing values ;
sort us_id year ;
gen logbm=log(nbv_ppe_cy_bm) ;
by us_id: mipolate logbm year, generate(nbv_ppe_cy_mipolate) epolate ;
replace nbv_ppe_cy_mipolate = exp(nbv_ppe_cy_mipolate) ;
save interpolate_rep_netppe, replace ;

clear ;
log close ;



