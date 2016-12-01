
/* list compactly all variables in a dataset */
/* same result as obtained via */
/* PROC CONTENTS DATA=dsn VARNUM SHORT; */

%MACRO LST(dsn);
  %GLOBAL x;
  %LET x=;
  %LET dsid=%SYSFUNC(open(&dsn));   /*open dataset*/
  %LET cnt=%SYSFUNC(attrn(&dsid,nvars));  /*count vars*/
  %DO i = 1 %TO &cnt;
     %LET x=&x %SYSFUNC(varname(&dsid,&i));   /*x contains all var names*/
  %END;
  %LET rc=%SYSFUNC(close(&dsid));   /*close dataset*/
%MEND LST;

/* list compactly all character variables */

%MACRO LSTC(dsn);
  %GLOBAL y;
  %LET y=;
  %LET dsid=%SYSFUNC(open(&dsn));   /*open dataset*/
  %LET cnt=%SYSFUNC(attrn(&dsid,nvars));  /*count vars*/
  %DO i = 1 %TO &cnt;
     %IF "%SYSFUNC(vartype(&dsid,&i))" EQ "C" %then %do;
     %LET y=&y %SYSFUNC(varname(&dsid,&i));   /*y contains all char var names*/
	 %END;
  %END;
  %LET rc=%SYSFUNC(close(&dsid));   /*close dataset*/
%MEND LSTC;

/* list compactly all numeric variables */

%MACRO LSTN(dsn);
  %GLOBAL z;
  %LET z=;
  %LET dsid=%SYSFUNC(open(&dsn));   /*open dataset*/
  %LET cnt=%SYSFUNC(attrn(&dsid,nvars));  /*count vars*/
  %DO i = 1 %TO &cnt;
     %IF "%SYSFUNC(vartype(&dsid,&i))" EQ "N" %then %do;
     %LET z=&z %SYSFUNC(varname(&dsid,&i));   /*z contains all numeric var names*/
	 %END;
  %END;
  %LET rc=%SYSFUNC(close(&dsid));   /*close dataset*/
%MEND LSTN;
