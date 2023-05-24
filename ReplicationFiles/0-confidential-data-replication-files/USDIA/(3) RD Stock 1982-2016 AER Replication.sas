/* Program date:  November 4, 2021 */
/* Program name:  '(3) RD Stock 1982-2016 AER Replication.sas' */
/* Program description:  This program generates R&D stocks built from R&D expenditures for U.S. parents
and foreign affiliates.  Average annual depreciation rate is 26 percent based on table 10 in
Crawford et al. (SCB November 2014).  The resulting dataset is a panel of R&D stocks for 1982-2016:  aer.rdstock. */
/* The datasets used in this program are generated in
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(1) USDIA Financial and Operating Data 1982-1992 AER Replication.sas'
and
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(2) USDIA Financial and Operating Data 1993-2016 AER Replication.sas' */
/* The output dataset from this program is used in
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(5) Working Data Sets 1982-2016 AER Replication.sas' */

libname aer 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Data Sets';
run;

/****************************************************************************************/
/****************************************************************************************/
data rd;
	set aer.usdiafo82to92 aer.usdiafo93to16;
	keep be11id foreignid year rdexp;
run;

data rdannual82;
	set rd;
	if year in (1982);
	rdannual = rdexp;
proc sort data = rdannual82;
	by be11id foreignid;
proc means noprint data = rdannual82;
	by be11id foreignid;
	var rdannual;
	output	out = rdstock82 (drop = _type_ _freq_)
			sum = RDstock;
data rdstock82year;
	set rdstock82;
	Year = 1982;
run;

data rdannual89;
	set rd;
	if year in (1989);
	rdannual = rdexp;
proc sort data = rdannual89;
	by be11id foreignid;
proc means noprint data = rdannual89;
	by be11id foreignid;
	var rdannual;
	output	out = rdstock89 (drop = _type_ _freq_)
			sum = RDstock;
data rdstock89year;
	set rdstock89;
	Year = 1989;
run;

data rdannual90;
	set rd;
	if year in (1989,1990);
	if year = 1989 then do;
		rdannual = rdexp * (0.74**1);
	end;
	if year = 1990 then do;
		rdannual = rdexp;
	end;
proc sort data = rdannual90;
	by be11id foreignid;
proc means noprint data = rdannual90;
	by be11id foreignid;
	var rdannual;
	output	out = rdstock90 (drop = _type_ _freq_)
			sum = RDstock;
data rdstock90year;
	set rdstock90;
	Year = 1990;
run;

data rdannual91;
	set rd;
	if year in (1989,1990,1991);
	if year = 1989 then do;
		rdannual = rdexp * (0.74**2);
	end;
	if year = 1990 then do;
		rdannual = rdexp * (0.74**1);
	end;
	if year = 1991 then do;
		rdannual = rdexp;
	end;
proc sort data = rdannual91;
	by be11id foreignid;
proc means noprint data = rdannual91;
	by be11id foreignid;
	var rdannual;
	output	out = rdstock91 (drop = _type_ _freq_)
			sum = RDstock;
data rdstock91year;
	set rdstock91;
	Year = 1991;
run;

data rdannual92;
set rd;
	if year in (1989,1990,1991,1992);
	if year = 1989 then do;
		rdannual = rdexp * (0.74**3);
	end;
	if year = 1990 then do;
		rdannual = rdexp * (0.74**2);
	end;
	if year = 1991 then do;
		rdannual = rdexp * (0.74**1);
	end;
	if year = 1992 then do;
		rdannual = rdexp;
	end;
proc sort data = rdannual92;
	by be11id foreignid;
proc means noprint data = rdannual92;
	by be11id foreignid;
	var rdannual;
	output	out = rdstock92 (drop = _type_ _freq_)
			sum = RDstock;
data rdstock92year;
	set rdstock92;
	Year = 1992;
run;

data rdannual93;
	set rd;
	if year in (1989,1990,1991,1992,1993);
	if year = 1989 then do;
		rdannual = rdexp * (0.74**4);
	end;
	if year = 1990 then do;
		rdannual = rdexp * (0.74**3);
	end;
	if year = 1991 then do;
		rdannual = rdexp * (0.74**2);
	end;
	if year = 1992 then do;
		rdannual = rdexp * (0.74**1);
	end;
	if year = 1993 then do;
		rdannual = rdexp;
	end;
proc sort data = rdannual93;
	by be11id foreignid;
proc means noprint data = rdannual93;
	by be11id foreignid;
	var rdannual;
	output	out = rdstock93 (drop = _type_ _freq_)
			sum = RDstock;
data rdstock93year;
	set rdstock93;
	Year = 1993;
run;

data rdannual94;
	set rd;
	if year in (1989,1990,1991,1992,1993,1994);
	if year = 1989 then do;
		rdannual = rdexp * (0.74**5);
	end;
	if year = 1990 then do;
		rdannual = rdexp * (0.74**4);
	end;
	if year = 1991 then do;
		rdannual = rdexp * (0.74**3);
	end;
	if year = 1992 then do;
		rdannual = rdexp * (0.74**2);
	end;
	if year = 1993 then do;
		rdannual = rdexp * (0.74**1);
	end;
	if year = 1994 then do;
		rdannual = rdexp;
	end;
proc sort data = rdannual94;
	by be11id foreignid;
proc means noprint data = rdannual94;
	by be11id foreignid;
	var rdannual;
	output	out = rdstock94 (drop = _type_ _freq_)
			sum = RDstock;
data rdstock94year;
	set rdstock94;
	Year = 1994;
run;

data rdannual95;
	set rd;
	if year in (1989,1990,1991,1992,1993,1994,1995);
	if year = 1989 then do;
		rdannual = rdexp * (0.74**6);
	end;
	if year = 1990 then do;
		rdannual = rdexp * (0.74**5);
	end;
	if year = 1991 then do;
		rdannual = rdexp * (0.74**4);
	end;
	if year = 1992 then do;
		rdannual = rdexp * (0.74**3);
	end;
	if year = 1993 then do;
		rdannual = rdexp * (0.74**2);
	end;
	if year = 1994 then do;
		rdannual = rdexp * (0.74**1);
	end;
	if year = 1995 then do;
		rdannual = rdexp;
	end;
proc sort data = rdannual95;
	by be11id foreignid;
proc means noprint data = rdannual95;
	by be11id foreignid;
	var rdannual;
	output	out = rdstock95 (drop = _type_ _freq_)
			sum = RDstock;
data rdstock95year;
	set rdstock95;
	Year = 1995;
run;

%macro rd (out1,out2,out3,yr1,yr2,yr3,yr4,yr5,yr6,yr7,yr8);
	data &out1;
		set rd;
		if year in (&yr1,&yr2,&yr3,&yr4,&yr5,&yr6,&yr7,&yr8);
			if year = &yr1 then do;
				rdannual = rdexp * (0.74**7);
			end;
			if year = &yr2 then do;
				rdannual = rdexp * (0.74**6);
			end;
			if year = &yr3 then do;
				rdannual = rdexp * (0.74**5);
			end;
			if year = &yr4 then do;
				rdannual = rdexp * (0.74**4);
			end;
			if year = &yr5 then do;
				rdannual = rdexp * (0.74**3);
			end;
			if year = &yr6 then do;
				rdannual = rdexp * (0.74**2);
			end;
			if year = &yr7 then do;
				rdannual = rdexp * (0.74**1);
			end;
			if year = &yr8 then do;
				rdannual = rdexp;
			end;
	proc sort data = &out1;
		by be11id foreignid;
	proc means noprint data = &out1;
		by be11id foreignid;
		var rdannual;
		output	out = &out2 (drop = _type_ _freq_)
				sum = RDstock;
	data &out3;
		set &out2;
		Year = &yr8;
		run;
%mend rd;

%rd (rdannual96,rdstock96,rdstock96year,1989,1990,1991,1992,1993,1994,1995,1996);
%rd (rdannual97,rdstock97,rdstock97year,1990,1991,1992,1993,1994,1995,1996,1997);
%rd (rdannual98,rdstock98,rdstock98year,1991,1992,1993,1994,1995,1996,1997,1998);
%rd (rdannual99,rdstock99,rdstock99year,1992,1993,1994,1995,1996,1997,1998,1999);
%rd (rdannual00,rdstock00,rdstock00year,1993,1994,1995,1996,1997,1998,1999,2000);
%rd (rdannual01,rdstock01,rdstock01year,1994,1995,1996,1997,1998,1999,2000,2001);
%rd (rdannual02,rdstock02,rdstock02year,1995,1996,1997,1998,1999,2000,2001,2002);
%rd (rdannual03,rdstock03,rdstock03year,1996,1997,1998,1999,2000,2001,2002,2003);
%rd (rdannual04,rdstock04,rdstock04year,1997,1998,1999,2000,2001,2002,2003,2004);
%rd (rdannual05,rdstock05,rdstock05year,1998,1999,2000,2001,2002,2003,2004,2005);
%rd (rdannual06,rdstock06,rdstock06year,1999,2000,2001,2002,2003,2004,2005,2006);
%rd (rdannual07,rdstock07,rdstock07year,2000,2001,2002,2003,2004,2005,2006,2007);
%rd (rdannual08,rdstock08,rdstock08year,2001,2002,2003,2004,2005,2006,2007,2008);
%rd (rdannual09,rdstock09,rdstock09year,2002,2003,2004,2005,2006,2007,2008,2009);
%rd (rdannual10,rdstock10,rdstock10year,2003,2004,2005,2006,2007,2008,2009,2010);
%rd (rdannual11,rdstock11,rdstock11year,2004,2005,2006,2007,2008,2009,2010,2011);
%rd (rdannual12,rdstock12,rdstock12year,2005,2006,2007,2008,2009,2010,2011,2012);
%rd (rdannual13,rdstock13,rdstock13year,2006,2007,2008,2009,2010,2011,2012,2013);
%rd (rdannual14,rdstock14,rdstock14year,2007,2008,2009,2010,2011,2012,2013,2014);
%rd (rdannual15,rdstock15,rdstock15year,2008,2009,2010,2011,2012,2013,2014,2015);
%rd (rdannual16,rdstock16,rdstock16year,2009,2010,2011,2012,2013,2014,2015,2016);

data aer.rdstock;
	set rdstock82year rdstock89year rdstock90year rdstock91year rdstock92year rdstock93year rdstock94year 
	rdstock95year rdstock96year rdstock97year rdstock98year rdstock99year rdstock00year rdstock01year rdstock02year 
	rdstock03year rdstock04year rdstock05year rdstock06year rdstock07year rdstock08year rdstock09year rdstock10year 
	rdstock11year rdstock12year rdstock13year rdstock14year rdstock15year rdstock16year;
run;
/****************************************************************************************/
/****************************************************************************************/
