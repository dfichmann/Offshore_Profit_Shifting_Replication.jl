Overview
--------

The code in this replication package uses the data files contained in `0-confidential-data-replication-files` and `1-raw-data` and the code in `2-code ` to create the 51 figures and 8 of the 10 tables in Guvenen et al. (2022). The exceptions are 

1. Table 3, which is created from the confidential data. The code and the table output are in `0-confidential-data-replication-files`. See the file "README confidential data" in that file for more details.
2. Table C3 does not contain any data or computational results. It is a description of the concordance. 

This README describes the publicly available data and code that creates the figures and tables. The "README confidential data" file describes the confidential data and the code that processes it. This file and its associated files are located in the `0-confidential-replication-files` folder. 

The replicator should expect this code to run in about 10 minutes. 

Data Availability and Provenance Statements
----------------------------
All publicly available data files are stored in the folder `1-raw-data`. When the file was provided with a unique name, the file name was kept. When files were provided with a generic descriptor (i.e., "download.csv") they have been renamed. A copy of the data is provided as part of this archive to guard against revisions to the data, making the paper irreproducible. The data are in the public domain.

* The files in the `author-created-concordances` folder were created by the authors. The files link BEA industries with NAICS codes and with author created industry groups: R&D, IT-using, and IT-producing.

* The files in `ne_110m_admin_0_countries_lakes` are shape files. They can be download [here](https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries_lakes.zip).

* `WTISPLC.xls` (Oil prices) From FRB St. Louis FRED database. Download from [here](https://fred.stlouisfed.org/series/WTISPLC). 

* Data from the Bureau of Economic Analysis. 
   * `Iip_T2.1.xls` (International Investment Position, Table 2.1) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=62&step=6&isuri=1&tablelist=148&product=5).
   *  `Ita_T1.1.xls` (International Transaction Accounts, Table 1.1) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=62&step=6&isuri=1&tablelist=1&product=1).
   *  `Ita_T4.2.xls` (International Transaction Accounts, Table 4.2) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=62&step=6&isuri=1&tablelist=57&product=1).
   *  `usdia_country.xls` (USDIA position by country) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=2&step=10&isuri=1&step1prompt1=1&step2prompt3=1&step1prompt2=1&step8prompt10a=1&step4prompt5=10&step3prompt4=30&step5prompt6=1,2&step7prompt8=55,52,49,48,43,42,41,40,39,38,37,36,35,34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13&step8prompt9a=2).
   * `usdiainc_country.xls` (USDIA DI income) [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=2&step=10&isuri=1&step1prompt1=1&step2prompt3=1&step1prompt2=1&step8prompt10a=1&step4prompt5=10&step3prompt4=27&step5prompt6=1,2&step7prompt8=55,52,49,48,43,42,41,40,39,38,37,36,35,34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13&step8prompt9a=2).
   * `go_by_industry-82-97.csv` (Gross output by industry) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=147&step=51&isuri=1&table_list=15).
   * `go_by_industry-97-16.csv` (Gross output by industry) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=150&step=3&isuri=1&table_list=15&series=a&first_year=1997&columns=ii&scale=-9&last_year=2016&categories=gdpxind&thetable=&rows=22r).
   * `nipa-T6.5b.csv` (Employment by industry) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=19&step=3&isuri=1&nipa_table_list=195&categories=survey).
   * `price-by-industry-82-97.csv` (Price index by industry) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=147&step=51&isuri=1&startyear=1982&table_list=11&endyear=1&valuationtype=b&thetable=1&codelist=22r,gdpva,pvtva,11va,111cava,113ffva,21va,211va,212va,213va,22va,23va,31gva,33dgva,321va,327va,331va,332va,333va,334va,335va,3361mvva,3364otva,337va,339va,31ndva,311ftva,313ttva,315alva,322va,323va,324va,325va,326va,42va,44rtva,441va,445va,452va,4a0va,48twva,481va,482va,483va,484va,485va,486va,487osva,493va,51va,511va,512va,513va,514va,fireva,52va,521civa,523va,524va,525va,53va,531va,vahs,vaore,532rlva,profva,54va,5411va,5415va,5412opva,55va,56va,561va,562va,6va,61va,62va,621va,622hova,622va,623va,624va,7va,71va,711asva,713va,72va,721va,722va,81va,gva,gfva,gfgva,vagfgd,vagfgn,gfeva,gslva,gslgva,gsleva,adndadnd,pgoodva,pservva,ictva).
   * `price-by-industry-97-16.csv` (Price index by industry) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=150&step=3&isuri=1&table_list=11&series=a&first_year=1997&columns=ii&scale=-99&last_year=2016&categories=gdpxind&thetable=&rows=22r).
   * `usdia-comp-2012.csv` (USDIA employee compensation by country) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=2&step=10&isuri=1&step1prompt1=1&step2prompt3=13&step1prompt2=2&step8prompt10a=1&step4prompt5=4&step3prompt4=7&step5prompt6=1,2&step7prompt8=43&step8prompt9a=2).
   * `usdia-employees-2012.csv` (USDIA employment by country) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=2&step=10&isuri=1&step1prompt1=1&step2prompt3=13&step1prompt2=2&step8prompt10a=1&step4prompt5=10&step3prompt4=8&step5prompt6=1,2&step7prompt8=43&step8prompt9a=47).
   * `usdia-ppe-2012.csv` (USDIA ppe by country) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=2&step=10&isuri=1&step1prompt1=1&step2prompt3=13&step1prompt2=2&step8prompt10a=1&step4prompt5=10&step3prompt4=54&step5prompt6=1,2&step7prompt8=43&step8prompt9a=71).
   * `usdia-total-assets-2012.csv` (USDIA total assets by country) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=2&step=10&isuri=1&step1prompt1=1&step2prompt3=13&step1prompt2=2&step8prompt10a=1&step4prompt5=10&step3prompt4=1&step5prompt6=1,2&step7prompt8=43&step8prompt9a=40).
   * `va-by-industry-82-97.csv` (Value added by industry) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=147&step=51&isuri=1&startyear=1982&table_list=1&endyear=1&valuationtype=b&thetable=1&codelist=22r,gdpva,pvtva,11va,111cava,113ffva,21va,211va,212va,213va,22va,23va,31gva,33dgva,321va,327va,331va,332va,333va,334va,335va,3361mvva,3364otva,337va,339va,31ndva,311ftva,313ttva,315alva,322va,323va,324va,325va,326va,42va,44rtva,441va,445va,452va,4a0va,48twva,481va,482va,483va,484va,485va,486va,487osva,493va,51va,511va,512va,513va,514va,fireva,52va,521civa,523va,524va,525va,53va,531va,vahs,vaore,532rlva,profva,54va,5411va,5415va,5412opva,55va,56va,561va,562va,6va,61va,62va,621va,622hova,622va,623va,624va,7va,71va,711asva,713va,72va,721va,722va,81va,gva,gfva,gfgva,vagfgd,vagfgn,gfeva,gslva,gslgva,gsleva,adndadnd,pgoodva,pservva,ictva).
   * `va-by-industry-97-16.csv` (Value added by industry) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=150&step=3&isuri=1&table_list=1&series=a&first_year=1997&columns=ii&scale=-9&last_year=2016&categories=gdpxind&thetable=&rows=22r).
   * `va-comp-by-industry-87-97.csv` (Components of value added by  industry) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=147&step=51&isuri=1&startyear=start&table_list=6&endyear=1&valuationtype=b&thetable=1&codelist=22r,gdpva,gdpcomp,gdptxpixsub,gdpgos,pvtva,pvtcomp,pvttxpixsub,pvtgos,11va,11comp,11txpixsub,11gos,111cava,111cacomp,111catxpixsub,111cagos,113ffva,113ffcomp,113fftxpixsub,113ffgos,21va,21comp,21txpixsub,21gos,211va,211comp,211txpixsub,211gos,212va,212comp,212txpixsub,212gos,213va,213comp,213txpixsub,213gos,22va,22comp,22txpixsub,22gos,23va,23comp,23txpixsub,23gos,31gva,31gcomp,31gtxpixsub,31ggos,33dgva,33dgcomp,33dgtxpixsub,33dggos,321va,321comp,321txpixsub,321gos,327va,327comp,327txpixsub,327gos,331va,331comp,331txpixsub,331gos,332va,332comp,332txpixsub,332gos,333va,333comp,333txpixsub,333gos,334va,334comp,334txpixsub,334gos,335va,335comp,335txpixsub,335gos,3361mvva,3361mvcomp,3361mvtxpixsub,3361mvgos,3364otva,3364otcomp,3364ottxpixsub,3364otgos,337va,337comp,337txpixsub,337gos,339va,339comp,339txpixsub,339gos,31ndva,31ndcomp,31ndtxpixsub,31ndgos,311ftva,311ftcomp,311fttxpixsub,311ftgos,313ttva,313ttcomp,313tttxpixsub,313ttgos,315alva,315alcomp,315altxpixsub,315algos,322va,322comp).
   * `va-comp-by-industry-97-16.csv` (Components of value added by  industry) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=150&step=3&isuri=1&table_list=6&series=q&first_year=1997&columns=ii&scale=-9&last_year=2016&categories=gdpxind&thetable=&rows=22r).
   * `va-total-affiliate.csv` (Total value added by affiliates) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=2&step=10&isuri=1&step1prompt1=1&step2prompt3=13&step1prompt2=2&step8prompt10a=94&step4prompt5=99&step3prompt4=6&step5prompt6=1,2&step7prompt8=40,41,42,43,48,49,52,55,56,58,60&step8prompt9a=45).
   * `va-total-parent.csv` (Total value added by parents) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=2&step=10&isuri=1&step1prompt1=1&step2prompt3=14&step1prompt2=2&step8prompt10a=94&step4prompt5=99&step3prompt4=6&step5prompt6=1,2&step7prompt8=40,41,42,43,48,49,52,55,56,58,60&step8prompt9a=45)
   * `NipaDataA.txt` (NIPA tables as a flat file) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=19&step=4&isuri=1&nipa_table_list=1&categories=flatfiles). Scroll down to the entry for "Flat file containing all annual data".
   * `SeriesRegister.txt` (List of NIPA series and associated table and line numbers) Download from [here](https://apps.bea.gov/iTable/iTable.cfm?reqid=19&step=4&isuri=1&nipa_table_list=1&categories=flatfiles). Scroll down to the entry for "Series Register."
   * `BEA_depreciation_rates.pdf` (Depreciation rates) Download [here](https://apps.bea.gov/national/pdf/BEA_depreciation_rates.pdf).

* Data from Bureau of Labor Statistics
   * `bls-PRS84006033.xlsx` (Business sector hours worked) Download from [here](https://data.bls.gov/PDQWeb/pr). Choose "Business Sector", "Hours Worked", and tick the box for "Index, base year = 100".
   * `us_total_hrs_emp.xls` (Employment by sector) Download from [here](https://www.bls.gov/lpc/). Scroll down to "LPC tables and charts" and then find the entry for "Total U.S. Economy - all worker - month day, year" and download the Excel file. This replication uses the file dated November 4, 2021. 
   * `ip.data.1.AllData.text` (Industry productivity database) Download from [here](https://download.bls.gov/pub/time.series/pr/).


### Statement about Rights

- [X] I certify that the author(s) of the manuscript have legitimate access to and permission to use the data used in this manuscript. 


### Summary of Availability

- [ ] All data **are** publicly available.
- [X] Some data **cannot be made** publicly available.
- [ ] **No data can be made** publicly available.

Please see "README confidential data" in the folder `0-confidential-data-replication-files` for details about the confidential data from the Bureau of Economic Analysis.

Computational requirements
---------------------------

### Software Requirements
This code is written in jupyter notebooks using python. The easiest way to install all the needed software, except for `geopandas`, is to install an anaconda distribution from [here](https://www.anaconda.com/products/individual). You can then install geopandas from the anaconda command prompt as `conda install geopandas`.

* Python 3.8.8
  - `notebook` 6.3.0
  - `pandas` 1.2.4
  - `numpy` 1.20.1
  - `matplotlib` 3.3.4
  - `seaborn` 0.11.1
  - `geopandas` 0.10.2
  - `pillow` 8.2.0
  - `shapely` 1.8.0
  - `descartes` 1.1.0
  - `xlrd` 2.0.1
  - the file "`requirements.txt`" lists these dependencies, please run "`pip install -r requirements.txt`" as the first step. See [https://pip.readthedocs.io/en/1.1/requirements.html](https://pip.readthedocs.io/en/1.1/requirements.html) for further instructions on using the "`requirements.txt`" file.
* SAS 9.4
* Stata 16.1



### Memory and Runtime Requirements

As of 2022, there are no significant memory or computational power requirements. 

#### Summary

Approximate time needed to reproduce the analyses on a standard 2022 desktop machine is less than 10 minutes. 

#### Details

The code was last run on a **4-core Intel i7-700 desktop with 16 GB of RAM, running Windows 10 Pro**. 


Description of programs/code
----------------------------

**Confidential data programming:** This description takes as given the output files derived from the confidential data sources. These files are located in the `0-confidential-data-replication-files` folder. **See the README in that folder for the details of how those files were created and how to access the confidential data through the Bureau of Economic Analysis.** 

**Public data programming:** The files in the `2-code` folder are needed for replication. 

* `1-process-public-aggregate.ipynb` cleans, reshapes, and performs some calculations on the data from files located in `1-raw-data`. These are data at the national level. This code produces the file `aggregate.csv`, located in the `3-intermediate-files` folder. 
* `1-process-public-industry.ipynb` cleans, reshapes, and performs some calculations on the data from files located in `1-raw-data`. These are data at the industry level. This code produces the file `industry.csv`, located in the `3-intermediate-files` folder.
* `2-analysis-I.ipynb` uses `industry.csv`, `aggregate.csv`, and output files from the `0-confidential-data-replication-files` folder to produce the tables, figures and numbers in the text of the paper. The tables and figures are saved into the `4-figures` and `4-tables` folders. An intermediate file with numbers used in the text is saved in `3-intermediate-files.` to be used later.  
* `2-analysis-II.ipynb` uses `industry.csv`, `aggregate.csv`, and output files from the `0-confidential-data-replication-files` folder to produce the labor share by industry figures for the paper and numbers used in the text of the paper. The figures are saved into the `4-figures` folder. An intermediate file with numbers used in the text is saved in `3-intermediate-files.` to be used later. 
* `2-analysis-III.ipynb` uses `industry.csv`, `aggregate.csv`, and output files from the `0-confidential-data-replication-files` folder to produce tables for the paper and numbers used in the text of the paper. The tables are saved into the `4-tables` folder. An intermediate file with numbers used in the text is saved in `3-intermediate-files.` to be used later. 
* `2-analysis-IV.ipynb` uses output files from the `0-confidential-data-replication-files` folder and the shape files to produce the map figure. It is the only file that requires the geopandas package. 
* `3-numbers-in-text.ipynb` uses the intermediate files to produce `numbers.csv` which is saved into the directory `4-numbers-in-text`. 


Instructions to Replicators
---------------------------

If you have downloaded this repository, then replicating the code requires: 

1. Open `1-process-public-aggregate.ipynb` and "run all cells" (run time < 1 min)
2. Open `1-process-public-industry.ipynb` and "run all cells" (run time < 1 min)
3. Open `2-analysis-I.ipynb` and "run all cells" (run time < 1 min)
4. Open `2-analysis-II.ipynb` and "run all cells" (run time < 1 min)
5. Open `2-analysis-III.ipynb` and "run all cells" (run time < 1 min)
6. Open `2-analysis-IV.ipynb` and "run all cells" (run time < 1 min)
7. Open `3-numbers-in-text.ipynb` and "run all cells" (run time < 1 min)

Note that files that start with '1' must be run before files that begin with '2'. The file that begins with '3' should be run last. 


List of tables and programs
---------------------------

The provided code reproduces:

- [ ] All numbers provided in text in the paper
- [ ] All tables and figures in the paper
- [X] Selected tables and figures in the paper, as explained and justified below.


| Figure/Table #    | Program                  | Section     | Output file                      | Note                            |
|-------------------|--------------------------|-------------|----------------------------------|---------------------------------|
| Table 1           | 2-analysis-III.ipynb                        | Table 1     | table1.tex                       ||
| Table 2           | 2-analysis-III.ipynb                        | Table 2     | table2.tex                       ||
| Table 3           | (7) Hines and Rice 1982 AER Replication.sas |             | OutputHinesRice.pdf |Requires confidential data|
| Table 4           | 2-analysis-III.ipynb                        | Table 4     | table4.tex                       ||
| Table 5           | 2-analysis-I.ipynb                          | Table 5     | table5.tex                       ||
| Table 6           | 2-analysis-I.ipynb                          | Table 6     | table6.tex                       ||
| Table 7           | 2-analysis-III.ipynb                        | Table 7     | table7.tex                       ||
| Table C1          | 2-analysis-III.ipynb                        | Table C1    | tablec1.tex                      ||
| Table C2          | 2-analysis-III.ipynb                        | Table C2    | tablec2.tex                      ||
| Table C3          | N/A                                         |             |                                  |Does not contain data or compuational results.|
| Figure 1          | 2-analysis-I.ipynb                          | Figure 1A-B  |agg_adj_share.pdf, agg_adj_l.pdf  ||
| Figure 2          | 2-analysis-I.ipynb                          | Figure 2A-B  |agg_adj_weights.pdf, robust.pdf  ||
| Figure 3          | 2-analysis-I.ipynb                          | Figure 3A-B  |oil_prices.pdf, adjustments_nopetro.pdf  ||
| Figure 4          | 2-analysis-IV.ipynb                         | Figure 4     |map.pdf  ||
| Figure 5          | 2-analysis-I.ipynb                          | Figure 5A-B  |trade_balance.pdf, balances.pdf  ||
| Figure 6          | 2-analysis-I.ipynb                          | Figure 6A-B  |total_returns.pdf, returns_havens_nhavens.pdf  ||
| Figure 7          | 2-analysis-I.ipynb                          | Figure 7A-B  |prod_all.pdf, prod_diff.pdf  ||
| Figure 8          | 2-analysis-I.ipynb                          | Figure 8A-B  |adj_rd.pdf, prod_rd_diff.pdf  ||
| Figure 9          | 2-analysis-I.ipynb                          | Figure 9     |prod_rd_long.pdf  ||
| Figure 10A        | 2-analysis-I.ipynb                          | Figure 10A   |gross_labor_share.pdf  ||
| Figure 10B        | 2-analysis-II.ipynb                         | Figure 10B   |two_industries.pdf  ||
| Figure 11         | 2-analysis-I.ipynb                          | Figure 11A-B |fdius12.pdf, fdius15.pdf  ||
| Figure C1         | 2-analysis-I.ipynb                          | Figure C1A-C |rd_shares_apx.pdf, itu_shares_apx.pdf, itp_shares_apx.pdf ||
| Figure C2         | 2-analysis-I.ipynb                          | Figure C2A-D |adj_itp.pdf, prod_itp.pdf, adj_itu.pdf, prod_itu.pdf  ||
| Figure C          | 2-analysis-I.ipynb                          | Figure C3A-D  |agg_prod_roll.pdf, prod_rd_roll.pdf, agg_prod_ann.pdf, prod_rd_ann.pdf  ||
|Figures C4-6       | 2-analysis-II.ipynb                         | Figure C4-6  | 11ls.pdf, 21ls.pdf, 22ls.pdf, 23ls.pdf, 31ls.pdf, 32ls.pdf, 33ls.pdf, 42ls.pdf, 44ls.pdf, 48ls.pdf, 51ls.pdf, 52ls.pdf, 53ls.pdf, 54ls.pdf, 55ls.pdf, 56ls.pdf, 60ls.pdf, 70ls.pdf, 80ls.pdf,|| 

### Numbers in the paper text 
Every number referred to in the text is in the file `4-numbers-in-text/numbers.csv`.  The position description is of the form 'S.n' where *S* is the section in which the number appears and *n* is the order in which it appears in the section. 

###Tables not produced in this package 
Only table 3 is not produced by the code in directory `2-code`. It requires the confidential data. See the readme in `0-confidential-data-replication-files` for more details. 

## References

Guvenen, Fatih, Raymond J. Mataloni Jr., Dylan G. Rassier, and Kim J. Ruhl (2022): "Offshore profit shifting and aggregate measurement: Balance of payments, foreign investment, productivity, and the labor share."  