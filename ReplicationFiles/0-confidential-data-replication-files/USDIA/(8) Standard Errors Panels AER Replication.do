/* Program date:  November 4, 2021 */
/* Program name:  '(8) Standard Errors Panels AER Replication.sas' */
/* Program description:  This program randomly generates 100 panels with an 
equal number of observations to our original panel. */
/* The dataset used in this program is generated in SAS at
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(5) Working Data Sets 1982-2016 AER Replication.sas' */
/* The CSV datasets from this program are used in SAS at
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(9) Standard Errors AER Replication.sas' */

// Clear the output window
cls
clear all

// Set this to directory with the data
cd "L:\Dylan\Paper - Productivity\AER Revision\AER Replication"

// Import the data
use if ForeignID != "0000" using "L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Data Sets\usdiafoir82to16.dta"

keep BE11ID ForeignID Year MajForOwned Haven Compensation NetPPE RDstock Profits

// Set the seed so that this can be reproduced.
set seed 1776 

// Number of data samples to make. Start small to get a feel for how long each 
// sample takes. 
local B 100

// For each loop, we draw a sample with replacement stratified by year.
// This means that we should have the same number of observations in each year
// as in the original data.

forvalues i = 1/`B' {
	preserve
	bsample, strata(Year)
	export delimited "CSV Panels/panel_`i'.csv", replace
	restore
} 
