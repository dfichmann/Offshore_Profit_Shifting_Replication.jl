/* Program date:  November 4, 2021 */
/* Program name:  '(5) Working Data Sets 1982-2016 AER Replication.sas' */
/* Program description:  This program generates two datasets.  
The first dataset includes financial and operating data on U.S. reporters and foreign 
affiliates plus a direct investment earnings proxy for U.S. reporters and foreign affiliates 
for 1982-2016:  aer.usdiafoir82to16. 
The second dataset includes an adjustment to the earnings proxy for U.S. reporters and foreign 
affiliates from the first dataset based on formulary apportionment for 1982-2016:  aer.usdiaapportion82to16. */
/* The datasets used in this program are generated in
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(1) USDIA Financial and Operating Data 1982-1992 AER Replication.sas'
and
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(2) USDIA Financial and Operating Data 1993-2016 AER Replication.sas'
and
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(3) RD Stock 1982-2016 AER Replication.sas' 
and
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(4) Reporter PPE Interpolation.do'
/* The first output dataset from this program is used in
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(8) Standard Errors Panels AER Replication.do'
The second output dataset from this program is used in
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(6) Formulary Apportionment 1982-2016 AER Replication.sas'
and
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(7) Hines and Rice 1982 AER Replication.sas' */

libname aer 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Data Sets';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Generate a panel data set for 1982-2016 that contains financial and operating data on
U.S. reporters and foreign affiliates plus a direct investment earnings-equivalent proxy 
for U.S. reporters and foreign affiliates.  According to the instructions for the BE577, 
earnings exclude a foreign affiliate's foreign income taxes paid and include the 
affiliate's share (on an equity basis) in net income of unconsolidated foreign business 
enterprises owned by it. */
/****************************************************************************************/
/****************************************************************************************/
data usdiafoir82to16;
	set aer.usdiafo82to92 aer.usdiafo93to16;
* Generate a variable for country names;
	format CountryName $25.;
	%macro ctrynames (ctrycode,ctryname);
	if country = &ctrycode then CountryName = &ctryname;
	%mend ctrynames;
	%ctrynames (100,'Canada'); %ctrynames (199,'US'); %ctrynames (999,'US');
	%ctrynames (200,'Argentina'); %ctrynames (201,'Bolivia'); %ctrynames (202,'Brazil'); 
	%ctrynames (203,'Chile'); %ctrynames (204,'Colombia'); %ctrynames (205,'Costa Rica');
	%ctrynames (206,'Cuba'); %ctrynames (207,'Dominican Republic'); %ctrynames (208,'Ecuador'); 
	%ctrynames (209,'El Salvador'); %ctrynames (210,'Guatemala'); %ctrynames (211,'Haiti');
	%ctrynames (212,'Honduras'); %ctrynames (213,'Mexico');
	%ctrynames (214,'Nicaragua'); %ctrynames (215,'Panama');
	%ctrynames (216,'Paraguay'); %ctrynames (217,'Peru');
	%ctrynames (218,'Uruguay'); %ctrynames (219,'Venezuela');
	%ctrynames (220,'Other Latin America'); %ctrynames (250,'Bahamas');
	%ctrynames (251,'Barbados'); %ctrynames (252,'Bermuda');
	%ctrynames (253,'British Caribbean'); %ctrynames (254,'Belize');
	%ctrynames (255,'French Islands'); %ctrynames (256,'French Guiana');
	%ctrynames (257,'Guyana'); %ctrynames (258,'Jamaica');
	%ctrynames (259,'Netherlands Antilles'); %ctrynames (260,'Suriname');
	%ctrynames (261,'Trinidad and Tobago'); %ctrynames (263,'St. Pierre and Miquelon');
	%ctrynames (265,'Grenada'); %ctrynames (266,'UK Islands - Caribbean');
	%ctrynames (267,'St. Kitts and Nevis'); %ctrynames (268,'UK Islands - Atlantic');
	%ctrynames (269,'Dominica'); %ctrynames (270,'St. Lucia');
	%ctrynames (271,'St. Vincent and the Grenadines'); %ctrynames (272,'Anguilla');
	%ctrynames (273,'Antigua and Barbuda'); %ctrynames (274,'Aruba');
	%ctrynames (275,'Curacao'); %ctrynames (276,'Saint Maarten'); 
	%ctrynames (277,'Netherlands Islands - Caribbean');
	%ctrynames (300,'Andorra'); %ctrynames (301,'Austria');
	%ctrynames (302,'Belgium'); %ctrynames (303,'British Islands - Atlantic');
	%ctrynames (304,'Cyprus'); %ctrynames (305,'Denmark');
	%ctrynames (306,'Finland'); %ctrynames (307,'France');
	%ctrynames (308,'Germany'); %ctrynames (309,'Gibraltar');
	%ctrynames (310,'Greece'); %ctrynames (311,'Greenland');
	%ctrynames (312,'Iceland'); %ctrynames (313,'Ireland');
	%ctrynames (314,'Italy'); %ctrynames (315,'Liechtenstein');
	%ctrynames (316,'Luxembourg'); %ctrynames (317,'Malta');
	%ctrynames (318,'Monaco'); %ctrynames (458,'Monaco'); %ctrynames (319,'Netherlands');
	%ctrynames (320,'Norway'); %ctrynames (321,'Portugal');
	%ctrynames (322,'San Marino'); %ctrynames (323,'Spain');
	%ctrynames (324,'Sweden'); %ctrynames (325,'Switzerland');
	%ctrynames (326,'Turkey'); %ctrynames (327,'UK'); %ctrynames (366,'UK');
	%ctrynames (328,'Yugoslavia'); %ctrynames (329,'Other Europe');
	%ctrynames (330,'Vatican City'); %ctrynames (331,'Estonia');
	%ctrynames (332,'Latvia'); %ctrynames (333,'Lithuania');
	%ctrynames (334,'Armenia'); %ctrynames (335,'Azerbaijan');
	%ctrynames (336,'Belarus'); %ctrynames (337,'Georgia');
	%ctrynames (338,'Kazakhstan'); %ctrynames (339,'Kyrgyzstan');
	%ctrynames (340,'Moldova'); %ctrynames (341,'Russia');
	%ctrynames (342,'Tajikistan'); %ctrynames (343,'Turkmenistan');
	%ctrynames (344,'Ukraine'); %ctrynames (345,'Uzbekistan');
	%ctrynames (350,'Albania'); %ctrynames (351,'Bulgaria');
	%ctrynames (352,'Czechoslovakia'); %ctrynames (353,'East Germany');
	%ctrynames (354,'Hungary'); %ctrynames (355,'Poland');
	%ctrynames (356,'Romania'); %ctrynames (357,'USSR');
	%ctrynames (358,'Bosnia and Herzegovina'); %ctrynames (359,'Croatia');
	%ctrynames (360,'Macedonia'); %ctrynames (361,'Montenegro');
	%ctrynames (362,'Serbia'); %ctrynames (363,'Slovenia');
	%ctrynames (364,'Czech Republic'); %ctrynames (365,'Slovakia');
	%ctrynames (400,'Algeria'); %ctrynames (401,'Angola');
	%ctrynames (402,'Botswana'); %ctrynames (403,'Burundi');
	%ctrynames (404,'Cameroon'); %ctrynames (405,'Central African Republic');
	%ctrynames (406,'Chad'); %ctrynames (407,'Congo'); %ctrynames (408,'Zaire');
	%ctrynames (409,'Benin'); %ctrynames (410,'Egypt');
	%ctrynames (411,'Ethiopia'); %ctrynames (412,'Djibouti');
	%ctrynames (413,'Gabon'); %ctrynames (414,'Gambia');
	%ctrynames (415,'Ghana'); %ctrynames (416,'Guinea');
	%ctrynames (417,'Cote D Ivoire'); %ctrynames (418,'Kenya');
	%ctrynames (419,'Lesotho'); %ctrynames (420,'Liberia');
	%ctrynames (421,'Libya'); %ctrynames (422,'Madagascar');
	%ctrynames (423,'Malawi'); %ctrynames (424,'Mali');
	%ctrynames (425,'Mauritania'); %ctrynames (426,'Morocco');
	%ctrynames (427,'Mozambique'); %ctrynames (428,'Niger');
	%ctrynames (429,'Nigeria'); %ctrynames (430,'Guinea - Bissau');
	%ctrynames (431,'Zimbabwe'); %ctrynames (432,'Rwanda');
	%ctrynames (433,'Senegal'); %ctrynames (434,'Sierra Leone');
	%ctrynames (435,'Somalia'); %ctrynames (436,'South Africa');
	%ctrynames (437,'Namibia'); %ctrynames (438,'Equatorial Guinea');
	%ctrynames (439,'Spanish North Morocco'); %ctrynames (440,'Western Sahara');
	%ctrynames (441,'Sudan'); %ctrynames (442,'Swaziland');
	%ctrynames (443,'Tanzania'); %ctrynames (444,'Togo');
	%ctrynames (445,'Tunisia'); %ctrynames (446,'Uganda');
	%ctrynames (447,'Burkina'); %ctrynames (448,'Zambia');
	%ctrynames (449,'Other Africa'); %ctrynames (450,'Cape Verde');
	%ctrynames (451,'Sao Tome and Principe'); %ctrynames (453,'Mauritius');
	%ctrynames (454,'Seychelles'); %ctrynames (455,'UK Islands - Atlantic'); %ctrynames (456,'Comoros');
	%ctrynames (457,'Eritrea'); %ctrynames (500,'Yemen');
	%ctrynames (501,'Bahrain'); %ctrynames (502,'Iran');
	%ctrynames (503,'Iraq'); %ctrynames (504,'Israel');
	%ctrynames (505,'Jordan'); %ctrynames (506,'Kuwait');
	%ctrynames (507,'Lebanon'); %ctrynames (508,'Oman'); %ctrynames (509,'Iraq Saudi Arabia Neutral');
	%ctrynames (510,'Qatar'); %ctrynames (511,'Saudi Arabia');
	%ctrynames (512,'Syria'); %ctrynames (513,'United Arab Emirates');
	%ctrynames (514,'Yemen'); %ctrynames (515,'Other Middle East');
	%ctrynames (600,'Afghanistan'); %ctrynames (601,'Australia');
	%ctrynames (602,'Bhutan'); %ctrynames (603,'Brunei');
	%ctrynames (604,'UK Islands - Pacific'); %ctrynames (605,'UK Islands - Pacific');
	%ctrynames (606,'Burma'); %ctrynames (607,'Cambodia');
	%ctrynames (608,'Sri Lanka'); %ctrynames (609,'French Islands - Indian Ocean');
	%ctrynames (610,'French Islands - Pacific'); %ctrynames (611,'Hong Kong');
	%ctrynames (612,'India'); %ctrynames (613,'Indonesia');
	%ctrynames (614,'Japan'); %ctrynames (615,'Laos');
	%ctrynames (616,'Macau'); %ctrynames (617,'Malaysia');
	%ctrynames (618,'Nepal'); %ctrynames (619,'Papua New Guinea');
	%ctrynames (620,'New Zealand'); %ctrynames (621,'Okinawa');
	%ctrynames (622,'Pakistan'); %ctrynames (623,'Philippines');
	%ctrynames (624,'Portuguese Timor'); %ctrynames (625,'Singapore');
	%ctrynames (626,'South Korea'); %ctrynames (627,'Vietnam');
	%ctrynames (628,'Taiwan'); %ctrynames (629,'Thailand');
	%ctrynames (631,'Bangladesh'); %ctrynames (632,'Fiji');
	%ctrynames (633,'Maldives'); %ctrynames (635,'Nauru');
	%ctrynames (636,'Vanuatu'); %ctrynames (637,'Samoa');
	%ctrynames (638,'Tonga'); %ctrynames (650,'China');
	%ctrynames (651,'Mongolia'); %ctrynames (652,'North Korea');
	%ctrynames (653,'Vietnam'); %ctrynames (654,'Solomon Islands');
	%ctrynames (655,'Kiribati'); %ctrynames (656,'Tuvalu');
	%ctrynames (657,'Micronesia'); %ctrynames (658,'Marshall Islands');
	%ctrynames (659,'Palau'); %ctrynames (660,'East Timor');
	%ctrynames (700,'International'); %ctrynames (701,'International'); %ctrynames (702,'International');
* Generate a variable for tax haven countries;
	if country in (205,215,250,251,252,266,313,315,316,319,325,611,625) then Haven = 1;
	else Haven = 0;
* Generate a variable for BEA published global regions;
	format x $3. Region $14.;
	x = country;
	if substr(x,1,1) = '1' then Region = 'Canada';
	if substr(x,1,1) = '2' then Region = 'Lat Am and OWH';
	if substr(x,1,1) = '3' then Region = 'Europe';
	if substr(x,1,1) = '4' then Region = 'Africa';
	if substr(x,1,1) = '5' then Region = 'Middle East';
	if substr(x,1,1) = '6' then Region = 'Asia';
	if substr(x,1,1) = '7' then Region = 'International';
	if substr(x,1,1) = '9' then Region = 'US';
* Generate a variable for BEA published NAICS industy group after 1998;
	if year gt 1998 then do;
		format IndustryName $25.;
		if substr(industry,5,6) = 11 then IndustryName = 'FFF';
		if substr(industry,5,6) = 21 then IndustryName = 'Mining';
		if substr(industry,5,6) = 22 then IndustryName = 'Utilities';
		if substr(industry,5,6) = 23 then IndustryName = 'Construction';
		if substr(industry,5,6) in (31,32,33) then IndustryName = 'Manufacturing';
		if substr(industry,5,6) = 42 then IndustryName = 'Wholesale Trade';
		if substr(industry,5,6) in (44,45) then IndustryName = 'Retail Trade';
		if substr(industry,5,6) in (48,49)then IndustryName = 'Transport and Ware';
		if substr(industry,5,6) = 51 then IndustryName = 'Information';
		if industry in (5242,5243,5249) then IndustryName = 'Insurance';
		if industry in (5221,5223,5224,5229,5231,5238,5252)then IndustryName = 'Finance';
		if substr(industry,5,6) = 53 then IndustryName = 'Real Estate';
		if substr(industry,5,6) = 54 then IndustryName = 'PST';
		if substr(industry,5,6) = 55 then IndustryName = 'Management';
		if substr(industry,5,6) = 56 then IndustryName = 'Administration';
		if substr(industry,5,6) = 62 then IndustryName = 'Health';
		if substr(industry,5,6) = 72 then IndustryName = 'Accommodation and Food';
		if substr(industry,5,6) in (61,71,81,92) then IndustryName = 'Misc Services';
	end;
* Generate a variable for BEA published SIC industy group before 1999 for firms with an industry code;
	if year lt 1999 then do;
		if industry in (10,20,21,70,80,90) then IndustryName = 'FFF';
		if industry in (101,102,103,107,108,120,124,133,138,140,148) then IndustryName = 'Mining';
		if industry = 150 then IndustryName = 'Construction';
		if industry in (201,202,203,204,205,208,209,210,220,230,240,250,262,264,265,270,271,272,
		275,281,283,284,285,287,289,291,292,299,305,307,308,310,321,329,331,335,341,342,343,344,
		345,346,349,351,352,353,354,355,356,357,358,359,363,364,366,367,369,371,379,381,383,384,
		386,387,390) then IndustryName = 'Manufacturing';
		if industry in (401,441,449,450,461,462,470,472,477) then IndustryName = 'Transport and Ware';
		if industry = 490 then IndustryName = 'Utilities';
		if industry in (501,503,504,505,506,507,508,509,511,512,513,514,515,517,519) 
		then IndustryName = 'Wholesale Trade';
		if industry in (530,540,554,560,580,590) then IndustryName = 'Retail Trade';
		if industry in (631,632,639) then IndustryName = 'Insurance';
		if industry in (600,603,612,691) then IndustryName = 'Finance';
		if industry in (611,649,650,679,735,751,890) then IndustryName = 'Real Estate';
		if industry = 671 then IndustryName = 'Management';
		if industry in (480,481,483,741,742,743,780) then IndustryName = 'Information';
		if industry in (731,733,734,737,739,749,810,871,872,873,874,891,893,895) then IndustryName = 'PST';
		if industry in (475,736) then IndustryName = 'Administration';
		if industry in (800,892) then IndustryName = 'Health';
		if industry = 700 then IndustryName = 'Accommodation and Food';
		if industry in (752,760,790,820,896,897,900,905) then IndustryName = 'Misc Services';
		if industry = 999 then IndustryName = 'N/A'; * Industry code for individuals;
	end;
* Generate a variable for IT-intensive-using industries after 1998;
	if year gt 1998 then do;
		if industry in (5417) then ITUindustry = 1;
		else if substr(industry,5,7) in (315,333,335,336,337,339,532) then ITUindustry = 1;
		else if substr(industry,5,6) in (42,44,45,51) then ITUindustry = 1;
		else ITUindustry = 0;
	end;
* Generate a variable for IT-intensive-using industries before 1999;
	if year lt 1999 then do;
		if industry in (230,250,270,271,272,275,351,352,353,354,355,356,358,359,363,
		364,369,371,379,383,384,386,480,481,483,501,503,504,505,506,507,508,509,511,
		512,513,514,515,517,519,530,540,560,580,590,733,735,737,741,742,743,751,873,
		890) then ITUindustry = 1;
		else ITUindustry = 0;
	end;
* Generate a variable for IT-intensive-producing industries after 1998;
	if year gt 1998 then do;
		if industry in (5415) then ITPindustry = 1;
		else if substr(industry,5,7) in (334) then ITPindustry = 1;
		else if substr(industry,5,6) in (51) then ITPindustry = 1;
		else ITPindustry = 0;
	end;
* Generate a variable for IT-intensive-producing industries before 1999;
	if year lt 1999 then do;
		if industry in (270,271,272,275,357,366,367,381,387,480,481,483,737,741,742,
		743) then ITPindustry = 1;
		else ITPindustry = 0;
	end;
* Generate a variable for RD intensive industries after 1998;
	if year gt 1998 then do;
		if industry in (5112,5415,5417) then RDindustry = 1;
		else if substr(industry,5,7) in (325,334,336) then RDindustry = 1;
		else RDindustry = 0;
	end;
* Generate a variable for RD intensive industries before 1999;
	if year lt 1999 then do;
		if industry in (281,283,284,285,287,289,357,366,367,371,379,381,
		387,733,737,741,742,743,873) then RDindustry = 1;
		else RDindustry = 0;
	end;
* Generate a variable for BEA annual industry accounts after 1998;
	if year gt 1998 then do;
		if substr(industry,5,6) = 11 then IEDindustry = 1100;
		if substr(industry,5,6) = 21 then IEDindustry = 2100;
		if substr(industry,5,6) = 22 then IEDindustry = 2200;
		if substr(industry,5,6) = 23 then IEDindustry = 2300;
		if substr(industry,5,7) = 321 then IEDindustry = 3210;
		if substr(industry,5,7) = 327 then IEDindustry = 3270;
		if substr(industry,5,7) = 331 then IEDindustry = 3310;
		if substr(industry,5,7) = 332 then IEDindustry = 3320;
		if substr(industry,5,7) = 333 then IEDindustry = 3330;
		if substr(industry,5,7) = 334 then IEDindustry = 3340;
		if substr(industry,5,7) = 335 then IEDindustry = 3350;
		if industry in (3361,3362,3363) then IEDindustry = 3361;
		if industry in (3364,3365,3366,3369) then IEDindustry = 3364;
		if substr(industry,5,7) = 337 then IEDindustry = 3370;
		if industry in (3391,3399) then IEDindustry = 3390;
		if substr(industry,5,7) in (311,312) then IEDindustry = 3110;
		if substr(industry,5,7) in (313,314) then IEDindustry = 3130;
		if substr(industry,5,7) in (315,316) then IEDindustry = 3150;
		if substr(industry,5,7) = 322 then IEDindustry = 3220;
		if substr(industry,5,7) = 323 then IEDindustry = 3230;
		if substr(industry,5,7) = 324 then IEDindustry = 3240;
		if substr(industry,5,7) = 325 then IEDindustry = 3250;
		if substr(industry,5,7) = 326 then IEDindustry = 3260;
		if substr(industry,5,6) = 42 then IEDindustry = 4200;
		if substr(industry,5,6) in (44,45) then IEDindustry = 4400;
		if substr(industry,5,6) in (48,49) then IEDindustry = 4800;
		if substr(industry,5,7) = 511 then IEDindustry = 5110;
		if substr(industry,5,7) = 512 then IEDindustry = 5120;
		if substr(industry,5,7) in (513,515,516,517) then IEDindustry = 5130;
		if substr(industry,5,7) in (514,518,519) then IEDindustry = 5140;
		if substr(industry,5,6) = 52 then IEDindustry = 5200;
		if substr(industry,5,6) = 53 then IEDindustry = 5300;
		if industry = 5411 then IEDindustry = 5411;
		if industry = 5415 then IEDindustry = 5415;
		if industry in (5412,5413,5414,5416,5417,5418,5419) then IEDindustry = 5412;
		if substr(industry,5,6) = 55 then IEDindustry = 5500;
		if substr(industry,5,7) in (561,562) then IEDindustry = 5600;
		if substr(industry,5,6) in (61,62) then IEDindustry = 6000;
		if substr(industry,5,6) in (71,72) then IEDindustry = 7000;
		if substr(industry,5,6) in (81,92) then IEDindustry = 8000;
	end;
* Generate a variable for BEA annual industry accounts before 1999;
	if year lt 1999 then do;
		if industry in (10,20,21,70,80,90) then IEDindustry = 1100;
		if industry in (133,138,101,102,103,107,108,120,140,124,148) then IEDindustry = 2100;
		if industry = 490 then IEDindustry = 2200;
		if industry = 150 then IEDindustry = 2300;
		if industry = 240 then IEDindustry = 3210;
		if industry in (321,329) then IEDindustry = 3270;
		if industry in (331,335) then IEDindustry = 3310;
		if industry in (341,342,343,344,345,346,349) then IEDindustry = 3320;
		if industry in (352,353,351,354,355,356,358,359,386) then IEDindustry = 3330;
		if industry in (357,366,367,381,387) then IEDindustry = 3340;
		if industry in (363,364,369) then IEDindustry = 3350;
		if industry = 371 then IEDindustry = 3361;
		if industry = 379 then IEDindustry = 3364;
		if industry = 250 then IEDindustry = 3370;
		if industry in (383,384,390) then IEDindustry = 3390;
		if industry in (204,205,208,201,202,203,209,210) then IEDindustry = 3110;
		if industry = 220 then IEDindustry = 3130;
		if industry in (230,310) then IEDindustry = 3150;
		if industry in (262,264,265) then IEDindustry = 3220;
		if industry in (291,292,299) then IEDindustry = 3240;
		if industry in (281,283,284,287,285,289) then IEDindustry = 3250;
		if industry in (305,307,308) then IEDindustry = 3260;
		if industry in (517,501,503,505,506,507,504,508,509,511,512,513,514,515,519)
		then IEDindustry = 4200;
		if industry in (530,554,540,560,580,590) then IEDindustry = 4400;
		if industry in (450,401,441,449,461,462,472,477,470) then IEDindustry = 4800;
		if industry in (270,271,272,275) then IEDindustry = 5110;
		if industry = 780 then IEDindustry = 5120;
		if industry in (480,481,483) then IEDindustry = 5130;
		if industry in (737,741,742,743) then IEDindustry = 5140;
		if industry in (600,611,612,679,603,631,632,639,691) then IEDindustry = 5200;
		if industry in (649,650,735,890,751) then IEDindustry = 5300;
		if industry in (895,810) then IEDindustry = 5411;
		if industry in (731,734,733,891,893,871,874,872,873) then IEDindustry = 5412;
		if industry = 671 then IEDindustry = 5500;
		if industry in (736,739,475,734,749) then IEDindustry = 5600;
		if industry in (896,820,892,800) then IEDindustry = 6000;
		if industry in (790,700) then IEDindustry = 7000;
		if industry in (897,905,890,752,760,999) then IEDindustry = 8000;
	end;
* Convert percentages for U.S. voting interests to decimals;
	if usvoting le 1000 then VotePercent = usvoting/1000;
	if usvoting gt 1000 then VotePercent = 1;
* Rename formulary factors;
	Compensation = sum(empcomp,0);
	UnaffSale = sum(unaffsales,0);
	* There is no reporter PPE data collected for non-benchmark years;
	if year in (1982,1989,1994,1999,2004,2009,2014) and foreignid = '0000' then do;
		NetPPE = sum(grppe,0) - sum(accdepr,0);
	end;
	* PPE data are collected on foreign affiliates for all years;
	if foreignid ne '0000' then do;
		NetPPE = (sum(grppe,0) - sum(accdepr,0));
	end;
* Generate direct investment earnings proxy for U.S. reporters 
(there is no reporter value-added data collected for 1983-1988 and 1990-1993);
	if year in (1982,1989,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,
	2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016) and foreignid = '0000' then do;
		ProfitsPar = sum(ni,0) - sum(gl,0) + sum(depl,0) - sum(iq,0);
	end;
* Generate direct investment earnings proxy with coverage adjustment for foreign affiliates;
* Coverage adjustment is calculated as a ratio of aggregate published to aggregate proxy;
	%macro earncc (x1,x2,x3); * x1 is year, x2 is published earnings without current cost adjustment,
	x3 is the earnings proxy without current cost adjustment;
	if foreignid ne '0000' and year = &x1 then do;
		ProfitsAff = ((sum(ni,0) - sum(gl,0) + sum(depl,0)) * votepercent) * (&x2/&x3);
	end;
	%mend earncc;
	%earncc (2016,416.9,379.3); %earncc (2015,423.8,380.6);
	%earncc (2014,447.8,439.6);	%earncc (2013,440.6,386.5);	%earncc (2012,428.7,417.6);
	%earncc (2011,441.0,423.7);	%earncc (2010,411.8,375.2);	%earncc (2009,333.5,313.1);
	%earncc (2008,384.8,347.0);	%earncc (2007,342.8,347.0);	%earncc (2006,298.3,268.5);
	%earncc (2005,267.5,254.0);	%earncc (2004,223.1,214.71);	%earncc (2003,159.9,148.7);
	%earncc (2002,120.357,100.967);	%earncc (2001,105.542,79.704);	%earncc (2000,129.9,112.1);
	%earncc (1999,111.2,102.8);	%earncc (1998,89.3,86.1);	%earncc (1997,104.2,97.9);
	%earncc (1996,92.9,85.2); %earncc (1995,86.1,76.7);	%earncc (1994,68.1,59.6);
	%earncc (1993,58.9,50.0); %earncc (1992,50.7,46.3);	%earncc (1991,52.3,48.9);
	%earncc (1990,58.0,56.7); %earncc (1989,56.0,54.6);	%earncc (1988,55.8,52.4);
	%earncc (1987,43.7,44.3); %earncc (1986,35.7,34.8);	%earncc (1985,33.9,31.7);
	%earncc (1984,36.3,32.0); %earncc (1983,32.3,28.2);	%earncc (1982,27.9,23.9);
* Direct investment earnings are measured for foreign affiliates that are directly owned;
	if foreignid ne '0000' then do;
		if votepercent ge 0.1 then IRindicator = 1; else IRindicator = 0;
	end;
	if foreignid = '0000' then do;
		IRindicator = 1;
	end;
* Keep analytic variables;
	keep be11id foreignid year industry industryname ituindustry itpindustry rdindustry 
	iedindustry country countryname region haven votepercent irindicator mofa majforowned
	va ptr nip ibt cca compensation ni tax iq depl gl grppe netppe unaffsale profitspar 
	profitsaff rdexp;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Generate indicators for R&D intensive firms.  R&D intensive firms are 
determined by the firm-level ratio of R&D expenditures to unaffiliated sales at the 75th 
percentile.  There are no R&D data collected for 1983-1988.  However, there are only 23 
firms that start and end in 1983-1988, and of the 23 firms, only 3 firms 
(072020,072530,072910) have any entities classified to R&D intensive industries and will 
thus presumably not be R&D intensive at the firm level. */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = usdiafoir82to16;
	by be11id;
proc means noprint data = usdiafoir82to16;
	by be11id;
	var rdexp unaffsale;
	where year in (1982,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,
	2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016);
	output	out = rdfirm (drop = _type_ _freq_)
			sum = RDexpS UnaffSaleS;
data rdintensityfirm;
	set rdfirm;
	RDintensity = sum(rdexps,0) / sum(unaffsales,2);
	if rdintensity ge 0.00985 then RDfirm = 1; else RDfirm = 0; * 75th percentile;
	keep be11id rdfirm;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Generate indicators for IT intensive using firms.  IT intensive using firms are 
determined by the proportion of unaffiliated sales generated by entities within a firm 
that are classified to industries that include IT intensive using industries (according 
to Bloom et al. 2012). */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = usdiafoir82to16;
	by be11id;
proc means noprint data = usdiafoir82to16;
	by be11id;
	var unaffsale;
	where ituindustry = 1;
	output	out = itufirm (drop = _type_ _freq_)
			sum = UnaffSaleSit;
proc means noprint data = usdiafoir82to16;
	by be11id;
	var unaffsale;
	output	out = allfirm (drop = _type_ _freq_)
			sum = UnaffSaleS;
data ituintensityfirm;
	merge itufirm allfirm;
	by be11id;
	ITUintensity = sum(unaffsalesit,0) / sum(unaffsales,1.01);
	if ituintensity gt 0.50 then ITUfirm = 1; else ITUfirm = 0;
	keep be11id itufirm;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Generate indicators for IT intensive producing firms.  IT intensive producing firms 
are determined by the proportion of unaffiliated sales generated by entities within a 
firm that are classified to industries that include IT intensive producing industries 
(according to Fernald 2014). */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = usdiafoir82to16;
	by be11id;
proc means noprint data = usdiafoir82to16;
	by be11id;
	var unaffsale;
	where itpindustry = 1;
	output	out = itpfirm (drop = _type_ _freq_)
			sum = UnaffSaleSit;
proc means noprint data = usdiafoir82to16;
	by be11id;
	var unaffsale;
	output	out = allfirm (drop = _type_ _freq_)
			sum = UnaffSaleS;
data itpintensityfirm;
	merge itpfirm allfirm;
	by be11id;
	ITPintensity = sum(unaffsalesit,0) / sum(unaffsales,1.01);
	if itpintensity gt 0.50 then ITPfirm = 1; else ITPfirm = 0;
	keep be11id itpfirm;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Generate a variable for each parent's primary industry based on BEA's annual industry
accounts */
/****************************************************************************************/
/****************************************************************************************/
data iedparent;
	set usdiafoir82to16;
	if foreignid = '0000';
	IEDindPar = iedindustry;
	keep be11id year iedindpar;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Use net PPE for U.S. parents interpolated in STATA for non-benchmark years */
/****************************************************************************************/
/****************************************************************************************/
* Calculate 1998 PPE as an average of 1997 and 1999 because PPE for that year is inconsistent;
data parentppe1997;
set aer.interpolate_rep_netppe;
if year = 1997;
ppe1997 = nbv_ppe_cy_mipolate;
drop year nbv_ppe_cy_mipolate;
data parentppe1999;
set aer.interpolate_rep_netppe;
if year = 1999;
ppe1999 = nbv_ppe_cy_mipolate;
drop year nbv_ppe_cy_mipolate;
proc sort data = parentppe1997;
by us_id;
proc sort data = parentppe1999;
by us_id;
data parentppe1998;
merge parentppe1997 parentppe1999;
by us_id;
year = 1998;
if ppe1997 ne . and ppe1999 ne . then nbv_ppe_cy_mipolate = sum(ppe1997,ppe1999)/2;
if ppe1997 ne . and ppe1999 = . then nbv_ppe_cy_mipolate = ppe1997;
if ppe1997 = . and ppe1999 ne . then nbv_ppe_cy_mipolate = ppe1999;
drop nbv_ppe_cy_bm nbv_ppe_cy logbm ppe1997 ppe1999;
run;

data parentexcl1998;
set aer.interpolate_rep_netppe;
if year = 1998 then delete;
data parentppenofill;
set parentexcl1998 parentppe1998;
run;

* Fill net PPE for missing years with net PPE for most recent year;
proc sort data = parentppenofill;
by us_id year;
data parentppe;
set parentppenofill;
usidlag1=lag1(us_id);
usidlag2=lag2(us_id);
usidlag3=lag3(us_id);
usidlag4=lag4(us_id);
ppelag1 = lag1(nbv_ppe_cy_mipolate);
ppelag2 = lag2(nbv_ppe_cy_mipolate);
ppelag3 = lag3(nbv_ppe_cy_mipolate);
ppelag4 = lag4(nbv_ppe_cy_mipolate);
BE11ID = us_id;
if year in (1982,1989,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,
2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017) then do;
if nbv_ppe_cy_mipolate ne . then parppe = nbv_ppe_cy_mipolate;
if us_id = usidlag1 and ppelag1 ne . and nbv_ppe_cy_mipolate = . then parppe = ppelag1;
if us_id = usidlag2 and ppelag2 ne . and nbv_ppe_cy_mipolate = . then parppe = ppelag2;
if us_id = usidlag3 and ppelag3 ne . and nbv_ppe_cy_mipolate = . then parppe = ppelag3;
if us_id = usidlag4 and ppelag4 ne . and nbv_ppe_cy_mipolate = . then parppe = ppelag4;
end;
keep be11id year parppe;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Attach the R&D intensity and IT intensity parent indicators and BEA's annual industry
indicators and affiliates' profits to the panel dataset */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = usdiafoir82to16;
	by be11id year;
proc sort data = iedparent;
	by be11id year;
proc sort data = parentppe;
	by be11id year;
data usdiafoir82to16parent;
	merge usdiafoir82to16 iedparent parentppe;
	by be11id year;
	if foreignid = ' ' then delete;
* Change missing values;
	array changemiss _numeric_;
	do over changemiss;
		if iedindpar = . then iedindpar = 8000;
		if NetPPE = . and foreignid = '0000' then NetPPE = parppe;
		if NetPPE = . then NetPPE = parppe;
	end;
	drop parppe;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Attach R&D stocks to the panel data set */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = usdiafoir82to16parent;
	by be11id foreignid year;
proc sort data = aer.rdstock;
	by be11id foreignid year;
data usdiafoir82to16rd;
	merge usdiafoir82to16parent aer.rdstock;
	by be11id foreignid year;
	if irindicator = . then delete;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Attach the R&D intensity and IT intensity firm indicators to the panel data set */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = usdiafoir82to16rd;
	by be11id;
proc sort data = rdintensityfirm;
	by be11id;
proc sort data = ituintensityfirm;
	by be11id;
proc sort data = itpintensityfirm;
	by be11id;
data aer.usdiafoir82to16;
	merge usdiafoir82to16rd rdintensityfirm ituintensityfirm itpintensityfirm;
	by be11id;
* Change missing values;
	array changemiss _numeric_;
	do over changemiss;
		if rdfirm = . then rdfirm = 1;
		if itufirm = . then itufirm = 1;
		if itpfirm = . then itpfirm = 1;
	end;
* Generate a single earnings proxy variable for U.S. parents and foreign affiliates;
	if foreignid = '0000' then do;
		Profits = profitspar;
	end;
	if foreignid ne '0000' then do;
		Profits = profitsaff;
	end;
	drop profitspar profitsaff;
run;
/****************************************************************************************/
/****************************************************************************************/

/****************************************************************************************/
/****************************************************************************************/
/* Use formulary apportionment to reallocate the direct investment earnings proxy
and generate an adjustment between U.S. reporters and foreign affiliates for 1982-2016. */
/****************************************************************************************/
/****************************************************************************************/
* Aggregate financial and operating data for each firm;
proc sort data = aer.usdiafoir82to16;
	by be11id year;
proc means noprint data = aer.usdiafoir82to16;
	by be11id year;
	var compensation unaffsale rdstock netppe profits;
	where year in (1982,1989,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,
	2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016);
	output	out = usdiafosum (drop = _type_ _freq_) /* contains aggregate financial and 
			operating data for each firm */
			sum = compsum salesum rdstksum ppesum profitssum;
run;

* Attach aggregate data to microdata and apply formulary apportionment;
proc sort data = aer.usdiafoir82to16;
	by be11id year;
proc sort data = usdiafosum;
	by be11id year;
data aer.usdiafoapportion82to16;
	merge aer.usdiafoir82to16 usdiafosum;
	by be11id year;
	where year in (1982,1989,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,
	2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016);
* Set missing values to zero;
	array changemiss _numeric_;
	do over changemiss;
		if compensation = . then compensation = 0;
		if unaffsale = . then unaffsale = 0;
		if rdstock = . then rdstock = 0;
		if netppe = . then netppe = 0;
		if profits = . then profits = 0;
	end;
* Generate apportionment factors;
	if compsum ne 0 then CompWt = (compensation / compsum); else CompWt = 0;
	if salesum ne 0 then SaleWt = (unaffsale / salesum); else SaleWt = 0;
	if rdstksum ne 0 then RDstkWT = (rdstock / rdstksum); else RDstkWT = 0;
	if ppesum ne 0 then PPEwt = (netppe / ppesum); else PPEwt = 0;
* Reallocate the proxy for earnings based on compensation;
	EarnFAcomp = profitssum * compwt;
	if compsum gt 0 then AdjComp = earnfacomp - profits;
	else AdjComp = 0;
* Reallocate the proxy for earnings based on unaffiliated sales;
	EarnFAsale = profitssum * salewt;
	if salesum gt 0 then AdjSale = earnfasale - profits;
	else AdjSale = 0;
* Reallocate the proxy for earnings based on R&D stock;
	EarnFArdstk = profitssum * rdstkwt;
	if rdstksum gt 0 then AdjRDstk = earnfardstk - profits;
	else AdjRDstk = 0;
* Reallocate the proxy for earnings based on PPE;
	EarnFAppe = profitssum * ppewt;
	if ppesum gt 0 then AdjPPE = earnfappe - profits;
	else AdjPPE = 0;
* Reattribute the proxy for earnings based on a weighted average of compensation, R&D stock, and PPE;
	EarnFA3 = sum((profitssum * compwt * 0.333),(profitssum * rdstkwt * 0.333),(profitssum * ppewt * 0.334));
	if compsum gt 0 and rdstksum gt 0 and ppesum gt 0 then AdjWt3 = earnfa3 - profits;
	else if compsum le 0 and rdstksum gt 0 and ppesum gt 0 then AdjWt3 = sum((profitssum * rdstkwt * 0.5),(profitssum * ppewt * 0.5)) - profits;
	else if compsum gt 0 and rdstksum le 0 and ppesum gt 0 then AdjWt3 = sum((profitssum * compwt * 0.5),(profitssum * ppewt * 0.5)) - profits;
	else if compsum gt 0 and rdstksum gt 0 and ppesum le 0 then AdjWt3 = sum((profitssum * compwt * 0.5),(profitssum * rdstkwt * 0.5)) - profits;
	else AdjWt3 = 0;
	drop compsum salesum rdstksum ppesum profitssum compwt salewt
	rdstkwt ppewt earnfacomp earnfasale earnfardstk earnfappe earnfa3;
run;
/****************************************************************************************/
/****************************************************************************************/

/****************************************************************************************/
/****************************************************************************************/
/* Calculate frequencies for majority-owned and wholly-owned affiliates for 2016 */
/****************************************************************************************/
/****************************************************************************************/
data majwhol;
	set aer.usdiafoir82to16;
	if year ne 2016 then delete;
	if votepercent lt 0.1 then delete;
	if foreignid = '0000' then delete;
run;

proc freq noprint data = majwhol;
	tables votepercent / out = majwholout;
proc export data = majwholout
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputMajWhol.xlsx';
run;
/****************************************************************************************/
/****************************************************************************************/
