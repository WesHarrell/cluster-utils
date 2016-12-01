log using "furnace_Stata_out.smcl"

import delimited Type CHArea CHShape CHHght CHLiner House Age BTUIn BTUOut Damper using "furnace.csv"

keep CHArea CHHght Age BTUIn BTUOut Damper

list in 1/25, separator(0)

summarize CHArea CHHght Age BTUIn BTUOut

* type "findit univar" and search for "sg67_1" 

quietly net from http://www.stata.com/stb/stb51/
quietly net install sg67_1.pkg 

univar CHArea CHHght Age BTUIn BTUOut

tabulate Damper

graph twoway (scatter BTUOut BTUIn if Damper==1, msymbol(Oh) mcolor(blue)) (scatter BTUOut BTUIn if Damper==2, msymbol(X) mcolor(red)), title (BTUIn vs BTUOut for Stratified Furnace Data) legend (label(1 EVD) label(2 TVD)) saving("fs1.gph",replace)
graph export "fs1.pdf" 

histogram(BTUIn), frequency normal title (BTUIn Histogram & Normal Fit) saving("fs2.gph",replace) 
graph export "fs2.pdf"

ci means BTUIn, level(90)

ci variances BTUIn, level(90) sd

regress BTUOut BTUIn

graph twoway (lfitci BTUOut BTUIn, ciplot(rline)) (scatter BTUOut BTUIn, msymbol(d) mcolor(orange)), saving("fs3.gph",replace) 
graph export "fs3.pdf"

predict resids, residuals

predict std_resids, rstandard 

predict cooks_D, cooksd

predict fit_values

label var fit_values "Fitted values"

rvfplot, yline(0) title("Residuals vs Fitted") name(fs4)

qnorm std_resids, title("Normal Q-Q") name(fs5)

quietly net from http://www.stata-journal.com/software/sj10-1/
quietly net install gr0009_1.pkg

rvfplot2, rstandard rscale(sqrt(abs(X))) lowess title("Scale-Location")  name(fs6)

generate index = _n

label var index "Observation number"

label var cooks_D "Cook's distance"

graph twoway scatter cooks_D index, msymbol(none) mlabel(index) mlabposition(0) title("Cook's Distance") name(fs7)

graph combine fs4 fs5 fs6 fs7, saving("fs0.gph",replace) 
graph export "fs0.pdf"

log close
