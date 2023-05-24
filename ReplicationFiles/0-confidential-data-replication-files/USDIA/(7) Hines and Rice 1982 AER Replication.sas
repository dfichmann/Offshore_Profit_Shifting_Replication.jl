/* Program date:  November 4, 2021 */
/* Program name:  '(7) Hines and Rice 1982 AER Replication.sas' */
/* Program description:  This program includes tax rates from Hines and Rice (1994) and an 
adjusted earnings proxy calculated using the formulary adjustment to generate elasticities 
for 1982:  aer.elasticities. */
/* The dataset used in this program is generated in
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(5) Working Data Sets 1982-2016 AER Replication.sas' */

libname aer 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Data Sets';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Generate a data set for elasticities based on Hines and Rice (1994) */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = aer.usdiafoapportion82to16;
by countryname;
proc means noprint sum data = aer.usdiafoapportion82to16;
by countryname;
where majforowned = 0 and foreignid ne '0000' and year = 1982;
var profits nip ni adjwt3 compensation netppe;
output	out = adjustment (drop = _type_ _freq_)
		sum = profits nip ni adjwt3 compensation ppe;
data aer.elasticities;
	set adjustment;
* Generate a variable for tax rates from Hines and Rice (1994) appendix 4;
	if countryname = 'Hong Kong' then rate = 0.12;
	if countryname = 'Ireland' then rate = 0.04;
	if countryname = 'Lebanon' then rate = 0.22;
	if countryname = 'Liberia' then rate = 0.21;
	if countryname = 'Panama' then rate = 0.10;
	if countryname = 'Singapore' then rate = 0.21;
	if countryname = 'Switzerland' then rate = 0.17;
	if countryname = 'Antigua and Barbuda' then rate = 0.03;
	if countryname = 'Bahamas' then rate = 0.00;
	if countryname = 'Bahrain' then rate = 0.13;
	if countryname = 'Barbados' then rate = 0.29;
	if countryname = 'Belize' then rate = 0.00;
	if countryname = 'Bermuda' then rate = 0.00;
	if countryname = 'UK Islands - Caribbean' then rate = 0.01;
	if countryname = 'Cyprus' then rate = 0.14;
	if countryname = 'Liechtenstein' then rate = 0.02;
	if countryname = 'Luxembourg' then rate = 0.18;
	if countryname = 'Malta' then rate = 0.15;
	if countryname = 'Netherlands Antilles' then rate = 0.03;
	if countryname = 'Vanuatu' then rate = 0.00;
	if countryname = 'Austria' then rate = 0.41;
	if countryname = 'Australia' then rate = 0.51;
	if countryname = 'Belgium' then rate = 0.45;
	if countryname = 'Canada' then rate = 0.52;
	if countryname = 'Denmark' then rate = 0.40;
	if countryname = 'Finland' then rate = 0.49;
	if countryname = 'France' then rate = 0.50;
	if countryname = 'Germany' then rate = 0.48;
	if countryname = 'Greece' then rate = 0.43;
	if countryname = 'Italy' then rate = 0.39;
	if countryname = 'Japan' then rate = 0.52;
	if countryname = 'Netherlands' then rate = 0.40;
	if countryname = 'New Zealand' then rate = 0.45;
	if countryname = 'Spain' then rate = 0.33;
	if countryname = 'Sweden' then rate = 0.60;
	if countryname = 'South Africa' then rate = 0.46;
	if countryname = 'UK' then rate = 0.52;
	if countryname = 'Argentina' then rate = 0.21;
	if countryname = 'Bangladesh' then rate = 0.25;
	if countryname = 'Bolivia' then rate = 0.30;
	if countryname = 'Botswana' then rate = 0.35;
	if countryname = 'Brazil' then rate = 0.35;
	if countryname = 'Chile' then rate = 0.49;
	if countryname = 'Columbia' then rate = 0.40;
	if countryname = 'Costa Rica' then rate = 0.50;
	if countryname = 'Dominican Republic' then rate = 0.41;
	if countryname = 'Ecuador' then rate = 0.22;
	if countryname = 'El Salvador' then rate = 0.30;
	if countryname = 'Fiji' then rate = 0.38;
	if countryname = 'French Islands - Indian O' then rate = 0.09;
	if countryname = 'French Islands - Pacific' then rate = 0.25;
	if countryname = 'Guatemala' then rate = 0.58;
	if countryname = 'Guyana' then rate = 0.50;
	if countryname = 'Haiti' then rate = 0.45;
	if countryname = 'Honduras' then rate = 0.46;
	if countryname = 'India' then rate = 0.52;
	if countryname = 'Israel' then rate = 0.32;
	if countryname = 'Jamaica' then rate = 0.50;
	if countryname = 'Malawi' then rate = 0.50;
	if countryname = 'Malaysia' then rate = 0.37;
	if countryname = 'Mexico' then rate = 0.42;
	if countryname = 'Morocco' then rate = 0.53;
	if countryname = 'Namibia' then rate = 0.46;
	if countryname = 'Nicaragua' then rate = 0.44;
	if countryname = 'Pakistan' then rate = 0.53;
	if countryname = 'Papua New Guinea' then rate = 0.48;
	if countryname = 'Paraguay' then rate = 0.30;
	if countryname = 'Peru' then rate = 0.35;
	if countryname = 'Philippines' then rate = 0.33;
	if countryname = 'Portugal' then rate = 0.40;
	if countryname = 'South Korea' then rate = 0.24;
	if countryname = 'Sri Lanka' then rate = 0.40;
	if countryname = 'Taiwan' then rate = 0.19;
	if countryname = 'Thailand' then rate = 0.44;
	if countryname = 'Tonga' then rate = 0.43;
	if countryname = 'Turkey' then rate = 0.40;
	if countryname = 'Uruguay' then rate = 0.25;
	if countryname = 'Venezuela' then rate = 0.39;
	if countryname = 'Zambia' then rate = 0.45;
	if countryname = 'Zimbabwe' then rate = 0.52;
* Eliminate records with no tax rate;
	if rate = . then delete;
* Generate dependent variables;
	* Net income with no net interest adjustment;
	if ni gt 0 then lnni = log(ni);
	* Net income with net interest adjustment;
	ninip = sum(ni,nip);
	if sum(ni,nip) gt 0 then lnninip = log(sum(ni,nip));
	* Earnings proxy with no net interest adjustment;
	if profits gt 0 then lnprofits = log(profits);
	if sum(profits,adjwt3) gt 0 then lnadjprofits = log(sum(profits,adjwt3));
	adjprofits = lnprofits - lnadjprofits;
* Generate regressors;
	if compensation gt 0 then lncomp = log(compensation);
	if ppe gt 0 then lnppe = log(ppe);
run;

/* Regressions */
ods pdf file = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputHinesRice.pdf' style = minimal;
proc reg data = aer.elasticities outest = hinesrice;
	where lnprofits ne . and lnadjprofits ne . and lnninip ne . and adjprofits ne . and lncomp ne . and lnppe ne .;
	m1: model lnninip = rate lncomp lnppe; * Best attempt to replicate Hines and Rice (1994) Table II with net interest paid;
	m2: model adjprofits = rate; * GMRR (2017) ln(profits) - ln(profits - adjustment) with net interest paid;
	m3: model lnadjprofits = rate lncomp lnppe; * GMRR (2017) adjusted earnings proxy with net interest paid;
run;
quit;
ods pdf close;
/****************************************************************************************/
/****************************************************************************************/
