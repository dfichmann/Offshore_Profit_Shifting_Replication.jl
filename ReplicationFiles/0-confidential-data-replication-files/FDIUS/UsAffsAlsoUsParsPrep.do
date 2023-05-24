* Jen Bruner
* Modified by Dylan Rassier
* November 18, 2021
* Generate a bridge file for years of interest of BE15 reporters that are also BE11, i.e., affiliates that are also US parentss

cd "\\Serv01cl\IID2\RESEARCH\PROJECTS\Jensen_mann\cross_border_svcs\Dylan\Paper - Productivity\AER Revision\AER Replication\FDIUS"

*2008
odbc load, clear table("be11_reporter") connectionstring("Driver={SQL Server};Server={SQLPROD2017};Trusted_Connection={Yes};Database={ii_data_review};UID=oddgr1")
destring(*), replace
keep if period_year==2008 & version=="r"
tab be15_id

keep us_id be15_id period_year
ren us_id BE11Id
ren be15_id UsId
gen IsUSPar=1
ren period_year year
keep UsId year BE11Id IsUSPar
egen tag=tag(UsId year)
keep if tag==1
drop tag

sort UsId year
save UsPars2008.dta, replace

* 2012
odbc load, clear table("be11_reporter") connectionstring("Driver={SQL Server};Server={SQLPROD2017};Trusted_Connection={Yes};Database={ii_data_review};UID=oddgr1")
destring(*), replace
keep if period_year==2012 & version=="r"
tab be15_id

keep us_id be15_id period_year
ren us_id BE11Id
ren be15_id UsId
gen IsUSPar=1
ren period_year year
keep UsId year BE11Id IsUSPar

egen tag=tag(UsId year)
keep if tag==1
drop tag

sort UsId year
save UsPars2012.dta, replace

*2015
odbc load, clear table("be11_reporter") connectionstring("Driver={SQL Server};Server={SQLPROD2017};Trusted_Connection={Yes};Database={ii_data_review};UID=oddgr1")
destring(*), replace
keep if period_year==2015 & version=="p"
tab be15_id

keep us_id be15_id period_year
ren us_id BE11Id
ren be15_id UsId
gen IsUSPar=1
ren period_year year
keep UsId year BE11Id IsUSPar

egen tag=tag(UsId year)
keep if tag==1
drop tag

sort UsId year
save UsPars2015.dta, replace




