PROC IMPORT OUT=furnace0 
            DATAFILE="furnace.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

DATA furnace;
   SET furnace0;
   KEEP CHArea CHHght Age BTUIn BTUOut Damper;
RUN;

OPTIONS OBS=25;             /*only first 25 observations printed until changed*/
PROC PRINT DATA=furnace;
   VAR CHArea CHHght Age BTUIn BTUOut Damper;
RUN;
OPTIONS OBS=MAX;             /*change so statistics over full dataset are computed*/

PROC CONTENTS DATA=furnace VARNUM;
RUN;

DATA furnace;
   SET furnace (RENAME=(Damper=tmp));
   Damper = PUT(tmp, 1.);
   DROP tmp;      
RUN;

%INCLUDE 'SAS_macros.sas';  
%LSTC(furnace);   /*apply macro to dataset*/
%PUT;
%PUT &y;   /*written to log window: verifies that Damper is type char*/
%PUT;

PROC MEANS MIN Q1 MEDIAN MEAN Q3 MAX STD NMISS DATA=furnace MAXDEC=2;
   VAR CHArea CHHght Age BTUIn BTUOut;
RUN;

PROC FREQ DATA=furnace;
   TABLES Damper;
RUN;

FILENAME file1 'scatterplot-BTU.pdf';
GOPTIONS RESET=global DEVICE=pdf GSFMODE=replace GSFNAME=file1;
GOPTIONS HSIZE=7in VSIZE=7in;
AXIS1 ORDER=(2 to 22 by 2) MINOR=NONE;
AXIS2 ORDER=(2 to 20 by 2) MINOR=NONE;
SYMBOL1 V=circle C=blue  I=none;
SYMBOL2 V=star   C=red   I=none;
PROC GPLOT DATA=furnace;
     PLOT BTUOut*BTUIn=Damper / VAXIS=AXIS1 HAXIS=AXIS2;
	 TITLE 'BTUIn vs BTUOut for Stratified Furnace Data';
RUN; 

ODS GRAPHICS / RESET IMAGENAME = 'histogram-BTU'  IMAGEFMT=pdf; 
ODS LISTING GPATH = '.'; 
PROC SGPLOT DATA=furnace;
   HISTOGRAM BTUIn / BINWIDTH=2 BINSTART=3;
   DENSITY BTUIn / LINEATTRS = (COLOR = "light green" THICKNESS = 2 PATTERN=solid); 
   TITLE 'BTUIn Histogram & Normal Fit';
RUN;
ODS GRAPHICS OFF;

ODS SELECT BasicIntervals;
PROC UNIVARIATE DATA=furnace CIBASIC(alpha=0.1);
   VAR BTUIn;
   TITLE 'Confidence Intervals';
RUN;

ODS GRAPHICS / RESET IMAGENAME = 'regression-BTU'  IMAGEFMT=pdf; 
ODS LISTING GPATH = '.'; 
PROC REG PLOTS(ONLY)=diagnostics(stats=default) DATA=furnace ;
   MODEL BTUOut = BTUIn;
   TITLE 'BTUIn vs BTUOut and Least Squares Regression Line';
RUN;
ODS GRAPHICS OFF;
