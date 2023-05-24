/* Program date:  November 4, 2021 */
/* Program name:  '(6) Formulary Apportionment 1982-2016 AER Replication.sas' */
/* Program description:  This program generates aggregates of formulary adjustments to 
direct investment earnings proxies between U.S. reporters and foreign affiliates for 1982-2016. */
/* The dataset used in this program is generated in
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(5) Working Data Set 1982-1992 AER Replication.sas' */

libname aer 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Data Sets';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Aggregate by year the formulary adjustments (net direct investment) */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = aer.usdiafoapportion82to16;
by year;
proc means noprint sum data = aer.usdiafoapportion82to16;
by year;
where majforowned = 0 and foreignid ne '0000';
var adjcomp adjsale adjrdstk adjppe adjwt3;
output	out = adjnet (drop = _type_ _freq_)
		sum = adjcomp adjsale adjrdstk adjppe adjwt3;
data adjnetscale;
	set adjnet;
		adjcomps = (adjcomp / 1000000); 
		adjsales = (adjsale / 1000000); 
		adjrdstks = (adjrdstk / 1000000); 
		adjppes = (adjppe / 1000000); 
		adjwt3s = (adjwt3 / 1000000);
	drop adjcomp adjsale adjrdstk adjppe adjwt3;
proc export data = adjnetscale
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputAdjNet.xlsx';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Aggregate by country the formulary adjustments for 2016 (net direct investment) */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = aer.usdiafoapportion82to16;
by countryname;
proc means noprint sum data = aer.usdiafoapportion82to16;
by countryname;
where majforowned = 0 and foreignid ne '0000' and year = 2016;
var adjcomp adjsale adjrdstk adjppe adjwt3 nip;
output	out = adjctrynet (drop = _type_ _freq_)
		sum = adjcomp adjsale adjrdstk adjppe adjwt3 nip;
data adjctryscale;
	set adjctrynet;
		adjcomps = (adjcomp / 1000000); 
		adjsales = (adjsale / 1000000); 
		adjrdstks = (adjrdstk / 1000000); 
		adjppes = (adjppe / 1000000); 
		adjwt3s = (adjwt3 / 1000000);
		nips = (nip / 1000000);
	drop adjcomp adjsale adjrdstk adjppe adjwt3 nip;
proc export data = adjctryscale
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputAdjNetCountry2016.xlsx';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Aggregate by country the formulary adjustments for 2015 (net direct investment) */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = aer.usdiafoapportion82to16;
by countryname;
proc means noprint sum data = aer.usdiafoapportion82to16;
by countryname;
where majforowned = 0 and foreignid ne '0000' and year = 2015;
var adjcomp adjsale adjrdstk adjppe adjwt3 nip;
output	out = adjctrynet (drop = _type_ _freq_)
		sum = adjcomp adjsale adjrdstk adjppe adjwt3 nip;
data adjctryscale;
	set adjctrynet;
		adjcomps = (adjcomp / 1000000); 
		adjsales = (adjsale / 1000000); 
		adjrdstks = (adjrdstk / 1000000); 
		adjppes = (adjppe / 1000000); 
		adjwt3s = (adjwt3 / 1000000);
		nips = (nip / 1000000);
	drop adjcomp adjsale adjrdstk adjppe adjwt3 nip;
proc export data = adjctryscale
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputAdjNetCountry2015.xlsx';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Aggregate by year and BEA annual industry accounts industry the formulary adjustments (net direct investment) */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = aer.usdiafoapportion82to16;
by year iedindpar;
proc means noprint sum data = aer.usdiafoapportion82to16;
by year iedindpar;
where majforowned = 0 and foreignid ne '0000';
var adjcomp adjsale adjrdstk adjppe adjwt3;
output	out = adjindnet (drop = _type_ _freq_)
		sum = adjcomp adjsale adjrdstk adjppe adjwt3;
data adjindscale;
	set adjindnet;
		adjcomps = (adjcomp / 1000000); 
		adjsales = (adjsale / 1000000); 
		adjrdstks = (adjrdstk / 1000000); 
		adjppes = (adjppe / 1000000); 
		adjwt3s = (adjwt3 / 1000000);
	drop adjcomp adjsale adjrdstk adjppe adjwt3;
proc export data = adjindscale
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputAdjNetIndustry.xlsx';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Aggregate by year and R&D intensive firm the formulary adjustments (net direct investment) */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = aer.usdiafoapportion82to16;
by year rdfirm;
proc means noprint sum data = aer.usdiafoapportion82to16;
by year rdfirm;
where majforowned = 0 and foreignid ne '0000';
var adjcomp adjsale adjrdstk adjppe adjwt3;
output	out = adjrdnet (drop = _type_ _freq_)
		sum = adjcomp adjsale adjrdstk adjppe adjwt3;
data adjrdscale;
	set adjrdnet;
		adjcomps = (adjcomp / 1000000); 
		adjsales = (adjsale / 1000000); 
		adjrdstks = (adjrdstk / 1000000); 
		adjppes = (adjppe / 1000000); 
		adjwt3s = (adjwt3 / 1000000);
	drop adjcomp adjsale adjrdstk adjppe adjwt3;
proc sort data = adjrdscale;
	by rdfirm year;
proc export data = adjrdscale
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputAdjNetRD.xlsx';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Aggregate by year and IT intensive using firm the formulary adjustments (net direct investment) */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = aer.usdiafoapportion82to16;
by year itufirm;
proc means noprint sum data = aer.usdiafoapportion82to16;
by year itufirm;
where majforowned = 0 and foreignid ne '0000';
var adjcomp adjsale adjrdstk adjppe adjwt3;
output	out = adjitunet (drop = _type_ _freq_)
		sum = adjcomp adjsale adjrdstk adjppe adjwt3;
data adjituscale;
	set adjitunet;
		adjcomps = (adjcomp / 1000000); 
		adjsales = (adjsale / 1000000); 
		adjrdstks = (adjrdstk / 1000000); 
		adjppes = (adjppe / 1000000); 
		adjwt3s = (adjwt3 / 1000000);
	drop adjcomp adjsale adjrdstk adjppe adjwt3;
proc sort data = adjituscale;
	by itufirm year;
proc export data = adjituscale
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputAdjNetITU.xlsx';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Aggregate by year and IT intensive producing firm the formulary adjustments (net direct investment) */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = aer.usdiafoapportion82to16;
by year itpfirm;
proc means noprint sum data = aer.usdiafoapportion82to16;
by year itpfirm;
where majforowned = 0 and foreignid ne '0000';
var adjcomp adjsale adjrdstk adjppe adjwt3;
output	out = adjitpnet (drop = _type_ _freq_)
		sum = adjcomp adjsale adjrdstk adjppe adjwt3;
data adjitpscale;
	set adjitpnet;
		adjcomps = (adjcomp / 1000000); 
		adjsales = (adjsale / 1000000); 
		adjrdstks = (adjrdstk / 1000000); 
		adjppes = (adjppe / 1000000); 
		adjwt3s = (adjwt3 / 1000000);
	drop adjcomp adjsale adjrdstk adjppe adjwt3;
proc sort data = adjitpscale;
	by itpfirm year;
proc export data = adjitpscale
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputAdjNetITP.xlsx';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Aggregate by year and tax haven country the formulary adjustments (net direct investment) */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = aer.usdiafoapportion82to16;
by year haven;
proc means noprint sum data = aer.usdiafoapportion82to16;
by year haven;
where majforowned = 0 and foreignid ne '0000';
var adjcomp adjsale adjrdstk adjppe adjwt3;
output	out = adjhvnnet (drop = _type_ _freq_)
		sum = adjcomp adjsale adjrdstk adjppe adjwt3;
data adjhvnscale;
	set adjhvnnet;
		adjcomps = (adjcomp / 1000000); 
		adjsales = (adjsale / 1000000); 
		adjrdstks = (adjrdstk / 1000000); 
		adjppes = (adjppe / 1000000); 
		adjwt3s = (adjwt3 / 1000000);
	drop adjcomp adjsale adjrdstk adjppe adjwt3;
proc sort data = adjhvnscale;
	by haven year;
proc export data = adjhvnscale
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputAdjNetHaven.xlsx';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Aggregate by year the formulary adjustments for directly held shares */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = aer.usdiafoapportion82to16;
by year;
proc means noprint sum data = aer.usdiafoapportion82to16;
by year;
where irindicator = 1 and majforowned = 0 and foreignid ne '0000';
var adjcomp adjsale adjrdstk adjppe adjwt3;
output	out = direct (drop = _type_ _freq_)
		sum = adjcomp adjsale adjrdstk adjppe adjwt3;
data directscale;
	set direct;
		adjcomps = (adjcomp / 1000000); 
		adjsales = (adjsale / 1000000); 
		adjrdstks = (adjrdstk / 1000000); 
		adjppes = (adjppe / 1000000); 
		adjwt3s = (adjwt3 / 1000000);
	drop adjcomp adjsale adjrdstk adjppe adjwt3;
proc export data = directscale
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputAdjDirect.xlsx';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Aggregate by year the formulary adjustments for indirectly held shares */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = aer.usdiafoapportion82to16;
by year;
proc means noprint sum data = aer.usdiafoapportion82to16;
by year;
where irindicator = 0 and majforowned = 0 and foreignid ne '0000';
var adjcomp adjsale adjrdstk adjppe adjwt3;
output	out = indirect (drop = _type_ _freq_)
		sum = adjcomp adjsale adjrdstk adjppe adjwt3;
data indirectscale;
	set indirect;
		adjcomps = (adjcomp / 1000000); 
		adjsales = (adjsale / 1000000); 
		adjrdstks = (adjrdstk / 1000000); 
		adjppes = (adjppe / 1000000); 
		adjwt3s = (adjwt3 / 1000000);
	drop adjcomp adjsale adjrdstk adjppe adjwt3;
proc export data = indirectscale
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputAdjIndirect.xlsx';
run;
/****************************************************************************************/
/****************************************************************************************/
