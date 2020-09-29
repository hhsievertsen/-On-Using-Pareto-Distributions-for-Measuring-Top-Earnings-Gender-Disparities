/*
	Project: Pareto Gender
	File: 02_Figure1b_part_time
	Last edited: by Hans, Sep 12, 2020
*/

// Load settings
do "D:\Data\workdata\704784\xdrev\704784\pareto_gender\do\settings.do"
// Load panel
use "$tf\analysisdata_raw.dta",clear
// Pos earnings
gen pos_earning=v_income1>0 & v_income1!=.
keep if pos_earning==1
* gen part time
drop if year>2007
di _N
drop if v_parttime_code==.
di _N
gen part_time=inlist(v_parttime_code,5,6,7,8)

collapse (mean) part_time, by(v_female year) fast
// Chart female
tw  (connected part_time year if v_female==0, msymbol(Sh) mcolor(black) lcolor(black) ) ///
	(connected part_time year if v_female==1, msymbol(X) msize(large) mcolor(black) lcolor(black)) ///
	, graphregion(fcolor(white) lcolor(white)) ///
	  plotregion(fcolor(white) lcolor(black))  ///
	  xlab(1980(3)2007, noticks) xtitle(" ")  ///
	  ylab(, noticks format(%6.2f)  angle(horizontal)) ytitle("Share") ///
	  legend(region(lcolor(white)) row(1) ring(0) pos(12) ///
	  order(2 "Women" 1 "Men" )) ///
	  xscale(noline) yscale(noline)
	graph export "$of\fig_part_times_by_gender.png", replace width(2000)
